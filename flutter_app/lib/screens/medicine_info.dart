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
    // The UI layout of the screen will go here
    // Use the passed data (medicineDetails, pharmacyName, price) to display the info
    // For the image, you can use the Image.asset widget if you have a local asset, or Image.network for a URL
  }
}
