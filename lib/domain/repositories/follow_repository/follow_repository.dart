

import 'package:flip/domain/models/user_model/user_model.dart';

abstract class FollowRepository {
  Future<void> followUser({required String uid, required String followId});
  Future<List<UserModel>> getFollowersList({required String uid});
  Future<List<UserModel>> getFollowingList({required String uid});
  Future<void> unfollowUser({required String uid, required String followId});
  Future<void> removeFollower(
      {required String uid, required String followerId});
}