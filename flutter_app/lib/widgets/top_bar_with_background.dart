import 'package:flutter/material.dart';
import '../widgets/search_bar.dart';
import 'package:flutter_svg/flutter_svg.dart';

class TopBarWithBackground extends StatelessWidget {
  final String firstName;
  final String address;

  const TopBarWithBackground({
    super.key,
    required this.firstName,
    required this.address,
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
            Container(
              color: Colors.white.withOpacity(0.9),
              height: 45,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Row(
                  children: [
                    CircleAvatar(
                      // backgroundImage: const NetworkImage(
                      //     'http://10.0.2.2:3001/path_to_avatar'),
                      backgroundColor: Colors.grey[200],
                      child: Text(firstName[0]),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      '$firstName, $address',
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    const Spacer(),
                    IconButton(
                      icon: SvgPicture.asset('assets/notification_icon.svg'),
                      onPressed: () {
                        // Your existing code
                      },
                    ),
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
