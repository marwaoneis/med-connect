import 'package:flutter/material.dart';

class MessageList extends StatelessWidget {
  const MessageList({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 20, // Replace with your actual data length
      itemBuilder: (context, index) {
        return const ListTile(
          leading: CircleAvatar(
            backgroundImage: AssetImage('assets/profile_placeholder.svg'),
          ),
          title: Text('Dr Name'),
          subtitle: Text('Message Content'),
          trailing: Text('Date/time'),
        );
      },
    );
  }
}
