import 'package:flutter/material.dart';
import 'package:flutter_app/screens/patient_profile.dart';
import '../api/api_service.dart';
import '../config/request_config.dart';
import '../widgets/footer.dart';
import '../widgets/top_bar_with_background.dart';
import '../models/doctor_model.dart';
import 'message_screen.dart';
import 'patient_screen.dart';

class DoctorAppointments extends StatefulWidget {
  final String title;

  const DoctorAppointments({super.key, this.title = 'Doctors'});

  @override
  DoctorAppointmentsState createState() => DoctorAppointmentsState();
}

class DoctorAppointmentsState extends State<DoctorAppointments> {
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
                builder: (context) => const DoctorAppointments(
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
