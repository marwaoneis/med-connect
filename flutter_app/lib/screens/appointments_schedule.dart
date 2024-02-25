import 'package:flutter/material.dart';
import 'package:flutter_app/api/api_service.dart';
import 'package:flutter_app/screens/doctor_message_screen.dart';
import 'package:flutter_app/screens/doctor_profile_logout.dart';
import 'package:flutter_app/widgets/no_glow_scroll.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../config/request_config.dart';
import '../models/appointment_model.dart';
import '../models/doctor_model.dart';
import '../providers/auth_provider.dart';
import '../tools/request.dart';
import '../widgets/footer.dart';
import '../widgets/top_bar_with_background.dart';
import 'chat_screen.dart';
import 'doctor_dashboard_screen.dart';
import 'patient_medical_history_screen.dart';

class AppointmentScheduleScreen extends StatefulWidget {
  final String? selectedPatientId;

  const AppointmentScheduleScreen({
    super.key,
    this.selectedPatientId,
  });

  @override
  AppointmentScheduleScreenState createState() =>
      AppointmentScheduleScreenState();
}

class AppointmentScheduleScreenState extends State<AppointmentScheduleScreen> {
  Doctor? _doctor;
  List<Appointment>? _appointments;

  @override
  void initState() {
    super.initState();
    _initializeData();
  }

  void _deleteAppointment(String appointmentId) async {
    try {
      final response = await sendRequest(
        route: "/appointments/$appointmentId",
        method: "DELETE",
        context: context,
      );

      if (response['success']) {
        setState(() {
          _appointments!
              .removeWhere((appointment) => appointment.id == appointmentId);
        });

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Appointment cancelled successfully')),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Failed to cancel appointment')),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to cancel appointment: $e')),
      );
    }
  }

  void _deleteAppointmentAndUpdateList(String appointmentId) async {
    _deleteAppointment(appointmentId); // Call your delete request
    setState(() {
      _appointments = _appointments!
          .where((appointment) => appointment.id != appointmentId)
          .toList();
    });
  }

  void _initializeData() async {
    final authProvider = Provider.of<Auth>(context, listen: false);
    final doctorId = authProvider.getUserId;

    if (doctorId != null) {
      Doctor doctorData = await fetchDoctorById(doctorId);
      List<Appointment> appointmentsData =
          await fetchAppointmentsByDoctorId(doctorId);

      setState(() {
        _doctor = doctorData;
        _appointments = appointmentsData;
      });
    }
  }

  Future<Doctor> fetchDoctorById(String doctorId) async {
    var headers = RequestConfig.getHeaders(context);
    final apiService =
        ApiService(baseUrl: 'http://10.0.2.2:3001', headers: headers);
    final json = await apiService.fetchData('doctors/$doctorId');
    return Doctor.fromJson(json);
  }

  Future<Map<String, dynamic>> fetchPatientById(String patientId) async {
    var headers = RequestConfig.getHeaders(context);
    final apiService =
        ApiService(baseUrl: 'http://10.0.2.2:3001', headers: headers);
    final json = await apiService.fetchData('patients/$patientId');
    return json;
  }

  Future<List<Appointment>> fetchAppointmentsByDoctorId(String doctorId) async {
    var headers = RequestConfig.getHeaders(context);
    final apiService =
        ApiService(baseUrl: 'http://10.0.2.2:3001', headers: headers);
    final response =
        await apiService.fetchData('appointments/doctor/$doctorId');
    final appointments =
        (response as List).map((json) => Appointment.fromJson(json)).toList();
    return appointments;
  }

  @override
  Widget build(BuildContext context) {
    if (_doctor == null || _appointments == null) {
      return const Center(child: CircularProgressIndicator());
    }
    return Scaffold(
      body: Column(
        children: [
          TopBarWithBackground(
            leadingContent: IconButton(
              icon: const Icon(Icons.arrow_back, color: Colors.white),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            titleContent: const Text(
              'Appointments Schedule',
              style: TextStyle(fontSize: 20, color: Colors.white),
            ),
            trailingContent: IconButton(
              icon: SvgPicture.asset(
                'assets/notification_icon.svg', // Replace with your asset path
                color: Colors.white,
              ),
              onPressed: () {
                // TODO: Notification action
              },
            ),
          ),
          Expanded(
            child: NoGlowScrollWrapper(
              child: ListView.builder(
                padding: EdgeInsets.all(20),
                itemCount: _appointments!.length,
                itemBuilder: (context, index) {
                  final appointment = _appointments![index];

                  return FutureBuilder<Map<String, dynamic>>(
                    future: fetchPatientById(appointment.patientId),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const CircularProgressIndicator();
                      } else if (snapshot.hasError) {
                        return Text('Error: ${snapshot.error}');
                      } else if (snapshot.hasData) {
                        final patientData = snapshot.data!;
                        final formattedDate = DateFormat('yyyy-MM-dd')
                            .format(appointment.updatedAt);
                        final formattedTime =
                            DateFormat('HH:mm').format(appointment.updatedAt);

                        return AppointmentItem(
                            patientName:
                                '${patientData['firstName']} ${patientData['lastName']}',
                            appointmentTime: formattedTime,
                            appointmentDate: formattedDate,
                            patientId: patientData['_id'],
                            onDelete: () => _deleteAppointmentAndUpdateList(
                                appointment.id));
                      } else {
                        return const SizedBox.shrink();
                      }
                    },
                  );
                },
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: Footer(
        onHomeTap: () {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const DoctorScreen()),
          );
        },
        onAppointmentTap: () {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (context) => AppointmentScheduleScreen(
                      selectedPatientId: _appointments?.first.patientId,
                    )),
          );
        },
        onChatTap: () {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (context) => const DoctorMessageScreen()),
          );
        },
        onProfileTap: () {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (context) => const DoctorProfileLogoutScreen()),
          );
        },
      ),
    );
  }

  Widget _buildDateSection(String date) {
    return Text(
      date,
      style: const TextStyle(
          fontSize: 20, color: Colors.grey, fontWeight: FontWeight.bold),
    );
  }
}

class AppointmentItem extends StatelessWidget {
  final String patientName;
  final String appointmentTime;
  final String appointmentDate;
  final String patientId;
  final VoidCallback onDelete;

  const AppointmentItem(
      {super.key,
      required this.patientName,
      required this.appointmentTime,
      required this.appointmentDate,
      required this.patientId,
      required this.onDelete});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 0, vertical: 12),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 8.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const CircleAvatar(
              backgroundImage: NetworkImage('https://via.placeholder.com/150'),
              radius: 25,
            ),
            const SizedBox(width: 15),
            Expanded(
              child: Column(
                children: [
                  Row(
                    children: [
                      Column(
                        children: [
                          const Text(
                            'Patient',
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Text(patientName,
                              style: const TextStyle(fontSize: 14)),
                          const SizedBox(
                            height: 10,
                          ),
                          _buildActionButton(
                            context,
                            'Chat',
                            () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => ChatScreen(
                                        receiverId: patientId,
                                        receiverName: patientName,
                                      )),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Column(
                        children: [
                          const Text(
                            'Time',
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Text(appointmentTime,
                              style: const TextStyle(fontSize: 14)),
                          const SizedBox(
                            height: 10,
                          ),
                          _buildActionButton(context, 'Cancel', onDelete),
                        ],
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Column(
                        children: [
                          const Text(
                            'Date',
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Text(appointmentDate,
                              style: const TextStyle(fontSize: 14)),
                          const SizedBox(
                            height: 10,
                          ),
                          _buildActionButton(context, 'Medical History', () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    PatientMedicalHistoryScreen(
                                        patientId: patientId),
                              ),
                            );
                          }),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildActionButton(
      BuildContext context, String text, VoidCallback onPressed) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color(0xFF0D4C92),
        foregroundColor: Colors.white,
        textStyle: const TextStyle(fontSize: 14),
        padding: const EdgeInsets.symmetric(horizontal: 10),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
      ),
      child: Text(text),
    );
  }
}
