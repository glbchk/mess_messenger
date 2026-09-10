import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:mess_messenger_app/core/enums/enums.dart';
import 'package:mess_messenger_app/core/providers/data_providers/global_providers.dart';
import 'package:mess_messenger_app/core/widgets/mobile_widgets/navigation_bar/mobile_navigation_bar.dart';
import 'package:mess_messenger_app/features/chats/chats_providers/open_chat_provider.dart';
import 'package:mess_messenger_app/features/settings/presentation/states/user_state.dart';
import 'package:mess_messenger_app/features/settings/user_providers/data_providers/user_providers.dart';
import 'package:responsive_framework/responsive_framework.dart';

class AppShell extends ConsumerStatefulWidget {
  final StatefulNavigationShell navigationShell;
  const AppShell({super.key, required this.navigationShell});

  @override
  ConsumerState<AppShell> createState() => _AppShellState();
}

class _AppShellState extends ConsumerState<AppShell>
    with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _syncLocaleFromUser(ref.read(userNotifierProvider));

    // //TODO: For testing only, must be deleted
    // if (kDebugMode) {
    //   Future(
    //     () => seedUsers(FirebaseFirestore.instance),
    //   ).catchError((e) => debugPrint('seedUsers failed: $e'));
    // }
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _setOnline(false);
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

    _setOnline(state == AppLifecycleState.resumed);
  }

  void _setOnline(bool isOnline) {
    final userId = ref.read(userNotifierProvider).userData?.id;
    if (userId == null) return;
    ref
        .read(chatsRemoteDataSourceProvider)
        .setUserOnlineStatus(userId, isOnline);
  }

  void _onItemTapped(int index) {
    final tab = ShellTab.values[index];
    if (tab.isPushed) {
      context.push('/${tab.name}');
    } else {
      widget.navigationShell.goBranch(index);
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
      if (previous?.userData?.id == null && next.userData?.id != null) {
        _setOnline(true);
      }
    });

    final bp = ResponsiveBreakpoints.of(context);

    return Scaffold(
      body: widget.navigationShell,
      bottomNavigationBar: bp.isMobile
          ? MobileNavigationBar(
              selectedIndex: widget.navigationShell.currentIndex,
              onItemTapped: _onItemTapped,
            )
          : null,
    );
  }
}
