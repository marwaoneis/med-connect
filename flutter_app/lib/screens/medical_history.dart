import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../api/api_service.dart';
import '../config/request_config.dart';
import '../providers/auth_provider.dart';
import '../widgets/footer.dart';
import '../widgets/no_glow_scroll.dart';
import 'message_screen.dart';
import 'patient_appointments.dart';
import 'patient_profile.dart';
import 'patient_screen.dart';

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

    Map<String, dynamic> additionalInfo = data['additionalInfo'] ?? {};

    return {
      'firstName': data['firstName'] ?? 'N/A',
      'lastName': data['lastName'] ?? 'N/A',
      'gender': data['gender'] ?? 'N/A',
      'dateOfBirth': data['dateOfBirth'] ?? 'N/A',
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
      body: NoGlowScrollWrapper(
        child: FutureBuilder<Map<String, dynamic>>(
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

  Widget _buildMedicalHistoryContent(Map<String, dynamic> data) {
    String formattedDateOfBirth = data['dateOfBirth'] != 'N/A'
        ? DateFormat('dd/MM/yyyy').format(DateTime.parse(data['dateOfBirth']))
        : 'N/A';

    Map<String, dynamic> infoList = {
      'Gender': data['gender'],
      'Birthday': formattedDateOfBirth,
      'Height': data['height'],
      'Weight': data['weight'],
      'Blood Group': data['bloodGroup'],
    };

    List<Widget> infoWidgets = infoList.entries.map((entry) {
      return ListTile(
        title: Text(
          entry.key,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Text(entry.value.toString()),
      );
    }).toList();

    List<Widget> vaccinationWidgets = _createListWidgets(data['vaccinations']);
    List<Widget> surgeryWidgets = _createListWidgets(data['priorSurgeries']);
    List<Widget> allergyWidgets = _createListWidgets(data['allergies']);
    List<Widget> emergencyContactWidgets =
        _createEmergencyContactWidgets(data['emergencyContacts']);

    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Card(
          color: const Color(0xFFE7EEF5),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Center(
                  child: Text(
                    "${data['firstName']} ${data['lastName']}",
                    style: const TextStyle(
                        fontSize: 26, fontWeight: FontWeight.w900),
                    textAlign: TextAlign.center,
                  ),
                ),
                const Divider(height: 24, thickness: 1),
                ...infoWidgets,
                _buildSectionDivider(),
                Text('Vaccinations',
                    style: Theme.of(context).textTheme.titleLarge),
                ...vaccinationWidgets,
                _buildSectionDivider(),
                Text('Prior Surgeries',
                    style: Theme.of(context).textTheme.titleLarge),
                ...surgeryWidgets,
                _buildSectionDivider(),
                Text('Allergies',
                    style: Theme.of(context).textTheme.titleLarge),
                ...allergyWidgets,
                _buildSectionDivider(),
                Text('Emergency Contacts',
                    style: Theme.of(context).textTheme.titleLarge),
                ...emergencyContactWidgets,
              ],
            ),
          ),
        ),
      ),
    );
  }

  List<Widget> _createListWidgets(List<dynamic> items) {
    return items.map((item) {
      return ListTile(
        title: Text(item.toString(), style: const TextStyle(fontSize: 16)),
      );
    }).toList();
  }

  List<Widget> _createEmergencyContactWidgets(List<dynamic> contacts) {
    return contacts.map((contact) {
      return ListTile(
        title: Text(contact['name'] ?? 'N/A'),
        subtitle: Text(contact['phone'] ?? 'N/A'),
      );
    }).toList();
  }

  Widget _buildSectionDivider() {
    return const Padding(
      padding: EdgeInsets.symmetric(vertical: 8.0),
      child: Divider(height: 1, thickness: 1),
    );
  }
}
