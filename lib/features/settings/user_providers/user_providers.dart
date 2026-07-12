import 'package:flutter_riverpod/flutter_riverpod.dart';
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
  return UserRepositoryImpl(ref.read(userRemoteDataSourceProvider));
});

final fetchUserDataUseCaseProvider = Provider<FetchUserDataUseCase>((ref) {
  return FetchUserDataUseCase(ref.read(userRepositoryProvider));
});

final userNotifierProvider = NotifierProvider<UserNotifier, UserState>(() {
  return UserNotifier();
});
