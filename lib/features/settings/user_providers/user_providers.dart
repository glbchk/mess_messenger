import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mess_messenger_app/features/auth/auth_providers/auth_providers.dart';
import 'package:mess_messenger_app/features/settings/data/data_source/user_remote_data_source.dart';
import 'package:mess_messenger_app/features/settings/data/user_repositories_impl/user_repository_impl.dart';
import 'package:mess_messenger_app/features/settings/domain/user_repositories/user_repository.dart';
import 'package:mess_messenger_app/features/settings/domain/user_use_cases/user_use_cases.dart';
import 'package:mess_messenger_app/features/settings/presentation/notifiers/user_notifier.dart';
import 'package:mess_messenger_app/features/settings/presentation/states/user_state.dart';
import 'package:mess_messenger_app/providers/firebase_provider.dart';

final userRemoteDataSourceProvider = Provider<UserRemoteDataSource>((ref) {
  return UserRemoteDataSource(ref.read(firestoreProvider));
});

final userRepositoryProvider = Provider<UserRepository>((ref) {
  return UserRepositoryImpl(
    ref.read(userRemoteDataSourceProvider),
    ref.read(authRemoteDataSourceProvider),
  );
});

final userNotifierProvider = NotifierProvider<UserNotifier, UserState>(() {
  return UserNotifier();
});

final fetchUserDataUseCaseProvider = Provider<FetchUserDataUseCase>((ref) {
  return FetchUserDataUseCase(ref.read(userRepositoryProvider));
});

final updateGeneralSettingsUseCaseProvider =
    Provider<UpdateGeneralSettingsUseCase>((ref) {
      return UpdateGeneralSettingsUseCase(ref.read(userRepositoryProvider));
    });

final updateApplicationLanguageUseCaseProvider =
    Provider<UpdateApplicationLanguageUseCase>((ref) {
      return UpdateApplicationLanguageUseCase(ref.read(userRepositoryProvider));
    });

final updateUserNameUseCaseProvider = Provider<UpdateUserNameUseCase>((ref) {
  return UpdateUserNameUseCase(ref.read(userRepositoryProvider));
});

final updateUserBirthdayUseCaseProvider = Provider<UpdateUserBirthdayUseCase>((
  ref,
) {
  return UpdateUserBirthdayUseCase(ref.read(userRepositoryProvider));
});

final updateUserEmailUseCaseProvider = Provider<UpdateUserEmailUseCase>((ref) {
  return UpdateUserEmailUseCase(ref.read(userRepositoryProvider));
});
