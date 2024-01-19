import 'package:flutter/material.dart';
import 'package:flutter_app/widgets/top_bar_with_background.dart';
import '../api/api_service.dart';
import '../config/request_config.dart';
import '../models/medicine_model.dart';

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

  Widget _buildMedicineRow(Medicine medicine) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(medicine.medicineDetails.first.name),
          Text(medicine.),
          Text(medicine.medicineDetails.first.group),
          Text('${medicine.stockLevel}'),
          ElevatedButton(
            onPressed: () {
              // View details logic
            },
            child: const Text('View Full Detail'),
          ),
        ],
      ),
    );
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
          Expanded(
            child: FutureBuilder<List<Medicine>>(
              future: _medicinesFuture,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return const Center(child: Text('No medicines found'));
                }

                List<Medicine> medicines = snapshot.data!;

                return ListView.builder(
                  itemCount: medicines.length,
                  itemBuilder: (context, index) {
                    return _buildMedicineRow(medicines[index]);
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
