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
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;

class DoctorProfileLogoutScreen extends StatefulWidget {
  const DoctorProfileLogoutScreen({super.key});

  @override
  DoctorProfileLogoutScreenState createState() =>
      DoctorProfileLogoutScreenState();
}

class DoctorProfileLogoutScreenState extends State<DoctorProfileLogoutScreen> {
  Map<String, dynamic>? doctorData;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchDoctorData().then((data) {
      if (mounted) {
        setState(() {
          doctorData = data;
          isLoading = false;
        });
      }
    });
  }

  Future<void> _uploadProfilePicture(
      BuildContext context, String userId) async {
    final ImagePicker _picker = ImagePicker();
    // Pick an image
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);

    if (image != null) {
      var uri = Uri.http(RequestConfig.url, '/doctors/$userId/profile-picture');
      var request = http.MultipartRequest('POST', uri);
      request.headers.addAll(RequestConfig.getHeaders(context));

      // Attach the file in the request
      request.files
          .add(await http.MultipartFile.fromPath('profilePicture', image.path));

      try {
        var streamedResponse = await request.send();
        var response = await http.Response.fromStream(streamedResponse);
        if (response.statusCode == 200) {
          // Handle successful upload
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Profile picture updated successfully!')),
          );
        } else {
          // Handle error
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Failed to upload profile picture')),
          );
        }
      } catch (e) {
        // Handle exception
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error: $e')),
        );
      }
    }
  }

  Future<Map<String, dynamic>> _fetchDoctorData() async {
    var headers = RequestConfig.getHeaders(context);

    final apiService =
        ApiService(baseUrl: 'http://10.0.2.2:3001', headers: headers);
    final userId = Provider.of<Auth>(context, listen: false).getUserId;
    var data = await apiService.fetchData('doctors/$userId');
    return data;
  }

  @override
  Widget build(BuildContext context) {
    String doctorId = doctorData?['_id'] ?? '';

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
            if (!isLoading && doctorData != null)
              _buildProfileCard(
                doctorData!['firstName'] ?? 'N/A',
                doctorData!['lastName'] ?? 'N/A',
                doctorData!['phone'] ?? 'N/A',
                doctorData!['specialization'] ?? 'N/A',
                doctorData!['profilePicture'],
                doctorId,
              ),
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
                builder: (context) => const DoctorProfileLogoutScreen()),
          );
        },
      ),
    );
  }

  Widget _buildProfileCard(String firstName, String lastName, String phone,
      String speciality, String? profilePictureUrl, String doctorId) {
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
            _buildProfilePicture(context, profilePictureUrl, doctorId),
            const SizedBox(width: 20),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('$firstName $lastName',
                      style: const TextStyle(
                          fontSize: 25, fontWeight: FontWeight.bold)),
                  Row(
                    children: [
                      const Text('Specialization:',
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 16,
                              fontWeight: FontWeight.w800)),
                      Text(speciality,
                          style: const TextStyle(
                              color: Colors.black,
                              fontSize: 16,
                              fontWeight: FontWeight.w500)),
                    ],
                  ),
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

  Widget _buildProfilePicture(
      BuildContext context, String? profileImageUrl, String userId) {
    String imageUrl = profileImageUrl != null && profileImageUrl.isNotEmpty
        ? profileImageUrl
        : 'https://png.pngtree.com/png-clipart/20230918/ourmid/pngtree-photo-men-doctor-physician-chest-smiling-png-image_10132895.png';

    return Stack(
      alignment: Alignment.bottomRight,
      children: [
        CircleAvatar(
          radius: 40,
          backgroundImage: NetworkImage(imageUrl),
        ),
        IconButton(
          onPressed: () => _uploadProfilePicture(context, userId),
          icon: const Icon(Icons.camera_alt),
          style: IconButton.styleFrom(
            padding: const EdgeInsets.all(10),
            // backgroundColor: Colors.blue,
            foregroundColor: Colors.white,
          ),
        ),
      ],
    );
  }
}
