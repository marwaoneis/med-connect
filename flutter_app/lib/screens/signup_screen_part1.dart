import 'package:flutter/material.dart';
import 'package:flutter_app/screens/login_screen.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'signup_screen_part2.dart';
import '../data/sign_up_form_data.dart';

class SignUpScreenPart1 extends StatefulWidget {
  final SignUpFormData formData;

  const SignUpScreenPart1({super.key, required this.formData});

  @override
  SignUpScreenPart1State createState() => SignUpScreenPart1State();
}

class SignUpScreenPart1State extends State<SignUpScreenPart1> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFC7D3E1),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 25),
              Image.asset('assets/logo.png', height: 200),
              const SizedBox(height: 25),
              Container(
                width: double.infinity,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(25),
                    topRight: Radius.circular(25),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        const SizedBox(height: 15),
                        const Text(
                          'Signup',
                          textAlign: TextAlign.left,
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                        Divider(
                          color: const Color(0xFF71717A),
                          thickness: 1,
                          indent: 7,
                          height: 6,
                          endIndent: MediaQuery.of(context).size.width - 95,
                        ),
                        const SizedBox(height: 15),
                        TextFormField(
                          decoration:
                              const InputDecoration(labelText: 'First Name'),
                          validator: (value) =>
                              value!.isEmpty ? 'Enter your first name' : null,
                          onSaved: (value) =>
                              widget.formData.firstName = value!,
                        ),
                        TextFormField(
                          decoration:
                              const InputDecoration(labelText: 'Last Name'),
                          validator: (value) =>
                              value!.isEmpty ? 'Enter your last name' : null,
                          onSaved: (value) => widget.formData.lastName = value!,
                        ),
                        TextFormField(
                          decoration:
                              const InputDecoration(labelText: 'Username'),
                          validator: (value) =>
                              value!.isEmpty ? 'Enter a username' : null,
                          onSaved: (value) => widget.formData.username = value!,
                        ),
                        TextFormField(
                          decoration: const InputDecoration(labelText: 'Email'),
                          keyboardType: TextInputType.emailAddress,
                          validator: (value) =>
                              value!.isEmpty || !value.contains('@')
                                  ? 'Enter a valid email'
                                  : null,
                          onSaved: (value) => widget.formData.email = value!,
                        ),
                        const SizedBox(height: 25),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(
                                0xFF0D4C92), // Button background color
                            foregroundColor: Colors.white, // Button text color
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(35),
                            ),
                            minimumSize: const Size(double.infinity,
                                50), // Setting the height to 40
                          ),
                          child: const Text(
                            'Next',
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.normal),
                          ),
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              _formKey.currentState!.save();
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => SignUpScreenPart2(
                                      formData: widget.formData),
                                ),
                              );
                            }
                          },
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(
                              "Don't have an account? ",
                              style: TextStyle(
                                fontSize: 14,
                                color:
                                    Colors.grey, // Set the text color to grey
                              ),
                            ),
                            TextButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => const LoginScreen(),
                                  ),
                                );
                              },
                              child: const Text(
                                'Login',
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors
                                      .black, // Set the text color to grey
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 10),
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
                        const SizedBox(height: 22),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            ElevatedButton(
                              onPressed: () {
                                // Implement Facebook sign-in functionality
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xFF0D4C92),
                                foregroundColor: const Color(0xFF4676ED),
                                minimumSize: const Size(100, 50),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                              child: Image.asset(
                                'assets/facebook.png',
                              ),
                            ),
                            const SizedBox(height: 15),
                            ElevatedButton(
                              onPressed: () {},
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xFF0D4C92),
                                foregroundColor: Colors.grey,
                                minimumSize: const Size(100, 50),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(
                                      10), // Rounded corners
                                ),
                                side: const BorderSide(color: Colors.grey),
                              ),
                              child: SvgPicture.asset(
                                'assets/chrome.svg',
                              ),
                            ),
                            const SizedBox(height: 15),
                            ElevatedButton(
                              onPressed: () {
                                // Implement Apple sign-in functionality
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(
                                    0xFF0D4C92), // Apple button color
                                foregroundColor: Colors.black, // Icon color
                                minimumSize: const Size(100, 50), // Square size
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(
                                      10), // Rounded corners
                                ),
                              ),
                              child: SvgPicture.asset(
                                'assets/apple.svg',
                              ),
                            ),
                            const SizedBox(height: 15),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
