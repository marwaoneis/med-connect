import 'package:flutter/material.dart';
import 'package:flutter_app/widgets/no_glow_scroll.dart';
import '../models/medicine_group_model.dart';
import '../tools/request.dart';
import '../widgets/top_bar_with_background.dart';

class MedicineDetailsScreen extends StatelessWidget {
  final MedicineGroup medicineGroup;

  const MedicineDetailsScreen({
    super.key,
    required this.medicineGroup,
  });

  Future<void> _removeMedicine(
      BuildContext context, String medicineId, String pharmacyId) async {
    final String route = "/medicines/bypharmacy/$medicineId/$pharmacyId";
    try {
      print('DELETE request URL: $route');

      final result = await sendRequest(
        route: route,
        method: "DELETE",
        context: context,
      );

      if (result != null && result['error'] == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Medicine removed successfully')),
        );
        // TODO: Update the UI or remove the item from the list
      } else {
        // If there is an error message from the server, display it
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error: ${result['error']}')),
        );
      }
    } catch (error) {
      // Handle the error
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to remove medicine: $error')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          TopBarWithBackground(
            leadingContent: IconButton(
              icon: const Icon(Icons.arrow_back, color: Colors.white),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            titleContent: Text(
              medicineGroup.groupName,
              style: const TextStyle(fontSize: 20, color: Colors.white),
            ),
            trailingContent: Container(),
          ),
          Expanded(
            child: NoGlowScrollWrapper(
              child: Container(
                margin: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: const Color(0xFF0D4C92).withOpacity(0.2),
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: Colors.grey),
                ),
                child: ListView(
                  padding: EdgeInsets.zero,
                  children: [
                    const Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: 12.0, vertical: 12.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Text(
                              'Medicine Name',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.bold),
                            ),
                          ),
                          Expanded(
                            child: Text(
                              'No of Medicines',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.bold),
                            ),
                          ),
                          Expanded(
                            child: Text(
                              'Action',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.bold),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const Divider(),
                    ...medicineGroup.medicines.map((medicine) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12.0,
                          vertical: 13.0,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Text(
                                medicine.medicineDetails.first.name,
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.bold),
                              ),
                            ),
                            Expanded(
                              child: Text(
                                '${medicine.stockLevel}',
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.bold),
                              ),
                            ),
                            Expanded(
                              child: TextButton.icon(
                                onPressed: () => _removeMedicine(
                                    context, medicine.id, medicine.pharmacyId),
                                icon: const Icon(
                                  Icons.delete,
                                  size: 14,
                                  color: Color(0xFFE93B81),
                                ),
                                label: const Text(
                                  'Remove from group',
                                  style: TextStyle(
                                      fontSize: 12, color: Color(0xFFE93B81)),
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    }).toList(),
                    // Additional buttons
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 20.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          ElevatedButton.icon(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.red, // Background color
                            ),
                            onPressed: () {
                              // TODO: Implement delete group logic
                            },
                            icon: const Icon(Icons.delete, color: Colors.white),
                            label: const Text('Delete Group',
                                style: TextStyle(color: Colors.white)),
                          ),
                          ElevatedButton.icon(
                            style: ElevatedButton.styleFrom(
                              primary: Colors.green, // Background color
                            ),
                            onPressed: () {
                              // TODO: Implement add medicine logic
                            },
                            icon: const Icon(Icons.add, color: Colors.white),
                            label: const Text('Add Medicine',
                                style: TextStyle(color: Colors.white)),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
