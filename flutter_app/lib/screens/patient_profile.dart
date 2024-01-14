import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

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
            icon: const Icon(Icons.edit, color: Colors.blue),
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
            _buildOption(
                Icons.history, 'Medical History', 'Check Your Medical History',
                onTap: () {
              // TODO: Add Medical History action
            }),
            _buildOption(Icons.medical_services, 'Medicine & Supplements', '',
                onTap: () {
              // TODO: Add Medicine & Supplements action
            }),
            _buildOption(FontAwesomeIcons.weightScale, 'Weight and Height', '',
                onTap: () {
              // TODO: Add Weight and Height action
            }),
            _buildOption(Icons.person, 'Personal Information', '', onTap: () {
              // TODO: Add Personal Information action
            }),
            _buildOption(Icons.health_and_safety, 'Symptom Checker', '',
                onTap: () {
              // TODO: Add Symptom Checker action
            }),
            _buildOption(Icons.logout, 'Log Out', '', onTap: () {
              // TODO: Add Log Out action
            }),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileCard() {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      elevation: 3,
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
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                  Text('04/12/1978', style: TextStyle(color: Colors.grey)),
                  Text('(316) 555-0116', style: TextStyle(color: Colors.grey)),
                ],
              ),
            ),
            Icon(Icons.edit, color: Colors.blue),
          ],
        ),
      ),
    );
  }

  Widget _buildOption(IconData icon, String title, String subtitle,
      {VoidCallback? onTap}) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      elevation: 1,
      child: ListTile(
        leading: Icon(icon, color: Colors.blue),
        title: Text(title),
        subtitle: subtitle.isNotEmpty ? Text(subtitle) : null,
        trailing: const Icon(Icons.arrow_forward_ios, size: 16),
        onTap: onTap,
      ),
    );
  }
}
