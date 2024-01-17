import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart'; // If you're using SVGs for icons

class DoctorAppointmentInfo extends StatelessWidget {
  final String patientName;
  final String appointmentType; // 'At Clinic' or 'Online'
  final String appointmentStatus; // 'Ongoing' or 'Time'
  final String patientImageUrl;

  const DoctorAppointmentInfo({
    super.key,
    required this.patientName,
    required this.appointmentType,
    required this.appointmentStatus,
    required this.patientImageUrl,
  });

  @override
  Widget build(BuildContext context) {
    Color buttonColor = const Color(0xFF0D4C92);

    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Row(
        children: [
          const SizedBox(
            width: 10,
          ),
          CircleAvatar(
            backgroundImage: AssetImage(patientImageUrl),
            radius: 20,
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  patientName,
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 16),
                ),
                Text(
                  appointmentType,
                  style: const TextStyle(fontSize: 12, color: Colors.grey),
                ),
              ],
            ),
          ),
          SvgPicture.asset(
            "assets/chat_icon.svg",
            height: 20,
            width: 20,
            color: Colors.black,
          ),
          const SizedBox(width: 10),
          if (appointmentStatus == 'Ongoing') ...[
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: buttonColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              onPressed: () {
                // TODO: Add action for ongoing appointment
              },
              child: const Text('Ongoing',
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.normal)),
            ),
          ] else ...[
            TextButton(
              style: TextButton.styleFrom(
                foregroundColor: buttonColor,
              ),
              onPressed: () {
                // TODO: Add action for scheduled time
              },
              child: Text(
                appointmentStatus,
              ), // 'Time' will be replaced with actual time data
            ),
          ],
          const SizedBox(
            width: 10,
          ),
        ],
      ),
    );
  }
}
