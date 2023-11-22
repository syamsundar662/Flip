import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flip/domain/repositories/save_post_repository/save_post_repository.dart';

class SavePostDataService extends SavePostRepository {
  @override
  Future<void> savePost(String currentUid, postId) async {
    final collection = FirebaseFirestore.instance.collection('UserCollection');
    collection.doc(currentUid).update({
      'saves': FieldValue.arrayUnion([postId])
    });
  }

  // Future<PostModel> fetchSavedPosts(String uId, String postId)async {
  //   final collection = FirebaseFirestore.instance.collection('UserCollection');
  //   final response = collection.doc(uId).get();



  // }
}
