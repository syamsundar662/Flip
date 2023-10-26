
abstract class AuthRepository{

  Future<String> signUp(String email, String password);
  Future<String> signIn(String email, String password);
  Future<void> signOut() ;
  signinWithGoogle();
}
