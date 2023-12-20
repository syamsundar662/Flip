import 'package:flip/data/models/post_model/post_model.dart';

abstract class LikeRepository{
  Future<PostModel> toggleLike(
      {required PostModel post, required String userId});
}