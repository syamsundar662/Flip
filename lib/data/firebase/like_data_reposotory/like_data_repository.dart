import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flip/domain/models/post_model/post_model.dart';
import 'package:flip/domain/repositories/like_post_repository/like_post.dart';

class LikeDataService extends LikeRepository {
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

  
}
