import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mess_messenger_app/core/widgets/mobile_widgets/navigation_bar/mobile_navigation_bar.dart';
import 'package:mess_messenger_app/features/auth/auth_providers/auth_providers.dart';
import 'package:mess_messenger_app/features/auth/presentation/pages/auth_page.dart';
import 'package:mess_messenger_app/features/auth/presentation/states/auth_state.dart';
import 'package:mess_messenger_app/features/chats/presentation/pages/chats_page.dart';
import 'package:mess_messenger_app/features/contacts/presentation/pages/contacts_page.dart';
import 'package:mess_messenger_app/features/settings/presentation/pages/settings_page.dart';
import 'package:responsive_framework/responsive_framework.dart';

class AppShell extends ConsumerStatefulWidget {
  const AppShell({super.key});

  @override
  ConsumerState<AppShell> createState() => _AppShellState();
}

class _AppShellState extends ConsumerState<AppShell> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    print('DEBUG: AppShell is building');

    ref.listen<AuthState>(authProvider, (previous, next) {
      if (next is AuthUnauthenticated) {
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (_) => const AuthPage()),
          (route) => false,
        );
      }
    });

    final bp = ResponsiveBreakpoints.of(context);

    return Scaffold(
      body: IndexedStack(
        index: _selectedIndex,
        children: const [
          ChatsPage(), // index 0
          Center(child: Text('Calls — coming soon')),
          ContactsPage(), // index 3
          SettingsPage(),
        ],
      ),
      bottomNavigationBar: bp.isMobile
          ? MobileNavigationBar(
              selectedIndex: _selectedIndex,
              onItemTapped: (index) => setState(() => _selectedIndex = index),
            )
          : null,
    );
  }
}
