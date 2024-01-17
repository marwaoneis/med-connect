import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AppointmentScheduleScreen extends StatelessWidget {
  const AppointmentScheduleScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Appointments'),
        backgroundColor: const Color(0xFF0D4C92), // AppBar color
      ),
      body: ListView(
        children: [
          _buildDateSection('Today'),
          AppointmentItem(
            patientName: 'John Doe',
            appointmentTime: '09:00 AM',
            appointmentDate: '2023-07-21',
          ),
          // Repeat AppointmentItem for other appointments
          _buildDateSection('Tomorrow'),
          // Repeat for other dates
        ],
      ),
    );
  }

  Widget _buildDateSection(String date) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Text(
        date,
        style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
      ),
    );
  }
}

class AppointmentItem extends StatelessWidget {
  final String patientName;
  final String appointmentTime;
  final String appointmentDate;

  const AppointmentItem({
    super.key,
    required this.patientName,
    required this.appointmentTime,
    required this.appointmentDate,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(patientName),
                Text(appointmentTime),
                Text(appointmentDate),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () {
                    // TODO: Implement edit action
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF0D4C92),
                  ),
                  child: const Text('Edit'),
                ),
                ElevatedButton(
                  onPressed: () {
                    // TODO: Implement cancel action
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF0D4C92),
                  ),
                  child: const Text('Cancel'),
                ),
                ElevatedButton(
                  onPressed: () {
                    // TODO: Implement medical history action
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF0D4C92),
                  ),
                  child: const Text('Medical History'),
                ),
                SvgPicture.asset(
                  "assets/chat_icon.svg",
                  height: 20,
                  width: 20,
                  color: const Color(0xFF0D4C92),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
