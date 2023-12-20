import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flip/data/firebase/user_data_resourse/user_data.dart';
import 'package:flip/domain/models/comment_model/comment_model.dart';
import 'package:flip/domain/repositories/comment_repository/comment_repository.dart';

class CommentServises extends CommentRepository {
  final FirebaseFirestore instance = FirebaseFirestore.instance;
  @override
  Future<void> addComments(Comments comments, String postId) async {
    final docRef = instance.collection('PostCollection').doc(postId);

    final commentCollection = instance
        .collection('PostCollection')
        .doc(postId)
        .collection('Comments')
        .doc();
    final Map<String, dynamic> comment = {
      'commentId': commentCollection.id,
      'postId': comments.postId,
      'comment': comments.comment,
      'timeStamp': comments.timeStamp,
      'userId': comments.userId,
      'likes': comments.likes
    };
    await commentCollection.set(comment);
    await docRef.update({
      'comments': FieldValue.arrayUnion([commentCollection.id])
    });
  }

  @override
  Future<List<Comments>> fetchComments(String postId) async {
    final response = await instance
        .collection('PostCollection')
        .doc(postId)
        .collection('Comments')
        .get();
    final comment =
        response.docs.map((data) => Comments.fromJson(data.data())).toList();
    return comment;
  }

  @override
  Future<List<CommentWithUserProfile>> fetchUser(
      List<Comments> comments) async {
    List<CommentWithUserProfile> commentsDataWithUserData = [];

    for (Comments comment in comments) {
      final user = await UserService().fetchDataByUser(comment.userId);
      if (user != null) {
        commentsDataWithUserData.add(
          CommentWithUserProfile(
            comment: comment,
            user: user,
          ),
        );
      }
    }
    return commentsDataWithUserData;
  }

  @override
  Future<void> deleteComment(Comments comments) async {
    final docRef = instance.collection('PostCollection').doc(comments.postId);
    instance
        .collection('PostCollection')
        .doc(comments.postId)
        .collection('Comments')
        .doc(comments.commentId)
        .delete();
    await docRef.update({
      'comments': FieldValue.arrayRemove([comments.commentId])
    });
  }
}
