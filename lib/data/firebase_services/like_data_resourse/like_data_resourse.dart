import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flip/data/firebase_services/notification_data_resourse/notification_service.dart';
import 'package:flip/data/firebase_services/user_data_resourse/user_data.dart';
import 'package:flip/data/models/post_model/post_model.dart';
import 'package:flip/data/repositories/like_post_repository/like_post.dart';

class LikeDataService extends LikeRepository {
  @override
  Future<PostModel> toggleLike(
      {required PostModel post, required String userId}) async {
    if (post.likes.contains(userId)) { 
      post.likes.remove(userId);
    } else {
      post.likes.add(userId);
      if (post.userId != FirebaseAuth.instance.currentUser!.uid) {
        final user = await UserService()
            .fetchDataByUser(FirebaseAuth.instance.currentUser!.uid);
        NotificationDataSource().addNotifications(
          toId: post.userId,
          content: "${user!.username} liked your post",
          type: post.imageUrls[0],
          postId: post.postId
        );
      }
    }
    await FirebaseFirestore.instance 
        .collection('PostCollection')
        .doc(post.postId)
        .update({'likes': post.likes});
    return post;
  }
}
