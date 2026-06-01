abstract class AuthRepository {
  Future<bool> isLoggedIn();
  Future<String> signUp(String email, String password);
  Future<void> login(String email, String password);
  Future<void> logout();
}
