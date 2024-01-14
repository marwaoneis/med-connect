import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

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
              // TODO: Add Medical History action
            }),
            _buildOption('assets/medicine.svg', 'Medicine & Supplements', '',
                onTap: () {
              // TODO: Add Medicine & Supplements action
            }),
            _buildOption('assets/weight_scale.svg', 'Weight and Height', '',
                onTap: () {
              // TODO: Add Weight and Height action
            }),
            _buildOption('assets/personal_info.svg', 'Personal Information', '',
                onTap: () {
              // TODO: Add Personal Information action
            }),
            _buildOption('assets/health_safety.svg', 'Symptom Checker', '',
                onTap: () {
              // TODO: Add Symptom Checker action
            }),
            _buildOption('assets/logout.svg', 'Log Out', '', onTap: () {
              // TODO: Add Log Out action
            }),
          ],
        ),
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
