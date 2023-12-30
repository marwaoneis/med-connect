import 'package:flutter/material.dart';

class DoctorScreen extends StatelessWidget {
  const DoctorScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Doctor Dashboard'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              'Welcome, Doctor!',
              style: Theme.of(context).textTheme.headline4,
            ),
            SizedBox(height: 20),
            // Example content: Add widgets that are relevant for the doctor's screen
            Text(
              'Appointments',
              style: Theme.of(context).textTheme.headline6,
            ),
            // Here you might list upcoming appointments, etc.
            // ...
            // Add more widgets as needed for the doctor's functionalities
          ],
        ),
      ),
    );
  }
}
