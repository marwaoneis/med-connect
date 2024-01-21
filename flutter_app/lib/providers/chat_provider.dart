import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
    // createChat for receiving & sending user
    var senderChatSnapshot = await doesChatExist(sender, receiver);
    if (senderChatSnapshot != null && !senderChatSnapshot.exists) {
      createChat(sender, receiver, receiverName);
    }
    var receiverChatSnapshot = await doesChatExist(receiver, sender);
    if (receiverChatSnapshot != null && !receiverChatSnapshot.exists) {
      createChat(receiver, sender, senderName);
    }
    String chatId = getChatId(sender, receiver);
    DocumentReference documentReference = firebaseFirestore
        .collection(FirestoreConstants.pathMessageCollection)
        .doc(chatId)
        .collection(chatId)
        .doc(DateTime.now().millisecondsSinceEpoch.toString());
    ChatMessage chatMessages = ChatMessage(
        idFrom: sender,
        idTo: receiver,
        timestamp: DateTime.now().millisecondsSinceEpoch.toString(),
        content: content,
        type: type);
    FirebaseFirestore.instance.runTransaction((transaction) async {
      transaction.set(documentReference, chatMessages.toJson());
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
