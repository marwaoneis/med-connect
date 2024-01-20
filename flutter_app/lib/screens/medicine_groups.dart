import 'package:flutter/material.dart';

class MedicineGroupsScreen extends StatelessWidget {
  final List<Map<String, dynamic>> medicineGroupsData;

  const MedicineGroupsScreen({
    super.key,
    required this.medicineGroupsData,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Medicine Groups'),
        backgroundColor: Color(0xFF0D4C92),
      ),
      body: Container(
        padding: EdgeInsets.all(10),
        child: Column(
          children: [
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: Color(0xFF0D4C92).withOpacity(0.2),
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: Colors.grey),
                ),
                child: ListView.separated(
                  itemCount: medicineGroupsData.length,
                  itemBuilder: (context, index) {
                    var group = medicineGroupsData[index];
                    return Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8.0, vertical: 16),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            group['groupName'],
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          Text('${group['noOfMedicines']}'),
                          TextButton(
                            onPressed: () {
                              // Implement the navigation to detail screen
                            },
                            child: Text(
                              'View Full Detail',
                              style: TextStyle(color: Colors.blue),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                  separatorBuilder: (context, index) => Divider(),
                ),
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: Color(0xFFE93B81), // background color
                onPrimary: Colors.white, // foreground color
                minimumSize: Size(180, 60),
              ),
              onPressed: () {
                // Implement the logic to add new group
              },
              child: Text('Add New Group'),
            ),
          ],
        ),
      ),
    );
  }
}
