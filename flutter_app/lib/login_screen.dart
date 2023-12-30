import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

enum UserType { patient, doctor, pharmacy }

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  LoginScreenState createState() => LoginScreenState();
}

class LoginScreenState extends State<LoginScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  UserType _selectedUserType = UserType.patient;
  String _username = '';
  String _password = '';
  bool _isLoading = false;
  final _storage = FlutterSecureStorage();

  Future<void> _login() async {
    if (!_formKey.currentState!.validate()) return;
    _formKey.currentState!.save();
    setState(() => _isLoading = true);

    String url;
    switch (_selectedUserType) {
      case UserType.patient:
        url = 'http://localhost:3001/patient/auth/login';
        break;
      case UserType.doctor:
        url = 'http://localhost:3001/doctor/auth/login';
        break;
      case UserType.pharmacy:
        url = 'http://localhost:3001/pharmacy/auth/login';
        break;
    }

    try {
      final response = await http.post(
        Uri.parse(url),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({'username': _username, 'password': _password}),
      );

      if (response.statusCode == 200) {
        final responseData = json.decode(response.body);
        await _storage.write(key: 'token', value: responseData['token']);

        // Navigate based on user type
        switch (_selectedUserType) {
          case UserType.patient:
            Navigator.pushReplacementNamed(context, '/patientScreen');
            break;
          case UserType.doctor:
            Navigator.pushReplacementNamed(context, '/doctorScreen');
            break;
          case UserType.pharmacy:
            Navigator.pushReplacementNamed(context, '/pharmacyScreen');
            break;
        }
      } else {
        // Show error message
        final responseData = json.decode(response.body);
        _showErrorDialog(responseData['error']);
      }
    } catch (e) {
      _showErrorDialog('Failed to connect to the server');
    }

    setState(() => _isLoading = false);
  }

  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('An Error Occurred'),
        content: Text(message),
        actions: <Widget>[
          TextButton(
            child: const Text('Okay'),
            onPressed: () {
              Navigator.of(ctx).pop();
            },
          ),
        ],
      ),
    );
  }

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
                          'Login',
                          textAlign: TextAlign.left,
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                        Divider(
                          color: const Color(0xFF71717A), // Color of the line
                          thickness: 1, // Thickness of the line
                          indent: 7,
                          height: 6,
                          endIndent: MediaQuery.of(context).size.width -
                              95, // Right spacing to make the line 50 width
                        ),
                        const SizedBox(height: 30),
                        TextFormField(
                          decoration: const InputDecoration(
                            hintText: 'Username',
                            prefixIcon: Icon(Icons.person),
                          ),
                          onSaved: (value) {
                            _username = value!;
                          },
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Please enter your username';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 16),
                        TextFormField(
                          decoration: const InputDecoration(
                            hintText: 'Enter your password',
                            prefixIcon: Icon(Icons.password),
                            prefixIconColor: Color(0xFF0D4C92),
                            border: UnderlineInputBorder(),
                            contentPadding: EdgeInsets.fromLTRB(12, 12, 12, 0),
                          ),
                          obscureText: true,
                          onSaved: (value) {
                            _password = value!;
                          },
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Please enter your password';
                            }
                            return null;
                          },
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
                                color:
                                    Colors.grey, // Set the text color to grey
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 25),
                        // User Type Selection
                        DropdownButton<UserType>(
                          value: _selectedUserType,
                          onChanged: (UserType? newValue) {
                            setState(() {
                              _selectedUserType = newValue!;
                            });
                          },
                          items: UserType.values
                              .map<DropdownMenuItem<UserType>>(
                                  (UserType value) {
                            return DropdownMenuItem<UserType>(
                              value: value,
                              child: Text(value.toString().split('.').last),
                            );
                          }).toList(),
                        ),
                        const SizedBox(
                            height: 25), // Spacing before login button
                        ElevatedButton(
                          onPressed: _isLoading ? null : _login,
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
                          child: _isLoading
                              ? const CircularProgressIndicator()
                              : const Text(
                                  'Login',
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.normal),
                                ),
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
                                // Navigate to the sign-up screen
                              },
                              child: const Text(
                                'Sign-up',
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors
                                      .black, // Set the text color to grey
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 25),
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
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            ElevatedButton(
                              onPressed: () {
                                // Implement Facebook sign-in functionality
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xFF0D4C92),
                                foregroundColor:
                                    const Color(0xFF4676ED), // Icon color
                                minimumSize: const Size(100, 50), // Square size
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(
                                      10), // Rounded corners
                                ),
                              ),
                              child: SvgPicture.asset(
                                'assets/facebook.svg',
                              ),
                            ),
                            const SizedBox(height: 15),
                            ElevatedButton(
                              onPressed: () {
                                // Implement Google sign-in functionality
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(
                                    0xFF0D4C92), // Fa, // Google button color
                                foregroundColor: Colors.grey, // Icon color
                                minimumSize: const Size(100, 50), // Square size
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(
                                      10), // Rounded corners
                                ),
                                side: const BorderSide(
                                    color: Colors
                                        .grey), // Border color for visibility
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
                          ],
                        ),
                        const SizedBox(height: 15),
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
