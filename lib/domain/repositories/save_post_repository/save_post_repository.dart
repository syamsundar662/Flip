import 'package:flip/domain/models/post_model/post_model.dart';
import 'package:flip/domain/models/user_model/user_model.dart';

abstract class SavePostRepository {
  Future<void> savePost(String currentUid, String postId);
  Future<List<PostModel>> fetchSavedPosts(String uId);
  Future<void> unSavePost(String currentUid, postId);
  Future<UserModel> toggleSavedPost({required String postId});
}
