import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flip/data/firebase_services/user_data_resourse/user_data.dart';
import 'package:flip/data/models/chat_user_model/chat_user.dart';
import 'package:flip/data/models/message_model/message.dart';

class MessageService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  Future<void> sentMessage(
      {required String toId,
      required MessageType type,
      required String content}) async {
    try {
      final message = Message(
          content: content,
          sentTime: DateTime.now(),
          senderId: FirebaseAuth.instance.currentUser!.uid,
          toId: toId,
          read: '',
          type: type);
      final chatId = getChatId(toId: toId);
      await _firestore.collection('MessageCollection').doc(chatId).set({
        'participants': [toId, FirebaseAuth.instance.currentUser!.uid],
        'chatId': chatId
      });
      final messageCollection = _firestore
          .collection('MessageCollection')
          .doc(chatId)
          .collection('Messages')
          .doc();
      await messageCollection
          .set({...message.toJson(), 'messageId': messageCollection.id});
    } catch (e) {
      log(e.toString());
    }
  }

  static String getChatId({required String toId}) {
    List<String> chatId = [toId, FirebaseAuth.instance.currentUser!.uid];
    chatId = chatId.join().split('').toList()..sort();
    return chatId.join();
  }

  Stream<List<ChatUser>> getChatUsers() {
    final userId = FirebaseAuth.instance.currentUser!.uid;
    return _firestore
        .collection('MessageCollection')
        .where('participants', arrayContainsAny: [userId])
        .snapshots()
        .map((snapshot) => snapshot.docs
            .map((document) => ChatUser.fromJson(document.data()))
            .toList());
  }

  Stream<List<ChatUserWithProfile>> getChatWithProfile() async* {
    await for (List<ChatUser> chatUsers in getChatUsers()) {
      List<ChatUserWithProfile> chatUsersWithProfile = [];
      for (var user in chatUsers) {
        final currentUid = FirebaseAuth.instance.currentUser!.uid;
        final toId = user.participants[0] == currentUid
            ? user.participants[1]
            : user.participants[0];
        final userProfile = await UserService().fetchDataByUser(toId);
        chatUsersWithProfile.add(
            ChatUserWithProfile(chatUser: user, userProfile: userProfile!));
      }
      yield chatUsersWithProfile;
    }
  }

  Stream<List<Message>> getMessage(String toId) {
    final chatId = getChatId(toId: toId);
    return _firestore
        .collection('MessageCollection/$chatId/Messages')
        .orderBy('sentTime', descending: false)
        .snapshots()
        .map((event) {
      List<Message> messages = [];
      for (var doc in event.docs) {
        final message = Message.fromJson(doc.data());
        if (message.senderId != FirebaseAuth.instance.currentUser!.uid) {
          if (message.read.isEmpty) {
            doc.reference.update({'read': DateTime.now().toIso8601String()});
          }
        }
        messages.add(message);
      }
      return messages;
    });
  }

  Stream<Message?> getLastMessage(String toId) {
    final chatId = getChatId(toId: toId);
    return _firestore
        .collection('MessageCollection/$chatId/Messages')
        .orderBy('sentTime', descending: true)
        .limit(1)
        .snapshots()
        .map((event) {
      if (event.docs.isEmpty) {
        return null;
      } else {
        return Message.fromJson(event.docs.first.data());
      }
    });
  }
   Future deleteMessage(
      {required String messageId, required String toId}) async { 
    final chatId = getChatId(toId: toId);
    try {
      await _firestore
          .collection('MessageCollection')
          .doc(chatId)
          .collection('Messages')
          .doc(messageId)
          .delete();
    } catch (e) {
      log(e.toString());
      return false;
    }
  }
}
