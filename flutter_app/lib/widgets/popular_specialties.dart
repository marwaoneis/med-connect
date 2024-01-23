import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../api/api_service.dart';
import '../config/request_config.dart';
import '../screens/specialist_doctors.dart';
import 'no_glow_scroll.dart';

class PopularSpecialtiesWidget extends StatelessWidget {
  const PopularSpecialtiesWidget({super.key});

  Future<List<Specialty>> fetchSpecializations(BuildContext context) async {
    var headers = RequestConfig.getHeaders(context);
    final apiService =
        ApiService(baseUrl: 'http://10.0.2.2:3001', headers: headers);
    final data = await apiService.fetchData('specializations/');
    return List<String>.from(data)
        .map((name) => Specialty(name, getIconPathForSpecialty(name)))
        .toList();
  }

  void _navigateToSpecialistDoctorsScreen(
      BuildContext context, String specialization) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) =>
            SpecialistDoctorsScreen(specialization: specialization),
      ),
    );
  }

  String getIconPathForSpecialty(String specialtyName) {
    switch (specialtyName) {
      case "Cardiology":
        return "assets/cardiologist.svg";
      case "Dermatology":
        return "assets/dermatologist.svg";
      case "EmergencyMedicine":
        return "assets/cardiologist.svg";
      case "Gastroenterology":
        return "assets/dermatologist.svg";
      case "GeneralSurgery":
        return "assets/cardiologist.svg";
      case "InternalMedicine":
        return "assets/dermatologist.svg";
      case "Neurology":
        return "assets/cardiologist.svg";
      case "ObstetricsGynecology":
        return "assets/dermatologist.svg";
      case "Oncology":
        return "assets/cardiologist.svg";
      case "Ophthalmology":
        return "assets/dermatologist.svg";
      case "Orthopedics":
        return "assets/cardiologist.svg";
      case "Pediatrics":
        return "assets/dermatologist.svg";
      case "Psychiatry":
        return "assets/dermatologist.svg";
      case "Pulmonology":
        return "assets/cardiologist.svg";
      case "Radiology":
        return "assets/dermatologist.svg";
      case "Urology":
        return "assets/cardiologist.svg";
      case "Anesthesiology":
        return "assets/dermatologist.svg";
      case "Endocrinology":
        return "assets/cardiologist.svg";
      case "Nephrology":
        return "assets/dermatologist.svg";
      case "Rheumatology":
        return "assets/cardiologist.svg";
      default:
        return "assets/dentist.svg";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 15.0),
          child: Text(
            "Most Popular Specialties",
            style: TextStyle(
              fontSize: 16.0,
              fontWeight: FontWeight.w900,
            ),
          ),
        ),
        const SizedBox(height: 15),
        FutureBuilder<List<Specialty>>(
          future: fetchSpecializations(context),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            } else if (snapshot.hasData) {
              var specialties = snapshot.data!;
              return SizedBox(
                height: 120,
                child: NoGlowScrollWrapper(
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: specialties.length,
                    itemBuilder: (context, index) {
                      var specialty = specialties[index];
                      return InkWell(
                        onTap: () => _navigateToSpecialistDoctorsScreen(
                            context, specialty.name),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Container(
                                width: 60,
                                height: 60,
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                  color:
                                      const Color(0xFF0D4C92).withOpacity(0.2),
                                  shape: BoxShape.circle,
                                ),
                                child: SvgPicture.asset(
                                  specialty.iconPath,
                                  semanticsLabel: specialty.name,
                                  width: 35,
                                  height: 35,
                                ),
                              ),
                              const SizedBox(height: 5),
                              Text(
                                specialty.name,
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 13.0,
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
              );
            } else {
              return const Text("No Specialties Found");
            }
          },
        ),
      ],
    );
  }
}

class Specialty {
  final String name;
  final String iconPath;

  Specialty(this.name, this.iconPath);
}
