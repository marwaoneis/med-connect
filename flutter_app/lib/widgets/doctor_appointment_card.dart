import 'package:flutter/material.dart';

typedef AppointmentActionCallback = void Function(String status);

class AppointmentCard extends StatefulWidget {
  final String name;
  final String details;
  final String status;
  final Color statusColor;
  final AppointmentActionCallback onStatusChanged;

  const AppointmentCard({
    super.key,
    required this.name,
    required this.details,
    required this.status,
    required this.statusColor,
    required this.onStatusChanged,
  });

  @override
  AppointmentCardState createState() => AppointmentCardState();
}

class AppointmentCardState extends State<AppointmentCard> {
  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: const CircleAvatar(
        child: Icon(Icons.person),
      ),
      title: Text(
        widget.name,
        style: const TextStyle(fontWeight: FontWeight.bold),
      ),
      contentPadding: const EdgeInsets.only(left: 16, right: 10),
      subtitle: Text(widget.details),
      trailing: widget.status == 'Scheduled'
          ? Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  icon: const Icon(Icons.check, color: Colors.green),
                  onPressed: () {
                    widget.onStatusChanged('Confirmed');
                  },
                  iconSize: 30,
                ),
                IconButton(
                  icon: Icon(Icons.close, color: Colors.red),
                  onPressed: () {
                    widget.onStatusChanged('Cancelled');
                  },
                  iconSize: 30,
                ),
              ],
            )
          : Text(
              widget.status,
              style: TextStyle(
                color: widget.status == 'Confirmed' ? Colors.green : Colors.red,
              ),
            ),
    );
  }
}
