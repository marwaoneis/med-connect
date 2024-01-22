import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../constants/firestore_constants.dart';
import '../models/chat_message_model.dart';

class ChatProvider {
  final SharedPreferences prefs;
  final FirebaseFirestore firebaseFirestore;

  ChatProvider({required this.prefs, required this.firebaseFirestore});

  Future<void> updateFirestoreData(
      String collectionPath, String docPath, Map<String, dynamic> dataUpdate) {
    return firebaseFirestore
        .collection(collectionPath)
        .doc(docPath)
        .update(dataUpdate);
  }

  Future<String> getUserName(String userId) async {
    DocumentSnapshot userDoc = await firebaseFirestore
        .collection(FirestoreConstants.pathUserCollection)
        .doc(userId)
        .get();

    if (userDoc.exists) {
      return userDoc.data()[FirestoreConstants.fullName] ?? "Unknown";
    } else {
      return "Unknown";
    }
  }

  void createChat(
      String senderId, String receiverName, String receiverId) async {
    Map<String, dynamic> receiverData = {
      FirestoreConstants.fullName: receiverName,
      FirestoreConstants.id: receiverId,
    };

    await firebaseFirestore
        .collection(FirestoreConstants.pathUserCollection)
        .doc(senderId)
        .collection(FirestoreConstants.pathChatsCollection)
        .doc(receiverId)
        .set(receiverData);
  }

  Stream<QuerySnapshot> getChatMessages(
      String sender, String receiver, int limit) {
    String chatId = getChatId(sender, receiver);
    return firebaseFirestore
        .collection(FirestoreConstants.pathMessageCollection)
        .doc(chatId)
        .collection(chatId)
        .orderBy(FirestoreConstants.timestamp, descending: true)
        .limit(limit)
        .snapshots();
  }

  void sendChatMessage(String content, int type, String sender, String receiver,
      String receiverName, String senderName) async {
    String chatId = getChatId(sender, receiver);

    // Check if chat session exists for the sender, create if not
    var senderChatSnapshot = await doesChatExist(sender, receiver);
    if (senderChatSnapshot == null || !senderChatSnapshot.exists) {
      createChat(sender, receiverName, receiver);
    }

    // Check if chat session exists for the receiver, create if not
    var receiverChatSnapshot = await doesChatExist(receiver, sender);
    if (receiverChatSnapshot == null || !receiverChatSnapshot.exists) {
      createChat(receiver, senderName, sender);
    }

    // Prepare the chat message
    ChatMessage chatMessage = ChatMessage(
        idFrom: sender,
        idTo: receiver,
        timestamp: DateTime.now().millisecondsSinceEpoch.toString(),
        content: content,
        type: type);

    // Save the message to Firestore
    DocumentReference messageRef = firebaseFirestore
        .collection(FirestoreConstants.pathMessageCollection)
        .doc(chatId)
        .collection(chatId)
        .doc(DateTime.now().millisecondsSinceEpoch.toString());

    FirebaseFirestore.instance.runTransaction((transaction) async {
      transaction.set(messageRef, chatMessage.toJson());
    });
  }

  Future<DocumentSnapshot<Map<String, dynamic>>?> doesChatExist(
      String sender, String receiver) async {
    try {
      DocumentSnapshot<Map<String, dynamic>> snapshot = await firebaseFirestore
          .collection(FirestoreConstants.pathUserCollection)
          .doc(sender)
          .collection(FirestoreConstants.pathChatsCollection)
          .doc(receiver)
          .get();

      return snapshot;
    } catch (e) {
      print("Error checking chat existence: $e");
      return null;
    }
  }

  String getChatId(String sender, String receiver) {
    List<String> uidList = [sender, receiver];
    uidList.sort();
    String docId = uidList.join('-');
    return docId;
  }
}

class MessageType {
  static const text = 0;
}
