import 'package:flutter/material.dart';
import 'package:flutter_app/screens/buy_medicine.dart';
import 'package:flutter_app/screens/login_screen.dart';
import 'package:flutter_app/screens/medical_history.dart';
import 'package:flutter_app/screens/symptom_checker.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../api/api_service.dart';
import '../config/request_config.dart';
import '../providers/auth_provider.dart';
import '../tools/request.dart';
import '../widgets/footer.dart';
import 'message_screen.dart';
import 'patient_appointments.dart';
import 'patient_dashboard_screen.dart';

class PatientProfileScreen extends StatefulWidget {
  const PatientProfileScreen({super.key});

  @override
  PatientProfileScreenState createState() => PatientProfileScreenState();
}

class PatientProfileScreenState extends State<PatientProfileScreen> {
  Map<String, dynamic>? patientData;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchPatientData().then((data) {
      if (mounted) {
        setState(() {
          patientData = data;
          isLoading = false;
        });
      }
    });
  }

  Future<Map<String, dynamic>> _fetchPatientData() async {
    var headers = RequestConfig.getHeaders(context);

    final apiService =
        ApiService(baseUrl: 'http://10.0.2.2:3001', headers: headers);
    final userId = Provider.of<Auth>(context, listen: false).getUserId;
    var data = await apiService.fetchData('patients/$userId');
    return data;
  }

  Future<void> _showEditWeightHeightDialog(
      BuildContext context, Map<String, dynamic> patientData) async {
    String patientId = patientData['_id'];
    String currentWeight = patientData['additionalInfo']['weight'] ?? '';
    String currentHeight = patientData['additionalInfo']['height'] ?? '';
    String newWeight = currentWeight;
    String newHeight = currentHeight;
    ScaffoldMessengerState scaffoldMessenger = ScaffoldMessenger.of(context);
    NavigatorState navigator = Navigator.of(context);

    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Edit Weight and Height'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                TextFormField(
                  initialValue: currentWeight,
                  decoration:
                      const InputDecoration(hintText: 'Enter Weight in kg'),
                  onChanged: (value) => newWeight = value,
                ),
                TextFormField(
                  initialValue: currentHeight,
                  decoration:
                      const InputDecoration(hintText: 'Enter Height in cm'),
                  onChanged: (value) => newHeight = value,
                ),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Save'),
              onPressed: () async {
                try {
                  dynamic response;
                  if (currentWeight.isEmpty && currentHeight.isEmpty) {
                    response = await sendRequest(
                      route: '/patients/$patientId/additional-info',
                      method: "POST",
                      load: {"key": "weight", "value": newWeight},
                      context: context,
                    );
                    if (!mounted) return;
                    response = await sendRequest(
                      route: '/patients/$patientId/additional-info',
                      method: "POST",
                      load: {"key": "height", "value": newHeight},
                      context: context,
                    );
                  } else {
                    response = await sendRequest(
                      route: '/patients/$patientId',
                      method: "PUT",
                      load: {
                        "additionalInfo": {
                          "weight": newWeight,
                          "height": newHeight
                        }
                      },
                      context: context,
                    );
                  }

                  if (!mounted) return;

                  if (response != null) {
                    Map<String, dynamic> updatedPatientData =
                        await _fetchPatientData();

                    setState(() {
                      patientData = updatedPatientData;
                    });
                    navigator.pop();
                    scaffoldMessenger.showSnackBar(
                      const SnackBar(
                          content:
                              Text('Weight and Height updated successfully!')),
                    );
                  } else {
                    navigator.pop(); // Close the dialog
                    scaffoldMessenger.showSnackBar(
                      const SnackBar(content: Text('Failed to update data')),
                    );
                  }
                } catch (error) {
                  if (!mounted) return;
                  Navigator.of(context).pop();
                  scaffoldMessenger.showSnackBar(
                    SnackBar(content: Text('Error: $error')),
                  );
                }
              },
            ),
          ],
        );
      },
    );
  }

  Future<void> _showEditPersonalInfoDialog(
      BuildContext context, Map<String, dynamic> patientData) async {
    String patientId = patientData['_id'];
    TextEditingController usernameController =
        TextEditingController(text: patientData['username']);
    TextEditingController passwordController = TextEditingController();
    TextEditingController firstNameController =
        TextEditingController(text: patientData['firstName']);
    TextEditingController lastNameController =
        TextEditingController(text: patientData['lastName']);
    TextEditingController emailController =
        TextEditingController(text: patientData['email']);
    TextEditingController addressController =
        TextEditingController(text: patientData['address']);
    TextEditingController phoneController =
        TextEditingController(text: patientData['phone']);
    TextEditingController dobController = TextEditingController(
        text: DateFormat('yyyy-MM-dd')
            .format(DateTime.parse(patientData['dateOfBirth'])));
    TextEditingController genderController =
        TextEditingController(text: patientData['gender']);

    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        ScaffoldMessengerState scaffoldMessenger =
            ScaffoldMessenger.of(context);
        NavigatorState navigator = Navigator.of(context);

        return AlertDialog(
          title: const Text('Edit Personal Information'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                TextFormField(
                  controller: usernameController,
                  decoration: const InputDecoration(labelText: 'Username'),
                ),
                TextFormField(
                  controller: passwordController,
                  decoration: const InputDecoration(
                      labelText: 'Password', hintText: 'Edit Password'),
                  obscureText: true,
                ),
                TextFormField(
                  controller: firstNameController,
                  decoration: const InputDecoration(labelText: 'First Name'),
                ),
                TextFormField(
                  controller: lastNameController,
                  decoration: const InputDecoration(labelText: 'Last Name'),
                ),
                TextFormField(
                  controller: emailController,
                  decoration: const InputDecoration(labelText: 'Email'),
                ),
                TextFormField(
                  controller: addressController,
                  decoration: const InputDecoration(labelText: 'Address'),
                ),
                TextFormField(
                  controller: phoneController,
                  decoration: const InputDecoration(labelText: 'Phone Number'),
                ),
                TextFormField(
                  controller: dobController,
                  decoration: const InputDecoration(labelText: 'Date of Birth'),
                ),
                TextFormField(
                  controller: genderController,
                  decoration: const InputDecoration(labelText: 'Gender'),
                ),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text('Save'),
              onPressed: () async {
                Map<String, dynamic> updateData = {
                  "username": usernameController.text,
                  "password": passwordController.text,
                  "firstName": firstNameController.text,
                  "lastName": lastNameController.text,
                  "email": emailController.text,
                  "address": addressController.text,
                  "phone": phoneController.text,
                  "dateOfBirth": dobController.text,
                  "gender": genderController.text,
                };

                try {
                  dynamic response = await sendRequest(
                    route: '/patients/$patientId',
                    method: "PUT",
                    load: updateData,
                    context: context,
                  );

                  if (response != null) {
                    Map<String, dynamic> updatedPatientData =
                        await _fetchPatientData();

                    setState(() {
                      patientData = updatedPatientData;
                    });
                    navigator.pop();
                    scaffoldMessenger.showSnackBar(
                      const SnackBar(
                          content: Text('Personal Info updated successfully!')),
                    );
                  } else {
                    navigator.pop(); // Close the dialog
                    scaffoldMessenger.showSnackBar(
                      const SnackBar(content: Text('Failed to update data')),
                    );
                  }
                } catch (error) {
                  if (!mounted) return;
                  Navigator.of(context).pop();
                  scaffoldMessenger.showSnackBar(
                    SnackBar(content: Text('Error: $error')),
                  );
                }
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => const PatientScreen()),
            );
          },
        ),
        title: const Text('Profile', style: TextStyle(color: Colors.black)),
        backgroundColor: Colors.white,
        centerTitle: true,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 20),
            if (!isLoading && patientData != null)
              _buildProfileCard(
                patientData!['firstName'] ?? 'N/A',
                patientData!['lastName'] ?? 'N/A',
                patientData!['phone'] ?? 'N/A',
                patientData!['dateOfBirth']?.toString() ?? 'N/A',
              ),
            if (isLoading)
              const Padding(
                padding: EdgeInsets.all(20.0),
                child: Text('Loading patient data...'),
              ),
            const SizedBox(height: 20),
            _buildOption("assets/medical.svg", 'Medical History',
                'Check Your Medical History', onTap: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                    builder: (context) => const MedicalHistoryScreen()),
              );
            }),
            _buildOption('assets/medicine.svg', 'Medicine & Supplements', '',
                onTap: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                    builder: (context) => const BuyMedicineScreen()),
              );
            }),
            _buildOption(
              'assets/weight_scale.svg',
              'Weight and Height',
              '',
              onTap: () async {
                var patient = await _fetchPatientData();
                _showEditWeightHeightDialog(context, patient);
              },
            ),
            _buildOption('assets/personal_info.svg', 'Personal Information', '',
                onTap: () async {
              var patient = await _fetchPatientData();
              _showEditPersonalInfoDialog(context, patient);
            }),
            _buildOption('assets/health_safety.svg', 'Symptom Checker', '',
                onTap: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                    builder: (context) => const SymptomCheckerScreen()),
              );
            }),
            _buildOption('assets/logout.svg', 'Log Out', '', onTap: () async {
              final authProvider = Provider.of<Auth>(context, listen: false);
              await authProvider.logout().then((_) {
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => const LoginScreen()),
                  (Route<dynamic> route) => false,
                );
              }).catchError((error) {
                showDialog(
                  context: context,
                  builder: (ctx) => AlertDialog(
                    title: const Text('Logout Failed'),
                    content: Text('An error occurred: $error'),
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
              });
            }),
          ],
        ),
      ),
      bottomNavigationBar: Footer(
        onHomeTap: () {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const PatientScreen()),
          );
        },
        onAppointmentTap: () {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (context) => const BookAppointmentScreen()),
          );
        },
        onChatTap: () {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const MessageScreen()),
          );
        },
        onProfileTap: () {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (context) => const PatientProfileScreen()),
          );
        },
      ),
    );
  }

  Widget _buildProfileCard(
      String firstName, String lastName, String phone, String dob) {
    String formattedDate;
    try {
      DateTime parsedDate = DateTime.parse(dob);
      formattedDate = DateFormat('yyyy-MM-dd').format(parsedDate);
    } catch (e) {
      formattedDate = 'Invalid Date';
    }
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Colors.grey.shade400),
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 2,
            blurRadius: 5,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            const CircleAvatar(
              radius: 40,
              backgroundImage: AssetImage("assets/myprofile.png"),
            ),
            const SizedBox(width: 20),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('$firstName $lastName',
                      style: const TextStyle(
                          fontSize: 25, fontWeight: FontWeight.bold)),
                  Row(
                    children: [
                      const Text('Date of Birth:',
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 16,
                              fontWeight: FontWeight.w800)),
                      Text(formattedDate,
                          style: const TextStyle(
                              color: Colors.black,
                              fontSize: 16,
                              fontWeight: FontWeight.w500)),
                    ],
                  ),
                  Row(
                    children: [
                      const Text('Phone Number:',
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 16,
                              fontWeight: FontWeight.w800)),
                      Text(phone,
                          style: const TextStyle(
                              color: Colors.black,
                              fontSize: 16,
                              fontWeight: FontWeight.w500)),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildOption(String svgAssetPath, String title, String subtitle,
      {VoidCallback? onTap}) {
    Color iconBackgroundColor = const Color(0xFF0D4C92).withOpacity(0.2);

    return Center(
      child: SizedBox(
        height: 85,
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(color: Colors.grey.shade400),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Center(
            child: ListTile(
              leading: Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: iconBackgroundColor,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: SvgPicture.asset(
                  svgAssetPath,
                ),
              ),
              title: Text(
                title,
                style:
                    const TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
              ),
              subtitle: subtitle.isNotEmpty ? Text(subtitle) : null,
              trailing: const Icon(Icons.arrow_forward_ios,
                  size: 16, color: Color(0xFF0D4C92)),
              onTap: onTap,
            ),
          ),
        ),
      ),
    );
  }
}
