import 'package:flutter/material.dart';
import '../models/medicine_model.dart';

class MyCartScreen extends StatelessWidget {
  final MedicineDetails medicineDetails;
  final String pharmacyName;
  final double price;
  final int quantity;

  const MyCartScreen({
    super.key,
    required this.medicineDetails,
    required this.pharmacyName,
    required this.price,
    required this.quantity,
  });

  @override
  Widget build(BuildContext context) {}
}
