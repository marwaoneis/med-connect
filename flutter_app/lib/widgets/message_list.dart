import 'package:flutter/material.dart';
import '../screens/chat_screen.dart'; // Replace with the actual import path

class MessageList extends StatelessWidget {
  const MessageList({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 20,
      itemBuilder: (context, index) {
        return InkWell(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const ChatScreen()),
            );
          },
          child: const ListTile(
            leading: CircleAvatar(
              backgroundImage: AssetImage('assets/profile_placeholder.png'),
            ),
            title: Text('Dr Name'),
            subtitle: Text('Message Content'),
            trailing: Text('Date/time'),
          ),
        );
      },
    );
  }
}
