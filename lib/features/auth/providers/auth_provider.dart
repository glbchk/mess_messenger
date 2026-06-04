import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mess_messenger_app/features/auth/data/datasources/auth_remote_data_source.dart';
import 'package:mess_messenger_app/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:mess_messenger_app/features/auth/data/services/firebase_auth_provider.dart';
import 'package:mess_messenger_app/features/auth/domain/repositories/auth_repository.dart';
import 'package:mess_messenger_app/features/auth/domain/usecases/auth_use_cases.dart';
import 'package:mess_messenger_app/features/auth/presentation/notifiers/auth_notifier.dart';
import 'package:mess_messenger_app/features/auth/presentation/states/auth_state.dart';

final authRemoteDataSourceProvider = Provider<AuthRemoteDataSource>((ref) {
  final auth = ref.read(firebaseAuthProvider);
  return AuthRemoteDataSource(auth);
});

final authRepositoryProvider = Provider<AuthRepository>((ref) {
  final authRemoteDataSource = ref.read(authRemoteDataSourceProvider);
  return AuthRepositoryImpl(authRemoteDataSource);
});

final isLoggedInUseCaseProvider = Provider<IsLoggedInUserUseCase>((ref) {
  final authRepo = ref.read(authRepositoryProvider);
  return IsLoggedInUserUseCase(authRepo);
});

final signUpUseCaseProvider = Provider<SignUpUserUseCase>((ref) {
  final authRepo = ref.read(authRepositoryProvider);
  return SignUpUserUseCase(authRepo);
});

final loginUseCaseProvider = Provider<LoginUserUseCase>((ref) {
  final authRepo = ref.read(authRepositoryProvider);
  return LoginUserUseCase(authRepo);
});

final logoutUseCaseProvider = Provider<LogoutUserUseCase>((ref) {
  final authRepo = ref.read(authRepositoryProvider);
  return LogoutUserUseCase(authRepo);
});

final authProvider = NotifierProvider<AuthNotifier, AuthState>(() {
  return AuthNotifier();
});
