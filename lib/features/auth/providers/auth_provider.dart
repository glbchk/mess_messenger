import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:mess_messenger_app/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:mess_messenger_app/features/auth/domain/repositories/auth_repository.dart';
import 'package:mess_messenger_app/features/auth/domain/usecases/auth_use_cases.dart';
import 'package:mess_messenger_app/features/auth/presentation/notifiers/auth_notifier.dart';
import 'package:mess_messenger_app/features/auth/presentation/states/auth_state.dart';

final authRepositoryProvider = Provider<AuthRepository>((ref) {
  return AuthRepositoryImpl();
});

final isLoggedInUseCaseProvider = Provider<IsLoggedInUserUseCase>((ref) {
  return IsLoggedInUserUseCase(ref.read(authRepositoryProvider));
});

final loginUseCaseProvider = Provider<LoginUserUseCase>((ref) {
  return LoginUserUseCase(ref.read(authRepositoryProvider));
});

final logoutUseCaseProvider = Provider<LogoutUserUseCase>((ref) {
  return LogoutUserUseCase(ref.read(authRepositoryProvider));
});

final authProvider = StateNotifierProvider<AuthNotifier, AuthState>((ref) {
  return AuthNotifier(
    loginUserUseCase: ref.read(loginUseCaseProvider),
    logoutUserUseCase: ref.read(logoutUseCaseProvider),
    isLoggedInUserUseCase: ref.read(isLoggedInUseCaseProvider),
  );
});
