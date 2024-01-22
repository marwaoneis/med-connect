import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/src/animation/animation_controller.dart';
import '../constants/firestore_constants.dart';

class ChatMessage {
  String idFrom;
  String idTo;
  String timestamp;
  String content;
  int type;
  String senderFullName;
  AnimationController? animationController;

  ChatMessage({
    required this.idFrom,
    required this.idTo,
    required this.timestamp,
    required this.content,
    required this.type,
    required this.senderFullName,
    this.animationController,
  });

  Map<String, dynamic> toJson() {
    return {
      FirestoreConstants.idFrom: idFrom,
      FirestoreConstants.idTo: idTo,
      FirestoreConstants.timestamp: timestamp,
      FirestoreConstants.content: content,
      FirestoreConstants.type: type,
      FirestoreConstants.fullName: senderFullName,
    };
  }

  factory ChatMessage.fromDocument(DocumentSnapshot documentSnapshot) {
    String idFrom = documentSnapshot.get(FirestoreConstants.idFrom);
    String idTo = documentSnapshot.get(FirestoreConstants.idTo);
    String timestamp = documentSnapshot.get(FirestoreConstants.timestamp);
    String content = documentSnapshot.get(FirestoreConstants.content);
    int type = documentSnapshot.get(FirestoreConstants.type);
    String senderFullName = documentSnapshot.get(FirestoreConstants.fullName);

    return ChatMessage(
        idFrom: idFrom,
        idTo: idTo,
        timestamp: timestamp,
        content: content,
        type: type,
        senderFullName: senderFullName);
  }
}
