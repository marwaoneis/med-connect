import 'package:flutter/material.dart';
import '../models/medicine_model.dart';

class MedicineInfoScreen extends StatelessWidget {
  final MedicineDetails medicineDetails;
  final String pharmacyName;
  final double price;

  const MedicineInfoScreen({
    super.key,
    required this.medicineDetails,
    required this.pharmacyName,
    required this.price,
  });

  @override
  Widget build(BuildContext context) {
    const coverImageUrl = "assets/cover_medicine.png";

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.of(context).pop(),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 150,
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage(coverImageUrl),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  medicineDetails.name,
                  style: const TextStyle(
                    fontSize: 23,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  pharmacyName,
                  style: const TextStyle(
                    fontSize: 20,
                    color: Colors.grey,
                  ),
                ),
                const SizedBox(height: 16),
                Text(
                  'Group: ${medicineDetails.group}',
                  style: const TextStyle(fontSize: 18),
                ),
                const SizedBox(height: 8),
                Text(
                  'Uses: ${medicineDetails.description}',
                  style: const TextStyle(fontSize: 18),
                ),
                const SizedBox(height: 8),
                Text(
                  'Side Effects: ${medicineDetails.sideEffects}',
                  style: const TextStyle(fontSize: 18),
                ),
                const SizedBox(height: 16),
                const Divider(),
                Text(
                  'Price: \$${price.toStringAsFixed(2)}',
                  style: const TextStyle(
                      fontSize: 24, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 20),
                Center(
                  child: ElevatedButton(
                    onPressed: () {
// Implement the buy action
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Theme.of(context)
                          .colorScheme
                          .secondary, // Use the secondary color of the theme, or choose your own
                      padding: const EdgeInsets.symmetric(
                          horizontal: 32.0, vertical: 12.0),
                    ),
                    child: const Text(
                      'Buy Now',
                      style: TextStyle(fontSize: 20),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
