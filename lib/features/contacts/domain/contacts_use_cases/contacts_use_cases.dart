import 'package:mess_messenger_app/features/contacts/domain/contacts_repositories/contacts_repository.dart';
import 'package:mess_messenger_app/features/settings/data/models/user_model.dart';

abstract class ContactsUseCase {
  final ContactsRepository contactsRepository;

  ContactsUseCase(this.contactsRepository);
}

class FindUserByEmailDataUseCase extends ContactsUseCase {
  FindUserByEmailDataUseCase(super.contactsRepository);

  Future<UserModel?> execute(String email) {
    return contactsRepository.findUserByEmail(email);
  }
}
