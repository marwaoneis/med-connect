import 'package:flutter/material.dart';

class DoctorProfileScreen extends StatelessWidget {
  final String name;
  final String specialty;
  final int yearsOfExperience;
  final String fee;

  const DoctorProfileScreen({
    super.key,
    required this.name,
    required this.specialty,
    required this.yearsOfExperience,
    required this.fee,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(specialty),
        actions: [
          IconButton(
            icon: Icon(Icons.star_border),
            onPressed: () {
              // Handle favorite action
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            ListTile(
              leading: CircleAvatar(
                backgroundImage: AssetImage('assets/doctor_image.png'),
                radius: 40,
              ),
              title: Text(
                name,
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: Text(specialty),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Text(
                'Years of work: $yearsOfExperience',
                style: TextStyle(fontSize: 18),
              ),
            ),
            Card(
              margin: EdgeInsets.all(10),
              child: ListTile(
                title: Text('In-Clinic Appointment'),
                trailing: Text(fee),
              ),
            ),
            // Additional information like availability, timing, location, and map view
            // ...
          ],
        ),
      ),
    );
  }
}
