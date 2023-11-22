
import 'package:flip/domain/models/comment_model/comment_model.dart';

abstract class CommentRepository{
  Future<void> addComments(Comments comments, String postId);
  Future<List<Comments>> fetchComments(String postId);
  Future<List<CommentWithUserProfile>> fetchUser(
    List<Comments> comments,
  );
}