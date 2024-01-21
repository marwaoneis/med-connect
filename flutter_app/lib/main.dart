import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'firebase_options.dart';
import 'providers/chat_provider.dart';
import 'providers/chats_provider.dart';
import 'screens/patient_dashboard_screen.dart';
import 'screens/pharmacy_dashboard_screen.dart';
import 'screens/login_screen.dart';
import 'package:provider/provider.dart';
import 'providers/auth_provider.dart';
import 'screens/welcome_screen.dart';
import 'screens/doctor_dashboard_screen.dart';
import 'providers/user_provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences prefs = await SharedPreferences.getInstance();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp(
    prefs: prefs,
  ));
}

class MyApp extends StatelessWidget {
  final FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  final SharedPreferences prefs;

  MyApp({super.key, required this.prefs});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
            create: (context) => Auth(prefs, firebaseFirestore)),
        ChangeNotifierProvider(create: (context) => UserProvider()),
        Provider<ChatsProvider>(
            create: (_) => ChatsProvider(firebaseFirestore: firebaseFirestore)),
        Provider<ChatProvider>(
            create: (_) => ChatProvider(
                prefs: prefs, firebaseFirestore: firebaseFirestore))
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
          '/pharmacyScreen': (context) => const PharmacyDashboard(),
        },
      ),
    );
  }
}
