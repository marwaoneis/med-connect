import 'package:flutter/material.dart';
import '../widgets/top_bar.dart';
import '../widgets/search_bar.dart';
import '../widgets/menu_grid.dart';
import '../widgets/appointment_card.dart';
import '../widgets/pharmacy_list.dart';
import '../widgets/specialist_list.dart';
import '../api/api_service.dart';

class PatientScreen extends StatefulWidget {
  const PatientScreen({super.key});
  @override
  PatientScreenState createState() => PatientScreenState();
}

class PatientScreenState extends State<PatientScreen> {
  late Future<Map<String, String>> patientData;

  @override
  void initState() {
    super.initState();
    ApiService apiService = ApiService(baseUrl: 'http://10.0.2.2:3001/');
    patientData = _fetchPatientData(apiService);
  }

  Future<Map<String, String>> _fetchPatientData(ApiService apiService) async {
    var data = await apiService.fetchData('patients/');
    return {
      "firstName": data['firstName'],
      "address": data['address'],
    };
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Map<String, String>>(
      future: patientData,
      builder:
          (BuildContext context, AsyncSnapshot<Map<String, String>> snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          if (snapshot.hasData) {
            return Scaffold(
              appBar: const TopBar(
                firstName: "Marwa",
                address: "Bekaa",
              ),
              body: ListView(
                children: const [
                  CustomSearchBar(),
                  MenuGrid(),
                  SizedBox(height: 10),
                  AppointmentCard(),
                  SizedBox(height: 10),
                  PharmacyList(),
                  SizedBox(height: 10),
                  SpecialistList(),
                ],
              ),
            );
          } else if (snapshot.hasError) {
            return Scaffold(
              body: Center(child: Text('Error: ${snapshot.error}')),
            );
          }
        }
        return const Scaffold(
          body: Center(child: CircularProgressIndicator()),
        );
      },
    );
  }
}
