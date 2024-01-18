import 'package:flutter/material.dart';
import 'package:flutter_app/screens/patient_dashboard_screen.dart';
import 'screens/login_screen.dart';
import 'package:provider/provider.dart';
import 'providers/auth_provider.dart';
import 'screens/welcome_screen.dart';
// import 'screens/patient_screen.dart';
import 'screens/doctor_dashboard_screen.dart';
import 'screens/pharmacy_screen.dart';
// import 'screens/message_screen.dart';
import 'providers/user_provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => Auth()),
        ChangeNotifierProvider(create: (context) => UserProvider()),
      ],
      child: MaterialApp(
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
      ),
    );
  }
}
