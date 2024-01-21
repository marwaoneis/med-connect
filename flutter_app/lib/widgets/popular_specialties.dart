import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../api/api_service.dart';
import '../config/request_config.dart';
import 'no_glow_scroll.dart';

class PopularSpecialtiesWidget extends StatelessWidget {
  const PopularSpecialtiesWidget({super.key});

  Future<List<String>> fetchSpecializations() async {
    var headers = RequestConfig.getHeaders(context);
    final apiService =
        ApiService(baseUrl: 'http://10.0.2.2:3001', headers: headers);
    final data = await apiService.fetchData('specializations/');
    return List<String>.from(data);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 15.0),
          child: Text(
            "Most popular Specialties",
            style: TextStyle(
              fontSize: 16.0,
              fontWeight: FontWeight.w900,
            ),
          ),
        ),
        const SizedBox(height: 15),
        FutureBuilder<List<String>>(
          future: fetchSpecializations(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return CircularProgressIndicator(); // Show loading indicator
            } else if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            } else {
              // Your specialties are in snapshot.data
              List<Specialty> specialties = snapshot.data!
                  .map((name) => Specialty(name, getIconPathForSpecialty(name)))
                  .toList();

              return SizedBox(
                height: 120,
                child: NoGlowScrollWrapper(
                  child: ListView.builder(
                      // ... same as before, but use 'specialties' for the data
                      ),
                ),
              );
            }
          },
        ),
      ],
    );
  }

  String getIconPathForSpecialty(String specialtyName) {
    // Here, map specialty names to icon paths
    switch (specialtyName) {
      case "Cardiology":
        return "assets/cardiologist.svg";
      // ... add cases for each specialty
      default:
        return "assets/default_icon.svg";
    }
  }
}

class Specialty {
  final String name;
  final String iconPath;

  Specialty(this.name, this.iconPath);
}
