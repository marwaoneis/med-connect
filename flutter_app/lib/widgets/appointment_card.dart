import 'package:flutter/material.dart';
// import 'package:flutter_svg/flutter_svg.dart';

class AppointmentCard extends StatelessWidget {
  const AppointmentCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      elevation: 5,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            Row(
              children: <Widget>[
                // Replace with an actual image of the doctor
                CircleAvatar(
                  radius: 24,
                  backgroundColor: Colors.grey[300],
                  child:
                      const Text('DR'), // Placeholder for the doctor's initials
                ),
                const SizedBox(width: 16),
                const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      'Dr. Shafiq Rahman',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      'Emergency Medicine',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 16),
            const Row(
              children: <Widget>[
                Icon(Icons.email, color: Colors.grey),
                SizedBox(width: 8),
                Text('shafiq.rahman@example.com'),
                Spacer(),
                Text('+7 (903) 880-93-38'),
              ],
            ),
            const SizedBox(height: 16),
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text('2024-01-01'),
                Text('05:30'),
              ],
            ),
            const SizedBox(height: 16),
            const Row(
              children: <Widget>[
                Icon(Icons.location_on, color: Colors.grey),
                SizedBox(width: 8),
                Text('Great Falls, Maryland'),
                Spacer(),
                Text('Open in Google Maps'),
              ],
            ),
            const Divider(height: 32),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                IconButton(
                  icon: const Icon(Icons.email),
                  onPressed: () {
                    // Handle email tap
                  },
                ),
                IconButton(
                  icon: const Icon(Icons.phone),
                  onPressed: () {
                    // Handle phone tap
                  },
                ),
                IconButton(
                  icon: const Icon(Icons.edit),
                  onPressed: () {
                    // Handle edit tap
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
