import 'package:flutter/material.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../models/doctor_model.dart';
import '../widgets/no_glow_scroll.dart';

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
        title: Text(doctor.specialization.name),
        actions: [
          IconButton(
            icon: const Icon(Icons.star_border),
            onPressed: () {
              // Handle favorite action
            },
          ),
        ],
      ),
      body: NoGlowScrollWrapper(
        child: ListView(
          children: [
            // Doctor details card
            _buildDoctorDetailsCard(doctor),
            // Availability section
            _buildAvailabilitySection(doctor),
            // Timing section
            _buildTimingSection(doctor),
            // Location section with map view
            // _buildLocationSection(doctor),
          ],
        ),
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
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(
              doctor.specialization.name,
              style: const TextStyle(fontSize: 18, color: Colors.grey),
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Years of Experience'),
                    Text('${doctor.yearsOfExperience} years'),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Appointment Price'),
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
        const Padding(
          padding: EdgeInsets.all(16.0),
          child: Text('Available Slots', style: TextStyle(fontSize: 18)),
        ),
        Center(
          child: Wrap(
            spacing: 8.0,
            children: availability
                .map((slot) => Chip(
                      label: Text(slot),
                      backgroundColor: Colors.blue[100],
                    ))
                .toList(),
          ),
        )
      ],
    );
  }

  Widget _buildTimingSection(Doctor doctor) {
    // Placeholder for timing data
    const timing = 'Monday: 09:00 AM - 05:00 PM';
    return const ListTile(
      title: Text('Timing'),
      subtitle: Text(timing),
    );
  }

  // Widget _buildLocationSection(Doctor doctor) {
  //   // Placeholder for doctor's clinic location
  //   final clinicLocation =
  //       LatLng(37.77483, -122.41942); // San Francisco coordinates

  //   return SizedBox(
  //     height: 200.0,
  //     child: GoogleMap(
  //       initialCameraPosition: CameraPosition(
  //         target: clinicLocation,
  //         zoom: 14.0,
  //       ),
  //       markers: {
  //         Marker(
  //           markerId: MarkerId('clinicLocation'),
  //           position: clinicLocation,
  //         ),
  //       },
  //     ),
  //   );
  // }
}
