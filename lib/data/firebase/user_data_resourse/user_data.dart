import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
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
      'followers': [],
      'following': [],
      'posts': user.posts
    };
    userDataDoc.set(userDatas);
  }

  @override
  Future<UserModel?> fetchDataByUser(String uId) async {
    final userData = await _firestore
        .collection('UserCollection')
        .where('userId', isEqualTo: uId)
        .get();
    if (userData.docs.isNotEmpty) {
      final response = userData.docs.first.data();
      return UserModel.fromJson(response);
    }
    return null;
  }

  Future<void> editUserDetails(UserModel user, String uId) async {
    final collection = _firestore.collection('UserCollection');
    final userDoc = collection.doc(uId);
    final Map<String, dynamic> userData = {
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
    userDoc.set(userData);
  }
}
