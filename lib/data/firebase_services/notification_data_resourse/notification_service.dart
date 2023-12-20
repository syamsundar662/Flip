import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flip/data/firebase_services/user_data_resourse/user_data.dart';
import 'package:flip/data/models/notification_model/notification.dart';

class NotificationDataSource {
  final _collection =
      FirebaseFirestore.instance.collection('notificationCollection');

  Future<void> addNotifications({
    required String postId,
    required String toId,
    required String content,
    required String type,
  }) async {
    final senderId = FirebaseAuth.instance.currentUser!.uid;
    final ref = _collection.doc(toId).collection('notifications').doc();
    final NotificationModel notification = NotificationModel(
      notificationId: ref.id,
      toId: toId,
      senderId: senderId,
      time: DateTime.now(),
      content: content,
      type: type,
      postId: postId

    );
    await ref.set(notification.toJson());
  }

  Stream<List<NotificationWithUserProfile>> getUserNotifications() async*{
    final userId = FirebaseAuth.instance.currentUser!.uid;
    try {
      final querySnapshot = await _collection
          .doc(userId)
          .collection('notifications')
          .orderBy('time', descending: true)
          .get();
      final responseData =
          await Future.wait(querySnapshot.docs.map((doc) async {
        Map<String, dynamic> data = doc.data();
        final notificationData = NotificationModel.fromJson(data);
        final userProfile =
            await UserService().fetchDataByUser(notificationData.senderId);
        final notificationWithUser = NotificationWithUserProfile(
            notification: notificationData, userProfile: userProfile!);
        return notificationWithUser;
      }).toList());
      yield responseData;
    } catch (e) {
      log('Error fetching user notifications: $e');
      yield [];
    }
  }
}
