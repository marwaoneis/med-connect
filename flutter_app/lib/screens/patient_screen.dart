import 'package:flutter/material.dart';

class PatientScreen extends StatelessWidget {
  const PatientScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Patient Dashboard'),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pushReplacementNamed(context, '/'),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              'Welcome, Patient!',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            const SizedBox(height: 20),
            // Example content: Add widgets that are relevant for the doctor's screen
            Text(
              'Appointments',
              style: Theme.of(context).textTheme.titleLarge,
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
