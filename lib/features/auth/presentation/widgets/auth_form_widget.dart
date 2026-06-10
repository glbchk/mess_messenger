import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mess_messenger_app/core/utils/spacing/app_spacing.dart';
import 'package:mess_messenger_app/core/widgets/mess_main_button.dart';
import 'package:mess_messenger_app/core/widgets/mess_textfield.dart';
import 'package:mess_messenger_app/theme/theme_extensions/theme_extension.dart';

class AuthFormWidget extends ConsumerWidget {
  final TextEditingController nameController;
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final bool isLoading;
  final String? emailError;
  final String? passwordError;
  final VoidCallback? onPressed;

  const AuthFormWidget({
    super.key,
    required this.nameController,
    required this.emailController,
    required this.passwordController,
    required this.isLoading,
    this.emailError,
    this.passwordError,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colors = context.colors;
    final textTheme = context.textStyles;

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Sign up',
          style: context.textStyles.displayMedium?.copyWith(
            color: context.colors.text1,
          ),
        ),
        AppSpacing.p12.gapV,
        Text(
          'Start your 30-day free trial.',
          style: context.textStyles.bodyLarge?.copyWith(
            color: context.colors.text2,
          ),
        ),
        AppSpacing.p24.gapV,
        MessTextField(
          controller: nameController,
          label: 'Name*',
          hint: 'Enter your name',
        ),
        AppSpacing.p16.gapV,
        MessTextField(
          controller: emailController,
          label: 'Email address*',
          hint: 'Enter your email',
        ),
        AppSpacing.p16.gapV,
        MessTextField(
          isPassword: true,
          controller: passwordController,
          label: 'Password*',
          hint: 'Create a password',
          error: 'Some cool error',
        ),
        AppSpacing.p24.gapV,
        SizedBox(
          width: double.infinity,
          child: isLoading
              ? const Center(child: CircularProgressIndicator())
              : MessMainButton(label: 'Get started', onPressed: onPressed),
        ),
        AppSpacing.p16.gapV,
        MessMainButton(
          label: 'Sign up with Google',
          onPressed: onPressed,
          backgroundColor: colors.surface2,
          textStyle: textTheme.labelLarge?.copyWith(color: colors.text1),
          iconPath: 'assets/icons/colored/google.svg',
        ),

        AppSpacing.p16.gapV,
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          spacing: AppSpacing.p4,
          children: [
            Text(
              'Already have an account?',
              style: textTheme.bodyMedium?.copyWith(color: colors.text2),
            ),
            Text(
              'Log in',
              style: textTheme.labelMedium?.copyWith(color: colors.link),
            ),
          ],
        ),
      ],
    );
  }
}
