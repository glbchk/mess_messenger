import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mess_messenger_app/core/widgets/mess_main_button.dart';
import 'package:mess_messenger_app/core/widgets/mess_textfield.dart';

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
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Sign up', style: TextStyle(fontSize: 36)),
        const SizedBox(height: 12),
        Text('Start your 30-day free trial.', style: TextStyle(fontSize: 16)),
        const SizedBox(height: 24),
        MessTextField(
          controller: emailController,
          label: 'Name*',
          hint: 'Enter your name',
        ),
        // TextField(
        //   controller: emailController,
        //   decoration: InputDecoration(
        //     labelText: 'Email',
        //     errorText: emailError,
        //     border: const OutlineInputBorder(),
        //   ),
        // ),
        const SizedBox(height: 16),
        MessTextField(
          controller: emailController,
          label: 'Email address*',
          hint: 'Enter your email',
        ),
        const SizedBox(height: 16),
        MessTextField(
          controller: emailController,
          label: 'Password*',
          hint: 'Create a password',
          error: 'Some cool error',
        ),
        const SizedBox(height: 24),
        SizedBox(
          width: double.infinity,
          height: 48,
          child: isLoading
              ? const Center(child: CircularProgressIndicator())
              : MessMainButton(label: 'Get started', onPressed: onPressed),
        ),
        const SizedBox(height: 16),
        MessMainButton(label: 'Sign up with Google', onPressed: onPressed),

        const SizedBox(height: 16),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [Text('Already have an account?'), Text('Log in')],
        ),
      ],
    );
  }
}
