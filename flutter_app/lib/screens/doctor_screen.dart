import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../widgets/appointment_list.dart';
import '../widgets/doctor_appointment_card.dart';
import '../widgets/no_glow_scroll.dart';
import '../widgets/top_bar_with_background.dart';

class DoctorScreen extends StatelessWidget {
  const DoctorScreen({super.key});

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
          const Expanded(
            child: NoGlowScrollWrapper(
              child: SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.all(16.0),
                  child: AppointmentList(
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
                      // Add more appointment cards...
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
