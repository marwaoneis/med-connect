import 'package:flutter/material.dart';
import '../models/medicine_model.dart';

class CheckoutScreen extends StatelessWidget {
  final MedicineDetails medicineDetails;
  final String pharmacyName;
  final double price;
  final int quantity;
  final double subtotal;
  final double shipping;
  final double total;

  const CheckoutScreen({
    super.key,
    required this.medicineDetails,
    required this.pharmacyName,
    required this.price,
    required this.quantity,
    required this.subtotal,
    required this.shipping,
    required this.total,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Order Detail'),
        backgroundColor: Colors.white,
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: const Padding(
        padding: EdgeInsets.all(20.0),
        child: Column(
          children: [],
        ),
      ),
    );
  }
}
