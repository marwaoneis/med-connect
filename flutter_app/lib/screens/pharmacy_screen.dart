import 'package:flutter/material.dart';

class PharmacyScreen extends StatelessWidget {
  const PharmacyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pharmacy Dashboard'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              'Welcome, Pharmacy!',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            const SizedBox(height: 20),
            // Example content: Add widgets that are relevant for the Pharmacy's screen
            Text(
              'Appointments',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            // Here you might list upcoming appointments, etc.
            // ...
            // Add more widgets as needed for the Pharmacy's functionalities
          ],
        ),
      ),
    );
  }
}
