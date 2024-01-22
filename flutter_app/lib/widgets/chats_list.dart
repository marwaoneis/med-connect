import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../constants/firestore_constants.dart';
import '../providers/auth_provider.dart';
import '../screens/chat_screen.dart';

class ChatsList extends StatelessWidget {
  final Stream<List<Map<String, dynamic>>> chatsStream;

  const ChatsList({super.key, required this.chatsStream});

  String getSenderName(Auth authProvider) {
    return authProvider.getFullName ?? "Unknown";
  }

  @override
  Widget build(BuildContext context) {
    Auth authProvider = Provider.of<Auth>(context, listen: false);
    String senderName = getSenderName(authProvider);

    return StreamBuilder<List<Map<String, dynamic>>>(
      stream: chatsStream,
      builder: (BuildContext context,
          AsyncSnapshot<List<Map<String, dynamic>>> chats) {
        if (chats.hasData) {
          print(chats);
          if (chats.data!.isNotEmpty) {
            return ListView.builder(
              itemCount: chats.data!.length,
              itemBuilder: (context, index) =>
                  buildItem(context, chats.data![index], senderName),
            );
          } else {
            return const Center(
              child: Text('No messages found...'),
            );
          }
        } else if (chats.hasError) {
          return const Center(
            child: Text('Error loading messages.'),
          );
        } else {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }

  Widget buildItem(
      BuildContext context, Map<String, dynamic> chat, String senderName) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ChatScreen(
              receiverId: chat[FirestoreConstants.id],
              receiverName: chat[FirestoreConstants.fullName],
              senderName: senderName,
            ),
          ),
        );
      },
      child: ListTile(
        leading: const CircleAvatar(
          backgroundImage: AssetImage('assets/profile_placeholder.png'),
        ),
        title: Text(chat[FirestoreConstants.fullName] ?? ''),
      ),
    );
  }
}
