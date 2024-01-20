import 'package:flutter/material.dart';
import 'package:flutter_app/widgets/no_glow_scroll.dart';
import '../models/medicine_group_model.dart';

class MedicineGroupsScreen extends StatelessWidget {
  final List<MedicineGroup> medicineGroups;

  const MedicineGroupsScreen({
    super.key,
    required this.medicineGroups,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Medicine Groups'),
        backgroundColor: const Color(0xFF0D4C92),
      ),
      body: NoGlowScrollWrapper(
        child: Expanded(
          child: Container(
            padding: const EdgeInsets.all(10),
            child: Column(
              children: [
                Expanded(
                  // Removed the fixed height
                  child: Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: const Color(0xFF0D4C92).withOpacity(0.2),
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: Colors.grey),
                    ),
                    child: Column(
                      children: [
                        const Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: 8.0, vertical: 8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: Text(
                                  'Group Name',
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                              ),
                              Expanded(
                                child: Text(
                                  'No of Medicines',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                              ),
                              Expanded(
                                child: Text(
                                  'Action',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const Divider(),
                        Expanded(
                          child: ListView.separated(
                            itemCount: medicineGroups.length,
                            itemBuilder: (context, index) {
                              var group = medicineGroups[index];
                              return Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 8.0, vertical: 16),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Expanded(
                                      child: Text(
                                        group.groupName,
                                        style: const TextStyle(
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                    Expanded(
                                      child: Text(
                                        '${group.numberOfMedicines}',
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                    Expanded(
                                      child: TextButton(
                                        onPressed: () {},
                                        child: const Text(
                                          'View Full Detail',
                                          style: TextStyle(color: Colors.black),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            },
                            separatorBuilder: (context, index) =>
                                const Divider(),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                // SizedBox(height: 20),
                // ElevatedButton(
                //   style: ElevatedButton.styleFrom(
                //     primary: Color(0xFFE93B81), // background color
                //     onPrimary: Colors.white, // foreground color
                //     minimumSize: Size(180, 60),
                //   ),
                //   onPressed: () {
                //     // Implement the logic to add new group
                //   },
                //   child: Text('Add New Group'),
                // ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
