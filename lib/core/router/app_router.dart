import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:mess_messenger_app/features/auth/auth_providers/auth_providers.dart';
import 'package:mess_messenger_app/features/auth/presentation/pages/auth_page.dart';
import 'package:mess_messenger_app/features/auth/presentation/states/auth_state.dart';
import 'package:mess_messenger_app/features/chats/presentation/pages/chats_page.dart';
import 'package:mess_messenger_app/features/contacts/presentation/pages/contacts_page.dart';
import 'package:mess_messenger_app/features/settings/presentation/pages/settings_page.dart';
import 'package:mess_messenger_app/features/settings/presentation/pages/support_page.dart';
import 'package:mess_messenger_app/features/ui_app_root/app_shell.dart';

class _AuthRefreshNotifier extends ChangeNotifier {
  _AuthRefreshNotifier(Ref ref) {
    ref.listen(authNotifierProvider, (_, __) => notifyListeners());
  }
}

final routerProvider = Provider<GoRouter>((ref) {
  final refreshNotifier = _AuthRefreshNotifier(ref);

  return GoRouter(
    initialLocation: '/',
    refreshListenable: refreshNotifier,
    redirect: (context, state) {
      final isAuthenticated =
          ref.read(authNotifierProvider) is AuthAuthenticated;
      final isOnLoginPage = state.matchedLocation == '/auth';

      if (!isAuthenticated && !isOnLoginPage) return '/auth';
      if (isAuthenticated && isOnLoginPage) return '/';
      return null;
    },
    routes: [
      GoRoute(path: '/auth', builder: (context, state) => const AuthPage()),
      // GoRoute(path: '/signup', builder: (context, state) => const AuthPage()),
      GoRoute(path: '/', redirect: (context, state) => '/chats'),
      StatefulShellRoute.indexedStack(
        builder: (context, state, navigationShell) =>
            AppShell(navigationShell: navigationShell),
        branches: [
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/chats',
                builder: (context, state) => const ChatsPage(),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/calls',
                builder: (context, state) =>
                    const Center(child: Text('Calls — coming soon')),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/contacts',
                builder: (context, state) => const ContactsPage(),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/settings',
                redirect: (context, state) => '/settings/general',
              ),
              GoRoute(
                path: '/settings/:tab',
                builder: (context, state) =>
                    SettingsPage(initialTab: state.pathParameters['tab']),
              ),
            ],
          ),
        ],
      ),
      GoRoute(
        path: '/support',
        builder: (context, state) => const SupportPage(),
      ),
    ],
  );
});
