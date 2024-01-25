import 'package:flutter/material.dart';
import 'package:flutter_app/screens/patient_profile.dart';
import 'package:flutter_app/widgets/no_glow_scroll.dart';
import 'package:provider/provider.dart';
import '../providers/auth_provider.dart';
import '../tools/request.dart';
import '../widgets/recommended_specialist_card.dart';
import 'patient_appointments.dart';
import '../widgets/footer.dart';
import 'message_screen.dart';
import 'patient_dashboard_screen.dart';
import 'specialist_doctors.dart';

class SymptomCheckerScreen extends StatefulWidget {
  const SymptomCheckerScreen({super.key});

  @override
  SymptomCheckerScreenState createState() => SymptomCheckerScreenState();
}

class SymptomCheckerScreenState extends State<SymptomCheckerScreen> {
  String _inputText = '';
  bool _showResult = false;
  String _aiText = '';

  Future<void> _onSearch() async {
    final payload = {
      "symptoms": _inputText,
    };

    final token = Provider.of<Auth>(context, listen: false).getToken();

    final jwtToken = token;
    const apiKey = 'AIzaSyCfcT1_dDNdRA70zbZ-aEbzdXjRXleuRAU';

    try {
      final response = await sendRequest(
        route: "/ai-symptom-analysis",
        method: "POST",
        load: payload,
        context: context,
        jwtToken: jwtToken,
        apiKey: apiKey,
      );

      if (response.containsKey("aiText")) {
        setState(() {
          _aiText = response["aiText"];
          _showResult = true;
        });
      }
    } catch (error) {
      print("Error: $error");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Symptom Checker'),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
      ),
      body: NoGlowScrollWrapper(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 10,
                    ),
                    const Center(
                      child: Text(
                        'Tell us your Symptoms',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                    ),
                    const SizedBox(height: 15),
                    const Text(
                      'By just typing it below, We will suggest the best solution or doctor for you.',
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 15),
                    TextField(
                      onChanged: (value) {
                        _inputText = value;
                      },
                      keyboardType: TextInputType.multiline,
                      maxLines: null,
                      minLines: 1,
                      decoration: InputDecoration(
                        hintText: 'Type your symptoms here',
                        suffixIcon: IconButton(
                          icon: const Icon(Icons.search,
                              size: 30, color: Color(0xFF0D4C92)),
                          onPressed: _onSearch,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        fillColor: const Color(0xFF0D4C92).withOpacity(0.2),
                        filled: true,
                      ),
                    ),
                    const SizedBox(height: 20),
                    if (_showResult) ...[
                      _buildAIResponse(),
                    ],
                  ],
                ),
              ),
            ],
          ),
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

  Widget _buildAIResponse() {
    var possibleReasons = _aiText.contains('Possible Reasons:')
        ? _aiText
            .split('Possible Reasons:')[1]
            .split('Recommendation:')[0]
            .trim()
        : '';
    var recommendation = _aiText.contains('Recommendation:')
        ? _aiText
            .split('Recommendation:')[1]
            .split('Recommended Specialization:')[0]
            .trim()
        : '';
    var recommendedSpecialist = _aiText.contains('Recommended Specialization:')
        ? _aiText.split('Recommended Specialization:')[1].trim()
        : '';
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const Text(
          'Possible Reasons:',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        Text(possibleReasons,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
        const SizedBox(height: 15),
        const Text(
          'Recommendation:',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        Text(
          recommendation,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
        ),
        const SizedBox(height: 15),
        const Text(
          'Recommended Specialzation:',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        Text(recommendedSpecialist,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
        const SizedBox(height: 30),
        _navigateToSpecialistButton(recommendedSpecialist),
      ],
    );
  }

  Widget _navigateToSpecialistButton(String recommendedSpecialist) {
    String specialization =
        recommendedSpecialist.split(":").last.replaceAll('-', '').trim();

    return SpecialistCard(
        imageUrl: 'assets/recommended_specialist.png',
        specialization: specialization,
        onSearchTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) =>
                  SpecialistDoctorsScreen(specialization: specialization),
            ),
          );
        });
  }
}
