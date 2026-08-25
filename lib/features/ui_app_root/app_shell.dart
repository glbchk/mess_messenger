import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:mess_messenger_app/core/providers/global_providers.dart';
import 'package:mess_messenger_app/core/widgets/mobile_widgets/navigation_bar/mobile_navigation_bar.dart';
import 'package:mess_messenger_app/features/chats/presentation/pages/chats_page.dart';
import 'package:mess_messenger_app/features/contacts/presentation/pages/contacts_page.dart';
import 'package:mess_messenger_app/features/settings/presentation/states/user_state.dart';
import 'package:mess_messenger_app/features/settings/user_providers/user_providers.dart';
import 'package:responsive_framework/responsive_framework.dart';

const _shellTabNames = ['chats', 'calls', 'contacts'];

class AppShell extends ConsumerStatefulWidget {
  final String initialTab;
  const AppShell({super.key, this.initialTab = 'chats'});

  @override
  ConsumerState<AppShell> createState() => _AppShellState();
}

class _AppShellState extends ConsumerState<AppShell>
    with WidgetsBindingObserver {
  late int _selectedIndex = _shellTabNames
      .indexOf(widget.initialTab)
      .clamp(0, _shellTabNames.length - 1);

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _syncLocaleFromUser(ref.read(userNotifierProvider));
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      final pendingEmail = ref
          .read(userNotifierProvider)
          .userData
          ?.pendingEmail;
      if (pendingEmail != null && pendingEmail.isNotEmpty) {
        ref.read(userNotifierProvider.notifier).checkEmailVerificationStatus();
      }
    }
  }

  void _onItemTapped(int index) {
    if (index == 3) {
      context.go('/settings');
    } else {
      context.go('/${_shellTabNames[index]}');
    }
  }

  void _syncLocaleFromUser(UserState userState) {
    final remoteLang = userState.userData?.generalSettings?.language;
    if (remoteLang != null && remoteLang.isNotEmpty) {
      final remoteLocale = Locale(remoteLang);
      if (ref.read(appLanguageProvider) != remoteLocale) {
        ref.read(appLanguageProvider.notifier).changeLanguage(remoteLocale);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    print('DEBUG: AppShell is building');

    ref.listen<UserState>(userNotifierProvider, (previous, next) {
      _syncLocaleFromUser(next);
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
