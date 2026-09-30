import 'package:mess_messenger_app/features/contacts/data/data_sources/contacts_remote_data_source.dart';
import 'package:mess_messenger_app/features/contacts/domain/contacts_repositories/contacts_repository.dart';
import 'package:mess_messenger_app/features/settings/data/models/user_model.dart';

class ContactsRepositoryImpl implements ContactsRepository {
  final ContactsRemoteDataSource contactsRemoteDataSource;

  ContactsRepositoryImpl(this.contactsRemoteDataSource);

  @override
  Future<UserModel?> findUserByEmail(String email) async {
    return await contactsRemoteDataSource.findUserByEmail(email);
  }
}
