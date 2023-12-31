import 'package:flutter/material.dart';
import '../widgets/top_bar.dart';

class PatientScreen extends StatelessWidget {
  const PatientScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: TopBar(),
    );
  }
}
