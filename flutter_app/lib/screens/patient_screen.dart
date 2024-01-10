import 'package:flutter/material.dart';
import '../widgets/search_bar.dart';
import '../widgets/dashboard_menu.dart';
import '../widgets/appointment_card.dart';
import '../widgets/pharmacy_list.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../widgets/specialist_list.dart';
import '../api/api_service.dart';
import '../providers/auth_provider.dart';
import 'package:provider/provider.dart';
import '../screens/message_screen.dart';
import '../widgets/footer.dart';
import '../widgets/popular_specialties.dart';

class PatientScreen extends StatefulWidget {
  const PatientScreen({super.key});
  @override
  PatientScreenState createState() => PatientScreenState();
}

class PatientScreenState extends State<PatientScreen> {
  Future<Map<String, dynamic>> patientData = Future.value({});

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final authProvider = Provider.of<Auth>(context, listen: false);
      if (authProvider.getUserId != null) {
        setState(() {
          patientData = _fetchPatientData();
        });
      } else {
        // If userId is null, redirect to login or handle appropriately
      }
    });
  }

  Future<Map<String, dynamic>> _fetchPatientData() async {
    final apiService = ApiService(baseUrl: 'http://10.0.2.2:3001/');
    final userId = Provider.of<Auth>(context, listen: false).getUserId;
    var data = await apiService.fetchData('patients/$userId');
    print(
        'Fetched patient data: $data'); // This will log the data to your console.
    return data;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Map<String, dynamic>>(
      future: patientData,
      builder:
          (BuildContext context, AsyncSnapshot<Map<String, dynamic>> snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          if (snapshot.hasData) {
            final String firstName = snapshot.data?['firstName'] ?? 'N/A';
            final String address = snapshot.data?['address'] ?? 'N/A';

            return Scaffold(
              body: Column(
                children: <Widget>[
                  _buildTopBarWithBackground(context, firstName, address),
                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        children: <Widget>[
                          const SizedBox(height: 5),
                          SizedBox(
                            height: 250,
                            child: DashboardMenu(),
                          ),
                          PopularSpecialtiesWidget(),
                          const SizedBox(height: 10),
                          const AppointmentCard(),
                          const SizedBox(height: 10),
                          const PharmacyList(),
                          const SizedBox(height: 10),
                          const SpecialistList(),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              bottomNavigationBar: Footer(
                onHomeTap: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const PatientScreen()),
                  );
                },
                onAppointmentTap: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const PatientScreen()),
                  );
                },
                onChatTap: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const MessageScreen()),
                  );
                },
                onProfileTap: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const MessageScreen()),
                  );
                },
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

Widget _buildTopBarWithBackground(
    BuildContext context, String firstName, String address) {
  return Stack(
    children: [
      Container(
        height: 175,
        decoration: const BoxDecoration(
          color: Color(0xFF0D4C92),
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.elliptical(50, 30),
            bottomRight: Radius.elliptical(50, 20),
          ),
        ),
      ),
      Column(
        children: [
          const SizedBox(height: 50),
          Container(
            color: Colors.white.withOpacity(0.9),
            height: 45,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Row(
                children: [
                  CircleAvatar(
                    // backgroundImage: const NetworkImage(
                    //     'http://10.0.2.2:3001/path_to_avatar'),
                    backgroundColor: Colors.grey[200],
                    child: Text(firstName[0]),
                  ),
                  const SizedBox(width: 8),
                  Text(
                    '$firstName, $address',
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  const Spacer(),
                  IconButton(
                    icon: SvgPicture.asset('assets/notification_icon.svg'),
                    onPressed: () {
                      // Your existing code
                    },
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 45),
          const CustomSearchBar(),
        ],
      ),
    ],
  );
}
