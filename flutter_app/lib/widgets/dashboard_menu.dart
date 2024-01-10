import 'package:flutter/material.dart';

class DashboardMenu extends StatelessWidget {
  DashboardMenu({super.key});

  final List<GridItem> gridItems = [
    GridItem(
      title: 'Book Appointment',
      imagePath: 'assets/book_appointment.png',
      onTap: () {
        // Navigate to the Book Appointment page
      },
    ),
    GridItem(
      title: 'Choose Pharmacy',
      imagePath: 'assets/choose_pharmacy.png',
      onTap: () {
        // Navigate to the Choose Pharmacy page
      },
    ),
    GridItem(
      title: 'Symptom Checker',
      imagePath: 'assets/symptom_checker.png',
      onTap: () {
        // Navigate to the Symptom Checker page
      },
    ),
    GridItem(
      title: 'Medicines',
      imagePath: 'assets/medicines.png',
      onTap: () {
        // Navigate to the Symptom Checker page
      },
    ),
    GridItem(
      title: 'Setup Redminders',
      imagePath: 'assets/setup_reminders.png',
      onTap: () {
        // Navigate to the Symptom Checker page
      },
    ),
    GridItem(
      title: 'Consultations',
      imagePath: 'assets/consultations.png',
      onTap: () {
        // Navigate to the Symptom Checker page
      },
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      padding: const EdgeInsets.all(12),
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        crossAxisSpacing: 1,
        mainAxisSpacing: 1,
        childAspectRatio: (50 / 43),
      ),
      itemCount: gridItems.length,
      itemBuilder: (context, index) {
        return _buildGridItem(context, gridItems[index]);
      },
    );
  }

  Widget _buildGridItem(BuildContext context, GridItem item) {
    return Card(
      elevation: 2,
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: item.onTap,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Image.asset(
              item.imagePath,
              fit: BoxFit.contain,
            ),
            Container(
              height: 30.0,
              color: Colors.white,
              padding: const EdgeInsets.all(2.0),
              child: Center(
                child: Text(
                  item.title,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 12.0,
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class GridItem {
  final String title;
  final String imagePath;
  final VoidCallback onTap;

  GridItem({
    required this.title,
    required this.imagePath,
    required this.onTap,
  });
}
