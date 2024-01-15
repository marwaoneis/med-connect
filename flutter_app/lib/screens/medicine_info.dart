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
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius:
                  BorderRadius.circular(10.0), // Border radius for cover image
              child: Container(
                height: 150,
                width: double.infinity,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(coverImageUrl),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(0, 12, 0, 12),
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
                    const SizedBox(height: 5),
                    Text(
                      pharmacyName,
                      style: const TextStyle(
                          fontSize: 23,
                          color: Color(0xFF7E7E7E),
                          fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 10),
                    const Divider(),
                    const SizedBox(height: 16),
                    const Text(
                      'Group:',
                      style: TextStyle(
                          color: Color(0xFF7E7E7E),
                          fontSize: 20,
                          fontWeight: FontWeight.bold),
                    ),
                    Text(
                      medicineDetails.group,
                      style: const TextStyle(
                          fontSize: 18, fontWeight: FontWeight.w500),
                    ),
                    const SizedBox(height: 15),
                    const Text(
                      'Uses:',
                      style: TextStyle(
                          color: Color(0xFF7E7E7E),
                          fontSize: 18,
                          fontWeight: FontWeight.bold),
                    ),
                    Text(
                      medicineDetails.description,
                      style: const TextStyle(
                          fontSize: 18, fontWeight: FontWeight.w500),
                    ),
                    const SizedBox(height: 15),
                    const Text(
                      'Side Effects:',
                      style: TextStyle(
                          color: Color(0xFF7E7E7E),
                          fontSize: 18,
                          fontWeight: FontWeight.bold),
                    ),
                    Text(
                      medicineDetails.sideEffects,
                      style: const TextStyle(
                          fontSize: 18, fontWeight: FontWeight.w500),
                    ),
                    const SizedBox(height: 16),
                    const Divider(),
                    const SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          '\$${price.toStringAsFixed(2)}',
                          style: const TextStyle(
                              fontSize: 24, fontWeight: FontWeight.w900),
                        ),
                        const SizedBox(height: 20),
                        Center(
                          child: ElevatedButton(
                            onPressed: () {
                              // Implement the buy action
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFF0D4C92),
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 32.0, vertical: 12.0),
                            ),
                            child: const Text(
                              'Add to Cart',
                              style:
                                  TextStyle(fontSize: 20, color: Colors.white),
                            ),
                          ),
                        ),
                      ],
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
}
