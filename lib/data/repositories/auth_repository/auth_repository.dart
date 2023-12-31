import 'package:flip/application/presentation/utils/constants/constants.dart';
import 'package:flip/data/models/login_model/login_model.dart';
import 'package:flip/data/models/sign_up_model/sign_up_model.dart';

abstract class AuthRepository{
  Future<AuthenticationResults> signUp(SignUpModel signUp);
  Future<AuthenticationResults> signIn(LogInModel logIn);
  Future<AuthenticationResults> verifyEmail(); 
  Future<void> signOut() ;
  Future<AuthenticationResults> signInWithGoogle();
  Future<String> resetPassword(String email);
  void deleteUserFromFirebase();
} 
 