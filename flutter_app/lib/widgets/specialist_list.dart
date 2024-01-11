import 'package:flutter/material.dart';

class Specialist {
  final String name;
  final String specialty;
  final String imageUrl;
  final double price;

  Specialist({
    required this.name,
    required this.specialty,
    required this.imageUrl,
    required this.price,
  });
}

class SpecialistList extends StatelessWidget {
  final List<Specialist> specialists = [
    Specialist(
      name: 'Miles, Esther',
      specialty: 'Neurology',
      imageUrl: 'assets/doctor_image.png',
      price: 80,
    ),
    Specialist(
      name: 'Flores, Juanita',
      specialty: 'Geriatrics',
      imageUrl: 'assets/doctor_image.png',
      price: 60,
    ),
    Specialist(
      name: 'Miles, Esther',
      specialty: 'Neurology',
      imageUrl: 'assets/doctor_image.png',
      price: 80,
    ),
    Specialist(
      name: 'Flores, Juanita',
      specialty: 'Geriatrics',
      imageUrl: 'assets/doctor_image.png',
      price: 60,
    ),
    // Add more specialists
  ];

  SpecialistList({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Expanded(
                child: Text(
                  "Specialists",
                  style: TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.w900,
                  ),
                ),
              ),
              InkWell(
                onTap: () {
                  // Handle "View all" tap
                },
                child: const Text(
                  'View all >',
                  style: TextStyle(
                      color: Color(0xFF0D4C92),
                      fontSize: 14,
                      decoration: TextDecoration.none,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          height: 300,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: specialists.length,
            itemBuilder: (BuildContext context, int index) {
              Specialist specialist = specialists[index];
              return Padding(
                padding: const EdgeInsets.fromLTRB(12.0, 10.0, 12.0, 12.0),
                child: Card(
                  child: SizedBox(
                    width: 170,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: ClipRRect(
                            borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(10),
                              topRight: Radius.circular(10),
                            ),
                            child: Image.asset(
                              specialist.imageUrl,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                specialist.specialty,
                                style: const TextStyle(),
                              ),
                              Text(
                                specialist.name,
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 16),
                              ),
                              const SizedBox(height: 15.0),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    '€${specialist.price}',
                                    style: const TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w900),
                                  ),
                                  ElevatedButton(
                                    onPressed: () {
                                      // Handle chat button press
                                    },
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: const Color(0xFF0D4C92),
                                      foregroundColor: Colors.white,
                                    ),
                                    child: const Text('Chat'),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
