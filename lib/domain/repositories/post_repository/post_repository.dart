import 'package:flip/domain/models/comment_model/comment_model.dart';
import 'package:flip/domain/models/post_model/post_model.dart';

abstract class PostRepository {
  Future<void> createPost(PostModel post, String userId);
  Future<List<PostModel>> getAllPosts();
  Future<List<PostModel>> fetchPostDataByUser(String uid);
  Future<List<PostModel>> fetchThoughtByUser(String uid);
  Future<void> deletePost(String postId, String userId);
  Future<PostModel> toggleLike(
      {required PostModel post, required String userId});

  Future<void> addComments(Comments comments, String postId);
  Future<List<Comments>> fetchComments(String postId);
  Future<List<CommentWithUserProfile>> fetchUser(
    List<Comments> comments,
  );
}
