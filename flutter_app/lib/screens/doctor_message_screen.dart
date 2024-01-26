import 'package:flutter/material.dart';
import 'package:flutter_app/providers/auth_provider.dart';
import 'package:flutter_app/providers/chat_provider.dart';
import 'package:flutter_app/providers/chats_provider.dart';
import 'package:flutter_app/screens/appointments_schedule.dart';
import 'package:flutter_app/screens/doctor_dashboard_screen.dart';
import 'package:flutter_app/screens/doctor_profile_logout.dart';
import 'package:provider/provider.dart';
import '../widgets/chats_list.dart';
import '../widgets/footer.dart';
import '../widgets/top_bar_with_background.dart';
import 'login_screen.dart';

class DoctorMessageScreen extends StatefulWidget {
  const DoctorMessageScreen({super.key});

  @override
  State<DoctorMessageScreen> createState() => _DoctorMessageScreen();
}

class _DoctorMessageScreen extends State<DoctorMessageScreen> {
  final ScrollController scrollController = ScrollController();

  late ChatsProvider chatsProvider;
  late ChatProvider chatProvider;
  late Auth authProvider;
  late String currentUserId;

  @override
  void initState() {
    super.initState();
    authProvider = context.read<Auth>();
    chatsProvider = context.read<ChatsProvider>();
    chatProvider = context.read<ChatProvider>();
    if (authProvider.getUserId?.isNotEmpty == true) {
      currentUserId = authProvider.getUserId!;
    } else {
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (context) => const LoginScreen()),
          (Route<dynamic> route) => false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          TopBarWithBackground(
            leadingContent: IconButton(
              icon: const Icon(Icons.arrow_back, color: Colors.white),
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => const DoctorScreen()),
                );
              },
            ),
            titleContent: const Text(
              'Messages',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            trailingContent: IconButton(
              icon: const Icon(Icons.filter_list, color: Colors.white),
              onPressed: () {},
            ),
          ),
          Expanded(
            child: ChatsList(
              chatsStream:
                  chatsProvider.getUserChats(currentUserId, chatProvider),
            ),
          ),
        ],
      ),
      bottomNavigationBar: Footer(
        onHomeTap: () {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const DoctorScreen()),
          );
        },
        onAppointmentTap: () {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (context) => const AppointmentScheduleScreen()),
          );
        },
        onChatTap: () {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (context) => const DoctorMessageScreen()),
          );
        },
        onProfileTap: () {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (context) => const DoctorProfileLogoutScreen()),
          );
        },
      ),
    );
  }
}
