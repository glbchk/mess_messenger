import 'package:firebase_auth/firebase_auth.dart';
import 'package:mess_messenger_app/features/auth/data/datasources/auth_local_data_source.dart';
import 'package:mess_messenger_app/features/auth/data/datasources/auth_remote_data_source.dart';
import 'package:mess_messenger_app/features/auth/data/datasources/user_remote_data_source.dart';
import 'package:mess_messenger_app/features/auth/data/models/user_model.dart';
import 'package:mess_messenger_app/features/auth/domain/repositories/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource authRemoteDataSource;
  final AuthLocalDataSource authLocalDataSource;
  final UserRemoteDataSource userRemoteDataSource;

  AuthRepositoryImpl(
    this.authRemoteDataSource,
    this.authLocalDataSource,
    this.userRemoteDataSource,
  );

  @override
  Future<bool> isLoggedIn() async {
    final isLoggedIn = await authRemoteDataSource.isLoggedIn();
    if (!isLoggedIn) return false;
    return authLocalDataSource.shouldStayLoggedIn();
  }

  @override
  Future<void> signUp(String email, String password) async {
    final uid = await authRemoteDataSource.signUp(email, password);
    await userRemoteDataSource.createUser(UserModel(id: uid, email: email));
  }

  @override
  Future<void> signInWithEmail(
    String email,
    String password,
    bool rememberMe,
  ) async {
    await authRemoteDataSource.setPersistence(rememberMe);
    await authRemoteDataSource.signInWithEmail(email, password);
    await authLocalDataSource.saveRememberMe(rememberMe);
  }

  @override
  Future<UserCredential> signInWithGoogle() async {
    final userCredential = await authRemoteDataSource.signInWithGoogle();

    if (userCredential.additionalUserInfo?.isNewUser == true) {
      final user = userCredential.user!;
      await userRemoteDataSource.createUser(
        UserModel(
          id: user.uid,
          email: user.email ?? '',
          name: user.displayName,
        ),
      );
    }

    return userCredential;
  }

  @override
  Future<void> linkEmailPassword(String email, String password) {
    return authRemoteDataSource.linkEmailPassword(email, password);
  }

  @override
  Future<void> linkGoogleAccount() {
    return authRemoteDataSource.linkGoogleAccount();
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
