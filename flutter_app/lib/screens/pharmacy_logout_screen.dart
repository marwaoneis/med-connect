import 'package:flutter/material.dart';
import 'package:flutter_app/screens/login_screen.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import '../api/api_service.dart';
import '../config/request_config.dart';
import '../providers/auth_provider.dart';
import '../widgets/footer.dart';
import 'appointments_schedule.dart';
import 'doctor_dashboard_screen.dart';
import 'doctor_message_screen.dart';
import 'patient_dashboard_screen.dart';

class PharmacyLogoutScreen extends StatefulWidget {
  const PharmacyLogoutScreen({super.key});

  @override
  PharmacyLogoutScreenState createState() => PharmacyLogoutScreenState();
}

class PharmacyLogoutScreenState extends State<PharmacyLogoutScreen> {
  Map<String, dynamic>? pharmacyData;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchpharmacyData().then((data) {
      if (mounted) {
        setState(() {
          pharmacyData = data;
          isLoading = false;
        });
      }
    });
  }

  Future<Map<String, dynamic>> _fetchpharmacyData() async {
    var headers = RequestConfig.getHeaders(context);

    final apiService =
        ApiService(baseUrl: 'http://10.0.2.2:3001', headers: headers);
    final userId = Provider.of<Auth>(context, listen: false).getUserId;
    var data = await apiService.fetchData('pharmacies/$userId');
    return data;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => const PatientScreen()),
            );
          },
        ),
        title: const Text('Profile', style: TextStyle(color: Colors.black)),
        backgroundColor: Colors.white,
        centerTitle: true,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 20),
            if (!isLoading && pharmacyData != null)
              _buildProfileCard(pharmacyData!['username'] ?? 'N/A',
                  pharmacyData!['phone'] ?? 'N/A'),
            if (isLoading)
              const Padding(
                padding: EdgeInsets.all(20.0),
                child: Text('Loading patient data...'),
              ),
            const SizedBox(height: 20),
            _buildOption('assets/logout.svg', 'Log Out', '', onTap: () async {
              final authProvider = Provider.of<Auth>(context, listen: false);
              await authProvider.logout().then((_) {
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => const LoginScreen()),
                  (Route<dynamic> route) => false,
                );
              }).catchError((error) {
                showDialog(
                  context: context,
                  builder: (ctx) => AlertDialog(
                    title: const Text('Logout Failed'),
                    content: Text('An error occurred: $error'),
                    actions: <Widget>[
                      TextButton(
                        child: const Text('Okay'),
                        onPressed: () {
                          Navigator.of(ctx).pop();
                        },
                      ),
                    ],
                  ),
                );
              });
            }),
          ],
        ),
      ),
      bottomNavigationBar: Footer(
        onHomeTap: () {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const DoctorScreen()),
          );
        },
        onAppointmentTap: () {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (context) => const AppointmentScheduleScreen()),
          );
        },
        onChatTap: () {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (context) => const DoctorMessageScreen()),
          );
        },
        onProfileTap: () {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (context) => const PharmacyLogoutScreen()),
          );
        },
      ),
    );
  }

  Widget _buildProfileCard(String username, String phone) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Colors.grey.shade400),
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 2,
            blurRadius: 5,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            const CircleAvatar(
              radius: 40,
              backgroundImage: NetworkImage('https://via.placeholder.com/150'),
            ),
            const SizedBox(width: 20),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('$username',
                      style: const TextStyle(
                          fontSize: 25, fontWeight: FontWeight.bold)),
                  Row(
                    children: [
                      const Text('Phone Number:',
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 16,
                              fontWeight: FontWeight.w800)),
                      Text(phone,
                          style: const TextStyle(
                              color: Colors.black,
                              fontSize: 16,
                              fontWeight: FontWeight.w500)),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildOption(String svgAssetPath, String title, String subtitle,
      {VoidCallback? onTap}) {
    Color iconBackgroundColor = const Color(0xFF0D4C92).withOpacity(0.2);

    return Center(
      child: SizedBox(
        height: 85,
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(color: Colors.grey.shade400),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Center(
            child: ListTile(
              leading: Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: iconBackgroundColor,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: SvgPicture.asset(
                  svgAssetPath,
                ),
              ),
              title: Text(
                title,
                style:
                    const TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
              ),
              subtitle: subtitle.isNotEmpty ? Text(subtitle) : null,
              trailing: const Icon(Icons.arrow_forward_ios,
                  size: 16, color: Color(0xFF0D4C92)),
              onTap: onTap,
            ),
          ),
        ),
      ),
    );
  }
}
