import 'package:flip/domain/models/user_model/user_model.dart';

class ChatUser {
  final List<String> participants;
  final String chatId;

  ChatUser({required this.participants, required this.chatId});

  factory ChatUser.fromJson(Map<String, dynamic> json) {
    return ChatUser(
        participants: List<String>.from(json['participants']),
        chatId: json['chatId']);
  }
}

class ChatUserWithProfile {
  final ChatUser chatUser;
  final UserModel userProfile;

  ChatUserWithProfile({required this.chatUser, required this.userProfile});
}
