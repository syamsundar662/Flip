
abstract class AuthRepository{

  Future<String> signUp(String email, String password);
  Future<String> signIn(String email, String password);
  Future<String> verifyEmail(); 
  Future<void> signOut() ;
  signinWithGoogle();
}
