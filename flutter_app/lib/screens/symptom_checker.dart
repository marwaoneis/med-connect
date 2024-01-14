import 'package:flutter/material.dart';

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
                  const Text(
                    'Tell us your Symptoms',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 10),
                  TextField(
                    onChanged: (value) {
                      _inputText = value;
                    },
                    decoration: InputDecoration(
                      hintText: 'Type your symptoms here',
                      suffixIcon: IconButton(
                        icon: const Icon(Icons.search),
                        onPressed: _inputText.isNotEmpty ? _onSearch : null,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
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
    );
  }
}
