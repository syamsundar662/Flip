import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flip/data/firebase_services/user_data_resourse/user_data.dart';
import 'package:flip/data/models/post_model/post_model.dart';
import 'package:flip/data/repositories/post_repository/post_repository.dart';

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
      'comments': post.comments,
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
  Future<List<PostModel>> fetchAllImagePosts() async {
    final postData = instance.collection('PostCollection');
    final fetchedData = await postData.get();
    final sortedData = fetchedData.docs.map((data) {
      final post = data.data();
      return PostModel.fromJson(post);
    }).toList();
    return sortedData.where((element) => element.imageUrls.isNotEmpty).toList();
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
  Future<List<FetchPostWithUserProfile>> getPostsWithUserData() async {
    final List<FetchPostWithUserProfile> fetchPostWithUserProfile = [];

    try {
      final postData = await instance.collection('PostCollection').get();
      final posts =
          postData.docs.map((doc) => PostModel.fromJson(doc.data())).toList();



      for (var post in posts) {
        final user = await UserService().fetchDataByUser(post.userId);
        fetchPostWithUserProfile
            .add(FetchPostWithUserProfile(postModel: posts, userModel: user!));
      }
    } catch (e) {
      log('Error fetching posts with user data: $e');
    }
    log(fetchPostWithUserProfile.length.toString());
    return fetchPostWithUserProfile;
  }
}
