import 'package:flutter/material.dart';

class AppointmentCard extends StatelessWidget {
  final String name;
  final String details;
  final String status;
  final Color statusColor;

  const AppointmentCard({
    super.key,
    required this.name,
    required this.details,
    required this.status,
    required this.statusColor,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: const CircleAvatar(
        child: Icon(Icons.person),
      ),
      title: Text(
        name,
        style: const TextStyle(fontWeight: FontWeight.bold),
      ),
      subtitle: Text(details),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (status == 'Confirmed') ...[
            Icon(Icons.check, color: statusColor),
          ] else if (status == 'Declined') ...[
            Icon(Icons.close, color: statusColor),
          ],
        ],
      ),
    );
  }
}
