import 'package:cloud_firestore/cloud_firestore.dart';

class PostModel {
  String postId;
  String userId;
  String textContent;
  List<String> imageUrls;
  DateTime timestamp;
  List likes;
  List comments;

  PostModel({
    this.postId = '',
    required this.userId,
    required this.textContent,
    required this.imageUrls,
    required this.timestamp,
    required this.likes,
    required this.comments,
  });
  factory PostModel.fromJson(Map<String, dynamic> json) {
    return PostModel(
        userId: json['userId'],
        textContent: json['textContent']??'',
        imageUrls: List.from( json['imageUrls']),
        timestamp:( json['timestamp'] as Timestamp).toDate(),
        likes: json['likes']??[],
        comments: json['comments']??[]);
  }
}
