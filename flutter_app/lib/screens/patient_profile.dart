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
}
