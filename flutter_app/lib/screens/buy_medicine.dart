import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../config/request_config.dart';
import '../providers/auth_provider.dart';
import '../widgets/medicine_card.dart';
import '../models/medicine_model.dart';
import '../api/api_service.dart';

class BuyMedicineScreen extends StatefulWidget {
  const BuyMedicineScreen({super.key});

  @override
  BuyMedicineScreenState createState() => BuyMedicineScreenState();
}

class BuyMedicineScreenState extends State<BuyMedicineScreen> {
  late Future<List<Medicine>> medicinesData;

  @override
  void initState() {
    super.initState();
    medicinesData = _fetchMedicinesData();
  }

  Future<List<Medicine>> _fetchMedicinesData() async {
    var headers = RequestConfig.getHeaders(context);

    final apiService =
        ApiService(baseUrl: 'http://10.0.2.2:3001', headers: headers);
    final userId = Provider.of<Auth>(context, listen: false).getUserId;
    final data = await apiService.fetchData('medicines/$userId');
    return (data as List)
        .map((medicineJson) => Medicine.fromJson(medicineJson))
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Buy Medicines'),
      ),
      body: FutureBuilder<List<Medicine>>(
        future: medicinesData,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasData) {
              return ListView.builder(
                itemCount: snapshot.data!.length,
                itemBuilder: (BuildContext context, int index) {
                  final medicine = snapshot.data![index];
                  const pharmacyName = 'Pharmacy Name';
                  return MedicineCard(
                    medicine: medicine,
                    pharmacyName: pharmacyName,
                    onTap: () {},
                  );
                },
              );
            } else if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            }
          }
          return const Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}
