import 'package:flutter/material.dart';
import 'package:flutter_app/screens/appointments_schedule.dart';
import 'package:flutter_app/screens/message_screen.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../widgets/appointment_list.dart';
import '../widgets/doctor_appointment_card.dart';
import '../widgets/doctor_appointment_info.dart';
import '../widgets/footer.dart';
import '../widgets/no_glow_scroll.dart';
import '../widgets/top_bar_with_background.dart';

class DoctorScreen extends StatelessWidget {
  const DoctorScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          TopBarWithBackground(
            leadingContent: const CircleAvatar(
              child: Text(
                'D',
                style: TextStyle(color: Color(0xFF0D4C92)),
              ),
            ),
            titleContent: const Text(
              'Hello Dr',
              style: TextStyle(fontSize: 20, color: Colors.white),
            ),
            trailingContent: IconButton(
              icon: SvgPicture.asset(
                'assets/notification_icon.svg',
                color: Colors.white,
              ),
              onPressed: () {},
            ),
          ),
          const SizedBox(
            height: 5,
          ),
          const Expanded(
            child: NoGlowScrollWrapper(
              child: SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      AppointmentList(
                        title: 'Appointment Requests',
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
                          AppointmentCard(
                            name: 'Patient Name',
                            details: 'Age, Gender, Date, Time of request',
                            status: 'Declined',
                            statusColor: Colors.red,
                          ),
                          AppointmentCard(
                            name: 'Patient Name',
                            details: 'Age, Gender, Date, Time of request',
                            status: 'Confirmed',
                            statusColor: Colors.green,
                          ),
                        ],
                      ),
                      SizedBox(height: 20),
                      AppointmentList(
                        title: 'Appointment Requests',
                        appointments: [
                          DoctorAppointmentInfo(
                            patientName: 'Jane Doe',
                            appointmentType: 'Online',
                            appointmentStatus: 'Ongoing',
                            patientImageUrl: 'assets/doctor_image.png',
                          ),
                          DoctorAppointmentInfo(
                            patientName: 'Jane Doe',
                            appointmentType: 'Online',
                            appointmentStatus: 'Ongoing',
                            patientImageUrl: 'assets/doctor_image.png',
                          ),
                          DoctorAppointmentInfo(
                            patientName: 'Jane Doe',
                            appointmentType: 'Online',
                            appointmentStatus: 'Ongoing',
                            patientImageUrl: 'assets/doctor_image.png',
                          ),
                          DoctorAppointmentInfo(
                            patientName: 'Jane Doe',
                            appointmentType: 'Online',
                            appointmentStatus: 'Ongoing',
                            patientImageUrl: 'assets/doctor_image.png',
                          ),
                        ],
                      ),
                    ],
                  ),
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
}
