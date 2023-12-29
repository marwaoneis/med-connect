import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:
          const Color(0xFFC7D3E1), // Screen background color with 20% opacity
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(height: 25), // Adjust the space as needed
            Image.asset('assets/logo.png',
                height: 200), // Place your logo asset
            const SizedBox(height: 30), // Space between logo and the white box
            // White box with top rounded corners
            Container(
              width: double.infinity,
              // height: ,
              decoration: const BoxDecoration(
                color: Colors.white, // White background color for the box
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(25), // Top left radius
                  topRight: Radius.circular(25), // Top right radius
                ),
              ),
              child: Padding(
                padding:
                    const EdgeInsets.all(20.0), // Padding inside the white box
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const SizedBox(
                        height: 20), // Spacing at the top inside the box
                    const Text(
                      'Login',
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    const SizedBox(height: 24), // Spacing after title
                    const Text(
                      'Email',
                      style: TextStyle(fontSize: 16),
                    ),
                    TextFormField(
                      decoration: const InputDecoration(
                        hintText: 'Enter your email',
                        prefixIcon: Icon(Icons.email),
                        prefixIconColor: Color(0xFF0D4C92),
                        border: UnderlineInputBorder(),
                      ),
                      keyboardType: TextInputType.emailAddress,
                    ),
                    const SizedBox(height: 16), // Spacing between text fields
                    const Text(
                      'Password',
                      style: TextStyle(fontSize: 16),
                    ),
                    TextFormField(
                      decoration: const InputDecoration(
                        hintText: 'Enter your password',
                        prefixIcon: Icon(Icons.password),
                        prefixIconColor: Color(0xFF0D4C92),
                        border: UnderlineInputBorder(),
                        contentPadding: EdgeInsets.fromLTRB(12, 12, 12, 0),
                      ),
                      obscureText: true,
                    ),
                    Align(
                      alignment: Alignment.centerRight,
                      child: TextButton(
                        onPressed: () {
                          // Implement forgot password functionality
                        },
                        style: TextButton.styleFrom(
                          padding: const EdgeInsets.fromLTRB(0, 0, 0, 12),
                          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        ),
                        child: const Text(
                          'Forgot Password ?',
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.grey, // Set the text color to grey
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 30), // Spacing before login button
                    ElevatedButton(
                      onPressed: () {
                        // Implement login functionality
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor:
                            const Color(0xFF0D4C92), // Button background color
                        foregroundColor: Colors.white, // Button text color
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(35),
                        ),
                        minimumSize: const Size(
                            double.infinity, 50), // Setting the height to 40
                      ),
                      child: const Text(
                        'Login',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.normal),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          "Don't have an account? ",
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.grey, // Set the text color to grey
                          ),
                        ),
                        TextButton(
                          onPressed: () {
                            // Navigate to the sign-up screen
                          },
                          child: const Text(
                            'Sign-up',
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.black, // Set the text color to grey
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 30),
                    const Row(
                      children: [
                        Expanded(
                          child: Divider(color: Color(0xFF71717A)),
                        ),
                        SizedBox(width: 5),
                        Text(
                          'OR',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: Color(0xFF71717A),
                              fontWeight: FontWeight.bold),
                        ),
                        SizedBox(width: 5),
                        Expanded(
                          child: Divider(color: Color(0xFF71717A)),
                        ),
                      ],
                    ),
                    const SizedBox(height: 35),
                    // Add social media buttons here
                    // Example for one social media button
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        // Facebook Button
                        ElevatedButton(
                          onPressed: () {
                            // Implement Facebook sign-in functionality
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(
                                0xFF0D4C92), // Facebook button color
                            foregroundColor:
                                const Color(0xFF4676ED), // Icon color
                            minimumSize: const Size(50, 50), // Square size
                            shape: RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.circular(10), // Rounded corners
                            ),
                          ),
                          child: SvgPicture.asset(
                            'assets/facebook.svg',
                          ),
                        ),
                        // Google Button
                        ElevatedButton(
                          onPressed: () {
                            // Implement Google sign-in functionality
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(
                                0xFF0D4C92), // Fa, // Google button color
                            foregroundColor: Colors.grey, // Icon color
                            minimumSize: const Size(50, 50), // Square size
                            shape: RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.circular(10), // Rounded corners
                            ),
                            side: const BorderSide(
                                color:
                                    Colors.grey), // Border color for visibility
                          ),
                          child: SvgPicture.asset(
                            'assets/chrome.svg',
                          ),
                        ),
                        // Apple Button
                        ElevatedButton(
                          onPressed: () {
                            // Implement Apple sign-in functionality
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor:
                                const Color(0xFF0D4C92), // Apple button color
                            foregroundColor: Colors.black, // Icon color
                            minimumSize: const Size(50, 50), // Square size
                            shape: RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.circular(10), // Rounded corners
                            ),
                          ),
                          child: SvgPicture.asset(
                            'assets/apple.svg', // Replace with your asset name
                            width: 24,
                            height: 24,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
