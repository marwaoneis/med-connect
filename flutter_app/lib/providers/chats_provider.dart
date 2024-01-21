import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_app/providers/chat_provider.dart';
import '../constants/firestore_constants.dart';

class ChatsProvider {
  final FirebaseFirestore firebaseFirestore;

  ChatsProvider({required this.firebaseFirestore});

  Future<void> updateFirestoreData(
      String collectionPath, String path, Map<String, dynamic> updateData) {
    return firebaseFirestore
        .collection(collectionPath)
        .doc(path)
        .update(updateData);
  }

  Stream<QuerySnapshot> getFirestoreData(
      String collectionPath, int limit, String? textSearch) {
    if (textSearch?.isNotEmpty == true) {
      return firebaseFirestore
          .collection(collectionPath)
          .limit(limit)
          .where(FirestoreConstants.firstName, isEqualTo: textSearch)
          .snapshots();
    } else {
      return firebaseFirestore
          .collection(collectionPath)
          .limit(limit)
          .snapshots();
    }
  }

  Stream<List<Map<String, dynamic>>> getUserChats(
      String userId, ChatProvider chatProvider) {
    return firebaseFirestore
        .collection(FirestoreConstants.pathUserCollection)
        .doc(userId)
        .collection(FirestoreConstants.pathChatsCollection)
        .snapshots()
        .map((QuerySnapshot userChatsSnapshot) {
      return userChatsSnapshot.docs
          .map((doc) => doc.data() as Map<String, dynamic>)
          .toList();
    });
  }
}
