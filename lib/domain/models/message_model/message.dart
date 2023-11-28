import 'package:cloud_firestore/cloud_firestore.dart';

enum MessageType { text, image }

class Message {
  final String content;
  final DateTime sentTime;
  final String senderId;
  final String toId;
  final String read;
  final MessageType type;
  final String? messageId;

  Message(
      {required this.content,
      required this.sentTime,
      required this.senderId,
      required this.toId,
      required this.read,
      required this.type,
      this.messageId});

  factory Message.fromJson(Map<String, dynamic> json) {
    return Message(
        messageId: json['messageId'] ?? '',
        content: json['content'] ?? '',
        sentTime: (json['sentTime'] as Timestamp).toDate(),
        senderId: json['senderId'] ?? '',
        toId: json['toId'] ?? '',
        read: json['read'] ?? '',
        type: json['type'] == MessageType.text.name
            ? MessageType.text
            : MessageType.image);
  }

  Map<String, dynamic> toJson() {
    return {
      'content': content,
      'sentTime': sentTime,
      'senderId': senderId,
      'toId': toId,
      'read': read,
      'type': type.name
    };
  }
}
