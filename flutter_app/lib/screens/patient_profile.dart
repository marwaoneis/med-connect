import 'package:flutter/material.dart';
import 'package:flutter_app/screens/buy_medicine.dart';
import 'package:flutter_app/screens/login_screen.dart';
import 'package:flutter_app/screens/medical_history.dart';
import 'package:flutter_app/screens/symptom_checker.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

import '../providers/auth_provider.dart';
import '../widgets/footer.dart';
import 'message_screen.dart';
import 'patient_appointments.dart';
import 'patient_screen.dart';

class PatientProfileScreen extends StatelessWidget {
  const PatientProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: const Text('Profile', style: TextStyle(color: Colors.black)),
        backgroundColor: Colors.white,
        actions: [
          IconButton(
            icon: const Icon(
              Icons.email_outlined,
              color: Color(0xFF0D4C92),
              size: 30,
            ),
            onPressed: () {
              // TODO: Add edit profile action
            },
          ),
        ],
        centerTitle: true,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 20),
            _buildProfileCard(),
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
            _buildOption('assets/weight_scale.svg', 'Weight and Height', '',
                onTap: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                    builder: (context) => const BookAppointmentScreen()),
              );
            }),
            _buildOption('assets/personal_info.svg', 'Personal Information', '',
                onTap: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                    builder: (context) => const BookAppointmentScreen()),
              );
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
                  MaterialPageRoute(builder: (context) => LoginScreen()),
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
                          Navigator.of(ctx).pop(); // Dismiss the dialog
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

  Widget _buildProfileCard() {
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
      child: const Padding(
        padding: EdgeInsets.all(16),
        child: Row(
          children: [
            CircleAvatar(
              radius: 40,
              backgroundImage: NetworkImage('https://via.placeholder.com/150'),
            ),
            SizedBox(width: 20),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Cooper, Birnard',
                      style:
                          TextStyle(fontSize: 25, fontWeight: FontWeight.bold)),
                  Text('04/12/1978',
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                          fontWeight: FontWeight.w500)),
                  Text('(316) 555-0116',
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                          fontWeight: FontWeight.w500)),
                ],
              ),
            ),
            Icon(
              Icons.edit,
              color: Color(0xFF0D4C92),
              size: 30,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildOption(String svgAssetPath, String title, String subtitle,
      {VoidCallback? onTap}) {
    Color iconBackgroundColor = const Color(0xFF0D4C92).withOpacity(0.2);
    // Color iconColor = const Color(0xFF0D4C92);

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
                  // width: 32,
                  // height: 32,
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
