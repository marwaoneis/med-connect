import 'package:flutter/material.dart';
import '../screens/doctor_profile.dart';
import '../models/doctor_model.dart';

class DoctorCard extends StatelessWidget {
  final Doctor doctor;
  final double rating;
  final VoidCallback onTap;

  const DoctorCard({
    super.key,
    required this.doctor,
    required this.rating,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(
              color: const Color.fromARGB(255, 228, 225, 225), width: 1),
          borderRadius: BorderRadius.circular(20.0),
        ),
        margin: const EdgeInsets.symmetric(horizontal: 22.0, vertical: 5.0),
        child: Card(
          color: Colors.white,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5.0),
          ),
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              children: [
                Row(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(10.0),
                      child: Image.asset(
                        'assets/doctor_image.png',
                        fit: BoxFit.cover,
                        width: 80.0,
                        height: 80.0,
                      ),
                    ),
                    const SizedBox(width: 10.0),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Dr. ${doctor.firstName} ${doctor.lastName}",
                            style: const TextStyle(
                              fontWeight: FontWeight.w900,
                              fontSize: 18,
                            ),
                          ),
                          Text(
                            doctor.specialization,
                            style: const TextStyle(
                                fontSize: 14, color: Color(0xFF0D4C92)),
                          ),
                          const SizedBox(height: 4.0),
                          Row(
                            children: [
                              const Icon(Icons.access_time,
                                  color: Colors.grey, size: 16),
                              const SizedBox(width: 4.0),
                              Text(
                                '${doctor.yearsOfExperience} Years',
                                style: const TextStyle(
                                    color: Colors.grey,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w700),
                              ),
                              const SizedBox(width: 25.0),
                              const Icon(Icons.star,
                                  color: Colors.grey, size: 16),
                              const SizedBox(width: 4.0),
                              Text(
                                '$rating',
                                style: const TextStyle(
                                    color: Colors.grey,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w700),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 5.0),
                const Divider(color: Color.fromARGB(255, 228, 225, 225)),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '\$${doctor.appointmentPrice.toString()}',
                      style: const TextStyle(
                        fontWeight: FontWeight.w900,
                        fontSize: 20,
                        color: Colors.black,
                      ),
                    ),
                    const SizedBox(height: 16.0),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor:
                            const Color(0xFF0D4C92), // Background color
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                DoctorProfileScreen(doctor: doctor),
                          ),
                        );
                      },
                      child: const Text('Book',
                          style: TextStyle(color: Colors.white)),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
