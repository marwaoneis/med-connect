import 'package:flutter/material.dart';
import 'package:flutter_app/screens/login_screen.dart';
import 'screens/welcome_screen.dart';
import 'screens/patient_screen.dart';
import 'screens/doctor_screen.dart';
import 'screens/pharmacy_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MedConnect',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/WelcomeScreen',
      routes: {
        '/WelcomeScreen': (context) => const WelcomeScreen(),
        '/': (context) => const LoginScreen(),
        '/patientScreen': (context) => const PatientScreen(),
        '/doctorScreen': (context) => const DoctorScreen(),
        '/pharmacyScreen': (context) => const PharmacyScreen(),
      },
    );
  }
}
