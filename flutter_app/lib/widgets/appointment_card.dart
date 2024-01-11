import 'package:flutter/material.dart';
// import 'package:flutter_svg/flutter_svg.dart';

class AppointmentCard extends StatelessWidget {
  const AppointmentCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 15.0),
          child: Text(
            "Your next Appointment",
            style: TextStyle(
              fontSize: 16.0,
              fontWeight: FontWeight.w900,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(12),
          child: Card(
            color: Colors.white,
            shape: RoundedRectangleBorder(
              side: const BorderSide(color: Colors.grey, width: 1),
              borderRadius: BorderRadius.circular(15.0),
            ),
            elevation: 5,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: <Widget>[
                  const Row(
                    children: <Widget>[
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            'Dr. Shafiq Rahman',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                          SizedBox(height: 5),
                          Text(
                            'Emergency Medicine',
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.black,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  const Row(
                    children: <Widget>[
                      Icon(Icons.email_outlined,
                          color: Color(0xFF0D4C92), size: 15),
                      SizedBox(width: 8),
                      Text(
                        'shafiq.rahman@example.com',
                        style: TextStyle(fontSize: 12),
                      ),
                      Spacer(),
                      Icon(
                        Icons.phone,
                        color: Color(0xFF0D4C92),
                        size: 15,
                      ),
                      SizedBox(width: 8),
                      Text('+7 (903) 880-93-38',
                          style: TextStyle(fontSize: 12)),
                    ],
                  ),
                  const SizedBox(height: 16),
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Column(
                        children: [
                          Text('Date', style: TextStyle(fontSize: 14)),
                          Text('2024-01-01',
                              style: TextStyle(
                                  fontSize: 14, fontWeight: FontWeight.bold)),
                        ],
                      ),
                      Column(
                        children: [
                          Text('Time', style: TextStyle(fontSize: 14)),
                          Text('05:30',
                              style: TextStyle(
                                  fontSize: 14, fontWeight: FontWeight.bold)),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  const Row(
                    children: <Widget>[
                      Icon(Icons.location_on, color: Color(0xFF0D4C92)),
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
                        icon: const Icon(
                          Icons.email,
                          color: Color(0xFF0D4C92),
                          size: 30,
                        ),
                        onPressed: () {
                          // Handle email tap
                        },
                      ),
                      IconButton(
                        icon: const Icon(
                          Icons.phone,
                          color: Color(0xFF0D4C92),
                          size: 30,
                        ),
                        onPressed: () {
                          // Handle phone tap
                        },
                      ),
                      IconButton(
                        icon: const Icon(
                          Icons.edit,
                          color: Color(0xFF0D4C92),
                          size: 30,
                        ),
                        onPressed: () {
                          // Handle edit tap
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
