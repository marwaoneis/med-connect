import 'package:flutter/material.dart';
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
                  child: ListView(
                    children: [
                      TextFormField(
                        decoration:
                            const InputDecoration(labelText: 'First Name'),
                        validator: (value) =>
                            value!.isEmpty ? 'Enter your first name' : null,
                        onSaved: (value) => widget.formData.firstName = value!,
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
                      ElevatedButton(
                        child: const Text('Next'),
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            _formKey.currentState!.save();
                            // Navigate to part 2 of the sign-up screen
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
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
