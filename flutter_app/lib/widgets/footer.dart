import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Footer extends StatelessWidget {
  final VoidCallback onHomeTap;
  final VoidCallback onSearchTap;
  final VoidCallback onChatTap;
  final VoidCallback onProfileTap;

  const Footer(
      {required this.onHomeTap,
      required this.onSearchTap,
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
            icon: SvgPicture.asset(
                'assets/home_icon.svg'), // Import your SVG icon
            onPressed: onHomeTap,
          ),
          IconButton(
            icon: SvgPicture.asset(
                'assets/search_icon.svg'), // Import your SVG icon
            onPressed: onSearchTap,
          ),
          IconButton(
            icon: SvgPicture.asset(
                'assets/chat_icon.svg'), // Import your SVG icon
            onPressed: onChatTap,
          ),
          IconButton(
            icon: SvgPicture.asset(
                'assets/profile_icon.svg'), // Import your SVG icon
            onPressed: onProfileTap,
          ),
        ],
      ),
    );
  }
}
