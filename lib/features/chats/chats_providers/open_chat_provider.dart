import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mess_messenger_app/core/providers/data_providers/firebase_provider.dart';
import 'package:mess_messenger_app/features/chats/data/chats_repositories_impl/chats_repository_impl.dart';
import 'package:mess_messenger_app/features/chats/data/data_sources/chats_remote_data_source.dart';
import 'package:mess_messenger_app/features/chats/domain/chats_repositories/chats_repository.dart';
import 'package:mess_messenger_app/features/chats/domain/chats_use_cases/chats_use_cases.dart';
import 'package:mess_messenger_app/features/chats/presentation/notifiers/open_chat_notifier.dart';
import 'package:mess_messenger_app/features/chats/presentation/notifiers/watched_user_norifier.dart';
import 'package:mess_messenger_app/features/chats/presentation/states/open_chat_state.dart';
import 'package:mess_messenger_app/features/chats/presentation/states/watched_user_state.dart';
import 'package:mess_messenger_app/features/settings/data/models/user_model.dart';

final chatsRemoteDataSourceProvider = Provider<ChatsRemoteDataSource>((ref) {
  return ChatsRemoteDataSource(ref.read(firestoreProvider));
});

final chatsRepositoryProvider = Provider<ChatsRepository>((ref) {
  return ChatsRepositoryImpl(ref.read(chatsRemoteDataSourceProvider));
});

final getOrCreateChatUseCaseProvider = Provider<GetOrCreateChatUseCase>((ref) {
  return GetOrCreateChatUseCase(ref.read(chatsRepositoryProvider));
});

final sendMessageUseCaseProvider = Provider<SendMessageUseCase>((ref) {
  return SendMessageUseCase(ref.read(chatsRepositoryProvider));
});

final fetchMessagesUseCaseProvider = Provider<FetchMessagesUseCase>((ref) {
  return FetchMessagesUseCase(ref.read(chatsRepositoryProvider));
});

final chatsNotifierProvider =
    NotifierProvider.family<OpenChatNotifier, OpenChatState, String>(
      OpenChatNotifier.new,
    );

final watchUserUseCaseProvider = Provider<WatchUserUseCase>((ref) {
  return WatchUserUseCase(ref.read(chatsRepositoryProvider));
});

final watchedUserProvider = StreamProvider.family<UserModel, String>((
  ref,
  userId,
) {
  if (userId.isEmpty) return const Stream.empty();
  return ref.read(watchUserUseCaseProvider).execute(userId);
});

final watchedUserNotifierProvider =
    NotifierProvider.family<WatchedUserNotifier, WatchedUserState, String>(
      WatchedUserNotifier.new,
    );

final updateChatStatusUseCaseProvider = Provider<UpdateChatStatusUseCase>((
  ref,
) {
  return UpdateChatStatusUseCase(ref.read(chatsRepositoryProvider));
});
