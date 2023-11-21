import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flip/data/firebase/user_data_resourse/user_data.dart';
import 'package:flip/domain/models/comment_model/comment_model.dart';
import 'package:flip/domain/models/post_model/post_model.dart';
import 'package:flip/domain/repositories/post_repository/post_repository.dart';

class PostServices extends PostRepository {
  final FirebaseFirestore instance = FirebaseFirestore.instance;

  @override
  Future<void> createPost(PostModel post, String userId) async {
    final CollectionReference postData = instance.collection('PostCollection');

    final DocumentReference documentReference = postData.doc();

    final String postId = documentReference.id;

    final Map<String, dynamic> postCollectionData = {
      'username': post.username,
      'postId': postId,
      'userId': post.userId,
      'textContent': post.textContent,
      'imageUrls': post.imageUrls,
      'timestamp': post.timestamp,
      'likes': post.likes,
      'comments': post.comments
    };

    await documentReference.set(postCollectionData);

    await FirebaseFirestore.instance
        .collection('UserCollection')
        .doc(userId)
        .update({
      'posts': FieldValue.arrayUnion([postId])
    });
  }

  @override
  Future<List<PostModel>> getAllPosts() async {
    final CollectionReference postData = instance.collection('PostCollection');
    final fetchedData = await postData.get();

    return fetchedData.docs.map((data) {
      final post = data.data() as Map<String, dynamic>;
      return PostModel.fromJson(post);
    }).toList();
  }

  @override
  Future<List<PostModel>> fetchPostDataByUser(String uid) async {
    try {
      final postData =
          instance.collection('PostCollection').where('userId', isEqualTo: uid);
      final fetchedData = await postData.get();

      final sortedData = fetchedData.docs.map((data) {
        final post = data.data();
        return PostModel.fromJson(post);
      }).toList();
      return sortedData.where((post) => post.imageUrls.isNotEmpty).toList();
    } catch (e) {
      return [];
    }
  }

  @override
  Future<List<PostModel>> fetchThoughtByUser(String uid) async {
    final thoughtData =
        instance.collection('PostCollection').where('userId', isEqualTo: uid);
    final fetchedData = await thoughtData.get();
    final sortedData = fetchedData.docs.map((e) {
      final thought = e.data();
      return PostModel.fromJson(thought);
    }).toList();
    return sortedData.where((element) => element.imageUrls.isEmpty).toList();
  }

  @override
  Future<void> deletePost(String postId, String userId) async {
    try {
      await instance.collection('PostCollection').doc(postId).delete();
      await instance.collection('UserCollection').doc(userId).update({
        'posts': FieldValue.arrayRemove([postId])
      });
    } catch (e) {
      log(e.toString());
    }
  }

  @override
  Future<PostModel> toggleLike(
      {required PostModel post, required String userId}) async {
    if (post.likes.contains(userId)) {
      post.likes.remove(userId);
    } else {
      post.likes.add(userId);
    }
    await FirebaseFirestore.instance
        .collection('PostCollection')
        .doc(post.postId)
        .update({'likes': post.likes});
    return post;
  }

  @override
  Future<void> addComments(Comments comments, String postId) async {
    // final postId = _firestore.collection('PostCollection').doc().id;
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
}
