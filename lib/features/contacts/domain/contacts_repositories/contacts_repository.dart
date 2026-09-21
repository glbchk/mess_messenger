import 'package:mess_messenger_app/features/settings/data/models/user_model.dart';

abstract class ContactsRepository {
  Future<UserModel?> findUserByEmail(String email);
}
