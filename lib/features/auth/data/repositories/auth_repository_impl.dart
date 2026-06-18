import 'package:firebase_auth/firebase_auth.dart';
import 'package:mess_messenger_app/features/auth/data/datasources/auth_remote_data_source.dart';
import 'package:mess_messenger_app/features/auth/domain/repositories/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource authRemoteDataSource;

  AuthRepositoryImpl(this.authRemoteDataSource);

  @override
  Future<bool> isLoggedIn() async {
    return await authRemoteDataSource.isLoggedIn();
  }

  @override
  Future<String> signUp(String email, String password) async {
    return await authRemoteDataSource.signUp(email, password);
  }

  @override
  Future<void> signInWithEmail(
    String email,
    String password,
    bool rememberMe,
  ) async {
    await authRemoteDataSource.signInWithEmail(email, password, rememberMe);
  }

  @override
  Future<UserCredential> signInWithGoogle() async {
    return await authRemoteDataSource.signInWithGoogle();
  }

  @override
  Future<void> sendPasswordResetEmail(String email) async {
    await authRemoteDataSource.sendPasswordResetEmail(email);
  }

  @override
  Future<void> logout() async {
    await authRemoteDataSource.logout();
  }
}
