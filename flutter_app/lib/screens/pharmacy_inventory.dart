import 'package:flutter/material.dart';
import 'package:flutter_app/screens/medicine_list.dart';
// import 'package:flutter_svg/flutter_svg.dart';

import '../api/api_service.dart';
import '../config/request_config.dart';
import '../models/medicine_group_model.dart';
import '../models/medicine_model.dart';
import '../widgets/no_glow_scroll.dart';
import '../widgets/top_bar_with_background.dart';
import 'medicine_groups.dart';

class InventoryScreen extends StatefulWidget {
  final int totalMedicines;
  final int medicineGroups;
  final String pharmacyId;

  const InventoryScreen({
    super.key,
    required this.totalMedicines,
    required this.medicineGroups,
    required this.pharmacyId,
  });

  @override
  InventoryScreenState createState() => InventoryScreenState();
}

class InventoryScreenState extends State<InventoryScreen> {
  late Future<List<Medicine>> allMedicines;

  @override
  void initState() {
    super.initState();
    allMedicines = _fetchMedicines(widget.pharmacyId);
  }

  Future<List<Medicine>> _fetchMedicines(String pharmacyId) async {
    var headers = RequestConfig.getHeaders(context);
    final apiService =
        ApiService(baseUrl: 'http://10.0.2.2:3001', headers: headers);
    final response =
        await apiService.fetchData('medicines/bypharmacy/$pharmacyId');
    return List<Medicine>.from(
      response.map((x) => Medicine.fromJson(x)),
    );
  }

  void _navigateToMedicineGroups(BuildContext context) async {
    try {
      final List<Medicine> medicines = await allMedicines;

      Map<String, List<Medicine>> groupedMedicines = {};
      for (var medicine in medicines) {
        for (var detail in medicine.medicineDetails) {
          groupedMedicines.putIfAbsent(detail.group, () => []).add(medicine);
        }
      }

      List<MedicineGroup> medicineGroups =
          groupedMedicines.entries.map((entry) {
        return MedicineGroup(groupName: entry.key, medicines: entry.value);
      }).toList();

      if (!mounted) return;

      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => MedicineGroupsScreen(
            medicineGroups: medicineGroups,
            pharmacyId: widget.pharmacyId,
          ),
        ),
      );
    } catch (e) {
      print('Error fetching medicines: $e');
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
            titleContent: const Text(
              'Inventory',
              style: TextStyle(fontSize: 20, color: Colors.white),
            ),
            trailingContent: const Text(
              '',
              style: TextStyle(fontSize: 20, color: Colors.transparent),
            ),
          ),
          Expanded(
            child: NoGlowScrollWrapper(
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: ListView(
                  children: [
                    _buildStatisticCard(
                      context,
                      iconData: Icons.medical_services,
                      statistic: widget.totalMedicines.toString(),
                      label: 'Medicines Available',
                      buttonText: 'View Full List',
                      buttonIcon: IconButton(
                        icon: const Icon(Icons.arrow_forward),
                        onPressed: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => MedicineListScreen(
                                pharmacyId: widget.pharmacyId,
                              ),
                            ),
                          );
                        },
                      ),
                      borderColor: const Color(0xFF0D4C92),
                      buttonColor: const Color(0xFF0093E9).withOpacity(0.3),
                    ),
                    const SizedBox(height: 10),
                    _buildStatisticCard(
                      context,
                      iconData: Icons.group_work,
                      statistic: widget.medicineGroups.toString(),
                      label: 'Medicine Groups',
                      buttonText: 'View Groups',
                      buttonIcon: IconButton(
                        icon: const Icon(Icons.arrow_forward),
                        onPressed: () {
                          _navigateToMedicineGroups(context);
                        },
                      ),
                      borderColor: const Color(0xFFE93B81),
                      buttonColor: const Color(0xFFFF96AD).withOpacity(0.4),
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

  Widget _buildStatisticCard(
    BuildContext context, {
    required IconData iconData,
    required String statistic,
    required String label,
    required String buttonText,
    required Widget? buttonIcon,
    required Color borderColor,
    required Color buttonColor,
  }) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12.0),
      color: Colors.white,
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
        side: BorderSide(color: borderColor, width: 2),
      ),
      child: Padding(
        padding: const EdgeInsets.only(top: 25.0),
        child: Column(
          children: [
            Icon(iconData, size: 48.0, color: borderColor),
            const SizedBox(height: 15.0),
            Text(statistic,
                style:
                    const TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
            const SizedBox(height: 15.0),
            Text(label,
                style:
                    const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 30.0),
            Container(
              width: double.infinity,
              height: 60.0,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: buttonColor,
                borderRadius: BorderRadius.circular(5.0),
                border: Border.all(color: borderColor, width: 2),
              ),
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: buttonIcon != null
                  ? Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(buttonText, style: const TextStyle(fontSize: 16)),
                        buttonIcon,
                      ],
                    )
                  : Text(buttonText, style: const TextStyle(fontSize: 16)),
            ),
          ],
        ),
      ),
    );
  }
}
