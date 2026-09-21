import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:mess_messenger_app/core/router/app_routes.dart';
import 'package:mess_messenger_app/features/auth/auth_providers/auth_providers.dart';
import 'package:mess_messenger_app/features/auth/presentation/pages/auth_page.dart';
import 'package:mess_messenger_app/features/auth/presentation/states/auth_state.dart';
import 'package:mess_messenger_app/features/chats/presentation/pages/chats_page.dart';
import 'package:mess_messenger_app/features/chats/presentation/pages/mobile_open_chat_page.dart';
import 'package:mess_messenger_app/features/chats/presentation/pages/mobile_profile_details_page.dart';
import 'package:mess_messenger_app/features/chats/presentation/pages/user_search_page.dart';
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

  final _rootNavigatorKey = GlobalKey<NavigatorState>();

  return GoRouter(
    navigatorKey: _rootNavigatorKey,
    initialLocation: AppRoutes.root,
    refreshListenable: refreshNotifier,
    redirect: (context, state) {
      final isAuthenticated =
          ref.read(authNotifierProvider) is AuthAuthenticated;
      final isOnLoginPage = state.matchedLocation == AppRoutes.auth;

      if (!isAuthenticated && !isOnLoginPage) return AppRoutes.auth;
      if (isAuthenticated && isOnLoginPage) return AppRoutes.root;
      return null;
    },
    routes: [
      GoRoute(
        path: AppRoutes.auth,
        builder: (context, state) => const AuthPage(),
      ),
      GoRoute(path: '/', redirect: (context, state) => AppRoutes.chats),
      StatefulShellRoute.indexedStack(
        builder: (context, state, navigationShell) =>
            AppShell(navigationShell: navigationShell),
        branches: [
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: AppRoutes.chats,
                builder: (context, state) => const ChatsPage(),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: AppRoutes.calls,
                builder: (context, state) =>
                    const Center(child: Text('Calls — coming soon')),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: AppRoutes.contacts,
                builder: (context, state) => const ContactsPage(),
              ),
            ],
          ),
        ],
      ),
      GoRoute(
        path: AppRoutes.settings,
        redirect: (context, state) => AppRoutes.settingsGeneral,
      ),
      GoRoute(
        path: AppRoutes.settingsTab,
        builder: (context, state) =>
            SettingsPage(initialTab: state.pathParameters['tab']),
      ),
      GoRoute(
        path: AppRoutes.support,
        builder: (context, state) => const SupportPage(),
      ),
      GoRoute(
        path: AppRoutes.chats,
        builder: (c, s) => const ChatsPage(),
        routes: [
          GoRoute(
            path: ':chatId',
            parentNavigatorKey: _rootNavigatorKey,
            builder: (context, state) =>
                MobileOpenChatPage(chatId: state.pathParameters['chatId']!),
          ),
        ],
      ),
      GoRoute(
        path: AppRoutes.profileDetails,
        builder: (context, state) =>
            MobileProfileDetailsPage(chatId: state.pathParameters['chatId']!),
      ),
      GoRoute(
        path: AppRoutes.userSearch,
        parentNavigatorKey: _rootNavigatorKey,
        pageBuilder: (context, state) => CustomTransitionPage(
          key: state.pageKey,
          child: const UserSearchPage(),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return SlideTransition(
              position:
                  Tween<Offset>(
                    begin: const Offset(0, 1),
                    end: Offset.zero,
                  ).animate(
                    CurvedAnimation(
                      parent: animation,
                      curve: Curves.easeOutCubic,
                    ),
                  ),
              child: child,
            );
          },
        ),
      ),
    ],
  );
});
