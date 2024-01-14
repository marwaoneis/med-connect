import 'package:flutter/material.dart';
import 'package:flutter_app/screens/patient_profile.dart';
import 'patient_appointments.dart';
import '../widgets/footer.dart';
import 'message_screen.dart';
import 'patient_screen.dart';

class SymptomCheckerScreen extends StatefulWidget {
  const SymptomCheckerScreen({super.key});

  @override
  SymptomCheckerScreenState createState() => SymptomCheckerScreenState();
}

class SymptomCheckerScreenState extends State<SymptomCheckerScreen> {
  String _inputText = '';
  bool _showResult = false;

  void _onSearch() {
    // Placeholder for search functionality
    // Here you would use ChatGPT or any other service to process _inputText and get results
    // After fetching results, you would use setState to update the UI
    setState(() {
      _showResult = true;
    });
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
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16),
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
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
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
                        icon: const Icon(
                          Icons.search,
                          size: 30,
                        ),
                        onPressed: _inputText.isNotEmpty ? _onSearch : null,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      fillColor: const Color(0xFFE5E5E5),
                      filled: true,
                    ),
                  ),
                  const SizedBox(height: 20),
                  if (_showResult) ...[
                    const Text(
                      'Possible Reason',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                    ),
                    const SizedBox(height: 10),
                    const Text(
                      "Possible Reason",
                      style: TextStyle(fontSize: 16),
                    ),
                    const SizedBox(height: 20),
                    const Text(
                      'Recommended',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                    ),
                    const SizedBox(height: 10),
                    const Text(
                      "Recommendations",
                      style: TextStyle(fontSize: 16),
                    ),
                  ],
                ],
              ),
            ),
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
}
