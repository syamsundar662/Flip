import 'package:firebase_auth/firebase_auth.dart';

class AuthRepository {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  Future<String> signUp(String email, String password) async {
    try {
      await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      return 'success';
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        return 'Weak password';
      } else if (e.code == 'email-already-in-use') {
        return 'Email already registered';
      } else if (e.code == 'invalid-email') {
        return 'Invalid email';
      } else {
        return 'Something went wrong';
      }
    }
  }

  Future<String> signIn(String email, String password) async {
    try {
      await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return "log in success";
    } on FirebaseAuthException catch (e) {
      if (e.code == 'invalid-email') {
        return 'invalid email';
      } else if (e.code == 'user-not-found') {
        return 'user not found';
      } else if (e.code == 'wrong-password') {
        return 'urong password';
      } else {
        return 'log in failed: ${e.toString()}';
      }
    }
  }

  Future<void> signOut() async {
    try {
      await _firebaseAuth.signOut();
    } catch (e) {
      throw Exception('Sign out failed');
    }
  }
}

      //  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Sign up successful')));