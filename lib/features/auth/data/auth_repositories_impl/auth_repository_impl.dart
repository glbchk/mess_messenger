import 'package:firebase_auth/firebase_auth.dart';
import 'package:mess_messenger_app/features/auth/data/data_source/auth_local_data_source.dart';
import 'package:mess_messenger_app/features/auth/data/data_source/auth_remote_data_source.dart';
import 'package:mess_messenger_app/features/auth/domain/auth_repositories/auth_repository.dart';
import 'package:mess_messenger_app/features/settings/data/data_source/user_remote_data_source.dart';
import 'package:mess_messenger_app/features/settings/data/models/user_model.dart';

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
  Future<bool> isUserLoggedIn() async {
    final isLoggedIn = await authRemoteDataSource.isUserLoggedIn();
    if (!isLoggedIn) return false;
    return authLocalDataSource.shouldStayLoggedIn();
  }

  @override
  Future<void> signUp(String email, String password, String name) async {
    final uid = await authRemoteDataSource.signUp(email, password);
    await userRemoteDataSource.createUser(
      UserModel.newUser(id: uid, email: email, name: name),
    );
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
