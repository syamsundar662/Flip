import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flip/application/presentation/utils/constants/constants.dart';
import 'package:flip/domain/models/login_in/login_model.dart';
import 'package:flip/domain/models/sign_up/sign_up_model.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../../domain/repositories/auth_repo/auth_repository.dart';

class AuthServices implements AuthRepository {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  @override
  Future<AuthenticationResults> signUp(SignUpModel signUp) async {
    try {
      final UserCredential userCredential =
          await _firebaseAuth.createUserWithEmailAndPassword(
        email: signUp.email,
        password: signUp.password,
      );
      userCredential.user!.sendEmailVerification();
      return AuthenticationResults.signUpSuccess;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        return AuthenticationResults.weakPassword;
      } else if (e.code == 'email-already-in-use') {
        return AuthenticationResults.alreadyRegisteredEmail;
      } else if (e.code == 'invalid-email') {
        return AuthenticationResults.invalidEmail;
      } else {
        return AuthenticationResults.somethingWentWrong;
      }
    }catch (e){
      return AuthenticationResults.errorOccurs;
    }
  }

  @override
  Future<AuthenticationResults> signIn(LogInModel logIn) async {
    try {
      await _firebaseAuth.signInWithEmailAndPassword(
        email: logIn.email,
        password: logIn.password,
      );
      return AuthenticationResults.signUpSuccess;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'invalid-email') {
        return AuthenticationResults.invalidEmail;
      } else if (e.code == 'user-not-found') {
        return AuthenticationResults.userNotFound;
      } else if (e.code == 'wrong-password') {
        return AuthenticationResults.wrongPassword;
      } else {
        return AuthenticationResults.loginFailed;
      }
    }
  }

  @override
  Future<AuthenticationResults> verifyEmail() async {
    await FirebaseAuth.instance.currentUser!.reload();
    final isEmailVerified =
        FirebaseAuth.instance.currentUser?.emailVerified ?? false;
    if (isEmailVerified) {
      return AuthenticationResults.verificationSuccess;
    } else {
      Completer<AuthenticationResults> completer =
          Completer<AuthenticationResults>();
      Timer.periodic(const Duration(seconds: 5), (timer) async {
        if (FirebaseAuth.instance.currentUser == null) {
          timer.cancel();
          completer.complete(AuthenticationResults.errorOccurs);
        }
        await FirebaseAuth.instance.currentUser!.reload();
        if (FirebaseAuth.instance.currentUser!.emailVerified) {
          timer.cancel();
          completer.complete(AuthenticationResults.verificationSuccess);
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
  signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      final GoogleSignInAuthentication? googleAuth =
          await googleUser?.authentication;

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );
      await FirebaseAuth.instance.signInWithCredential(credential);
      return AuthenticationResults.googleSignInSuccess;
    } catch (e) {
      return AuthenticationResults.googleSignInFailed;
    }
  }

  @override
  Future<String> resetPassword(String email)async{
    try{
  await _firebaseAuth.sendPasswordResetEmail(email: email);
  return 'passwordResetSuccess';
    } catch(e){
      return 'Error sending password reseting email $e' ; 
      // return AuthenticationResults.somethingWentWrong ;

    }
  }
}
