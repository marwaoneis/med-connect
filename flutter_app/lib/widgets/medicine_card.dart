import 'package:flutter/material.dart';
import '../models/medicine_model.dart';
import '../screens/medicine_info.dart';

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
    const imageUrl = "assets/medicine_img.png";

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
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Medicine Image
                  Image.asset(
                    imageUrl,
                    fit: BoxFit.cover,
                    // width: 50.0,
                    // height: 50.0,
                  ),
                  const SizedBox(width: 10),
                  // Medicine Details
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Availablity: $pharmacyName',
                          style:
                              const TextStyle(fontSize: 14, color: Colors.grey),
                        ),
                        Text(
                          medicine.medicineDetails[0].name,
                          style: const TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 18),
                        ),
                        Text(
                          medicine.medicineDetails[0].description,
                          style:
                              const TextStyle(fontSize: 14, color: Colors.grey),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const Divider(color: Colors.grey, thickness: 0.2),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
              child: Row(
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
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => MedicineInfoScreen(
                            medicineDetails: medicine.medicineDetails[0],
                            pharmacyName: pharmacyName,
                            price: medicine.price,
                          ),
                        ),
                      );
                    },
                    child: const Text('Buy',
                        style: TextStyle(color: Colors.white)),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
