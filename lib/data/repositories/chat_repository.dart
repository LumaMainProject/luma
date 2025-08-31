import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:luma_2/data/models/chat.dart';
import 'package:luma_2/data/models/message.dart';

class ChatRepository {
  final FirebaseFirestore firestore;
  ChatRepository({FirebaseFirestore? firestore})
    : firestore = firestore ?? FirebaseFirestore.instance;

  Stream<List<Chat>> streamUserChats(String userId) {
    return firestore
        .collection('chats')
        .where('participants', arrayContains: userId)
        .orderBy('lastUpdated', descending: true)
        .snapshots()
        .map(
          (snap) => snap.docs
              .map((doc) => Chat.fromJson(doc.data(), doc.id))
              .toList(),
        );
  }

  Stream<List<Message>> streamMessages(String chatId) {
    return firestore
        .collection('chats')
        .doc(chatId)
        .collection('messages')
        .orderBy('createdAt', descending: true)
        .snapshots()
        .map(
          (snap) => snap.docs
              .map((doc) => Message.fromJson(doc.data(), doc.id))
              .toList(),
        );
  }

  Future<void> sendMessage(String chatId, Message message) async {
    final ref = firestore
        .collection('chats')
        .doc(chatId)
        .collection('messages')
        .doc();
    await ref.set(message.toJson());
    await firestore.collection('chats').doc(chatId).update({
      'lastMessage': message.text,
      'lastUpdated': FieldValue.serverTimestamp(),
    });
  }
}
