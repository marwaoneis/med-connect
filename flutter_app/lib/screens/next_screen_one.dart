import 'package:flutter/material.dart';
import 'next_screen_two.dart';

class NextScreenOne extends StatelessWidget {
  const NextScreenOne({super.key});

  @override
  Widget build(BuildContext context) {
    // MediaQuery provides the dimensions of the screen
    final screenSize = MediaQuery.of(context).size;

    return Scaffold(
        backgroundColor: Colors.white,
        body: Center(
          // Centers the child horizontally
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: 334, // Set your desired width here
                  child: Column(
                    children: [
                      const Text(
                        '24/7 Online Consultation',
                        style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.w900,
                          color: Colors.black,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const Padding(
                        padding: EdgeInsets.only(top: 8.0),
                        child: Text(
                          'Find a Doctor and make an appointment at your nearest location.',
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.black,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 16.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: List.generate(
                              3, (index) => _buildIndicatorDot(index == 0)),
                        ),
                      ),
                    ],
                  ),
                ),
                Stack(
                  clipBehavior: Clip.none,
                  alignment: Alignment.bottomCenter,
                  children: [
                    Container(
                      width: screenSize.width * 0.8,
                      height: screenSize.height * 0.5,
                      margin: const EdgeInsets.only(
                          top: 100), // Space above the gradient box
                      decoration: const BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [Colors.white, Color(0xFF0D4C92)],
                        ),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            'assets/doctor_consultation_1.png',
                          ),
                        ],
                      ),
                    ),
                    Positioned(
                      bottom: -30,
                      child: MouseRegion(
                        cursor: SystemMouseCursors.click,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(
                                0xFF0D4C92), // Button background color
                            foregroundColor: Colors.white, // Text color
                            fixedSize: const Size(238, 78), // Button size
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(
                                  30), // Button border radius
                            ),
                            elevation: 0,
                          ),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const NextScreenTwo()),
                            );
                          },
                          child: const Text(
                            'Next',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
                const SizedBox(
                    height:
                        78 / 2), // Space for the overflowing part of the button
              ],
            ),
          ),
        ));
  }

  Widget _buildIndicatorDot(bool isActive) {
    return Container(
      width: isActive ? 30 : 15,
      height: 10, // Height is the same for both active and inactive dots
      margin: const EdgeInsets.symmetric(horizontal: 5),
      decoration: BoxDecoration(
        color: isActive ? const Color(0xFF0D4C92) : Colors.grey,
        borderRadius:
            isActive ? BorderRadius.circular(10) : BorderRadius.circular(50),
      ),
    );
  }
}
