import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mess_messenger_app/core/providers/data_providers/firebase_provider.dart';
import 'package:mess_messenger_app/features/auth/auth_providers/auth_providers.dart';
import 'package:mess_messenger_app/features/settings/data/data_source/user_remote_data_source.dart';
import 'package:mess_messenger_app/features/settings/data/user_repositories_impl/user_repository_impl.dart';
import 'package:mess_messenger_app/features/settings/domain/user_repositories/user_repository.dart';
import 'package:mess_messenger_app/features/settings/domain/user_use_cases/user_use_cases.dart';
import 'package:mess_messenger_app/features/settings/presentation/notifiers/user_notifier.dart';
import 'package:mess_messenger_app/features/settings/presentation/states/user_state.dart';

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

final updateAvatarUseCaseProvider = Provider<UpdateAvatarUseCase>((ref) {
  return UpdateAvatarUseCase(ref.read(userRepositoryProvider));
});

final updateIsLoggedInUseCaseProvider = Provider<UpdateIsLoggedInUseCase>((
  ref,
) {
  return UpdateIsLoggedInUseCase(ref.read(userRepositoryProvider));
});

final updateLanguageUseCaseProvider = Provider<UpdateLanguageUseCase>((ref) {
  return UpdateLanguageUseCase(ref.read(userRepositoryProvider));
});

final updateIsPhotoPasswordProtectedUseCaseProvider =
    Provider<UpdateIsPhotoPasswordProtectedUseCase>((ref) {
      return UpdateIsPhotoPasswordProtectedUseCase(
        ref.read(userRepositoryProvider),
      );
    });

final updateIsAudioPasswordProtectedUseCaseProvider =
    Provider<UpdateIsAudioPasswordProtectedUseCase>((ref) {
      return UpdateIsAudioPasswordProtectedUseCase(
        ref.read(userRepositoryProvider),
      );
    });

final updateIsVideoPasswordProtectedUseCaseProvider =
    Provider<UpdateIsVideoPasswordProtectedUseCase>((ref) {
      return UpdateIsVideoPasswordProtectedUseCase(
        ref.read(userRepositoryProvider),
      );
    });

final updateIsDocumentPasswordProtectedUseCaseProvider =
    Provider<UpdateIsDocumentPasswordProtectedUseCase>((ref) {
      return UpdateIsDocumentPasswordProtectedUseCase(
        ref.read(userRepositoryProvider),
      );
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

final updateUserPhoneNumberUseCaseProvider =
    Provider<UpdateUserPhoneNumberUseCase>((ref) {
      return UpdateUserPhoneNumberUseCase(ref.read(userRepositoryProvider));
    });

final updateThemeModeUseCaseProvider = Provider<UpdateThemeModeUseCase>((ref) {
  return UpdateThemeModeUseCase(ref.read(userRepositoryProvider));
});

final updateBackgroundColorUseCaseProvider =
    Provider<UpdateBackgroundColorUseCase>((ref) {
      return UpdateBackgroundColorUseCase(ref.read(userRepositoryProvider));
    });

final updateSubscriptionPlanUseCaseProvider =
    Provider<UpdateSubscriptionPlanUseCase>((ref) {
      return UpdateSubscriptionPlanUseCase(ref.read(userRepositoryProvider));
    });
