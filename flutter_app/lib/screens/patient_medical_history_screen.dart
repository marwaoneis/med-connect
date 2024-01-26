import 'dart:typed_data';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_app/screens/appointments_schedule.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../api/api_service.dart';
import '../config/request_config.dart';
import '../providers/auth_provider.dart';
import '../tools/request.dart';
import '../widgets/footer.dart';
import '../widgets/no_glow_scroll.dart';
import 'doctor_dashboard_screen.dart';
import 'doctor_message_screen.dart';
import 'doctor_profile_logout.dart';
import 'message_screen.dart';
import 'patient_appointments.dart';
import 'patient_profile.dart';
import 'patient_dashboard_screen.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

class PatientMedicalHistoryScreen extends StatefulWidget {
  final String patientId;

  const PatientMedicalHistoryScreen({
    super.key,
    required this.patientId,
  });

  @override
  PatientMedicalHistoryScreenState createState() =>
      PatientMedicalHistoryScreenState();
}

class PatientMedicalHistoryScreenState
    extends State<PatientMedicalHistoryScreen> {
  late Future<Map<String, dynamic>> medicalHistoryData;

  @override
  void initState() {
    super.initState();
    medicalHistoryData = _fetchMedicalHistoryData(widget.patientId);
  }

  Future<Map<String, dynamic>> _fetchMedicalHistoryData(
      String patientId) async {
    var headers = RequestConfig.getHeaders(context);

    final apiService =
        ApiService(baseUrl: 'http://10.0.2.2:3001', headers: headers);
    var data = await apiService.fetchData('patients/$patientId');

    Map<String, dynamic> additionalInfo = data['additionalInfo'] ?? {};

    dynamic ensureList(dynamic item) {
      if (item == null) return [];
      if (item is String) return [item];
      return item;
    }

    return {
      'firstName': data['firstName'] ?? 'N/A',
      'lastName': data['lastName'] ?? 'N/A',
      'gender': data['gender'] ?? 'N/A',
      'dateOfBirth': data['dateOfBirth'] ?? 'N/A',
      'height': additionalInfo['height'] ?? 'N/A',
      'weight': additionalInfo['weight'] ?? 'N/A',
      'bloodGroup': additionalInfo['bloodGroup'] ?? 'N/A',
      'vaccinations': ensureList(additionalInfo['vaccinations']),
      'priorSurgeries': ensureList(additionalInfo['priorSurgeries']),
      'allergies': ensureList(additionalInfo['allergies']),
      'emergencyContacts': ensureList(additionalInfo['emergencyContacts']),
    };
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Medical History')),
      body: NoGlowScrollWrapper(
        child: FutureBuilder<Map<String, dynamic>>(
          future: medicalHistoryData,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              if (snapshot.hasData) {
                return Column(
                  children: [
                    Expanded(
                      child: ListView(
                        children: [
                          _buildMedicalHistoryContent(snapshot.data!),
                        ],
                      ),
                    ),
                  ],
                );
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
            MaterialPageRoute(builder: (context) => const DoctorScreen()),
          );
        },
        onAppointmentTap: () {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (context) => const AppointmentScheduleScreen()),
          );
        },
        onChatTap: () {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (context) => const DoctorMessageScreen()),
          );
        },
        onProfileTap: () {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (context) => const DoctorProfileLogoutScreen()),
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
        child: Stack(
          children: [
            Card(
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
                    const Text(
                      'Vaccinations',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    ...vaccinationWidgets,
                    _buildSectionDivider(),
                    const Text(
                      'Prior Surgeries',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    ...surgeryWidgets,
                    _buildSectionDivider(),
                    const Text(
                      'Allergies',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    ...allergyWidgets,
                    _buildSectionDivider(),
                    const Text(
                      'Emergency Contacts',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    ...emergencyContactWidgets,
                  ],
                ),
              ),
            ),
          ],
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
    if (contacts.any((contact) => contact is! Map)) {
      return [const ListTile(title: Text('Invalid emergency contact data'))];
    }
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
