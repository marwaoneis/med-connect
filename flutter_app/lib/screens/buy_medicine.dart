import 'package:flutter/material.dart';
import '../config/request_config.dart';
import '../models/pharmacy_model.dart';
import '../widgets/footer.dart';
import '../widgets/medicine_card.dart';
import '../models/medicine_model.dart';
import '../api/api_service.dart';
import '../widgets/no_glow_scroll.dart';
import '../widgets/top_bar_with_background.dart';
import 'message_screen.dart';
import 'patient_appointments.dart';
import 'patient_profile.dart';
import 'patient_screen.dart';

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

  String capitalize(String s) =>
      s.isNotEmpty ? s[0].toUpperCase() + s.substring(1) : s;

  Future<List<Medicine>> _fetchMedicinesData() async {
    var headers = RequestConfig.getHeaders(context);

    final apiService =
        ApiService(baseUrl: 'http://10.0.2.2:3001', headers: headers);
    final data = await apiService.fetchData('medicines/');
    return (data as List)
        .map((medicineJson) => Medicine.fromJson(medicineJson))
        .toList();
  }

  Future<Pharmacy> _fetchPharmacyDetails(String pharmacyId) async {
    var headers = RequestConfig.getHeaders(context);

    final apiService =
        ApiService(baseUrl: 'http://10.0.2.2:3001', headers: headers);
    final data = await apiService.fetchData('pharmacies/$pharmacyId');
    return Pharmacy.fromJson(data);
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
              'Medicines',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            trailingContent: IconButton(
              icon: const Icon(Icons.filter_list, color: Colors.white),
              onPressed: () {
                // TODO: Sort action
              },
            ),
          ),
          Expanded(
            child: FutureBuilder<List<Medicine>>(
              future: medicinesData,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  if (snapshot.hasData) {
                    return NoGlowScrollWrapper(
                      child: ListView.builder(
                        itemCount: snapshot.data!.length,
                        itemBuilder: (BuildContext context, int index) {
                          final medicine = snapshot.data![index];

                          return FutureBuilder<Pharmacy>(
                            future: _fetchPharmacyDetails(medicine.pharmacyId),
                            builder: (context, pharmacySnapshot) {
                              if (pharmacySnapshot.connectionState ==
                                      ConnectionState.done &&
                                  pharmacySnapshot.hasData) {
                                return MedicineCard(
                                  medicine: medicine,
                                  pharmacyName: capitalize(
                                      pharmacySnapshot.data!.username),
                                  onTap: () {
                                    // Handle the tap event
                                  },
                                );
                              } else if (pharmacySnapshot.hasError) {
                                return Text('Error: ${pharmacySnapshot.error}');
                              }
                              return const CircularProgressIndicator();
                            },
                          );
                        },
                      ),
                    );
                  } else if (snapshot.hasError) {
                    return Center(child: Text('Error: ${snapshot.error}'));
                  }
                }
                return const Center(child: CircularProgressIndicator());
              },
            ),
          ),
        ],
      ),
      bottomNavigationBar: Footer(
        onHomeTap: () {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const PatientScreen()),
          );
        },
        onAppointmentTap: () {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (context) => const BookAppointmentScreen()),
          );
        },
        onChatTap: () {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const MessageScreen()),
          );
        },
        onProfileTap: () {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (context) => const PatientProfileScreen()),
          );
        },
      ),
    );
  }
}
