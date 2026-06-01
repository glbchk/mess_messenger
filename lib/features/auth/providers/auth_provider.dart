import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mess_messenger_app/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:mess_messenger_app/features/auth/domain/repositories/auth_repository.dart';
import 'package:mess_messenger_app/features/auth/domain/usecases/auth_use_cases.dart';
import 'package:mess_messenger_app/features/auth/presentation/notifiers/auth_notifier.dart';
import 'package:mess_messenger_app/features/auth/presentation/states/auth_state.dart';

// final authRemoteDataSourceProvider = Provider<AuthRemoteDataSource>((ref) {
//   return AuthRemoteDataSource();
// });

final authRepositoryProvider = Provider<AuthRepository>((ref) {
  return AuthRepositoryImpl();
});

final isLoggedInUseCaseProvider = Provider<IsLoggedInUserUseCase>((ref) {
  return IsLoggedInUserUseCase();
});

final signUpUseCaseProvider = Provider<SignUpUserUseCase>((ref) {
  return SignUpUserUseCase();
});

final loginUseCaseProvider = Provider<LoginUserUseCase>((ref) {
  return LoginUserUseCase();
});

final logoutUseCaseProvider = Provider<LogoutUserUseCase>((ref) {
  return LogoutUserUseCase();
});

final authProvider = NotifierProvider<AuthNotifier, AuthState>(() {
  return AuthNotifier();
});
