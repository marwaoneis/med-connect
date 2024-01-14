import 'package:flutter/material.dart';
import 'package:flutter_app/providers/auth_provider.dart'; // Adjust the import path as necessary
import 'package:flutter_app/api/api_service.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

import '../config/request_config.dart';

class MedicalHistoryScreen extends StatefulWidget {
  const MedicalHistoryScreen({super.key});

  @override
  MedicalHistoryScreenState createState() => MedicalHistoryScreenState();
}

class MedicalHistoryScreenState extends State<MedicalHistoryScreen> {
  late Future<Map<String, dynamic>> medicalHistoryData;

  @override
  void initState() {
    super.initState();
    medicalHistoryData = _fetchMedicalHistoryData();
  }

  Future<Map<String, dynamic>> _fetchMedicalHistoryData() async {
    var headers = RequestConfig.getHeaders(context);
    final authProvider = Provider.of<Auth>(context, listen: false);
    final apiService =
        ApiService(baseUrl: 'http://10.0.2.2:3001', headers: headers);
    final userId = authProvider.getUserId;
    try {
      var response = await apiService.fetchData('patients/$userId');
      var additionalInfo = response['additionalInfo'] ?? {};
      return {
        // other properties
        'height': additionalInfo['height']?.toString() ?? 'N/A',
        'weight': additionalInfo['weight']?.toString() ?? 'N/A',
        // ...
      };
    } catch (e) {
      // Handle exceptions by logging or returning an empty map
      print('Error fetching medical history data: $e');
      return {};
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Medical History'),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
        centerTitle: true,
      ),
      body: FutureBuilder<Map<String, dynamic>>(
        future: medicalHistoryData,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasData) {
              final patientInfo = snapshot.data!;
              final DateFormat dateFormat = DateFormat('dd/MM/yyyy');

              // Extracting the data from the snapshot
              final String firstName = patientInfo['firstName'] ?? 'N/A';
              final String lastName = patientInfo['lastName'] ?? 'N/A';
              final String gender = patientInfo['gender'] ?? 'N/A';
              final String dateOfBirth = patientInfo['dateOfBirth'] != null
                  ? dateFormat
                      .format(DateTime.parse(patientInfo['dateOfBirth']))
                  : 'N/A';
              final String height =
                  patientInfo['additionalInfo']['height']?.toString() ?? 'N/A';
              final String weight =
                  patientInfo['additionalInfo']['weight']?.toString() ?? 'N/A';
              final String bloodGroup =
                  patientInfo['additionalInfo']['bloodGroup'] ?? 'N/A';
              final List vaccinations =
                  patientInfo['additionalInfo']['vaccinations'] ?? [];
              final List priorSurgeries =
                  patientInfo['additionalInfo']['priorSurgeries'] ?? [];
              final List allergies =
                  patientInfo['additionalInfo']['allergies'] ?? [];
              final List emergencyContacts =
                  patientInfo['additionalInfo']['emergencyContacts'] ?? [];

              return SingleChildScrollView(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildProfileHeader(patientInfo),
                    const SizedBox(height: 20),
                    _buildSectionTitle("Vaccinations"),
                    _buildListSection(vaccinations),
                    const SizedBox(height: 20),
                    _buildSectionTitle("Prior Surgeries"),
                    _buildListSection(priorSurgeries),
                    const SizedBox(height: 20),
                    _buildSectionTitle("Allergies"),
                    _buildListSection(allergies),
                    const SizedBox(height: 20),
                    _buildSectionTitle("Emergency Contacts"),
                    _buildContactSection(emergencyContacts),
                    // ... Additional sections as needed ...
                  ],
                ),
              );
            } else if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            }
          }
          return const Center(child: CircularProgressIndicator());
        },
      ),
    );
  }

  Widget _buildProfileHeader(Map<String, dynamic> patientInfo) {
    final DateFormat dateFormat = DateFormat('dd/MM/yyyy');

    return Card(
      child: ListTile(
        title: Text(
            '${patientInfo['firstName'] ?? 'N/A'} ${patientInfo['lastName'] ?? 'N/A'}'),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Gender: ${patientInfo['gender'] ?? 'N/A'}'),
            Text(
                'Birthday: ${patientInfo['dateOfBirth'] != null ? dateFormat.format(DateTime.parse(patientInfo['dateOfBirth'])) : 'N/A'}'),
            Text('Height: ${patientInfo['height'] ?? 'N/A'}'),
            Text('Weight: ${patientInfo['weight'] ?? 'N/A'}'),
            Text('Blood Group: ${patientInfo['bloodGroup'] ?? 'N/A'}'),
          ],
        ),
        leading: const CircleAvatar(
          backgroundImage: AssetImage(
              'assets/user_avatar.png'), // Replace with actual image path
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Text(
        title,
        style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget _buildListSection(List items) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: items.map((item) {
// Assuming item is a Map, adjust the code if the structure is different
        return Padding(
          padding: const EdgeInsets.only(bottom: 8.0),
          child: Text('- ${item['name']} (${item['date']})'),
        );
      }).toList(),
    );
  }

  Widget _buildContactSection(List contacts) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: contacts.map((contact) {
// Assuming contact is a Map, adjust the code if the structure is different
        return Card(
          child: ListTile(
            title: Text(contact['name']),
            subtitle:
                Text('Phone: ${contact['phone']}\nEmail: ${contact['email']}'),
            leading: const Icon(Icons.person), // Placeholder for contact icon
          ),
        );
      }).toList(),
    );
  }
}
