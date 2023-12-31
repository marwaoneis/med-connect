import 'package:flutter/material.dart';
import '../widgets/top_bar.dart';
import '../widgets/search_bar.dart';
import '../widgets/menu_grid.dart';
import '../widgets/appointment_card.dart';
import '../widgets/pharmacy_list.dart';

class PatientScreen extends StatelessWidget {
  const PatientScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const TopBar(),
      body: ListView(
        children: const [
          CustomSearchBar(),
          MenuGrid(),
          SizedBox(height: 10),
          AppointmentCard(),
          SizedBox(height: 10),
          PharmacyList(),
        ],
      ),
    );
  }
}
