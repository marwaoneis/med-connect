import 'package:flutter/material.dart';
import '../widgets/appointment_list.dart';
import '../widgets/doctor_appointment_card.dart';

class DoctorScreen extends StatelessWidget {
  const DoctorScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Doctor Screen'),
      ),
      body: const SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: AppointmentList(
            appointments: [
              AppointmentCard(
                name: 'Patient Name',
                details: 'Age, Gender, Date, Time of request',
                status: 'Confirmed',
                statusColor: Colors.green,
              ),
              AppointmentCard(
                name: 'Patient Name',
                details: 'Age, Gender, Date, Time of request',
                status: 'Declined',
                statusColor: Colors.red,
              ),
              // Add more appointment cards...
            ],
          ),
        ),
      ),
    );
  }
}
