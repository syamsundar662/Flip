import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flip/domain/models/user_model/user_model.dart';
import 'package:flip/domain/repositories/follow_repository/follow_repository.dart';

class FollowDataSources extends FollowRepository {
  final usersCollection =
      FirebaseFirestore.instance.collection('UserCollection');

  @override
  Future<void> unfollowUser(
      {required String uid, required String followId}) async {
    try {
      final snap = await usersCollection.doc(uid).get();
      List following = (snap.data()! as dynamic)['following'];
      if (following.contains(followId)) {
        await usersCollection.doc(followId).update({
          'followers': FieldValue.arrayRemove([uid])
        });
        await usersCollection.doc(uid).update({
          'following': FieldValue.arrayRemove([followId])
        });
      }
    } catch (e) {
      log(e.toString());
    }
  }

  @override
  Future<void> followUser(
      {required String uid, required String followId}) async {
    try {
      final snap = await usersCollection.doc(uid).get();
      List following = (snap.data()! as dynamic)['following'];

      if (!following.contains(followId)) {
        await usersCollection.doc(followId).update({
          'followers': FieldValue.arrayUnion([uid])
        });
        await usersCollection.doc(uid).update({
          'following': FieldValue.arrayUnion([followId])
        });
      }
    } catch (e) {
      log(e.toString());
    }
  }

  @override
  Future<void> removeFollower(
      {required String uid, required String followerId}) async {
    try {
      final snap = await usersCollection.doc(uid).get();
      List followers = (snap.data()! as dynamic)['followers'];

      if (followers.contains(followerId)) {
        await usersCollection.doc(followerId).update({
          'following': FieldValue.arrayRemove([uid])
        });
        await usersCollection.doc(uid).update({
          'followers': FieldValue.arrayRemove([followerId])
        });
      }
    } catch (e) {
      log(e.toString());
    }
  }

  @override
  Future<List<UserModel>> getFollowersList({required String uid}) async {
    final document = await usersCollection.doc(uid).get();
    List<dynamic>? followersData = (document.data()! as dynamic)['followers'];

    if (followersData == null) {
      return [];
    }

    List<Future<DocumentSnapshot>> followersSnapshots = followersData
        .map((userId) => usersCollection.doc(userId).get())
        .toList();

    List<DocumentSnapshot> followers = await Future.wait(followersSnapshots);

    List<UserModel> followerProfiles = followers
        .map((follower) =>
            UserModel.fromJson(follower.data() as Map<String, dynamic>))
        .toList();
    return followerProfiles;
  }

  @override
  Future<List<UserModel>> getFollowingList({required String uid}) async {
    final document = await usersCollection.doc(uid).get();
    List<dynamic>? followingUsersData =
        (document.data()! as dynamic)['following'];
    if (followingUsersData == null) {
      return [];
    }
    List<Future<DocumentSnapshot>> followingUsers = followingUsersData
        .map((userId) => usersCollection.doc(userId).get())
        .toList();
    List<DocumentSnapshot> following = await Future.wait(followingUsers);
    return following
        .map((user) => UserModel.fromJson(user.data() as Map<String, dynamic>))
        .toList();
  }
}
