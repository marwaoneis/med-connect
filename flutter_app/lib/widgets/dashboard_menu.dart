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
      padding: const EdgeInsets.all(8),
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        crossAxisSpacing: 8,
        mainAxisSpacing: 8,
      ),
      itemCount: gridItems.length,
      itemBuilder: (context, index) {
        return _buildGridItem(context, gridItems[index]);
      },
    );
  }

  Widget _buildGridItem(BuildContext context, GridItem item) {
    return Card(
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: item.onTap,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment
              .stretch, // Ensure the widgets fill the card width
          children: <Widget>[
            Expanded(
              // Use Expanded to give the image a flexible height, but not the text
              child: Container(
                // Define a max height for the image container if needed
                constraints: const BoxConstraints(
                  minHeight: 120, // Maximum height for the image
                ),
                child: Image.asset(
                  item.imagePath,
                  fit: BoxFit
                      .contain, // The image should be contained within the bounds of the Container
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(
                  8, 8, 8, 8), // Add padding around the text
              child: Text(
                item.title,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.titleMedium,
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
