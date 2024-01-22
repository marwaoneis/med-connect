import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/providers/auth_provider.dart';
import 'package:provider/provider.dart';

import '../constants/firestore_constants.dart';
import '../providers/chat_provider.dart';

class ChatScreen extends StatefulWidget {
  final String receiverId;
  final String receiverName;
  final String senderName;

  const ChatScreen({
    super.key,
    required this.receiverId,
    required this.receiverName,
    required this.senderName,
  });

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

    senderId = authProvider.getUserId ?? "";
    senderName = authProvider.getFullName ?? "You";

    receiverName = widget.receiverName;

    chatProvider
        .getChatMessages(senderId, widget.receiverId, 10)
        .listen((QuerySnapshot snapshot) {
      List<Message> newMessages = snapshot.docs.map((doc) {
        Map<String, dynamic> messageData = doc.data() as Map<String, dynamic>;
        bool isCurrentUserSender =
            messageData[FirestoreConstants.idFrom] == senderId;
        String displayName =
            isCurrentUserSender ? senderName : widget.receiverName;

        return Message(
          senderName: displayName,
          text: messageData[FirestoreConstants.content] ??
              'Message not available',
          animationController: AnimationController(
            duration: const Duration(milliseconds: 700),
            vsync: this,
          ),
        );
      }).toList();

      setState(() {
        _messages = newMessages;
      });
    });
  }

  void _handleSubmitted(String text) {
    if (text.trim().isNotEmpty) {
      _textController.clear();
      Message message = Message(
        senderName: widget.senderName,
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

      _scrollController.animateTo(
        0.0,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );

      chatProvider.sendChatMessage(text, 0, senderId, widget.receiverId,
          widget.receiverName, widget.senderName);
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
  final String senderName;
  final String text;
  final AnimationController animationController;

  Message(
      {required this.senderName,
      required this.text,
      required this.animationController,
      super.key}) {
    animationController.forward();
  }

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
              child: CircleAvatar(child: Text(senderName[0])),
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(senderName,
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
