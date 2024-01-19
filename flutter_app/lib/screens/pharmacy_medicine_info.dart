import 'package:flutter/material.dart';
import '../models/medicine_model.dart';

class PharmacyMedicineInfoScreen extends StatelessWidget {
  final Medicine medicine;

  const PharmacyMedicineInfoScreen({super.key, required this.medicine});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(medicine.medicineDetails.first.name),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  Text('Medicine ID: ${medicine.id}'),
                  Text(
                      'Medicine Group: ${medicine.medicineDetails.first.group}'),
                ],
              ),
            ),
            // ... Rest of the UI components
          ],
        ),
      ),
    );
  }
}
