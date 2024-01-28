import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/auth_provider.dart';
import '../data/sign_up_form_data.dart';
import 'patient_dashboard_screen.dart';

class SignUpScreenPart2 extends StatefulWidget {
  final SignUpFormData formData;

  const SignUpScreenPart2({super.key, required this.formData});

  @override
  SignUpScreenPart2State createState() => SignUpScreenPart2State();
}

class SignUpScreenPart2State extends State<SignUpScreenPart2> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _isLoading = false;
  String? _dateOfBirthError;

  Future<void> _register() async {
    if (!_formKey.currentState!.validate()) return;
    _formKey.currentState!.save();

    final scaffoldMessenger = ScaffoldMessenger.of(context);

    setState(() {
      _isLoading = true;
    });

    try {
      await Provider.of<Auth>(context, listen: false).signUp(widget.formData);

      if (mounted) {
        scaffoldMessenger.showSnackBar(
          const SnackBar(
            content: Text('Registration successful!'),
            backgroundColor: Colors.green,
          ),
        );

        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const PatientScreen()),
        );
      }
    } catch (error) {
      _showErrorDialog(error.toString());
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
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

  Map<String, dynamic> _parseAdditionalInfo(String additionalInfo) {
    var infoParts = additionalInfo.split('BloodGroup:');
    var medicalInfo = infoParts[0].split('MedicalInfo:').last.trim();
    var bloodGroup = infoParts.length > 1 ? infoParts[1].trim() : '';

    return {
      'MedicalInfo': medicalInfo,
      'BloodGroup': bloodGroup,
    };
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          SafeArea(
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
                                const InputDecoration(labelText: 'Email'),
                            keyboardType: TextInputType.emailAddress,
                            validator: (value) =>
                                value!.isEmpty || !value.contains('@')
                                    ? 'Enter a valid email'
                                    : null,
                            onSaved: (value) => widget.formData.email = value!,
                          ),
                          TextFormField(
                            decoration:
                                const InputDecoration(labelText: 'Address'),
                            onSaved: (value) =>
                                widget.formData.address = value!,
                          ),
                          TextFormField(
                            decoration: const InputDecoration(
                                labelText: 'Phone Number'),
                            keyboardType: TextInputType.phone,
                            onSaved: (value) => widget.formData.phone = value!,
                          ),
                          TextFormField(
                            decoration: InputDecoration(
                              labelText: 'Date of Birth (yyyy-MM-dd)',
                              errorText: _dateOfBirthError,
                            ),
                            keyboardType: TextInputType.datetime,
                            onSaved: (value) {
                              setState(() => _dateOfBirthError = null);
                              if (value != null && value.isNotEmpty) {
                                try {
                                  widget.formData.dateOfBirth =
                                      DateTime.parse(value);
                                } catch (e) {
                                  setState(() => _dateOfBirthError =
                                      'Invalid date format');
                                  widget.formData.dateOfBirth = null;
                                }
                              } else {
                                widget.formData.dateOfBirth = null;
                              }
                            },
                            validator: (value) {
                              if (value != null && value.isNotEmpty) {
                                try {
                                  DateTime.parse(value);
                                  return null;
                                } catch (e) {
                                  return 'Enter date in yyyy-MM-dd format';
                                }
                              }
                              return null;
                            },
                          ),
                          TextFormField(
                            decoration:
                                const InputDecoration(labelText: 'Gender'),
                            onSaved: (value) => widget.formData.gender = value!,
                          ),
                          TextFormField(
                            decoration: const InputDecoration(
                              labelText: 'Additional Info',
                              hintText: 'Medical Info and Blood Group',
                            ),
                            onSaved: (value) {
                              if (value != null) {
                                widget.formData.additionalInfo =
                                    _parseAdditionalInfo(value);
                              }
                            },
                          ),
                          const SizedBox(height: 35),
                          _isLoading
                              ? const CircularProgressIndicator()
                              : ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: const Color(0xFF0D4C92),
                                    foregroundColor: Colors.white,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(35),
                                    ),
                                    minimumSize:
                                        const Size(double.infinity, 50),
                                  ),
                                  onPressed: _register,
                                  child: const Text(
                                    'Sign Up',
                                    style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.normal),
                                  ),
                                ),
                          const SizedBox(height: 12),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          SafeArea(
            child: Align(
              alignment: Alignment.topLeft,
              child: IconButton(
                icon: const Icon(Icons.arrow_back, color: Colors.black),
                onPressed: () => Navigator.of(context).pop(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
