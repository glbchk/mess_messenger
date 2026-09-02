import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mess_messenger_app/core/providers/data_providers/firebase_provider.dart';
import 'package:mess_messenger_app/features/chats/data/chats_repositories_impl/chats_repository_impl.dart';
import 'package:mess_messenger_app/features/chats/data/datasources/chats_remote_data_source.dart';
import 'package:mess_messenger_app/features/chats/domain/chats_repositories/chats_repository.dart';
import 'package:mess_messenger_app/features/chats/domain/chats_use_cases/chats_use_cases.dart';
import 'package:mess_messenger_app/features/chats/presentation/notifiers/open_chat_notifier.dart';
import 'package:mess_messenger_app/features/chats/presentation/states/open_chat_state.dart';

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

// .family because each chat screen needs its own chatId-scoped state
final chatsNotifierProvider =
    NotifierProvider.family<OpenChatNotifier, OpenChatState, String>(
      OpenChatNotifier.new,
    );
