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

  void createChat(String senderId, String receiverName, String receiverId,
      {String? senderFullName}) async {
    senderFullName ??= await fetchFullName(senderId) ?? "Unknown User";

    await firebaseFirestore
        .collection(FirestoreConstants.pathUserCollection)
        .doc(senderId)
        .collection(FirestoreConstants.pathChatsCollection)
        .doc(receiverId)
        .set({
      FirestoreConstants.fullName: receiverName,
      FirestoreConstants.id: receiverId,
    });

    await firebaseFirestore
        .collection(FirestoreConstants.pathUserCollection)
        .doc(receiverId)
        .collection(FirestoreConstants.pathChatsCollection)
        .doc(senderId)
        .set({
      FirestoreConstants.fullName: senderFullName,
      FirestoreConstants.id: senderId,
    });
  }

  Future<String?> fetchFullName(String userId) async {
    try {
      DocumentSnapshot userDoc = await firebaseFirestore
          .collection(FirestoreConstants.pathUserCollection)
          .doc(userId)
          .get();

      if (userDoc.exists) {
        Map<String, dynamic> userData =
            userDoc.data() as Map<String, dynamic>? ?? {};

        String firstName = userData['firstName'] ?? '';
        String lastName = userData['lastName'] ?? '';

        // Return the full name if both firstName and lastName are available
        return (firstName.isNotEmpty && lastName.isNotEmpty)
            ? '$firstName $lastName'
            : null;
      }
      return null;
    } catch (e) {
      print("Error fetching user's full name: $e");
      return null;
    }
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

  Future<void> sendChatMessage(String content, int type, String senderId,
      String receiverId, String receiverName, String senderFullName) async {
    String chatId = getChatId(senderId, receiverId);

    // Check if chat session exists for the sender and create if not.
    var senderChatDocRef = firebaseFirestore
        .collection(FirestoreConstants.pathUserCollection)
        .doc(senderId)
        .collection(FirestoreConstants.pathChatsCollection)
        .doc(receiverId);
    var senderChatSnapshot = await senderChatDocRef.get();
    if (!senderChatSnapshot.exists) {
      await senderChatDocRef.set({
        FirestoreConstants.fullName: receiverName,
        FirestoreConstants.id: receiverId,
      });
    }

    // Check if chat session exists for the receiver and create if not.
    var receiverChatDocRef = firebaseFirestore
        .collection(FirestoreConstants.pathUserCollection)
        .doc(receiverId)
        .collection(FirestoreConstants.pathChatsCollection)
        .doc(senderId);
    var receiverChatSnapshot = await receiverChatDocRef.get();
    if (!receiverChatSnapshot.exists) {
      await receiverChatDocRef.set({
        FirestoreConstants.fullName: senderFullName,
        FirestoreConstants.id: senderId,
      });
    }

    // Prepare the chat message.
    ChatMessage chatMessage = ChatMessage(
      idFrom: senderId,
      idTo: receiverId,
      timestamp: DateTime.now().millisecondsSinceEpoch.toString(),
      content: content,
      type: type,
      senderFullName: senderFullName,
    );

    // Save the message to Firestore.
    DocumentReference messageRef = firebaseFirestore
        .collection(FirestoreConstants.pathMessageCollection)
        .doc(chatId)
        .collection(FirestoreConstants.pathChatsCollection)
        .doc(DateTime.now().millisecondsSinceEpoch.toString());

    await firebaseFirestore.runTransaction((transaction) async {
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
