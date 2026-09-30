import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mess_messenger_app/core/providers/data_providers/firebase_provider.dart';
import 'package:mess_messenger_app/features/contacts/data/contacts_repositories_impl/contacts_repository_impl.dart';
import 'package:mess_messenger_app/features/contacts/data/data_sources/contacts_remote_data_source.dart';
import 'package:mess_messenger_app/features/contacts/domain/contacts_repositories/contacts_repository.dart';
import 'package:mess_messenger_app/features/contacts/domain/contacts_use_cases/contacts_use_cases.dart';
import 'package:mess_messenger_app/features/contacts/presentation/notifiers/contact_details_notifier.dart';
import 'package:mess_messenger_app/features/contacts/presentation/notifiers/contacts_notifier.dart';
import 'package:mess_messenger_app/features/contacts/presentation/notifiers/user_search_notifier.dart';
import 'package:mess_messenger_app/features/contacts/presentation/states/contact_details_state.dart';
import 'package:mess_messenger_app/features/contacts/presentation/states/contacts_state.dart';
import 'package:mess_messenger_app/features/contacts/presentation/states/user_search_state.dart';

final contactsRemoteDataSourceProvider = Provider<ContactsRemoteDataSource>((
  ref,
) {
  return ContactsRemoteDataSource(ref.read(firestoreProvider));
});

final contactsRepositoryProvider = Provider<ContactsRepository>((ref) {
  return ContactsRepositoryImpl(ref.read(contactsRemoteDataSourceProvider));
});

final findUserByEmailUseCaseProvider = Provider<FindUserByEmailDataUseCase>((
  ref,
) {
  return FindUserByEmailDataUseCase(ref.read(contactsRepositoryProvider));
});

final userSearchNotifierProvider =
    NotifierProvider<UserSearchNotifier, UserSearchState>(
      UserSearchNotifier.new,
    );

final selectedContactIdProvider =
    NotifierProvider<ContactsNotifier, ContactsState>(ContactsNotifier.new);

final contactsNotifierProvider =
    NotifierProvider<ContactsNotifier, ContactsState>(ContactsNotifier.new);

final contactDetailsProvider = NotifierProvider.autoDispose
    .family<ContactDetailsNotifier, ContactDetailsState, String>(
      ContactDetailsNotifier.new,
    );
