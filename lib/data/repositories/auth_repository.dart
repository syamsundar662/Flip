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
           
        }else if(e.code== 'invalid-email'){
          return 'Invalid email';
        } 
      else {
        return 'Something went wrong'; 
      }
    }
  }

  Future<void> signIn(String email, String password) async {
    try {
      await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
    } catch (e) {
      if (e is FirebaseAuthException) {
        if (e.code == 'invalid-email') {
          throw Exception('Invalid email');
        } else if (e.code == 'user-not-found' || e.code == 'wrong-password') {
          throw Exception('Invalid email or password');
        } else {
          throw Exception('Sign in failed');
        }
      } else {
        throw Exception('Sign in failed: ${e.toString()}');
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