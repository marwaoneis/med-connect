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

  Widget _buildAvailabilitySection(Doctor doctor) {
    // Assuming `doctor.availability` is a list of available slots.
    // This is a placeholder and should be replaced with actual data structure.
    final availability = ['06:00 - 06:30', '06:30 - 07:00', '07:00 - 07:30'];
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text('Available Slots', style: TextStyle(fontSize: 18)),
        ),
        Wrap(
          spacing: 8.0,
          children: availability
              .map((slot) => Chip(
                    label: Text(slot),
                    backgroundColor: Colors.blue[100],
                  ))
              .toList(),
        ),
      ],
    );
  }

  Widget _buildTimingSection(Doctor doctor) {
    // Placeholder for timing data
    final timing = 'Monday: 09:00 AM - 05:00 PM';
    return ListTile(
      title: Text('Timing'),
      subtitle: Text(timing),
    );
  }
}
