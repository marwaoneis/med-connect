import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/providers/auth_provider.dart';
import 'package:flutter_app/screens/login_screen.dart';
import 'package:provider/provider.dart';

import '../providers/chat_provider.dart';

class ChatScreen extends StatefulWidget {
  final String receiverId;
  final String receiverName;

  const ChatScreen(
      {super.key, required this.receiverId, required this.receiverName});

  @override
  State createState() => ChatScreenState();
}

class ChatScreenState extends State<ChatScreen> with TickerProviderStateMixin {
  late String senderId;
  late String senderName;
  late String receiverName;
  late ChatProvider chatProvider;
  late Auth authProvider;
  late List<Message> _messages = [];
  final TextEditingController _textController = TextEditingController();
  late ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    authProvider = context.read<Auth>();
    chatProvider = context.read<ChatProvider>();
    _scrollController = ScrollController();

    if (authProvider.getUserId?.isNotEmpty == true) {
      senderId = authProvider.getUserId!;
      senderName =
          authProvider.getUserId!; // This should be replaced with userName
    } else {
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (context) => const LoginScreen()),
          (Route<dynamic> route) => false);
    }

    chatProvider
        .getChatMessages(senderId, widget.receiverId, 10)
        .listen((QuerySnapshot snapshot) {
      List<Message> newMessages = [];

      for (QueryDocumentSnapshot doc in snapshot.docs) {
        // Assuming you have a method to convert a document to a Message
        var messageContent = doc.data() as Map<String, dynamic>;
        Message message = Message(
            text: messageContent['content']!,
            animationController: AnimationController(
              duration: const Duration(milliseconds: 700),
              vsync: this,
            ));
        newMessages.add(message);
      }

      setState(() {
        _messages = newMessages;
      });
    });
  }

  void _handleSubmitted(String text) {
    if (text.trim().isNotEmpty) {
      _textController.clear();
      Message message = Message(
        text: text,
        animationController: AnimationController(
          duration: const Duration(milliseconds: 700),
          vsync: this,
        ),
      );
      setState(() {
        _messages.insert(0, message);
      });
      message.animationController.forward();

      // Scroll to the newly added message
      _scrollController.animateTo(
        0.0,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );

      chatProvider.sendChatMessage(text, 0, senderId, widget.receiverId,
          widget.receiverName, senderName);
    } else {
      // TODO: IMPLEMENT WHAT TO DO IN CASE MESSAGE WAS EMPTY
    }
  }

  Widget _buildTextComposer() {
    return IconTheme(
      data: IconThemeData(color: Theme.of(context).colorScheme.secondary),
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Row(
          children: <Widget>[
            Flexible(
              child: TextField(
                controller: _textController,
                onSubmitted: _handleSubmitted,
                decoration:
                    const InputDecoration.collapsed(hintText: "Type a message"),
              ),
            ),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 4.0),
              child: IconButton(
                  icon: const Icon(Icons.send),
                  onPressed: () => _handleSubmitted(_textController.text)),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.receiverName)),
      body: Column(
        children: <Widget>[
          Flexible(
            child: ListView(
              controller: _scrollController,
              padding: const EdgeInsets.all(8.0),
              reverse: true,
              children: _messages,
            ),
          ),
          const Divider(height: 1.0),
          Container(
            decoration: BoxDecoration(color: Theme.of(context).cardColor),
            child: _buildTextComposer(),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    for (var message in _messages) {
      message.animationController.dispose();
    }
    super.dispose();
  }
}

class Message extends StatelessWidget {
  Message({required this.text, required this.animationController, super.key}) {
    animationController.forward();
  }

  final String text;
  final AnimationController animationController;

  @override
  Widget build(BuildContext context) {
    return SizeTransition(
      sizeFactor:
          CurvedAnimation(parent: animationController, curve: Curves.easeOut),
      axisAlignment: 0.0,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 10.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              margin: const EdgeInsets.only(right: 16.0),
              child: const CircleAvatar(child: Text('Your Initials')),
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text('Your Name',
                      style: Theme.of(context).textTheme.titleMedium),
                  Container(
                    margin: const EdgeInsets.only(top: 5.0),
                    child: Text(text),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
