import 'package:flutter/material.dart';
import '../widgets/search_bar.dart';

class TopBarWithBackground extends StatelessWidget {
  final Widget leadingContent;
  final Widget titleContent;
  final Widget trailingContent;

  const TopBarWithBackground({
    super.key,
    required this.leadingContent,
    required this.titleContent,
    required this.trailingContent,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          height: 175,
          decoration: const BoxDecoration(
            color: Color(0xFF0D4C92),
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.elliptical(50, 30),
              bottomRight: Radius.elliptical(50, 20),
            ),
          ),
        ),
        Column(
          children: [
            const SizedBox(height: 50),
            SizedBox(
              height: 45,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Row(
                  children: [
                    leadingContent,
                    const SizedBox(width: 8),
                    titleContent,
                    const Spacer(),
                    trailingContent,
                  ],
                ),
              ),
            ),
            const SizedBox(height: 45),
            const CustomSearchBar(),
          ],
        ),
      ],
    );
  }
}
