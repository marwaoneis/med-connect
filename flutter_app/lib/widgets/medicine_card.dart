import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
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
    // Assuming each medicine has an image URL. You need to adjust it based on your data.
    final imageUrl = "assets/medicine.svg";

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
        child: Row(
          children: [
            // Medicine Image
            ClipRRect(
              borderRadius: BorderRadius.circular(10.0),
              child: SvgPicture.asset(
                imageUrl,
                fit: BoxFit.cover,
                width: 50.0,
                height: 50.0,
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Pharmacy: $pharmacyName',
                      style: const TextStyle(fontSize: 14, color: Colors.grey),
                    ),
                    Text(
                      medicine.medicineDetails[0].name,
                      style: const TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 18),
                    ),
                    const SizedBox(height: 8.0),
                    Text(
                      medicine.medicineDetails[0].description,
                      style: const TextStyle(fontSize: 14, color: Colors.grey),
                    ),
                    const SizedBox(height: 8.0),
                    const Divider(color: Colors.grey, thickness: 0.2),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          '\$${medicine.price.toStringAsFixed(2)}',
                          style: const TextStyle(
                              fontSize: 18, fontWeight: FontWeight.w900),
                        ),
                        const SizedBox(height: 8.0),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor:
                                const Color(0xFF0D4C92), // Background color
                          ),
                          onPressed: onTap,
                          child: const Text('Buy',
                              style: TextStyle(color: Colors.white)),
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
