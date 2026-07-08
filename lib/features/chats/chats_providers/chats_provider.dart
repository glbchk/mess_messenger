import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:mess_messenger_app/features/chats/chats_providers/open_chat_provider.dart';
import 'package:mess_messenger_app/features/chats/domain/chats_use_cases/chats_use_cases.dart';
import 'package:mess_messenger_app/features/chats/presentation/notifiers/user_chats_notifier.dart';
import 'package:mess_messenger_app/features/chats/presentation/states/user_chats_state.dart';

final fetchUserChatsUseCaseProvider = Provider<FetchUserChatsUseCase>((ref) {
  return FetchUserChatsUseCase(ref.read(chatsRepositoryProvider));
});

final selectedChatIdProvider = StateProvider<String?>((ref) => null);

final userChatsNotifierProvider =
    NotifierProvider<UserChatsNotifier, UserChatsState>(UserChatsNotifier.new);
