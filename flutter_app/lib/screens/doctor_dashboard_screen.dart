import 'package:flutter/material.dart';
import 'package:flutter_app/screens/appointments_schedule.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import '../api/api_service.dart';
import '../config/request_config.dart';
import '../models/appointment_model.dart';
import '../models/doctor_model.dart';
import '../providers/auth_provider.dart';
import '../widgets/appointment_list.dart';
import '../widgets/doctor_appointment_card.dart';
import '../widgets/doctor_appointment_info.dart';
import '../widgets/footer.dart';
import '../widgets/no_glow_scroll.dart';
import '../widgets/top_bar_with_background.dart';
import 'doctor_message_screen.dart';
import 'doctor_profile_logout.dart';

class DoctorScreen extends StatefulWidget {
  const DoctorScreen({
    super.key,
  });

  @override
  DoctorScreenState createState() => DoctorScreenState();
}

class DoctorScreenState extends State<DoctorScreen> {
  Future<Doctor>? _doctorFuture;
  Future<List<Appointment>>? _appointmentsFuture;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final authProvider = Provider.of<Auth>(context, listen: false);
      final doctorId = authProvider.getUserId;
      if (doctorId != null) {
        _doctorFuture = fetchDoctorById(doctorId);
        _appointmentsFuture = fetchAppointmentsByDoctorId(doctorId);
      }
    });
  }

  Future<Doctor> fetchDoctorById(String doctorId) async {
    var headers = RequestConfig.getHeaders(context);
    final apiService =
        ApiService(baseUrl: 'http://10.0.2.2:3001', headers: headers);
    final json = await apiService.fetchData('doctors/$doctorId');
    return Doctor.fromJson(json);
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

  Future<Map<String, dynamic>> fetchPatientById(String patientId) async {
    var headers = RequestConfig.getHeaders(context);
    final apiService =
        ApiService(baseUrl: 'http://10.0.2.2:3001', headers: headers);
    final json = await apiService.fetchData('patients/$patientId');
    return json; // json is a Map<String, dynamic> representing patient details
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          TopBarWithBackground(
            leadingContent: const CircleAvatar(
              child: Text(
                'D',
                style: TextStyle(color: Color(0xFF0D4C92)),
              ),
            ),
            titleContent: const Text(
              'Hello Dr',
              style: TextStyle(fontSize: 20, color: Colors.white),
            ),
            trailingContent: IconButton(
              icon: SvgPicture.asset(
                'assets/notification_icon.svg',
                color: Colors.white,
              ),
              onPressed: () {},
            ),
          ),
          const SizedBox(
            height: 5,
          ),
          Expanded(
            child: NoGlowScrollWrapper(
              child: SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      AppointmentList(
                        title: 'Appointment Requests',
                        appointments: [
                          FutureBuilder<List<Appointment>>(
                            future: _appointmentsFuture,
                            builder: (context, appointmentSnapshot) {
                              if (appointmentSnapshot.connectionState ==
                                  ConnectionState.waiting) {
                                return const CircularProgressIndicator();
                              } else if (appointmentSnapshot.hasError) {
                                return Text(
                                    'Error: ${appointmentSnapshot.error}');
                              } else if (appointmentSnapshot.hasData) {
                                var appointments = appointmentSnapshot.data!;
                                return Column(
                                  children: appointments.map((appointment) {
                                    return FutureBuilder<Map<String, dynamic>>(
                                      future: fetchPatientById(
                                          appointment.patientId),
                                      builder: (context, patientSnapshot) {
                                        if (patientSnapshot.connectionState ==
                                            ConnectionState.waiting) {
                                          return const CircularProgressIndicator();
                                        } else if (patientSnapshot.hasError) {
                                          return Text(
                                              'Error: ${patientSnapshot.error}');
                                        } else if (patientSnapshot.hasData) {
                                          var patient = patientSnapshot.data!;
                                          return AppointmentCard(
                                            name:
                                                '${patient['firstName']} ${patient['lastName']}',
                                            details:
                                                'Gender: ${patient['gender']}, Date: ${appointment.createdAt}, Time of request: ${appointment.updatedAt}',
                                            status: appointment.status,
                                            statusColor: appointment.status ==
                                                    'Confirmed'
                                                ? Colors.green
                                                : Colors.red,
                                          );
                                        } else {
                                          return const SizedBox();
                                        }
                                      },
                                    );
                                  }).toList(),
                                );
                              } else {
                                return const SizedBox();
                              }
                            },
                          ),
                        ],
                      ),
                      SizedBox(height: 20),
                      AppointmentList(
                        title: 'Appointment Requests',
                        appointments: [
                          FutureBuilder<List<Appointment>>(
                            future: _appointmentsFuture,
                            builder: (context, appointmentSnapshot) {
                              if (appointmentSnapshot.connectionState ==
                                  ConnectionState.waiting) {
                                return const CircularProgressIndicator();
                              } else if (appointmentSnapshot.hasError) {
                                return Text(
                                    'Error: ${appointmentSnapshot.error}');
                              } else if (appointmentSnapshot.hasData) {
                                var appointments = appointmentSnapshot.data!;
                                return Column(
                                  children: appointments.map((appointment) {
                                    return FutureBuilder<Map<String, dynamic>>(
                                      future: fetchPatientById(
                                          appointment.patientId),
                                      builder: (context, patientSnapshot) {
                                        if (patientSnapshot.connectionState ==
                                            ConnectionState.waiting) {
                                          return const CircularProgressIndicator();
                                        } else if (patientSnapshot.hasError) {
                                          return Text(
                                              'Error: ${patientSnapshot.error}');
                                        } else if (patientSnapshot.hasData) {
                                          var patient = patientSnapshot.data!;
                                          return DoctorAppointmentInfo(
                                            patientName:
                                                '${patient['firstName']} ${patient['lastName']}',
                                            appointmentType: appointment.type,
                                            appointmentStatus:
                                                appointment.status,
                                            patientImageUrl:
                                                'assets/doctor_image.png', // Replace with actual patient image URL
                                          );
                                        } else {
                                          return const SizedBox();
                                        }
                                      },
                                    );
                                  }).toList(),
                                );
                              } else {
                                return const SizedBox();
                              }
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
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
                builder: (context) => const AppointmentScheduleScreen()),
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
}
