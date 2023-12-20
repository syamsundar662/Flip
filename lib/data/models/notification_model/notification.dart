import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flip/data/models/user_model/user_model.dart';

class NotificationModel {
  String? notificationId;
  String toId;
  String senderId;
  String content;
  DateTime time;
  String? type;
  String ?postId;
  NotificationModel(
      {this.notificationId,
      this.type,
      this.postId,
      required this.toId,
      required this.senderId,
      required this.time,
      required this.content});
  factory NotificationModel.fromJson(Map<String, dynamic> json) {
    return NotificationModel(
        notificationId: json['notificationId'] ?? '',
        toId: json['toId'],
        content: json['status'],
        senderId: json['senderId'],
        time: (json['time'] as Timestamp).toDate(),
        postId: json['postId']??'',
        type: json['type'] ?? '');
  }
  Map<String, dynamic> toJson() {
    return {
      'toId': toId,
      'status': content,
      'senderId': senderId,
      'time': time,
      'type': type,
      'postId':postId
    };
  }
}

class NotificationWithUserProfile {
  final NotificationModel notification;
  final UserModel userProfile;
  NotificationWithUserProfile(
      {required this.notification, required this.userProfile});
}