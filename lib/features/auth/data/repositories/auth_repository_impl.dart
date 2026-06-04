import 'package:mess_messenger_app/features/auth/data/datasources/auth_remote_data_source.dart';
import 'package:mess_messenger_app/features/auth/domain/repositories/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource authRemoteDataSource;

  AuthRepositoryImpl(this.authRemoteDataSource);

  @override
  Future<bool> isLoggedIn() async {
    return await authRemoteDataSource.getCurrentUser();
  }

  @override
  Future<String> signUp(String email, String password) async {
    return await authRemoteDataSource.signUp(email, password);
  }

  @override
  Future<void> login(String email, String password) async {
    await authRemoteDataSource.login(email, password);
  }

  @override
  Future<void> logout() async {
    await authRemoteDataSource.logout();
  }
}
