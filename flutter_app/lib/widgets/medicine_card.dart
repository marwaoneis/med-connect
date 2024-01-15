import 'package:flutter/material.dart';
import '../models/medicine_model.dart';

class MedicineCard extends StatelessWidget {
  final Medicine medicine;
  final String pharmacyName;
  final VoidCallback onTap;

  const MedicineCard({
    super.key,
    required this.medicine,
    required this.pharmacyName,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final medicineDetail = medicine.medicineDetails.isNotEmpty
        ? medicine.medicineDetails.first
        : MedicineDetails(
            name: 'Unknown',
            description: 'No description available',
            sideEffects: 'None',
            group: 'Unknown',
          );

    return InkWell(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey[300]!, width: 1),
          borderRadius: BorderRadius.circular(15.0),
        ),
        margin: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [
              Text(
                'Pharmacy: $pharmacyName',
                style: const TextStyle(fontSize: 14, color: Colors.grey),
              ),
              Text(
                medicine.medicineDetails[0].name,
                style:
                    const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ),
              const SizedBox(height: 8.0),
              Text(
                medicine.medicineDetails[0].description,
                style: const TextStyle(fontSize: 14, color: Colors.grey),
              ),
              const SizedBox(height: 8.0),
              Text(
                'Price: \$${medicine.price.toStringAsFixed(2)}',
                style:
                    const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 8.0),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue, // Background color
                ),
                onPressed: onTap,
                child: const Text('Buy', style: TextStyle(color: Colors.white)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
