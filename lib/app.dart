import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mess_messenger_app/core/utils/colors/app_colors.dart';
import 'package:mess_messenger_app/core/utils/colors/app_palette.dart';
import 'package:mess_messenger_app/core/utils/font/app_typography.dart';
import 'package:mess_messenger_app/features/auth/presentation/pages/sign_up_page.dart';
import 'package:mess_messenger_app/features/auth/presentation/states/auth_state.dart';
import 'package:mess_messenger_app/features/auth/providers/auth_provider.dart';
import 'package:mess_messenger_app/features/chat/presentation/pages/home_page.dart';
import 'package:mess_messenger_app/theme/providers/theme_provider.dart';

///TODO: Here should be MyApp configuration for MaterialApp.router,
///theme, localization, router setup, global builders and global app configuration
class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentThemeMode = ref.watch(appThemeProvider);
    final authState = ref.watch(authProvider);

    final windowSize = MediaQueryData.fromView(View.of(context)).size;
    final isDesktop = windowSize.width > 1100;

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      themeMode: currentThemeMode,

      theme: ThemeData(
        brightness: Brightness.light,
        scaffoldBackgroundColor: AppPalette.surface0Light,
        extensions: [AppColors.light()],
        textTheme: buildTextTheme(isDesktop: isDesktop),
      ),

      darkTheme: ThemeData(
        brightness: Brightness.dark,
        scaffoldBackgroundColor: AppPalette.surface0Dark,
        extensions: [AppColors.dark()],
        textTheme: buildTextTheme(isDesktop: isDesktop),
      ),

      home: authState is AuthAuthenticated
          ? const HomePage()
          : const SignUpPage(),
    );
  }
}
