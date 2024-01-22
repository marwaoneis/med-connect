import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../api/api_service.dart';
import '../config/request_config.dart';
import '../models/appointment_model.dart';
import '../models/doctor_model.dart';
// import 'package:flutter_svg/flutter_svg.dart';

class AppointmentCard extends StatefulWidget {
  final String patientId;

  const AppointmentCard({super.key, required this.patientId});

  @override
  AppointmentCardState createState() => AppointmentCardState();
}

class AppointmentCardState extends State<AppointmentCard> {
  Appointment? appointment;
  Doctor? doctor;
  String? errorMessage;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<Appointment> fetchLatestAppointment(String patientId) async {
    var headers = RequestConfig.getHeaders(context);
    final apiService =
        ApiService(baseUrl: 'http://10.0.2.2:3001', headers: headers);
    final response =
        await apiService.fetchData('appointments/patient/$patientId');
    final appointments =
        (response as List).map((json) => Appointment.fromJson(json)).toList();
    return appointments.isNotEmpty
        ? appointments.first
        : throw Exception('No appointments found');
  }

  Future<Doctor> fetchDoctorById(String doctorId) async {
    var headers = RequestConfig.getHeaders(context);
    final apiService =
        ApiService(baseUrl: 'http://10.0.2.2:3001', headers: headers);
    final json = await apiService.fetchData('doctors/$doctorId');
    return Doctor.fromJson(json);
  }

  void _loadData() async {
    try {
      appointment = await fetchLatestAppointment(widget.patientId);
      doctor = await fetchDoctorById(appointment!.doctorId);
    } catch (e) {
      print('Error loading data: $e');
    } finally {
      setState(() => isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (errorMessage != null) {
      return Center(child: Text(errorMessage!));
    }

    if (appointment == null) {
      return const Center(
        child: Text("You have no appointments."),
      );
    }

    String formattedDate =
        DateFormat('yyyy-MM-dd').format(appointment!.createdAt);
    String formattedTime = DateFormat('HH:mm').format(appointment!.createdAt);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 15.0),
          child: Text(
            "Your next Appointment",
            style: TextStyle(
              fontSize: 16.0,
              fontWeight: FontWeight.w900,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(18),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(15.0),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 1,
                  blurRadius: 3,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            'Dr. ${doctor?.firstName} ${doctor?.lastName}',
                            style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                          const SizedBox(height: 5),
                          Text(
                            '${doctor?.specialization}',
                            style: const TextStyle(
                              fontSize: 14,
                              color: Colors.black,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: <Widget>[
                      const Icon(Icons.email_outlined,
                          color: Color(0xFF0D4C92), size: 15),
                      const SizedBox(width: 8),
                      Text(
                        doctor!.email,
                        style: const TextStyle(fontSize: 12),
                      ),
                      const Spacer(),
                      const Icon(
                        Icons.phone,
                        color: Color(0xFF0D4C92),
                        size: 15,
                      ),
                      const SizedBox(width: 8),
                      Text(doctor!.phone, style: const TextStyle(fontSize: 12)),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Column(
                        children: [
                          const Text('Date', style: TextStyle(fontSize: 14)),
                          Text(formattedDate,
                              style: const TextStyle(
                                  fontSize: 14, fontWeight: FontWeight.bold)),
                        ],
                      ),
                      Column(
                        children: [
                          const Text('Time', style: TextStyle(fontSize: 14)),
                          Text(formattedTime,
                              style: const TextStyle(
                                  fontSize: 14, fontWeight: FontWeight.bold)),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: <Widget>[
                      const Icon(Icons.location_on, color: Color(0xFF0D4C92)),
                      const SizedBox(width: 8),
                      Text(doctor!.address),
                      const Spacer(),
                      const Text('Open in Google Maps'),
                    ],
                  ),
                  const Divider(height: 32),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      IconButton(
                        icon: const Icon(
                          Icons.email,
                          color: Color(0xFF0D4C92),
                          size: 30,
                        ),
                        onPressed: () {
                          // Handle email tap
                        },
                      ),
                      IconButton(
                        icon: const Icon(
                          Icons.phone,
                          color: Color(0xFF0D4C92),
                          size: 30,
                        ),
                        onPressed: () {
                          // Handle phone tap
                        },
                      ),
                      IconButton(
                        icon: const Icon(
                          Icons.edit,
                          color: Color(0xFF0D4C92),
                          size: 30,
                        ),
                        onPressed: () {
                          // Handle edit tap
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
