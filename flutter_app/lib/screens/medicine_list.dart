import 'package:flutter/material.dart';
import 'package:flutter_app/widgets/top_bar_with_background.dart';
import '../api/api_service.dart';
import '../config/request_config.dart';
import '../models/medicine_model.dart';
import 'pharmacy_medicine_info.dart';

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

                return SingleChildScrollView(
                  child: Container(
                    margin: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        DataTable(
                          dataRowHeight: 80,
                          columnSpacing: 0,
                          horizontalMargin: 5,
                          columns: const [
                            DataColumn(
                              label: SizedBox(
                                width: 80,
                                child: Text(
                                  'Medicine Name',
                                  softWrap: true,
                                  style: TextStyle(
                                      fontSize: 13,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                            DataColumn(
                              label: SizedBox(
                                width: 80,
                                child: Text('Medicine ID',
                                    softWrap: true,
                                    style: TextStyle(
                                        fontSize: 13,
                                        fontWeight: FontWeight.bold)),
                              ),
                            ),
                            DataColumn(
                              label: SizedBox(
                                width: 80,
                                child: Text('Group Name',
                                    softWrap: true,
                                    style: TextStyle(
                                        fontSize: 13,
                                        fontWeight: FontWeight.bold)),
                              ),
                            ),
                            DataColumn(
                              label: SizedBox(
                                width: 90,
                                child: Text('Qty in Stock',
                                    softWrap: true,
                                    style: TextStyle(
                                        fontSize: 13,
                                        fontWeight: FontWeight.bold)),
                              ),
                            ),
                            DataColumn(
                              label: SizedBox(
                                width: 90,
                                child: Text('Action',
                                    softWrap: true,
                                    style: TextStyle(
                                        fontSize: 13,
                                        fontWeight: FontWeight.bold)),
                              ),
                            ),
                          ],
                          rows: snapshot.data!
                              .map(
                                (medicine) => DataRow(cells: [
                                  DataCell(Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 8, horizontal: 5),
                                      child: Container(
                                          alignment: Alignment.center,
                                          child: Text(
                                              medicine
                                                  .medicineDetails.first.name,
                                              style: const TextStyle(
                                                  fontSize: 12))))),
                                  DataCell(Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 8, horizontal: 5),
                                      child: Container(
                                          alignment: Alignment.center,
                                          width: 70,
                                          child: Text(medicine.id,
                                              style: const TextStyle(
                                                  fontSize: 12))))),
                                  DataCell(Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 8, horizontal: 5),
                                      child: Container(
                                          alignment: Alignment.center,
                                          width: 70,
                                          child: Text(
                                              medicine
                                                  .medicineDetails.first.group,
                                              style: const TextStyle(
                                                  fontSize: 12))))),
                                  DataCell(Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 8, horizontal: 5),
                                      child: Container(
                                          alignment: Alignment.center,
                                          width: 70,
                                          child: Text('${medicine.stockLevel}',
                                              style: const TextStyle(
                                                  fontSize: 12))))),
                                  DataCell(
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 8, horizontal: 5),
                                      child: Container(
                                        alignment: Alignment.center,
                                        width: 100,
                                        child: TextButton(
                                          onPressed: () {
                                            Navigator.of(context).push(
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    PharmacyMedicineInfoScreen(
                                                        medicine: medicine),
                                              ),
                                            );
                                          },
                                          style: TextButton.styleFrom(
                                            padding: const EdgeInsets.only(
                                              left: 0,
                                              right: 50,
                                              top: 4,
                                              bottom: 4,
                                            ),
                                          ),
                                          child: const Text('View Full Detail',
                                              style: TextStyle(
                                                  fontSize: 10,
                                                  color: Colors.black)),
                                        ),
                                      ),
                                    ),
                                  ),
                                ]),
                              )
                              .toList(),
                        ),
                        const SizedBox(height: 12),
                        Padding(
                          padding: const EdgeInsets.all(15),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              ElevatedButton.icon(
                                onPressed: () {},
                                icon:
                                    const Icon(Icons.add, color: Colors.white),
                                label: const Text(
                                  'Add Medicine',
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 20),
                                ),
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: const Color(0xFFE93B81),
                                  minimumSize: const Size(50, 50),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
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
