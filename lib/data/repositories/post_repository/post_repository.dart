import 'package:flip/data/models/post_model/post_model.dart';

abstract class PostRepository {
  Future<void> createPost(PostModel post, String userId);
  Future<List<PostModel>> getAllPosts();
  Future<List<PostModel>> fetchPostDataByUser(String uid);
  Future<List<PostModel>> fetchThoughtByUser(String uid);
  Future<void> deletePost(String postId, String userId);
  Future<List<PostModel>> fetchAllImagePosts();
  Future<List<FetchPostWithUserProfile>> getPostsWithUserData();
}
