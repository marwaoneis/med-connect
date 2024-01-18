import 'package:flutter/material.dart';
import 'package:flutter_app/screens/patient_profile.dart';
import 'package:flutter_app/widgets/no_glow_scroll.dart';
import '../api/api_service.dart';
import '../config/request_config.dart';
import '../widgets/doctor_card.dart';
import '../widgets/footer.dart';
import '../widgets/top_bar_with_background.dart';
import '../models/doctor_model.dart';
import '../screens/doctor_profile.dart';
import 'message_screen.dart';
import 'patient_dashboard_screen.dart';

class BookAppointmentScreen extends StatefulWidget {
  final String title;

  const BookAppointmentScreen({super.key, this.title = 'Doctors'});

  @override
  BookAppointmentScreenState createState() => BookAppointmentScreenState();
}

class BookAppointmentScreenState extends State<BookAppointmentScreen> {
  late Future<List<Doctor>> doctorsData;

  @override
  void initState() {
    super.initState();
    doctorsData = _fetchDoctorsData();
  }

  Future<List<Doctor>> _fetchDoctorsData() async {
    var headers = RequestConfig.getHeaders(context);
    final apiService =
        ApiService(baseUrl: 'http://10.0.2.2:3001', headers: headers);
    final data = await apiService.fetchData('doctors/');
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
              widget.title,
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
                  if (snapshot.hasData) {
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
                    return Center(child: Text('Error: ${snapshot.error}'));
                  }
                }
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
                builder: (context) => const BookAppointmentScreen(
                      title: 'Book Appointment',
                    )),
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
