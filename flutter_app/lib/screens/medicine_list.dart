import 'package:flutter/material.dart';
import 'package:flutter_app/widgets/top_bar_with_background.dart';
import '../api/api_service.dart';
import '../config/request_config.dart';
import '../models/medicine_model.dart';
import '../widgets/no_glow_scroll.dart';

class MedicineListScreen extends StatefulWidget {
  final String pharmacyId;

  const MedicineListScreen({
    super.key,
    required this.pharmacyId,
  });

  @override
  MedicineListScreenState createState() => MedicineListScreenState();
}

class MedicineListScreenState extends State<MedicineListScreen> {
  late Future<List<Medicine>> medicinesFuture;

  @override
  void initState() {
    super.initState();
    medicinesFuture = _fetchMedicines(widget.pharmacyId);
  }

  Future<List<Medicine>> _fetchMedicines(String pharmacyId) async {
    var headers = RequestConfig.getHeaders(context);
    final apiService =
        ApiService(baseUrl: 'http://10.0.2.2:3001', headers: headers);
    final response =
        await apiService.fetchData('medicines/bypharmacy/$pharmacyId');
    return List<Medicine>.from(response.map((x) => Medicine.fromJson(x)));
  }

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
            titleContent: const Text(
              'Medicine List',
              style: TextStyle(fontSize: 20, color: Colors.white),
            ),
            trailingContent: Container(),
          ),
          const SizedBox(
            height: 15,
          ),
          Expanded(
            child: FutureBuilder<List<Medicine>>(
              future: medicinesFuture,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return const Center(child: Text('No medicines found'));
                }

                return NoGlowScrollWrapper(
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: DataTable(
                      columns: const [
                        DataColumn(label: Text('Medicine Name')),
                        DataColumn(label: Text('Medicine ID')),
                        DataColumn(label: Text('Group Name')),
                        DataColumn(label: Text('Qty in Stock')),
                        DataColumn(label: Text('Action')),
                      ],
                      rows: snapshot.data!
                          .map(
                            (medicine) => DataRow(cells: [
                              DataCell(
                                  Text(medicine.medicineDetails.first.name)),
                              DataCell(Text(medicine.id)),
                              DataCell(
                                  Text(medicine.medicineDetails.first.group)),
                              DataCell(Text('${medicine.stockLevel}')),
                              DataCell(ElevatedButton(
                                onPressed: () {
                                  // TODO: View details logic
                                },
                                child: const Text('View Full Detail'),
                              )),
                            ]),
                          )
                          .toList(),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
