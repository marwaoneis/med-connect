import 'package:flutter/material.dart';
import 'package:flutter_app/widgets/no_glow_scroll.dart';
import '../api/api_service.dart';
import '../config/request_config.dart';
import '../widgets/doctor_card.dart';
import '../widgets/footer.dart';
import '../widgets/top_bar_with_background.dart';
import '../models/doctor_model.dart';
import '../screens/doctor_profile.dart';
import 'message_screen.dart';
import 'patient_appointments.dart';
import 'patient_dashboard_screen.dart';
import 'patient_profile.dart';

class SpecialistDoctorsScreen extends StatefulWidget {
  final String specialization;

  const SpecialistDoctorsScreen({super.key, required this.specialization});

  @override
  SpecialistDoctorsScreenState createState() => SpecialistDoctorsScreenState();
}

class SpecialistDoctorsScreenState extends State<SpecialistDoctorsScreen> {
  late Future<List<Doctor>> doctorsData;

  @override
  void initState() {
    super.initState();
    doctorsData = _fetchDoctorsBySpecialization(widget.specialization);
  }

  Future<List<Doctor>> _fetchDoctorsBySpecialization(
      String specialization) async {
    var headers = RequestConfig.getHeaders(context);
    final apiService =
        ApiService(baseUrl: 'http://10.0.2.2:3001', headers: headers);
    final data =
        await apiService.fetchData('doctors/specialization/$specialization');
    return (data as List)
        .map((doctorJson) => Doctor.fromJson(doctorJson))
        .toList();
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
            titleContent: Text(
              widget.specialization,
              style: const TextStyle(
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
            child: FutureBuilder<List<Doctor>>(
              future: doctorsData,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  if (snapshot.hasData && snapshot.data!.isNotEmpty) {
                    return NoGlowScrollWrapper(
                      child: ListView.builder(
                        itemCount: snapshot.data!.length,
                        itemBuilder: (BuildContext context, int index) {
                          final doctor = snapshot.data![index];
                          return DoctorCard(
                            doctor: doctor,
                            rating: 4.5,
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      DoctorProfileScreen(doctor: doctor),
                                ),
                              );
                            },
                          );
                        },
                      ),
                    );
                  } else if (snapshot.hasError) {
                    // Handle error
                    return Center(child: Text('Error: ${snapshot.error}'));
                  } else {
                    return const Center(
                      child: Text(
                        'No doctors are found in this specialty',
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                    );
                  }
                }
                // While data is loading
                return const Center(child: CircularProgressIndicator());
              },
            ),
          ),
          const SizedBox(height: 5)
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
                builder: (context) =>
                    const BookAppointmentScreen(title: 'Book Appointment')),
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
