import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mess_messenger_app/features/auth/data/datasources/auth_local_data_source.dart';
import 'package:mess_messenger_app/features/auth/data/datasources/auth_remote_data_source.dart';
import 'package:mess_messenger_app/features/auth/data/datasources/user_remote_data_source.dart';
import 'package:mess_messenger_app/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:mess_messenger_app/features/auth/domain/repositories/auth_repository.dart';
import 'package:mess_messenger_app/features/auth/domain/usecases/auth_use_cases.dart';
import 'package:mess_messenger_app/features/auth/presentation/notifiers/auth_notifier.dart';
import 'package:mess_messenger_app/features/auth/presentation/states/auth_state.dart';
import 'package:mess_messenger_app/features/auth/providers/firebase_provider.dart';

final authRemoteDataSourceProvider = Provider<AuthRemoteDataSource>((ref) {
  final auth = ref.read(firebaseAuthProvider);
  return AuthRemoteDataSource(auth);
});

final authLocalDataSourceProvider = Provider<AuthLocalDataSource>((ref) {
  return AuthLocalDataSource();
});

final userRemoteDataSourceProvider = Provider<UserRemoteDataSource>((ref) {
  final firestore = ref.read(firestoreProvider);
  return UserRemoteDataSource(firestore);
});

final authRepositoryProvider = Provider<AuthRepository>((ref) {
  final authRemoteDataSource = ref.read(authRemoteDataSourceProvider);
  final authLocalDataSource = ref.read(authLocalDataSourceProvider);
  final userRemoteDataSource = ref.read(userRemoteDataSourceProvider);
  return AuthRepositoryImpl(
    authRemoteDataSource,
    authLocalDataSource,
    userRemoteDataSource,
  );
});

final isLoggedInUseCaseProvider = Provider<IsLoggedInUserUseCase>((ref) {
  final authRepo = ref.read(authRepositoryProvider);
  return IsLoggedInUserUseCase(authRepo);
});

final signUpUseCaseProvider = Provider<SignUpUserUseCase>((ref) {
  final authRepo = ref.read(authRepositoryProvider);
  return SignUpUserUseCase(authRepo);
});

final signInWithEmailUseCaseProvider = Provider<SignInWithEmailUserUseCase>((
  ref,
) {
  final authRepo = ref.read(authRepositoryProvider);
  return SignInWithEmailUserUseCase(authRepo);
});

final signInWithGoogleUseCaseProvider = Provider<SignInWithGoogleUseCase>((
  ref,
) {
  final authRepo = ref.read(authRepositoryProvider);
  return SignInWithGoogleUseCase(authRepo);
});

final sendPasswordResetUseCaseProvider = Provider<SendPasswordResetUserUseCase>(
  (ref) {
    final authRepo = ref.read(authRepositoryProvider);
    return SendPasswordResetUserUseCase(authRepo);
  },
);

final logoutUseCaseProvider = Provider<LogoutUserUseCase>((ref) {
  final authRepo = ref.read(authRepositoryProvider);
  return LogoutUserUseCase(authRepo);
});

final linkEmailPasswordUseCaseProvider = Provider<LinkEmailPasswordUseCase>((
  ref,
) {
  final authRepo = ref.read(authRepositoryProvider);
  return LinkEmailPasswordUseCase(authRepo);
});

final linkGoogleAccountUseCaseProvider = Provider<LinkGoogleAccountUseCase>((
  ref,
) {
  final authRepo = ref.read(authRepositoryProvider);
  return LinkGoogleAccountUseCase(authRepo);
});

final authProvider = NotifierProvider<AuthNotifier, AuthState>(() {
  return AuthNotifier();
});
