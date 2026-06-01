import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mess_messenger_app/features/auth/presentation/states/auth_state.dart';
import 'package:mess_messenger_app/features/auth/providers/auth_provider.dart';
import 'package:mess_messenger_app/features/chat/presentation/pages/home_page.dart';

class AuthPage extends ConsumerStatefulWidget {
  const AuthPage({super.key});

  @override
  ConsumerState<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends ConsumerState<AuthPage> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ref.listen<AuthState>(authProvider, (previous, next) {
      if (next is AuthAuthenticated) {
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (_) => const HomePage()),
          (route) => false,
        );
      }
      if (next is AuthUnauthenticated && next.errorMessage != null) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text(next.errorMessage!)));
        ref.read(authProvider.notifier).clearErrorMessage();
      }
    });

    final authState = ref.watch(authProvider);
    final isLoading = authState is AuthLoading;
    final unauthState = authState is AuthUnauthenticated ? authState : null;

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: _emailController,
              decoration: InputDecoration(
                labelText: 'Email',
                errorText: unauthState?.emailError,
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _passwordController,
              obscureText: true,
              decoration: InputDecoration(
                labelText: 'Password',
                errorText: unauthState?.passwordError,
              ),
            ),
            const SizedBox(height: 24),
            if (isLoading)
              const CircularProgressIndicator()
            else
              ElevatedButton(
                onPressed: () => ref
                    .read(authProvider.notifier)
                    .signUp(_emailController.text, _passwordController.text),
                child: const Text('Sign Up'),
              ),
          ],
        ),
      ),
    );
  }
}
