import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mess_messenger_app/features/contacts/presentation/states/contact_details_state.dart';

class ContactDetailsNotifier extends Notifier<ContactDetailsState> {
  ContactDetailsNotifier(this.userId);
  final String userId;

  @override
  ContactDetailsState build() {
    Future.microtask(_load);
    return const ContactDetailsState(isLoading: true);
  }

  Future<void> _load() async {
    try {
      // final files = await
      // ref.read(getSharedFilesUseCaseProvider).execute(userId);
      state = state.copyWith(
        isLoading: false,
        files: const [
          'Unknown-attachment.pdf',
          'Resume-2024.doc',
          'Financial-sheet.csv',
        ],
      );
    } catch (e) {
      state = state.copyWith(isLoading: false, error: e.toString());
    }
  }

  Future<void> openFile(String file) async {}
  Future<void> openLink(String url) async {}
}
