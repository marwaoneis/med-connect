import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../screens/appointments_schedule.dart';
import '../screens/chat_screen.dart';
import '../tools/request.dart';

class DoctorAppointmentInfo extends StatelessWidget {
  final String patientId;
  final String patientName;
  final String appointmentId;
  final String appointmentType;
  final String appointmentStatus;
  final String patientImageUrl;
  final VoidCallback onCancel;

  const DoctorAppointmentInfo(
      {super.key,
      required this.patientId,
      required this.patientName,
      required this.appointmentId,
      required this.appointmentType,
      required this.appointmentStatus,
      required this.patientImageUrl,
      required this.onCancel});

  @override
  Widget build(BuildContext context) {
    Color buttonColor = const Color(0xFF0D4C92);

    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Row(
        children: [
          const SizedBox(
            width: 6,
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
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => ChatScreen(
                          receiverId: patientId,
                          receiverName: patientName,
                        )),
              );
            },
            icon: SvgPicture.asset(
              "assets/chat_icon.svg",
              height: 20,
              width: 20,
              color: Colors.black,
            ),
          ),
          const SizedBox(width: 5),
          if (appointmentStatus == 'Confirmed') ...[
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: buttonColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => AppointmentScheduleScreen(
                      selectedPatientId: patientId,
                    ),
                  ),
                );
              },
              child: Text(appointmentStatus,
                  style: const TextStyle(
                      color: Colors.white, fontWeight: FontWeight.normal)),
            ),
          ] else ...[
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: buttonColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              onPressed: onCancel,
              child: const Text("Cancelled",
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.normal)),
            ),
          ],
          const SizedBox(
            width: 6,
          ),
        ],
      ),
    );
  }
}
