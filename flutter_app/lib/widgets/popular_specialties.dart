import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

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
    return Container(
      height: 100, // Adjust the height as needed
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: specialties.length,
        itemBuilder: (context, index) {
          return Container(
            width: 80, // Diameter of the circle
            height: 80, // Diameter of the circle
            alignment: Alignment.center,
            margin: const EdgeInsets.all(10), // Spacing between circles
            decoration: const BoxDecoration(
              color: Colors.blue, // The color of the circle
              shape: BoxShape.circle,
            ),
            child: SvgPicture.asset(
              specialties[index].iconPath,
              color: Colors.white, // SVG icon color, if applicable
              semanticsLabel: specialties[index].name,
            ),
          );
        },
      ),
    );
  }
}

class Specialty {
  final String name;
  final String iconPath;

  Specialty(this.name, this.iconPath);
}
