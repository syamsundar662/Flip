import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flip/data/models/user_model/user_model.dart';

class StoryModel {
  final String? stroyId;
  final String userId;
  final String imageUrl;
  final DateTime time;

  StoryModel(
      {this.stroyId,
      required this.userId,
      required this.imageUrl,
      required this.time});

  factory StoryModel.fromJson(Map<String, dynamic> json) {
    return StoryModel(
        stroyId: json['storyId'] ?? '',
        userId: json['userId'] ?? '',
        imageUrl: json['imageUrl'] ?? '',
        time: (json['time'] as Timestamp).toDate());
  }
  Map<String, dynamic> toJson() {
    return {
     'userId': userId,
     'imageUrl': imageUrl,
     'time': time};
  }
}

class StoryWithUser{
  final List<StoryModel> stories;
  final UserModel user;

  StoryWithUser({required this.stories, required this.user});
}
