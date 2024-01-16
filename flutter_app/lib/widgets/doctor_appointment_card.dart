import 'package:flutter/material.dart';
import 'package:flutter_app/models/appointment_model.dart'; // Ensure you have this file

class AppointmentCard extends StatelessWidget {
  final Appointment appointment;

  const AppointmentCard({
    super.key,
    required this.appointment,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(10.0),
      child: ListTile(
        leading: Icon(Icons.person), // Replace with doctor's image if available
        title: Text(appointment.patientName), // Replace with actual data
        subtitle: Text(
            'Appointment at ${appointment.time}'), // Replace with actual data
        trailing: ElevatedButton(
          onPressed: () {
            // Add your onPressed logic here
          },
          child: Text(appointment.status), // Replace with actual data
          style: ElevatedButton.styleFrom(
            primary:
                appointment.status == 'Confirmed' ? Colors.green : Colors.red,
          ),
        ),
      ),
    );
  }
}
