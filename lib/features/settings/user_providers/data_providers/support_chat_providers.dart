import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mess_messenger_app/core/providers/data_providers/firebase_provider.dart';
import 'package:mess_messenger_app/features/chats/data/models/message_model.dart';
import 'package:mess_messenger_app/features/settings/data/data_sources/support_chat_remote_data_source.dart';
import 'package:mess_messenger_app/features/settings/data/models/support_chat_model.dart';
import 'package:mess_messenger_app/features/settings/data/user_repositories_impl/support_chat_respository_impl.dart';
import 'package:mess_messenger_app/features/settings/domain/user_repositories/support_chat_repository.dart';
import 'package:mess_messenger_app/features/settings/domain/user_use_cases/support_chat_use_cases.dart';
import 'package:mess_messenger_app/features/settings/presentation/notifiers/support_chat_notifier.dart';
import 'package:mess_messenger_app/features/settings/presentation/states/support_chat_state.dart';
import 'package:mess_messenger_app/features/settings/user_providers/data_providers/user_providers.dart';

final supportChatRemoteDataSourceProvider =
    Provider<SupportChatRemoteDataSource>((ref) {
      return SupportChatRemoteDataSource(ref.read(firestoreProvider));
    });

final supportChatRepositoryProvider = Provider<SupportChatRepository>((ref) {
  return SupportChatRepositoryImpl(
    ref.read(supportChatRemoteDataSourceProvider),
  );
});

final requestSupportAgentUseCaseProvider = Provider<RequestSupportAgentUseCase>(
  (ref) {
    return RequestSupportAgentUseCase(ref.read(supportChatRepositoryProvider));
  },
);

final sendSupportMessageUseCaseProvider = Provider<SendSupportMessageUseCase>((
  ref,
) {
  return SendSupportMessageUseCase(ref.read(supportChatRepositoryProvider));
});

final fetchSupportMessagesUseCaseProvider =
    Provider<FetchSupportMessagesUseCase>((ref) {
      return FetchSupportMessagesUseCase(
        ref.read(supportChatRepositoryProvider),
      );
    });

final watchSupportRequestUseCaseProvider = Provider<WatchSupportRequestUseCase>(
  (ref) {
    return WatchSupportRequestUseCase(ref.read(supportChatRepositoryProvider));
  },
);

final watchActiveRequestIdUseCaseProvider =
    Provider<WatchActiveRequestIdUseCase>((ref) {
      return WatchActiveRequestIdUseCase(
        ref.read(supportChatRepositoryProvider),
      );
    });

final fetchPastRequestsUseCaseProvider = Provider<FetchPastRequestsUseCase>((
  ref,
) {
  return FetchPastRequestsUseCase(ref.read(supportChatRepositoryProvider));
});

final pastSupportRequestsProvider =
    StreamProvider.autoDispose<List<SupportChatModel>>((ref) {
      final userId = ref.watch(userNotifierProvider).userData?.id;
      if (userId == null) return const Stream.empty();
      return ref.read(fetchPastRequestsUseCaseProvider).execute(userId);
    });

final viewedSupportRequestMessagesProvider = StreamProvider.autoDispose
    .family<List<MessageModel>, String>((ref, requestId) {
      final userId = ref.watch(userNotifierProvider).userData?.id;
      if (userId == null) return const Stream.empty();
      return ref
          .read(fetchSupportMessagesUseCaseProvider)
          .execute(userId, requestId);
    });

final supportChatNotifierProvider =
    NotifierProvider<SupportChatNotifier, SupportChatState>(
      SupportChatNotifier.new,
    );
