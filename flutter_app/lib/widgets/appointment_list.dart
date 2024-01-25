import 'package:flutter/material.dart';

class AppointmentList extends StatelessWidget {
  final List<FutureBuilder> appointments;
  final String title;

  const AppointmentList({
    super.key,
    required this.title,
    required this.appointments,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Colors.grey.shade300, width: 1),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 8.0, bottom: 8.0),
            child: Text(
              title,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
          ),
          Column(
            children: appointments,
          ),
        ],
      ),
    );
  }
}
