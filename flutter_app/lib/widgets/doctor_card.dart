import 'package:flutter/material.dart';

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
        leading: Image.network(
          'https://via.placeholder.com/150',
          fit: BoxFit.cover,
        ),
        title: Text(name),
        subtitle: Text('$specialty\n$experience Years · $rating'),
        trailing: Text(fee),
        isThreeLine: true,
        onTap: () {
          // TODO: Navigate to doctor's detail or booking screen
        },
      ),
    );
  }
}
