import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mess_messenger_app/features/chat/presentation/states/chats_state.dart';

class AuthNotifier extends Notifier<ChatsState> {
  @override
  ChatsState build() {
    // _checkAuthStatus()
    return ChatsState(isUserAuthenticated: true);
  }

  // Future<void> _checkAuthStatus() async {
  //   try {
  //     final isLoggedIn = await ref.read(isLoggedInUseCaseProvider).execute();
  //     if (isLoggedIn) {
  //       state = AuthAuthenticated();
  //     } else {
  //       final s = state;
  //       state = s is AuthUnauthenticated
  //           ? s
  //           : AuthUnauthenticated(isRegisterMode: true);
  //     }
  //   } catch (e) {
  //     state = AuthError(e.toString());
  //   }
  // }
}
