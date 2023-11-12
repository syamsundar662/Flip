import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flip/domain/models/user_model/user_model.dart';
import 'package:flip/domain/repositories/user_repository/user_repository.dart';

class UserDataService implements UserRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
   
  void userAuthDataCollection(UserRepositoryModel user) async {
   final CollectionReference users = _firestore.collection('UserCollection');
    DocumentReference userDataDoc = users.doc(FirebaseAuth.instance.currentUser!.uid);
    final Map<String,dynamic> userDatas ={
      'username':user.username,
      'email':user.email,
      'userId':user.userId,
      'postId':user.postId,
      'displayName':user.displayName,
      'bio':user.bio,
      'saves':user.saves,
      'profileImageUrl':user.profileImageUrl,
      'coverImageUrl':user.coverImageUrl,
      'followers':user.followers,
      'following':user.following,
      'posts':user.posts
    };
    userDataDoc.set(userDatas);
  }
}
