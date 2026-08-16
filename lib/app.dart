import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mess_messenger_app/core/utils/colors/app_colors.dart';
import 'package:mess_messenger_app/core/utils/colors/app_palette.dart';
import 'package:mess_messenger_app/core/utils/font/app_typography.dart';
import 'package:mess_messenger_app/features/auth/auth_providers/auth_providers.dart';
import 'package:mess_messenger_app/features/auth/presentation/pages/auth_page.dart';
import 'package:mess_messenger_app/features/auth/presentation/states/auth_state.dart';
import 'package:mess_messenger_app/features/settings/presentation/pages/confirm_email_page.dart';
import 'package:mess_messenger_app/features/settings/user_providers/user_providers.dart';
import 'package:mess_messenger_app/features/ui_app_root/app_shell.dart';
import 'package:mess_messenger_app/localization/l10n/app_localizations.dart';
import 'package:mess_messenger_app/localization/localization_service.dart';
import 'package:mess_messenger_app/providers/global_providers.dart';
import 'package:mess_messenger_app/theme/providers/theme_provider.dart';
import 'package:responsive_framework/responsive_framework.dart';

///TODO: Here should be MyApp configuration for MaterialApp.router,
///theme, localization, router setup, global builders and global app configuration
enum AppPhase {
  unauthenticated,
  loadingUser,
  needsEmailConfirmation,
  authenticated,
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentThemeMode = ref.watch(appThemeProvider);
    final authState = ref.watch(authNotifierProvider);
    final userData = ref.watch(userNotifierProvider).userData;

    final windowSize = MediaQueryData.fromView(View.of(context)).size;
    final isDesktop = windowSize.width > 1100;

    final appLocale = ref.watch(appLanguageProvider);

    final AppPhase phase;
    if (authState is! AuthAuthenticated) {
      phase = AppPhase.unauthenticated;
    } else if (userData == null) {
      phase = AppPhase.loadingUser;
    } else if (userData.isEmailVerified == false) {
      phase = AppPhase.needsEmailConfirmation;
    } else {
      phase = AppPhase.authenticated;
    }

    final Widget home = switch (phase) {
      AppPhase.unauthenticated => const AuthPage(),
      AppPhase.loadingUser => const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      ),
      AppPhase.needsEmailConfirmation => const ConfirmEmailPage(),
      AppPhase.authenticated => const AppShell(),
    };

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      themeMode: currentThemeMode,
      scrollBehavior: MyScrollBehavior(),

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
      locale: appLocale,
      supportedLocales: LocalizationService.supportedCodes
          .map((code) => Locale(code, ''))
          .toList(),
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
      home: Navigator(
        key: ValueKey(phase), // only THIS Navigator resets on phase change
        onGenerateRoute: (settings) => MaterialPageRoute(builder: (_) => home),
      ),
    );
  }
}

class MyScrollBehavior extends MaterialScrollBehavior {
  @override
  Set<PointerDeviceKind> get dragDevices => {
    PointerDeviceKind.touch,
    PointerDeviceKind.mouse,
    PointerDeviceKind.trackpad,
    PointerDeviceKind.stylus,
  };
}
