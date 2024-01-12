import 'package:flutter/material.dart';

import '../screens/doctor_profile.dart';

class DoctorCard extends StatelessWidget {
  final String name;
  final String specialty;
  final int experience;
  final double rating;
  final String fee;

  const DoctorCard({
    super.key,
    required this.name,
    required this.specialty,
    required this.experience,
    required this.rating,
    required this.fee,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(10.0),
      child: ListTile(
        leading: Image.asset(
          'assets/doctor_image.png',
          fit: BoxFit.cover,
        ),
        title: Text(name),
        subtitle: Text('$specialty\n$experience Years · $rating'),
        trailing: Text(fee),
        isThreeLine: true,
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => const DoctorProfileScreen()),
          );
        },
      ),
    );
  }
}
