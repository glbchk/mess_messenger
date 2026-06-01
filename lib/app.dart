import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mess_messenger_app/features/auth/presentation/pages/sign_up_page.dart';
import 'package:mess_messenger_app/features/auth/presentation/states/auth_state.dart';
import 'package:mess_messenger_app/features/auth/providers/auth_provider.dart';
import 'package:mess_messenger_app/features/chat/presentation/pages/home_page.dart';

///TODO: Here should be MyApp configuration for MaterialApp.router,
///theme, localization, router setup, global builders and global app configuration
class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authState = ref.watch(authProvider);

    return MaterialApp(
      home: authState is AuthAuthenticated
          ? const HomePage()
          : const SignUpPage(),
    );
  }
}
