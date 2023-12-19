import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flip/data/firebase/user_data_resourse/user_data.dart';
import 'package:flip/domain/models/post_model/post_model.dart';
import 'package:flip/domain/models/user_model/user_model.dart';
import 'package:flip/domain/repositories/save_post_repository/save_post_repository.dart';

class SavePostDataService extends SavePostRepository {
  @override
  Future<void> savePost(String currentUid, String postId) async {
    final collection = FirebaseFirestore.instance.collection('UserCollection');
    collection.doc(currentUid).update({
      'saves': FieldValue.arrayUnion([postId])
    });
  }

  @override
  Future<void> unSavePost(String currentUid, postId) async {
    final collection = FirebaseFirestore.instance.collection('UserCollection');
    collection.doc(currentUid).update({
      'saves': FieldValue.arrayRemove([postId])
    });
  }

  @override
  Future<UserModel> toggleSavedPost({required String postId}) async {
    final user = await UserService()
        .fetchDataByUser(FirebaseAuth.instance.currentUser!.uid);

    if (user!.saves.contains(postId)) {
      user.saves.remove(postId);
    } else {
      user.saves.add(postId);
    }
    await FirebaseFirestore.instance
        .collection('UserCollection')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .update({'saves': user.saves});
    return user;
  }

  @override
  Future<List<PostModel>> fetchSavedPosts(String uId) async {
    try {
      final userCollection =
          FirebaseFirestore.instance.collection('UserCollection').doc(uId);
      final response = await userCollection.get();
      final savedPostIds = response.data()!['saves'];
      final postCollection =
          FirebaseFirestore.instance.collection('PostCollection');
      final postDatas =
          await postCollection.where('postId', whereIn: savedPostIds).get();
      final sortedSavesPostList =
          postDatas.docs.map((e) => PostModel.fromJson(e.data())).toList();
      return sortedSavesPostList;
    } catch (e) {
      log(e.toString());
      return [];
    }
  }
}
