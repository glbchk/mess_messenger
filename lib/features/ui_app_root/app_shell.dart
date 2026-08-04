import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mess_messenger_app/core/widgets/mobile_widgets/navigation_bar/mobile_navigation_bar.dart';
import 'package:mess_messenger_app/features/auth/auth_providers/auth_providers.dart';
import 'package:mess_messenger_app/features/auth/presentation/pages/auth_page.dart';
import 'package:mess_messenger_app/features/auth/presentation/states/auth_state.dart';
import 'package:mess_messenger_app/features/chats/presentation/pages/chats_page.dart';
import 'package:mess_messenger_app/features/contacts/presentation/pages/contacts_page.dart';
import 'package:mess_messenger_app/features/settings/presentation/pages/settings_page.dart';
import 'package:mess_messenger_app/features/settings/user_providers/user_providers.dart';
import 'package:mess_messenger_app/providers/global_providers.dart';
import 'package:responsive_framework/responsive_framework.dart';

class AppShell extends ConsumerStatefulWidget {
  const AppShell({super.key});

  @override
  ConsumerState<AppShell> createState() => _AppShellState();
}

class _AppShellState extends ConsumerState<AppShell> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    if (index == 3) {
      Navigator.of(
        context,
      ).push(MaterialPageRoute(builder: (context) => const SettingsPage()));
    } else {
      setState(() {
        _selectedIndex = index;
      });
    }
  }

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

    ref.listen(userNotifierProvider, (previous, next) {
      final remoteLang = next.userData?.generalSettings?.language;
      if (remoteLang != null && remoteLang.isNotEmpty) {
        final remoteLocale = Locale(remoteLang);
        if (ref.read(appLanguageProvider) != remoteLocale) {
          ref.read(appLanguageProvider.notifier).changeLanguage(remoteLocale);
        }
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
          SizedBox.shrink(),
        ],
      ),
      bottomNavigationBar: bp.isMobile
          ? MobileNavigationBar(
              selectedIndex: _selectedIndex,
              onItemTapped: _onItemTapped,
            )
          : null,
    );
  }
}
