import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Footer extends StatelessWidget {
  final VoidCallback onHomeTap;
  final VoidCallback onAppointmentTap;
  final VoidCallback onChatTap;
  final VoidCallback onProfileTap;

  const Footer(
      {required this.onHomeTap,
      required this.onAppointmentTap,
      required this.onChatTap,
      required this.onProfileTap,
      super.key});

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          IconButton(
            icon: SvgPicture.asset('assets/home_icon.svg'),
            onPressed: onHomeTap,
          ),
          IconButton(
            icon: SvgPicture.asset('assets/appointment_icon.svg'),
            onPressed: onAppointmentTap,
          ),
          IconButton(
            icon: SvgPicture.asset('assets/chat_icon.svg'),
            onPressed: onChatTap,
          ),
          IconButton(
            icon: SvgPicture.asset('assets/profile_icon.svg'),
            onPressed: onProfileTap,
          ),
        ],
      ),
    );
  }
}
