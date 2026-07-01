import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mess_messenger_app/core/utils/layouts/responsive_layout_wrapper.dart';
import 'package:mess_messenger_app/features/auth/presentation/pages/auth_page.dart';
import 'package:mess_messenger_app/features/auth/presentation/states/auth_state.dart';
import 'package:mess_messenger_app/features/auth/providers/auth_provider.dart';
import 'package:mess_messenger_app/features/chat/presentation/pages/layouts/chats_desktop_layout.dart';
import 'package:mess_messenger_app/features/chat/presentation/pages/layouts/chats_mobile_layout.dart';
import 'package:mess_messenger_app/features/chat/presentation/pages/layouts/chats_tablet_layout.dart';
import 'package:mess_messenger_app/theme/theme_extensions/theme_extension.dart';

class ChatsPage extends ConsumerStatefulWidget {
  const ChatsPage({super.key});

  @override
  ConsumerState<ChatsPage> createState() => _ChatsPageState();
}

class _ChatsPageState extends ConsumerState<ChatsPage> {
  int _selectedIndex = 1;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;

    ref.listen<AuthState>(authProvider, (previous, next) {
      if (next is AuthUnauthenticated) {
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (_) => const AuthPage()),
          (route) => false,
        );
      }
    });

    return ResponsiveLayout(
      mobile: ChatsMobileLayout(),
      tablet: ChatsTabletLayout(
        // formContent: isRegisterMode ? signUpForm : signInForm,
      ),
      desktop: ChatsDesktopLayout(
        // formContent: isRegisterMode ? signUpForm : signInForm,
      ),
    );

    // return Scaffold(
    //   backgroundColor: colors.bg,
    //   appBar: MessAppBar(
    //     resizeToAvoidBottomInset: false,
    //     showAppBarContent: false,
    //     title: 'Chats',
    //     actions: [
    //       IconButton(
    //         icon: const Icon(Icons.logout, color: Colors.red),
    //         onPressed: () => ref.read(authProvider.notifier).logout(),
    //       ),
    //     ],
    //     // actions: buildActionButtons(context, true),
    //   ),
    //
    //   // AppBar(
    //   //   title: const Text('Home'),
    //   //   actions: [
    //   //     IconButton(
    //   //       icon: const Icon(Icons.logout, color: Colors.red),
    //   //       onPressed: () => ref.read(authProvider.notifier).logout(),
    //   //     ),
    //   //   ],
    //   // ),
    //   body: const Center(child: Text('Welcome!')),
    //   bottomNavigationBar: MessNavigationBar(
    //     selectedIndex: _selectedIndex,
    //     onItemTapped: (index) => setState(() => _selectedIndex = index),
    //   ),
    // );
  }
}
