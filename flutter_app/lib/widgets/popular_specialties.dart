import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'no_glow_scroll.dart';

class PopularSpecialtiesWidget extends StatelessWidget {
  PopularSpecialtiesWidget({super.key});

  final List<Specialty> specialties = [
    Specialty("Eye Specialist", "assets/eye.svg"),
    Specialty("Dentist", "assets/dentist.svg"),
    Specialty("Cardiologist", "assets/cardiologist.svg"),
    Specialty("Pulmonologist", "assets/pulmonologist.svg"),
    Specialty("Physiotherapist", "assets/physiotherapist.svg"),
  ];

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
        SizedBox(
          height: 120,
          child: NoGlowScrollWrapper(
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: specialties.length,
              physics: const ClampingScrollPhysics(),
              itemBuilder: (context, index) {
                var specialty = specialties[index];
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        width: 60,
                        height: 60,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: const Color(0xFF0D4C92).withOpacity(0.2),
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
                );
              },
            ),
          ),
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
