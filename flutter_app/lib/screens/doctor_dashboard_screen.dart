import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../api/api_service.dart';
import '../config/request_config.dart';
import '../models/appointment_model.dart';
import '../models/doctor_model.dart';
import '../providers/auth_provider.dart';
import '../tools/request.dart';
import '../widgets/appointment_list.dart';
import '../widgets/doctor_appointment_card.dart';
import '../widgets/doctor_appointment_info.dart';
import '../widgets/footer.dart';
import '../widgets/no_glow_scroll.dart';
import '../widgets/top_bar_with_background.dart';
import 'appointments_schedule.dart';
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
    _initializeData();
  }

  void _initializeData() async {
    final authProvider = Provider.of<Auth>(context, listen: false);
    final doctorId = authProvider.getUserId;
    if (doctorId != null) {
      setState(() {
        _appointmentsFuture = fetchAppointmentsByDoctorId(doctorId);
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

  void _updateAppointmentStatus(String appointmentId, String newStatus) async {
    final authProvider = Provider.of<Auth>(context, listen: false);
    final doctorId = authProvider.getUserId;

    if (doctorId != null) {
      final updatedAppointment = {
        'status': newStatus,
      };

      final response = await sendRequest(
        route: 'appointments/$appointmentId',
        method: 'PUT',
        load: updatedAppointment,
        context: context,
      );

      if (response != null) {
        setState(() {
          _appointmentsFuture?.then((appointments) {
            var appointment =
                appointments.firstWhere((a) => a.id == appointmentId);
            appointment.status = newStatus;
          });
        });
      }
    }
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
          _appointmentsFuture = _appointmentsFuture?.then((appointments) =>
              appointments
                  .where((appointment) => appointment.id != appointmentId)
                  .toList());
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

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<Auth>(context, listen: false);
    final doctorId = authProvider.getUserId;

    return Scaffold(
      body: Column(children: <Widget>[
        FutureBuilder<Doctor>(
          future: fetchDoctorById(doctorId!),
          builder: (context, snapshot) {
            String initialLetter = snapshot.hasData
                ? snapshot.data!.firstName.substring(0, 1)
                : 'D';
            String doctorFirstName =
                snapshot.hasData ? 'Dr. ${snapshot.data!.firstName}' : 'Dr.';

            return TopBarWithBackground(
              leadingContent: CircleAvatar(
                child: Text(
                  initialLetter,
                  style: const TextStyle(color: Color(0xFF0D4C92)),
                ),
              ),
              titleContent: Text(
                'Hello $doctorFirstName',
                style: const TextStyle(fontSize: 20, color: Colors.white),
              ),
              trailingContent: IconButton(
                icon: SvgPicture.asset(
                  'assets/notification_icon.svg',
                  color: Colors.white,
                ),
                onPressed: () {},
              ),
            );
          },
        ),
        const SizedBox(
          height: 5,
        ),
        Expanded(
          child: NoGlowScrollWrapper(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
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

                              var scheduledAppointments = appointments
                                  .where((appointment) =>
                                      appointment.status == 'Scheduled')
                                  .toList();

                              if (scheduledAppointments.isEmpty) {
                                return const Text(
                                  'No scheduled appointments.',
                                  textAlign: TextAlign.center,
                                );
                              }

                              return Column(
                                children:
                                    scheduledAppointments.map((appointment) {
                                  return FutureBuilder<Map<String, dynamic>>(
                                    future:
                                        fetchPatientById(appointment.patientId),
                                    builder: (context, patientSnapshot) {
                                      if (patientSnapshot.connectionState ==
                                          ConnectionState.waiting) {
                                        return const CircularProgressIndicator();
                                      } else if (patientSnapshot.hasError) {
                                        return Text(
                                            'Error: ${patientSnapshot.error}');
                                      } else if (patientSnapshot.hasData) {
                                        var patient = patientSnapshot.data!;
                                        final formattedDate =
                                            DateFormat('yyyy-MM-dd')
                                                .format(appointment.updatedAt);
                                        final formattedTime =
                                            DateFormat('HH:mm')
                                                .format(appointment.updatedAt);

                                        return AppointmentCard(
                                          name:
                                              '${patient['firstName']} ${patient['lastName']}',
                                          details:
                                              'Gender: ${patient['gender']}, Date: $formattedDate, Time of request: $formattedTime',
                                          status: appointment.status,
                                          statusColor:
                                              appointment.status == 'Confirmed'
                                                  ? Colors.green
                                                  : Colors.red,
                                          // isScheduled: true,
                                          onStatusChanged: (newStatus) {
                                            _updateAppointmentStatus(
                                                appointment.id, newStatus);
                                          },
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
                              return CircularProgressIndicator();
                            } else if (appointmentSnapshot.hasError) {
                              return Text(
                                  'Error: ${appointmentSnapshot.error}');
                            } else if (appointmentSnapshot.hasData) {
                              var appointments = appointmentSnapshot.data!;
                              return Column(
                                children: appointments.map((appointment) {
                                  return FutureBuilder<Map<String, dynamic>>(
                                    future:
                                        fetchPatientById(appointment.patientId),
                                    builder: (context, patientSnapshot) {
                                      if (patientSnapshot.connectionState ==
                                          ConnectionState.waiting) {
                                        return CircularProgressIndicator();
                                      } else if (patientSnapshot.hasError) {
                                        return Text(
                                            'Error: ${patientSnapshot.error}');
                                      } else if (patientSnapshot.hasData) {
                                        var patient = patientSnapshot.data!;
                                        return DoctorAppointmentInfo(
                                          patientId: patient['_id'],
                                          patientName:
                                              '${patient['firstName']} ${patient['lastName']}',
                                          appointmentId: appointment.id,
                                          appointmentType: appointment.type,
                                          appointmentStatus: appointment.status,
                                          patientImageUrl:
                                              'assets/doctor_image.png',
                                          onCancel: () => _deleteAppointment(
                                              appointment.id),
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
      ]),
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
              builder: (context) => const AppointmentScheduleScreen(),
            ),
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
