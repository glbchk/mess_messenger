import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AuthFormWidget extends ConsumerWidget {
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final bool isLoading;
  final String? emailError;
  final String? passwordError;
  final VoidCallback? onPressed;

  const AuthFormWidget({
    super.key,
    required this.emailController,
    required this.passwordController,
    required this.isLoading,
    this.emailError,
    this.passwordError,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          'Welcome Back',
          style: Theme.of(
            context,
          ).textTheme.headlineMedium?.copyWith(fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 32),
        TextField(
          controller: emailController,
          decoration: InputDecoration(
            labelText: 'Email',
            errorText: emailError,
            border: const OutlineInputBorder(),
          ),
        ),
        const SizedBox(height: 16),
        TextField(
          controller: passwordController,
          obscureText: true,
          decoration: InputDecoration(
            labelText: 'Password',
            errorText: passwordError,
            border: const OutlineInputBorder(),
          ),
        ),
        const SizedBox(height: 24),
        SizedBox(
          width: double.infinity,
          height: 48,
          child: isLoading
              ? const Center(child: CircularProgressIndicator())
              : ElevatedButton(
                  onPressed: onPressed,
                  child: const Text('Sign Up'),
                ),
        ),
      ],
    );
  }
}
