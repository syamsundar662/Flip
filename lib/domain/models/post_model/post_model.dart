import 'package:cloud_firestore/cloud_firestore.dart';

class PostModel {
  String postId;
  String userId;
  String username;
  String textContent;
  List<String> imageUrls;
  DateTime timestamp;
  List likes;
  List comments;

  PostModel({
    this.postId = '',
    required this.userId,
    required this.username,
    required this.textContent,
    required this.imageUrls,
    required this.timestamp,
    required this.likes,
    required this.comments,
  });
  factory PostModel.fromJson(Map<String, dynamic> json) {
    return PostModel(
        userId: json['userId'],
        postId: json['postId'] ?? '',
        username: json['username'] ?? '',
        textContent: json['textContent'] ?? '',
        imageUrls: List.from(json['imageUrls'] ?? ''),
        timestamp: (json['timestamp'] as Timestamp).toDate(),
        likes: json['likes'] ?? [],
        comments: json['comments'] ?? []);
  }
  Map<String, dynamic> toJson() {
    return {
      'postId': postId,
      'userId': userId,
      'username': username,
      'textContent': textContent,
      'imageUrls': imageUrls,
      'timestamp': timestamp,
      'likes': likes,
      'comments': comments,
    };
  }
}
