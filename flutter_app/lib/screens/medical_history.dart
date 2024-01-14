import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../api/api_service.dart';
import '../config/request_config.dart';
import '../providers/auth_provider.dart';

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

    final apiService =
        ApiService(baseUrl: 'http://10.0.2.2:3001', headers: headers);
    final authProvider = Provider.of<Auth>(context, listen: false);
    final userId = authProvider.getUserId;
    var data = await apiService.fetchData('patients/$userId');

    // Ensure that additionalInfo exists and has a non-null value.
    Map<String, dynamic> additionalInfo = data['additionalInfo'] ?? {};

    return {
      'firstName': data['firstName'] ?? 'N/A',
      'lastName': data['lastName'] ?? 'N/A',
      'gender': data['gender'] ?? 'N/A',
      'dateOfBirth': data['dateOfBirth'] ?? 'N/A',
      // Extract other fields from additionalInfo if they exist, otherwise use a default value
      'height': additionalInfo['height'] ?? 'N/A',
      'weight': additionalInfo['weight'] ?? 'N/A',
      'bloodGroup': additionalInfo['bloodGroup'] ?? 'N/A',
      'vaccinations': additionalInfo['vaccinations'] ?? [],
      'priorSurgeries': additionalInfo['priorSurgeries'] ?? [],
      'allergies': additionalInfo['allergies'] ?? [],
      'emergencyContacts': additionalInfo['emergencyContacts'] ?? [],
    };
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Medical History'),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        centerTitle: true,
      ),
      body: FutureBuilder<Map<String, dynamic>>(
        future: medicalHistoryData,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasData) {
              return _buildMedicalHistoryContent(snapshot.data!);
            } else if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            }
          }
          return const Center(child: CircularProgressIndicator());
        },
      ),
    );
  }

  Widget _buildMedicalHistoryContent(Map<String, dynamic> data) {
// Format the date of birth if it's not 'N/A'
    String formattedDateOfBirth = data['dateOfBirth'] != 'N/A'
        ? DateFormat('dd/MM/yyyy').format(DateTime.parse(data['dateOfBirth']))
        : 'N/A';

    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildInfoSection(
              title: "${data['firstName']} ${data['lastName']}",
              infoList: {
                'Gender': data['gender'],
                'Birthday': formattedDateOfBirth,
                'Height': data['height'],
                'Weight': data['weight'],
                'Blood Group': data['bloodGroup'],
              },
            ),
            _buildListSection(
              title: 'Vaccinations',
              list: data['vaccinations'],
            ),
            _buildListSection(
              title: 'Prior Surgeries',
              list: data['priorSurgeries'],
            ),
            _buildListSection(
              title: 'Allergies',
              list: data['allergies'],
            ),
            _buildEmergencyContacts(data['emergencyContacts']),
            // ... Add other sections as necessary
          ],
        ),
      ),
    );
  }

  Widget _buildInfoSection(
      {required String title, required Map<String, dynamic> infoList}) {
    List<Widget> infoWidgets = infoList.entries.map((entry) {
      return ListTile(
        title: Text(
          entry.key,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Text(entry.value.toString()),
      );
    }).toList();

    return Card(
      color: const Color(0xFFE7EEF5),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Center(
              child: Text(
                title,
                style:
                    const TextStyle(fontSize: 26, fontWeight: FontWeight.w900),
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(height: 8),
            ...infoWidgets,
          ],
        ),
      ),
    );
  }

  Widget _buildListSection(
      {required String title, required List<dynamic> list}) {
    List<Widget> listWidgets = list.map((item) {
      return ListTile(
          title: Text(item.toString(), style: const TextStyle(fontSize: 16)));
    }).toList();

    if (listWidgets.isEmpty) {
      listWidgets = [const ListTile(title: Text('None'))];
    }

    return Card(
      color: const Color(0xFFE7EEF5),
      margin: const EdgeInsets.only(top: 16.0),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(title, style: Theme.of(context).textTheme.titleLarge),
            ...listWidgets,
          ],
        ),
      ),
    );
  }

  Widget _buildEmergencyContacts(List<dynamic> contacts) {
    List<Widget> contactWidgets = contacts.map((contact) {
// Assuming each contact is a Map with name, phone, etc.
      return ListTile(
        title: Text(contact['name'] ?? 'N/A'),
        subtitle: Text(contact['phone'] ?? 'N/A'),
      );
    }).toList();

    if (contactWidgets.isEmpty) {
      contactWidgets = [
        const ListTile(title: Text('No emergency contacts listed'))
      ];
    }

    return Card(
      color: const Color(0xFFE7EEF5),
      margin: const EdgeInsets.only(top: 16.0),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text('Emergency Contacts',
                style: Theme.of(context).textTheme.titleLarge),
            ...contactWidgets,
          ],
        ),
      ),
    );
  }
}
