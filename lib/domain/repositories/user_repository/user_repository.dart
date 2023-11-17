import 'package:flip/domain/models/comment_model/comment_model.dart';
import 'package:flip/domain/models/user_model/user_model.dart';

abstract class UserRepository {
  void userAuthDataCollection(UserModel user);
  Future<UserModel?> fetchDataByUser(String uid);
  Future<void>addComments(Comments comments,String postId);
  Stream<List<Comments>>fetchComments(String postId);
}
