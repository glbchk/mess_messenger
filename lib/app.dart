import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mess_messenger_app/core/constants/app_icons.dart';
import 'package:mess_messenger_app/core/utils/colors/app_colors.dart';
import 'package:mess_messenger_app/core/utils/colors/app_palette.dart';
import 'package:mess_messenger_app/core/utils/font/app_typography.dart';
import 'package:mess_messenger_app/features/auth/presentation/pages/auth_page.dart';
import 'package:mess_messenger_app/features/auth/presentation/states/auth_state.dart';
import 'package:mess_messenger_app/features/auth/providers/auth_provider.dart';
import 'package:mess_messenger_app/features/chat/presentation/pages/chats_page.dart';
import 'package:mess_messenger_app/localization/l10n/app_localizations.dart';
import 'package:mess_messenger_app/theme/providers/theme_provider.dart';
import 'package:responsive_framework/responsive_framework.dart';

import 'localization/providers/app_language_notifier.dart';

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

    final appLocale = ref.watch(appLanguageProvider);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      themeMode: currentThemeMode,

      theme: ThemeData(
        brightness: Brightness.light,
        scaffoldBackgroundColor: AppPalette.surface0Light,
        extensions: [AppColors.light(), AppIcons.light()],
        textTheme: buildTextTheme(isDesktop: isDesktop),
      ),

      darkTheme: ThemeData(
        brightness: Brightness.dark,
        scaffoldBackgroundColor: AppPalette.surface0Dark,
        extensions: [AppColors.dark(), AppIcons.dark()],
        textTheme: buildTextTheme(isDesktop: isDesktop),
      ),
      locale: appLocale,
      supportedLocales: const [Locale('en', ''), Locale('uk', '')],
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],

      builder: (context, child) => ResponsiveBreakpoints.builder(
        child: child!,
        breakpoints: [
          const Breakpoint(start: 0, end: 649, name: MOBILE),
          const Breakpoint(start: 650, end: 1099, name: TABLET),
          const Breakpoint(start: 1100, end: double.infinity, name: DESKTOP),
        ],
      ),
      home: authState is AuthAuthenticated
          ? const ChatsPage()
          : const AuthPage(),
    );
  }
}
