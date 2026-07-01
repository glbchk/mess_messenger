import 'package:flutter/material.dart';
import 'package:mess_messenger_app/core/widgets/mobile_widgets/app_bar/mess_app_bar.dart';
import 'package:mess_messenger_app/core/widgets/mobile_widgets/mess_navigation_bar.dart';
import 'package:mess_messenger_app/theme/theme_extensions/theme_extension.dart';

class ChatsMobileLayout extends StatelessWidget {
  // final Widget formContent;

  const ChatsMobileLayout({super.key});

  @override
  Widget build(BuildContext context) {
    int _selectedIndex = 1;

    bool isDarkMode = Theme.of(context).brightness == Brightness.dark;

    final colors = context.colors;
    final textTheme = context.textStyles;

    return Scaffold(
      backgroundColor: colors.bg,
      appBar: MessAppBar(
        resizeToAvoidBottomInset: false,
        showAppBarContent: false,
        title: 'Chats',
        actions: [
          IconButton(
            icon: const Icon(Icons.logout, color: Colors.red),
            onPressed: () => {}, //ref.read(authProvider.notifier).logout(),
          ),
        ],
      ),

      body: const Center(child: Text('Welcome!')),
      bottomNavigationBar: MessNavigationBar(
        selectedIndex: _selectedIndex,
        onItemTapped: (index) => (), //setState(() => _selectedIndex = index),
      ),
    );
  }
}
