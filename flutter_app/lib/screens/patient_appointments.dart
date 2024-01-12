import 'package:flutter/material.dart';
import 'package:flutter_app/widgets/no_glow_scroll.dart';
import '../api/api_service.dart';
import '../config/request_config.dart';
import '../widgets/doctor_card.dart';
import '../widgets/top_bar_with_background.dart';

class BookAppointmentScreen extends StatefulWidget {
  const BookAppointmentScreen({super.key});

  @override
  _BookAppointmentScreenState createState() => _BookAppointmentScreenState();
}

class _BookAppointmentScreenState extends State<BookAppointmentScreen> {
  late Future<List<Map<String, dynamic>>> doctorsData;

  @override
  void initState() {
    super.initState();
    doctorsData = _fetchDoctorsData();
  }

  Future<List<Map<String, dynamic>>> _fetchDoctorsData() async {
    var headers = RequestConfig.getHeaders(context);

    final apiService =
        ApiService(baseUrl: 'http://10.0.2.2:3001', headers: headers);
    final data = await apiService.fetchData('doctors/');
    return List<Map<String, dynamic>>.from(data);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          TopBarWithBackground(
            leadingContent: IconButton(
              icon: const Icon(Icons.arrow_back, color: Colors.black),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            titleContent: const Text(
              'Nearby Doctors',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            trailingContent: IconButton(
              icon: const Icon(Icons.filter_list, color: Colors.black),
              onPressed: () {
                // TODO: Sort action
              },
            ),
          ),
          Expanded(
            child: FutureBuilder<List<Map<String, dynamic>>>(
              future: doctorsData,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  if (snapshot.hasData) {
                    return NoGlowScrollWrapper(
                      child: ListView.builder(
                        itemCount: snapshot.data!.length,
                        itemBuilder: (BuildContext context, int index) {
                          final doctor = snapshot.data![index];
                          return DoctorCard(
                            name:
                                '${doctor['firstName']} ${doctor['lastName']}',
                            specialty: doctor['specialization'],
                            experience: doctor['yearsOfExperience'],
                            rating: 4.5,
                            fee: '€${doctor['appointmentPrice'].toString()}',
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
    );
  }
}
