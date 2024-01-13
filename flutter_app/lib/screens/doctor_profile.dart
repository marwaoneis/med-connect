import 'package:flutter/material.dart';

import '../models/doctor_model.dart';

class DoctorProfileScreen extends StatelessWidget {
  final Doctor doctor;

  const DoctorProfileScreen({
    super.key,
    required this.doctor,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(doctor.specialization),
        actions: [
          IconButton(
            icon: const Icon(Icons.star_border),
            onPressed: () {
              // Handle favorite action
            },
          ),
        ],
      ),
      body: ListView(
        children: [
          // Doctor details card
          _buildDoctorDetailsCard(doctor),
          // Availability section
          _buildAvailabilitySection(doctor),
          // Timing section
          _buildTimingSection(doctor),
          // Location section with map view
          _buildLocationSection(doctor),
        ],
      ),
    );
  }

  Widget _buildDoctorDetailsCard(Doctor doctor) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Dr. ${doctor.firstName} ${doctor.lastName}',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text(
              doctor.specialization,
              style: TextStyle(fontSize: 18, color: Colors.grey),
            ),
            SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Years of Experience'),
                    Text('${doctor.yearsOfExperience} years'),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Appointment Price'),
                    Text('\$${doctor.appointmentPrice}'),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
