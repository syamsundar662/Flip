import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flip/data/firebase/user_data_resourse/user_data.dart';
import 'package:flip/domain/models/story_model/story_model.dart';
import 'package:photo_manager/photo_manager.dart';

class StoryDataSource {
  final _storyCollection = FirebaseFirestore.instance.collection('story');

  Future<void> addStory({required StoryModel story}) async {
    final storyDoc = _storyCollection.doc();
    await storyDoc.set({...story.toJson(), 'storyId': storyDoc.id});
  }

  Future<StoryWithUser?> fetchCurrentUserStories() async {
    final userId = FirebaseAuth.instance.currentUser!.uid;
    final stories =
        await _storyCollection.where('userId', isEqualTo: userId).get();

    if (stories.docs.isNotEmpty) {
      final storiesData = stories.docs
          .map((story) => StoryModel.fromJson(story.data()))
          .toList();

      final filteredStoriesData = storiesData
          .where((story) => DateTime.now().difference(story.time).inHours <= 24)
          .toList();

      if (filteredStoriesData.isNotEmpty) {
        final userData = await UserService().fetchDataByUser(userId);
        return StoryWithUser(stories: filteredStoriesData, user: userData!);
      }
    }
    return null;
  }

  Future<void> deleteStroy({required String stroyId}) async {
    await _storyCollection.doc(stroyId).delete();
  }

  Future<List<File?>> fetchRecentImages() async {
    final result = await PhotoManager.getAssetPathList(
      type: RequestType.image,
      hasAll: true,
    );

    if (result.isNotEmpty) {
      final recentImages = await result[0].getAssetListRange(start: 0, end: 30);
      final images = recentImages.map((asset) async {
        final imageData = await asset.file;
        if (imageData != null) {
          return imageData;
        } else {
          return null;
        }
      }).toList();
      final response = await Future.wait(images);
      return response;
    }
    return [];
  }

  Future<List<StoryWithUser>> fetchFollowingStories(
      {required String userId}) async {
    List<StoryWithUser> storiesWithUser = [];

    final userDoc = (await FirebaseFirestore.instance
            .collection('users')
            .where('uid', isEqualTo: userId)
            .get())
        .docs
        .first;
    List followings = userDoc['following'];

    for (var user in followings) {
      final userData = await UserService().fetchDataByUser(userId);
      final stories =
          await _storyCollection.where('userId', isEqualTo: user).get();

      if (stories.docs.isNotEmpty) {
        final storiesData = stories.docs
            .map((story) => StoryModel.fromJson(story.data()))
            .toList();

        final filteredStoriesData = storiesData
            .where(
                (story) => DateTime.now().difference(story.time).inHours <= 24)
            .toList();

        if (filteredStoriesData.isNotEmpty) {
          storiesWithUser.add(
              StoryWithUser(stories: filteredStoriesData, user: userData!));
        }
      }
    }

    return storiesWithUser;
  }

  Future<List<StoryWithUser>> fetchStories() async {
    StoryWithUser? currentUserStories = await fetchCurrentUserStories();
    List<StoryWithUser> followingStories = await fetchFollowingStories(
      userId: FirebaseAuth.instance.currentUser!.uid,
    );
    List<StoryWithUser> allStories = [];
    if (currentUserStories != null && currentUserStories.stories.isNotEmpty) {
      allStories.add(currentUserStories);
    } else {
      final userProfile = await UserService()
          .fetchDataByUser(FirebaseAuth.instance.currentUser!.uid);
      allStories.add(StoryWithUser(stories: [], user: userProfile!));
    }
    allStories.addAll(followingStories);
    return allStories;
  }
}
