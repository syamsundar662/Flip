import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flip/domain/models/comment_model/comment_model.dart';
import 'package:flip/domain/models/user_model/user_model.dart';
import 'package:flip/domain/repositories/user_repository/user_repository.dart';

class UserService implements UserRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  void userAuthDataCollection(UserModel user) async {
    final CollectionReference users = _firestore.collection('UserCollection');
    DocumentReference userDataDoc =
        users.doc(FirebaseAuth.instance.currentUser!.uid);
    final Map<String, dynamic> userDatas = {
      'username': user.username,
      'email': user.email,
      'userId': user.userId,
      'postId': user.postId,
      'displayName': user.displayName,
      'bio': user.bio,
      'saves': user.saves,
      'profileImageUrl': user.profileImageUrl,
      'coverImageUrl': user.coverImageUrl,
      'followers': user.followers,
      'following': user.following,
      'posts': user.posts
    };
    userDataDoc.set(userDatas);
  }

  @override
  Future<UserModel?> fetchDataByUser(String uid) async {
    final userData = await _firestore
        .collection('UserCollection')
        .where('userId', isEqualTo: uid)
        .get();
    if (userData.docs.isNotEmpty) {
      final response = userData.docs.first.data();
      return UserModel.fromJson(response);
    }
    return null;
  }

  @override
  Future<void> addComments(Comments comments, String postId) async {
    // final postId = _firestore.collection('PostCollection').doc().id;
    final commentCollection = _firestore
        .collection('PostCollection')
        .doc(postId)
        .collection('Comments')
        .doc();
    final Map<String, dynamic> comment = {
      'commentId': commentCollection.id,
      'postId': comments.postId,
      'comment': comments.comment,
      'timeStamp': comments.timeStamp,
      'userId': comments.userId,
      'likes': comments.likes
    };
    await commentCollection.set(comment);
  }

  @override
  Stream<List<Comments>> fetchComments(String postId) async* {
    final response = await _firestore
        .collection('PostCollection')
        .doc(postId)
        .collection('Comments')
        .get();
    final comment = 
        response.docs.map((data) => Comments.fromJson(data.data())).toList();
    yield comment;
  }
}
