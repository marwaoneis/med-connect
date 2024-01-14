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
        title: Text('Symptom Checker'),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Tell us your Symptoms',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 10),
                  TextField(
                    onChanged: (value) {
                      _inputText = value;
                    },
                    decoration: InputDecoration(
                      hintText: 'Type your symptoms here',
                      suffixIcon: IconButton(
                        icon: Icon(Icons.search),
                        onPressed: _inputText.isNotEmpty ? _onSearch : null,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      fillColor: Color(0xFFE5E5E5),
                      filled: true,
                    ),
                  ),
                  SizedBox(height: 20),
                  if (_showResult) ...[
                    Text(
                      'Possible Reason',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                    ),
                    SizedBox(height: 10),
                    Text(
                      // Your possible reason text goes here
                      style: TextStyle(fontSize: 16),
                    ),
                    SizedBox(height: 20),
                    Text(
                      'Recommended',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                    ),
                    SizedBox(height: 10),
                    Text(
                      // Your recommendations text goes here
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
