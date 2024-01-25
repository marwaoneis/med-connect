import 'package:flutter/material.dart';
import 'package:flutter_app/screens/appointments_schedule.dart';
import 'package:flutter_svg/flutter_svg.dart';
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
            appointment.status =
                newStatus; // Update the status in the appointment object
          });
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(children: <Widget>[
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
                              return CircularProgressIndicator();
                            } else if (appointmentSnapshot.hasError) {
                              return Text(
                                  'Error: ${appointmentSnapshot.error}');
                            } else if (appointmentSnapshot.hasData) {
                              var appointments = appointmentSnapshot.data!;

                              // Filter appointments with status "Scheduled"
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
                                        return CircularProgressIndicator();
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

                    // Second Appointment List using FutureBuilder
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
                                          patientName:
                                              '${patient['firstName']} ${patient['lastName']}',
                                          appointmentType: appointment.type,
                                          appointmentStatus: appointment.status,
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
