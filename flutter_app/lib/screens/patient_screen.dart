import 'package:flutter/material.dart';
import '../widgets/top_bar.dart';
import '../widgets/search_bar.dart';

class PatientScreen extends StatelessWidget {
  const PatientScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const TopBar(),
      body: ListView(
        children: [
          const CustomSearchBar(),
        ],
      ),
    );
  }
}
