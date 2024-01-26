import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../models/doctor_model.dart';
import '../providers/auth_provider.dart';
import '../tools/request.dart';
import '../widgets/no_glow_scroll.dart';

class DoctorProfileScreen extends StatefulWidget {
  final Doctor doctor;
  const DoctorProfileScreen({
    super.key,
    required this.doctor,
  });

  @override
  DoctorProfileScreenState createState() => DoctorProfileScreenState();
}

class DoctorProfileScreenState extends State<DoctorProfileScreen> {
  String? selectedDay;
  TimeOfDay? selectedTime;

  Future<void> _createAppointment(
      BuildContext context, String doctorId, String status, String type) async {
    final userId = Provider.of<Auth>(context, listen: false).getUserId;

    // Define your appointment payload
    Map<String, dynamic> appointmentPayload = {
      'patientId': userId,
      'doctorId': doctorId,
      'status': "Scheduled",
      'type': "Online",
    };

    try {
      final response = await sendRequest(
        route: "/appointments",
        method: "POST",
        load: appointmentPayload,
        context: context,
      );

      if (response.containsKey('_id')) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Appointment created successfully')),
        );
      } else {
        final errorMessage = response['error'] ?? 'Unknown error';
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
              content: Text('Failed to create appointment: $errorMessage')),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to create appointment: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    print("Doctor ID in Profile Screen: ${widget.doctor.id}");

    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.doctor.specialization.name,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: NoGlowScrollWrapper(
        child: ListView(
          children: [
            // Doctor details card
            _buildDoctorDetailsCard(widget.doctor),
            // Timing section
            _buildTimingSection(context, widget.doctor),
            // Location section with map view
            // _buildLocationSection(doctor),
          ],
        ),
      ),
    );
  }

  Widget _buildDoctorDetailsCard(Doctor doctor) {
    return Card(
      margin: const EdgeInsets.all(16),
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
              style: const TextStyle(
                  fontSize: 18,
                  color: Color(0xFF0D4C92),
                  fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Years of Experience',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      '${doctor.yearsOfExperience} years',
                      style: const TextStyle(
                          fontSize: 18, fontWeight: FontWeight.w500),
                    ),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Appointment Price',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      '\$${doctor.appointmentPrice}',
                      style: const TextStyle(
                          fontSize: 18, fontWeight: FontWeight.w500),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTimingSection(BuildContext context, Doctor doctor) {
    return Card(
      margin: const EdgeInsets.all(16.0),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Working Hours: ${doctor.timing.startTime} - ${doctor.timing.endTime}',
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () => _showDaySelectionDialog(context, doctor),
              child: const Text('Select Day'),
            ),
            Text(
              'Selected Day: ${selectedDay ?? 'Not Selected'}',
              style: const TextStyle(fontSize: 16),
            ),
            Text(
              'Selected Time: ${selectedTime?.format(context) ?? 'Not Selected'}',
              style: const TextStyle(fontSize: 16),
            ),
            ElevatedButton(
              onPressed: () async {
                final TimeOfDay? pickedTime = await showTimePicker(
                  context: context,
                  initialTime: selectedTime ?? TimeOfDay.now(),
                );
                if (pickedTime != null && pickedTime != selectedTime) {
                  setState(() {
                    selectedTime = pickedTime;
                  });
                }
              },
              child: const Text('Select Time'),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: selectedDay != null && selectedTime != null
                  ? () => _confirmAndCreateAppointment(
                      context, doctor, selectedDay!, selectedTime!)
                  : null,
              child: const Text('Confirm Appointment'),
            ),
          ],
        ),
      ),
    );
  }

  void _showDaySelectionDialog(BuildContext context, Doctor doctor) {
    final List<String> weekdays = [
      'Monday',
      'Tuesday',
      'Wednesday',
      'Thursday',
      'Friday'
    ];

    showDialog(
      context: context,
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          title: const Text('Select a Day'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: weekdays.map((day) {
              return ListTile(
                title: Text(day),
                onTap: () {
                  setState(() {
                    selectedDay = day;
                    Navigator.of(dialogContext)
                        .pop(); // Close the dialog after selection
                  });
                },
              );
            }).toList(),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Cancel'),
              onPressed: () {
                Navigator.of(dialogContext).pop(); // Close the dialog
              },
            ),
          ],
        );
      },
    );
  }

  void _confirmAndCreateAppointment(BuildContext context, Doctor doctor,
      String selectedDay, TimeOfDay selectedTime) {
    String formattedTime = selectedTime.format(context);

    showDialog(
      context: context,
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          title: const Text('Confirm Appointment'),
          content: Text(
              'Are you sure you want to book an appointment with Dr. ${doctor.firstName} ${doctor.lastName} on $selectedDay?'),
          actions: <Widget>[
            TextButton(
              child: const Text('Cancel'),
              onPressed: () {
                Navigator.of(dialogContext).pop(); // Close the dialog
              },
            ),
            TextButton(
              child: const Text('Confirm'),
              onPressed: () {
                // Close the dialog
                Navigator.of(dialogContext).pop();
                // Call the appointment creation function
                _createAppointment(
                    context, widget.doctor.id, selectedDay, formattedTime);
              },
            ),
          ],
        );
      },
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
