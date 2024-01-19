import 'package:flutter/material.dart';
import '../models/medicine_model.dart';
import '../widgets/no_glow_scroll.dart';
import '../widgets/top_bar_with_background.dart';

class PharmacyMedicineInfoScreen extends StatelessWidget {
  final Medicine medicine;

  const PharmacyMedicineInfoScreen({super.key, required this.medicine});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          TopBarWithBackground(
            leadingContent: IconButton(
              icon: const Icon(Icons.arrow_back, color: Colors.white),
              onPressed: () => Navigator.of(context).pop(),
            ),
            titleContent: Text(
              medicine.medicineDetails.first.name,
              style: const TextStyle(fontSize: 20, color: Colors.white),
            ),
            trailingContent: Container(),
          ),
          const SizedBox(height: 15),
          Expanded(
            child: NoGlowScrollWrapper(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      buildInfoBox(
                        context,
                        title: 'Medicine',
                        leftValue: medicine.id,
                        leftTitle: 'Medicine ID',
                        rightValue: medicine.medicineDetails.first.group,
                        rightTitle: 'Medicine Group',
                      ),
                      const SizedBox(height: 20),
                      buildInfoBox(
                        context,
                        title: 'Inventory in Qty',
                        leftValue: '${medicine.stockLevel}',
                        leftTitle: 'Stock Qty',
                      ),
                      const SizedBox(height: 20),
                      buildInfoBox(
                        context,
                        title: 'How to use',
                        leftValue: medicine.medicineDetails.first.description,
                        leftTitle: '',
                      ),
                      const SizedBox(height: 20),
                      buildInfoBox(
                        context,
                        title: 'Inventory in Qty',
                        leftValue: medicine.medicineDetails.first.sideEffects,
                        leftTitle: '',
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding:
                const EdgeInsets.symmetric(vertical: 20.0, horizontal: 20.0),
            child: Row(
              children: [
                SizedBox(
                  height: 50,
                  width: 185,
                  child: Padding(
                    padding: const EdgeInsets.only(right: 10.0),
                    child: ElevatedButton.icon(
                      icon: const Icon(Icons.delete, color: Color(0xFFE93B81)),
                      label: const Text('Delete Medicine',
                          style: TextStyle(
                              fontSize: 18, color: Color(0xFFE93B81))),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white, // Background color
                        foregroundColor: const Color(0xFFE93B81), // Text color
                        side: const BorderSide(
                            color: Color(0xFFE93B81)), // Border color
                        shape: RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.circular(10), // Border radius
                        ),
                        padding: const EdgeInsets.all(3),
                        elevation: 0,
                      ),
                      onPressed: () {
                        // TODO: Implement delete logic
                      },
                    ),
                  ),
                ),
                SizedBox(
                  height: 50,
                  width: 185,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 10.0),
                    child: ElevatedButton.icon(
                      icon: const Icon(Icons.edit, color: Colors.white),
                      label: const Text('Edit Details',
                          style: TextStyle(fontSize: 18, color: Colors.white)),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF0D4C92),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        elevation: 0,
                      ),
                      onPressed: () {
                        // TODO: Implement edit details logic
                      },
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

  Widget buildInfoBox(BuildContext context,
      {required String title,
      String? leftValue,
      String? leftTitle,
      String? rightValue,
      String? rightTitle}) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFF0D4C92).withOpacity(0.2),
        border: Border.all(color: Colors.black),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 8, 8, 8),
            child: Text(
              title,
              style: const TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.w900,
                fontSize: 24,
              ),
            ),
          ),
          const Divider(height: 2, thickness: 2),
          IntrinsicHeight(
            child: Row(
              children: <Widget>[
                if (leftValue != null && leftTitle != null) ...[
                  Expanded(
                    child: Container(
                      decoration: const BoxDecoration(
                        border: Border(
                          top: BorderSide(
                            color: Colors.black,
                          ),
                        ),
                      ),
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text(
                            leftValue,
                            style: const TextStyle(
                              fontWeight: FontWeight.w900,
                              fontSize: 22,
                            ),
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          Text(
                            leftTitle,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
                if (rightValue != null && rightTitle != null) ...[
                  Container(
                    decoration: const BoxDecoration(
                      border: Border(
                        top: BorderSide(
                          color: Colors.black,
                        ),
                      ),
                    ),
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(
                          rightValue,
                          style: const TextStyle(
                            fontWeight: FontWeight.w900,
                            fontSize: 22,
                          ),
                        ),
                        Text(
                          rightTitle,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }
}
