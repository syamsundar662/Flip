import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flip/domain/models/post_model/post_model.dart';
import 'package:flip/domain/models/user_model/user_model.dart';

class Post {
  final FirebaseFirestore instance = FirebaseFirestore.instance;
  Future<void> createPost(PostModel post) async {
    final CollectionReference postData = instance.collection('PostCollection');
    final DocumentReference documentReference = postData.doc();
    final String postId = documentReference.id;
    final Map<String, dynamic> postCollectionData = {
      'username':post.username, 
      'postId': postId,
      'userId': post.userId,
      'textContent': post.textContent,
      'imageUrls': post.imageUrls,
      'timestamp': post.timestamp,
      'likes': post.likes,
      'comments': post.comments
    };
    documentReference.set(postCollectionData);
  }

  Future<List<PostModel>> getAllPosts() async {
    final CollectionReference postData = instance.collection('PostCollection');
    final fetchedData = await postData.get();

    return fetchedData.docs.map((data) {
      final post = data.data() as Map<String, dynamic>;
      return PostModel.fromJson(post);
    }).toList();
  }

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
 
  Future<UserRepositoryModel?> fetchDataByUser(String uid) async {
    final userData = await instance
        .collection('UserCollection')
        .where('userId', isEqualTo: uid)
        .get();
    if (userData.docs.isNotEmpty) {
      final response = userData.docs.first.data();
      return UserRepositoryModel.fromJson(response);
    }
    return null;
  }

  Future<void> deletePost(String postId)async{
    try{
    await instance.collection('PostCollection').doc(postId).delete();
    }catch(e){
      log(e.toString()); 
    }
  }

}
