import 'package:flutter/material.dart';
import 'next_screen_two.dart';

class NextScreen extends StatelessWidget {
  const NextScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('24/7 Online Consultation'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment:
              MainAxisAlignment.spaceBetween, // To distribute space evenly
          crossAxisAlignment: CrossAxisAlignment
              .stretch, // To stretch widgets across the screen width
          children: <Widget>[
            const Text(
              'Find a Doctor and make an appointment at your nearest location.',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.black,
                fontSize: 16,
              ),
            ),
            // Add your image asset here
            Image.asset(
              'assets/doctor_consultation_image.png', // Replace with your actual image asset
              height: 300, // Set a height that works with your layout
            ),
            // Indicator dots can be added using a package or custom widget
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                _buildIndicatorDot(true),
                _buildIndicatorDot(false),
                _buildIndicatorDot(false),
              ],
            ),
            ElevatedButton(
              child: const Text('Next'),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const NextScreenTwo()),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildIndicatorDot(bool isActive) {
    return Container(
      width: 8,
      height: 8,
      margin: const EdgeInsets.symmetric(horizontal: 4),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: isActive ? Colors.blue : Colors.grey,
      ),
    );
  }
}
