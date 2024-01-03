import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class MessageList extends StatelessWidget {
  const MessageList({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 20,
      itemBuilder: (context, index) {
        return ListTile(
          leading: CircleAvatar(
            child: SvgPicture.asset(
              'assets/profile_placeholder.svg',
              fit: BoxFit
                  .cover, // This is optional, depending on how you want it to fit
              width: double.infinity, // Ensures the SVG fills the circle
              height: double.infinity, // Ensures the SVG fills the circle
            ),
          ),
          title: const Text('Dr Name'),
          subtitle: const Text('Message Content'),
          trailing: const Text('Date/time'),
        );
      },
    );
  }
}
