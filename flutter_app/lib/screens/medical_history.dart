import 'dart:typed_data';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../api/api_service.dart';
import '../config/request_config.dart';
import '../providers/auth_provider.dart';
import '../tools/request.dart';
import '../widgets/footer.dart';
import '../widgets/no_glow_scroll.dart';
import 'message_screen.dart';
import 'patient_appointments.dart';
import 'patient_profile.dart';
import 'patient_dashboard_screen.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

class MedicalHistoryScreen extends StatefulWidget {
  const MedicalHistoryScreen({super.key});

  @override
  MedicalHistoryScreenState createState() => MedicalHistoryScreenState();
}

class MedicalHistoryScreenState extends State<MedicalHistoryScreen> {
  late Future<Map<String, dynamic>> medicalHistoryData;
  Map<String, dynamic> editableData = {};
  bool isEditing = false;
  GlobalKey _printKey = GlobalKey();

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

  Future<void> _saveMedicalHistory() async {
    final authProvider = Provider.of<Auth>(context, listen: false);
    final userId = authProvider.getUserId;
    final updateData = {
      'additionalInfo': {
        'height': editableData['height'],
        'weight': editableData['weight'],
        'bloodGroup': editableData['bloodGroup'],
        'vaccinations': editableData['vaccinations'],
        'priorSurgeries': editableData['priorSurgeries'],
        'allergies': editableData['allergies'],
        'emergencyContacts': editableData['emergencyContacts'],
      }
    };

    var response = await sendRequest(
      route: '/patients/$userId',
      method: "PUT",
      load: updateData,
      context: context,
    );

    if (response != null) {
      setState(() {
        isEditing = false;
        medicalHistoryData = _fetchMedicalHistoryData(); // Refetch data
      });
    } else {
      // Handle error
    }
  }

  Future<void> _printCard() async {
    RenderRepaintBoundary boundary =
        _printKey.currentContext!.findRenderObject() as RenderRepaintBoundary;
    var image = await boundary.toImage();
    ByteData? byteData = await image.toByteData(format: ImageByteFormat.png);
    Uint8List pngBytes = byteData!.buffer.asUint8List();

    final doc = pw.Document();
    final imageProvider = pw.MemoryImage(pngBytes);

    doc.addPage(pw.Page(
      build: (pw.Context context) {
        return pw.Center(
          child: pw.Image(imageProvider, fit: pw.BoxFit.contain),
        );
      },
    ));

    await Printing.layoutPdf(onLayout: (PdfPageFormat format) => doc.save());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Medical History'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            if (isEditing) {
              setState(() {
                isEditing = false;
              });
            } else {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                    builder: (context) => const PatientProfileScreen()),
              );
            }
          },
        ),
        actions: [
          if (!isEditing)
            IconButton(
              icon: const Icon(Icons.edit, color: Color(0xFF0D4C92)),
              onPressed: () {
                setState(() {
                  isEditing = true;
                });
              },
            ),
        ],
      ),
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
                          RepaintBoundary(
                            key: _printKey,
                            child: _buildMedicalHistoryContent(snapshot.data!),
                          ),
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
            MaterialPageRoute(builder: (context) => const PatientScreen()),
          );
        },
        onAppointmentTap: () {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (context) =>
                    const BookAppointmentScreen(title: 'Book Appointment')),
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
    if (!isEditing) {
      editableData = Map.from(data);
    }

    String formattedDateOfBirth = editableData['dateOfBirth'] != 'N/A'
        ? DateFormat('dd/MM/yyyy')
            .format(DateTime.parse(editableData['dateOfBirth']))
        : 'N/A';

    Map<String, dynamic> infoList = {
      'Gender': editableData['gender'],
      'Birthday': formattedDateOfBirth,
      'Height': editableData['height'],
      'Weight': editableData['weight'],
      'Blood Group': editableData['bloodGroup'],
    };

    List<Widget> infoWidgets = infoList.entries.map((entry) {
      return isEditing
          ? _buildEditableField(entry.key, entry.value)
          : ListTile(
              title: Text(
                entry.key,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: Text(entry.value.toString()),
            );
    }).toList();

    List<Widget> vaccinationWidgets = isEditing
        ? _buildEditableList('vaccinations', data['vaccinations'])
        : _createListWidgets(data['vaccinations']);
    List<Widget> surgeryWidgets = isEditing
        ? _buildEditableList('priorSurgeries', data['priorSurgeries'])
        : _createListWidgets(data['priorSurgeries']);
    List<Widget> allergyWidgets = isEditing
        ? _buildEditableList('allergies', data['allergies'])
        : _createListWidgets(data['allergies']);
    List<Widget> emergencyContactWidgets = isEditing
        ? _buildEditableList('emergencyContacts', data['emergencyContacts'])
        : _createListWidgets(data['emergencyContacts']);

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
                        "${editableData['firstName']} ${editableData['lastName']}",
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
                    Align(
                      alignment: Alignment.centerRight,
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          // Only add the Check icon if in editing mode
                          if (isEditing)
                            _buildSvgIconButton(Icons.check, 'Save', () {
                              _saveMedicalHistory();
                            }),
                          // Always add the Print icon
                          _buildSvgIconButton(Icons.print, 'Print', _printCard),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEditableField(String label, dynamic value) {
    return ListTile(
      title: Text(
        label,
        style: const TextStyle(fontWeight: FontWeight.bold),
      ),
      subtitle: TextFormField(
        initialValue: value.toString(),
        onChanged: (newValue) {
          setState(() {
            editableData[label.toLowerCase()] = newValue;
          });
        },
      ),
    );
  }

  List<Widget> _buildEditableList(String key, List<dynamic> items) {
    List<TextEditingController> controllers = items
        .map((item) => TextEditingController(text: item.toString()))
        .toList();

    return List<Widget>.generate(controllers.length, (index) {
      return ListTile(
        title: TextFormField(
          controller: controllers[index],
          decoration: InputDecoration(hintText: 'Enter $key'),
          onChanged: (newValue) {
            setState(() {
              editableData[key][index] = newValue;
            });
          },
        ),
      );
    });
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

  Widget _buildSvgIconButton(
      IconData icon, String tooltip, VoidCallback onTap) {
    return Container(
      margin: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: const Color(0xFF0D4C92).withOpacity(0.2),
        borderRadius: BorderRadius.circular(8),
      ),
      child: IconButton(
        onPressed: onTap,
        tooltip: tooltip,
        icon: Icon(icon, color: const Color(0xFF0D4C92)),
      ),
    );
  }
}
