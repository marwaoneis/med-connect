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
        title: Text(specialty),
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
}
