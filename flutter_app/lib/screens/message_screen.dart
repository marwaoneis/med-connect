import 'package:flutter/material.dart';
import 'package:flutter_app/screens/login_screen.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../widgets/search_bar.dart';
import '../widgets/message_list.dart';

class MessageScreen extends StatelessWidget {
  const MessageScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          _buildTopBarWithBackground(context),
          const Expanded(
            child: MessageList(),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.message),
            label: 'Messages',
          ),
          // Add more items if needed
        ],
      ),
    );
  }

  Widget _buildTopBarWithBackground(BuildContext context) {
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
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('Message',
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.black)),
                    IconButton(
                      icon: SvgPicture.asset(
                        'assets/back_arrow.svg',
                      ),
                      onPressed: () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const LoginScreen()),
                        );
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
