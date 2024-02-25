import 'package:flutter/material.dart';
// import 'package:flutter_app/widgets/forgot_password_screen.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'signup_screen_part1.dart';
import '../data/sign_up_form_data.dart';
import 'package:provider/provider.dart';
import '../providers/auth_provider.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  LoginScreenState createState() => LoginScreenState();
}

class LoginScreenState extends State<LoginScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  UserType _userType = UserType.patient;
  String _username = '';
  String _password = '';
  bool _isLoading = false;

  void _forgotPassword() {
    // Navigator.of(context).push(
    //     MaterialPageRoute(builder: (context) => const ForgotPasswordScreen()));
  }

  Future<void> _login() async {
    if (!_formKey.currentState!.validate()) return;
    _formKey.currentState!.save();
    setState(() => _isLoading = true);

    try {
      await Provider.of<Auth>(context, listen: false).login(
        _username,
        _password,
        _userType,
      );

      if (!mounted) return;

      switch (_userType) {
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
    } catch (error) {
      if (!mounted) return;
      _showErrorDialog(error.toString());
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
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
      backgroundColor: Colors.white,
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
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(25),
                    topRight: Radius.circular(25),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 1,
                      blurRadius: 5,
                      offset: const Offset(0, -2),
                    ),
                  ],
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
                          'Log In',
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
                        const SizedBox(height: 30),
                        TextFormField(
                          decoration: const InputDecoration(
                            hintText: 'Username',
                            prefixIcon: Icon(Icons.person),
                            prefixIconColor: Color(0xFF0D4C92),
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
                            onPressed: _forgotPassword,
                            style: TextButton.styleFrom(
                              padding: const EdgeInsets.fromLTRB(0, 0, 0, 12),
                              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                            ),
                            child: const Text(
                              'Forgot Password ?',
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.grey,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 10),
                        DropdownButton<UserType>(
                          value: _userType,
                          onChanged: (UserType? newValue) {
                            setState(() {
                              _userType = newValue!;
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
                        const SizedBox(height: 25),
                        ElevatedButton(
                          onPressed: _isLoading ? null : _login,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF0D4C92),
                            foregroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(35),
                            ),
                            minimumSize: const Size(double.infinity, 50),
                          ),
                          child: _isLoading
                              ? const CircularProgressIndicator()
                              : const Text(
                                  'Log In',
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
                                color: Colors.grey,
                              ),
                            ),
                            TextButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => SignUpScreenPart1(
                                        formData: SignUpFormData()),
                                  ),
                                );
                              },
                              child: const Text(
                                'Sign Up',
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.black,
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
                        const SizedBox(height: 23),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            ElevatedButton(
                              onPressed: () {},
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
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                side: const BorderSide(color: Colors.grey),
                              ),
                              child: SvgPicture.asset(
                                'assets/google.svg',
                              ),
                            ),
                            const SizedBox(height: 15),
                            ElevatedButton(
                              onPressed: () {},
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xFF0D4C92),
                                foregroundColor: Colors.white,
                                minimumSize: const Size(100, 50),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                              child: const Icon(
                                Icons.apple,
                                size: 40,
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
