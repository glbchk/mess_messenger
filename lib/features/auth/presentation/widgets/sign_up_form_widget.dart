import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mess_messenger_app/core/constants/svg_icons.dart';
import 'package:mess_messenger_app/core/constants/textfields_ids.dart';
import 'package:mess_messenger_app/core/providers/ui_providers/textfield_provider.dart';
import 'package:mess_messenger_app/core/utils/spacing/app_spacing.dart';
import 'package:mess_messenger_app/core/widgets/mess_main_button.dart';
import 'package:mess_messenger_app/core/widgets/mess_password_field.dart';
import 'package:mess_messenger_app/core/widgets/mess_textfield.dart';
import 'package:mess_messenger_app/features/auth/presentation/pages/controllers/auth_controller.dart';
import 'package:mess_messenger_app/localization/l10n/app_localizations.dart';
import 'package:mess_messenger_app/theme/theme_extensions/theme_extension.dart';

class SignUpFormWidget extends ConsumerWidget {
  final AppLocalizations l10n;
  final TextEditingController nameController;
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final bool isRegisterMode;
  final bool isLoading;
  final String? nameError;
  final String? emailError;
  final String? passwordError;
  final bool? showPassword;
  final VoidCallback? onToggleIconShowPassword;
  final VoidCallback? onPressedGetStarted;
  final VoidCallback? onPressedSignUpWithGoogle;
  final VoidCallback? onPressedLogIn;

  const SignUpFormWidget({
    super.key,
    required this.l10n,
    required this.nameController,
    required this.emailController,
    required this.passwordController,
    required this.isRegisterMode,
    required this.isLoading,
    this.nameError,
    this.emailError,
    this.passwordError,
    this.showPassword = false,
    this.onToggleIconShowPassword,
    this.onPressedGetStarted,
    this.onPressedSignUpWithGoogle,
    this.onPressedLogIn,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colors = context.colors;
    final textTheme = context.textStyles;

    final nameSignUpStatus = ref.watch(
      textfieldStatusProvider(TextfieldIds.signUpName),
    );
    final emailSignUpStatus = ref.watch(
      textfieldStatusProvider(TextfieldIds.signUpEmail),
    );
    final passwordSignUpStatus = ref.watch(
      textfieldStatusProvider(TextfieldIds.signUpPassword),
    );

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: .start,
      children: [
        Text(
          l10n.signUp,
          style: context.textStyles.displayMedium?.copyWith(
            color: context.colors.text1,
          ),
        ),
        AppSpacing.p12.gapV,
        Text(
          l10n.startTrial,
          style: context.textStyles.bodyLarge?.copyWith(
            color: context.colors.text2,
          ),
        ),
        AppSpacing.p24.gapV,
        MessTextField(
          controller: nameController,
          label: l10n.nameLabel,
          hint: l10n.nameHint,
          error: nameSignUpStatus.message,
          onChanged: (value) => ref
              .read(authFormControllerProvider)
              .onNameChanged(value ?? '', TextfieldIds.signUpName),
        ),
        AppSpacing.p16.gapV,
        MessTextField(
          controller: emailController,
          label: l10n.emailLabel,
          hint: l10n.emailHint,
          error: emailSignUpStatus.message,
          onChanged: (value) => ref
              .read(authFormControllerProvider)
              .onEmailChanged(value ?? '', TextfieldIds.signUpEmail),
        ),
        AppSpacing.p16.gapV,
        MessPasswordField(
          controller: passwordController,
          showPassword: showPassword,
          label: l10n.passwordLabel,
          hint: l10n.passwordHint,
          error: passwordSignUpStatus.message,
          onSuffixIconTap: onToggleIconShowPassword,
          onChanged: (value) => ref
              .read(authFormControllerProvider)
              .onPasswordChanged(value ?? '', TextfieldIds.signUpPassword),
        ),
        AppSpacing.p24.gapV,
        SizedBox(
          width: double.infinity,
          child: isLoading
              ? const Center(child: CircularProgressIndicator())
              : MessMainButton(
                  label: l10n.getStarted,
                  onPressed: onPressedGetStarted,
                ),
        ),
        AppSpacing.p16.gapV,
        MessMainButton(
          label: l10n.signUpWithGoogle,
          onPressed: onPressedSignUpWithGoogle,
          backgroundColor: colors.surface2,
          textStyle: textTheme.labelLarge?.copyWith(color: colors.text1),
          prefixIconPath: SvgIcons.google,
        ),

        AppSpacing.p24.gapV,
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          spacing: AppSpacing.p4,
          children: [
            Text(
              l10n.alreadyHaveAnAccount,
              style: textTheme.bodyMedium?.copyWith(color: colors.text2),
            ),
            GestureDetector(
              onTap: onPressedLogIn,
              child: Text(
                l10n.logIn,
                style: textTheme.labelMedium?.copyWith(color: colors.link),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
