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
    return Card(
      child: ListTile(
        leading: const CircleAvatar(
          // Placeholder for patient image
          child: Icon(Icons.person),
        ),
        title: Text(name),
        subtitle: Text(details),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (status == 'Confirmed') ...[
              Icon(Icons.check, color: statusColor),
            ] else if (status == 'Declined') ...[
              Icon(Icons.close, color: statusColor),
            ],
            // Add more conditions for different statuses if needed
          ],
        ),
      ),
    );
  }
}
