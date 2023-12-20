import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flip/data/models/user_model/user_model.dart';

class Comments {
  final String? commentId;
  final String comment;
  final DateTime timeStamp;
  final List<String> likes;
  final String userId;
  final String postId;

  Comments(
      {required this.commentId,
      required this.postId,
      required this.comment,
      required this.timeStamp,
      required this.likes,
      required this.userId});

  Map<String, dynamic> toJson() {
    return {
      'commentId': commentId,
      'comment': comment,
      'timeStamp': timeStamp,
      'likes': likes,
      'userId': userId,
      'postId': postId,
    };
  }

  factory Comments.fromJson(Map<String, dynamic> json) {
    return Comments(
      commentId: json['commentId'] ?? '',
      postId: json['postId'] ?? '', 
      comment: json['comment'] ?? '',
       timeStamp: (json['timeStamp'] as Timestamp).toDate(),
      likes: List<String>.from(json['likes'] ?? []),
      userId: json['userId'] ?? '',
    );
  }
}
class CommentWithUserProfile {
  final Comments comment;
  final UserModel user;
  CommentWithUserProfile({required this.comment, required this.user});
}

