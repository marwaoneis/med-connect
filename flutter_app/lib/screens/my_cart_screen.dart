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
  Widget build(BuildContext context) {
    double subtotal = price * quantity;
    const double shipping = 3.00;
    double total = subtotal + shipping;

    return Scaffold(
      appBar: AppBar(
        title: const Text('My Cart'),
        backgroundColor: Colors.white,
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Card(
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Row(
                  children: [
                    Image.asset(
                      'assets/medicine_img.png',
                      width: 100,
                      height: 100,
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(medicineDetails.name,
                              style: const TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold)),
                          Text(pharmacyName),
                          Text('Amount: $quantity'),
                          Text('\$${price.toStringAsFixed(2)}'),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const Spacer(),
            // Subtotal, Shipping, and Total
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Subtotal'),
                Text('\$${subtotal.toStringAsFixed(2)}'),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Shipping'),
                Text('\$${shipping.toStringAsFixed(2)}'),
              ],
            ),
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Payment Method'),
                Text('Cash'),
              ],
            ),
            const Divider(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Total Amount'),
                Text('\$${total.toStringAsFixed(2)}'),
              ],
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Implement the checkout action
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                padding:
                    const EdgeInsets.symmetric(horizontal: 100, vertical: 15),
                textStyle: const TextStyle(fontSize: 18),
              ),
              child: const Text('Checkout'),
            ),
          ],
        ),
      ),
    );
  }
}
