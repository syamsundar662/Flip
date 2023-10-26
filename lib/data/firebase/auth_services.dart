import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../../domain/repositories/auth_repo/auth_repository.dart';

class AuthServices implements AuthRepository {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  @override
  Future<String> signUp(String email, String password) async {
    try {
      final UserCredential userCredential =
      await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      userCredential.user!.sendEmailVerification(); 
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

  @override
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
        return 'wrong password';
      } else {
        return 'log in failed: ${e.toString()}';
      }
    }
  }

  @override
  Future<String> verifyEmail() async {
    await FirebaseAuth.instance.currentUser!.reload();
    final isEmailVerified =
        FirebaseAuth.instance.currentUser?.emailVerified ?? false;
    if (isEmailVerified) {
      return 'varified';
    } else {
      Completer<String> completer = Completer<String>();
      Timer.periodic(const Duration(seconds: 5), (timer) async {
        if (FirebaseAuth.instance.currentUser == null) {
          timer.cancel();
          completer.complete('error');
        }
        await FirebaseAuth.instance.currentUser!.reload();
        if (FirebaseAuth.instance.currentUser!.emailVerified) {
          timer.cancel();
          completer.complete('verified');
        }
      });
      return completer.future;
    }
  }
  @override
  Future<void> signOut() async {
    try {
      await _firebaseAuth.signOut();
      GoogleSignIn().signOut(); 
    } catch (e) {
      throw Exception('Sign out failed');
    }
  }

  @override
  signinWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      final GoogleSignInAuthentication? googleAuth =
          await googleUser?.authentication;


      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );
      await FirebaseAuth.instance.signInWithCredential(credential);
      return 'google signin success';
    } catch (e) {
      return 'failed to sign in';
    }
  }
}