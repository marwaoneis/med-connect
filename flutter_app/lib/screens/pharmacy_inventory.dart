import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class InventoryScreen extends StatelessWidget {
  final int totalMedicines;
  final int medicineGroups;

  const InventoryScreen({
    super.key,
    required this.totalMedicines,
    required this.medicineGroups,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Inventory'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            _buildStatisticCard(
              context,
              iconData: Icons.medical_services,
              statistic: totalMedicines.toString(),
              label: 'Medicines Available',
              buttonText: 'View Full List',
              borderColor: Colors.blue,
              buttonColor: Colors.lightBlue.shade100,
            ),
            _buildStatisticCard(
              context,
              iconData: Icons.group_work,
              statistic: medicineGroups.toString(),
              label: 'Medicine Groups',
              buttonText: 'View Groups',
              borderColor: Colors.pink,
              buttonColor: Colors.pink.shade100,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatisticCard(
    BuildContext context, {
    required IconData iconData,
    required String statistic,
    required String label,
    required String buttonText,
    required Color borderColor,
    required Color buttonColor,
  }) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
        side: BorderSide(color: borderColor, width: 2),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Icon(iconData, size: 48.0, color: borderColor),
            SizedBox(height: 8.0),
            Text(statistic,
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
            SizedBox(height: 4.0),
            Text(label, style: TextStyle(fontSize: 16)),
            SizedBox(height: 16.0),
            Container(
              decoration: BoxDecoration(
                color: buttonColor,
                borderRadius: BorderRadius.circular(5.0),
                border: Border.all(color: borderColor, width: 2),
              ),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 24.0, vertical: 8.0),
                child: Text(buttonText, style: TextStyle(fontSize: 16)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
