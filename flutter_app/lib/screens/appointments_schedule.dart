import 'package:flutter/material.dart';
import 'package:flutter_app/widgets/no_glow_scroll.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../widgets/footer.dart';
import '../widgets/top_bar_with_background.dart';
import 'doctor_screen.dart';
import 'message_screen.dart';

class AppointmentScheduleScreen extends StatelessWidget {
  const AppointmentScheduleScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          TopBarWithBackground(
            leadingContent: IconButton(
              icon: const Icon(Icons.arrow_back, color: Colors.white),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            titleContent: const Text(
              'Appointments Schedule',
              style: TextStyle(fontSize: 20, color: Colors.white),
            ),
            trailingContent: IconButton(
              icon: SvgPicture.asset(
                'assets/notification_icon.svg', // Replace with your asset path
                color: Colors.white,
              ),
              onPressed: () {
                // TODO: Notification action
              },
            ),
          ),
          Expanded(
            child: NoGlowScrollWrapper(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(15.0, 0, 15.0, 15.0),
                child: ListView(
                  children: [
                    const Text(
                      'Your Appointments',
                      style:
                          TextStyle(fontSize: 24, fontWeight: FontWeight.w900),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    _buildDateSection('Today'),

                    const AppointmentItem(
                      patientName: 'John Doe',
                      appointmentTime: '09:00 AM',
                      appointmentDate: '2023-07-21',
                    ),
                    // Repeat AppointmentItem for other appointments
                    _buildDateSection('Tomorrow'),
                    // Repeat for other dates
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: Footer(
        onHomeTap: () {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const DoctorScreen()),
          );
        },
        onAppointmentTap: () {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (context) => const AppointmentScheduleScreen()),
          );
        },
        onChatTap: () {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const MessageScreen()),
          );
        },
        onProfileTap: () {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const DoctorScreen()),
          );
        },
      ),
    );
  }

  Widget _buildDateSection(String date) {
    return Text(
      date,
      style: const TextStyle(
          fontSize: 20, color: Colors.grey, fontWeight: FontWeight.bold),
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
      margin: const EdgeInsets.symmetric(horizontal: 0, vertical: 12),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 5.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const CircleAvatar(
              backgroundImage: NetworkImage('https://via.placeholder.com/150'),
              radius: 20,
            ),
            const SizedBox(width: 10),
            Column(
              children: [
                Row(
                  children: [
                    Column(
                      children: [
                        const Text(
                          'Patient',
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Text(patientName, style: const TextStyle(fontSize: 14)),
                        const SizedBox(
                          height: 10,
                        ),
                        _buildActionButton(context, 'Edit'),
                      ],
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Column(
                      children: [
                        const Text(
                          'Time',
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Text(appointmentTime,
                            style: const TextStyle(fontSize: 14)),
                        const SizedBox(
                          height: 10,
                        ),
                        _buildActionButton(context, 'Cancel'),
                      ],
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Column(
                      children: [
                        const Text(
                          'Date',
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Text(appointmentDate,
                            style: const TextStyle(fontSize: 14)),
                        const SizedBox(
                          height: 10,
                        ),
                        _buildActionButton(context, 'Medical History'),
                      ],
                    ),
                    IconButton(
                      icon: SvgPicture.asset(
                        "assets/chat_icon.svg",
                        height: 25,
                        width: 25,
                        color: const Color(0xFF0D4C92),
                      ),
                      onPressed: () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const MessageScreen()),
                        );
                      },
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

  Widget _buildActionButton(BuildContext context, String text) {
    return ElevatedButton(
      onPressed: () {
        // TODO: Implement action
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color(0xFF0D4C92),
        foregroundColor: Colors.white,
        textStyle: const TextStyle(fontSize: 14),
        padding: const EdgeInsets.symmetric(horizontal: 10),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
      ),
      child: Text(text),
    );
  }
}
