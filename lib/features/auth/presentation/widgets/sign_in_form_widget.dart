import 'package:flutter/material.dart';
import 'package:mess_messenger_app/core/constants/svg_icons.dart';
import 'package:mess_messenger_app/core/utils/spacing/app_spacing.dart';
import 'package:mess_messenger_app/core/widgets/mess_icon.dart';
import 'package:mess_messenger_app/core/widgets/mess_main_button.dart';
import 'package:mess_messenger_app/core/widgets/mess_password_field.dart';
import 'package:mess_messenger_app/core/widgets/mess_textfield.dart';
import 'package:mess_messenger_app/localization/l10n/app_localizations.dart';
import 'package:mess_messenger_app/theme/theme_extensions/theme_extension.dart';

class SignInFormWidget extends StatelessWidget {
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final bool isRegisterMode;
  final bool isLoading;
  final String? emailError;
  final String? passwordError;
  final bool rememberMe;
  final VoidCallback? onToggleRememberMe;
  final bool? showPassword;
  final VoidCallback? onToggleIconShowPassword;
  final VoidCallback? onPressedForgotPassword;
  final VoidCallback? onPressedSignIn;
  final VoidCallback? onPressedSignInWithGoogle;
  final VoidCallback? onPressedSignUp;

  const SignInFormWidget({
    super.key,
    required this.emailController,
    required this.passwordController,
    required this.isRegisterMode,
    required this.isLoading,
    this.emailError,
    this.passwordError,
    this.rememberMe = true,
    this.onToggleRememberMe,
    this.showPassword = false,
    this.onToggleIconShowPassword,
    this.onPressedForgotPassword,
    this.onPressedSignIn,
    this.onPressedSignInWithGoogle,
    this.onPressedSignUp,
  });

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final textTheme = context.textStyles;

    final l10n = AppLocalizations.of(context)!;

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        MessIcon(SvgIcons.logo, size: 64),
        AppSpacing.p24.gapV,
        Text(
          l10n.signIn,
          style: context.textStyles.displayMedium?.copyWith(
            color: context.colors.text1,
          ),
        ),
        AppSpacing.p12.gapV,
        Text(
          l10n.welcomeBack,
          style: context.textStyles.bodyLarge?.copyWith(
            color: context.colors.text2,
          ),
        ),

        AppSpacing.p24.gapV,
        MessTextField(
          controller: emailController,
          label: l10n.emailLabel,
          hint: l10n.emailHint,
        ),
        AppSpacing.p16.gapV,
        MessPasswordField(
          controller: passwordController,
          showPassword: showPassword,
          label: l10n.passwordLabel,
          hint: l10n.passwordHint,
          error: 'Some cool error', //TODO: Replace with real error
          onSuffixIconTap: onToggleIconShowPassword,
        ),
        AppSpacing.p24.gapV,
        Row(
          children: [
            Row(
              children: [
                GestureDetector(
                  onTap: onToggleRememberMe,
                  child: MessIcon(
                    rememberMe ? SvgIcons.checkboxChecked : SvgIcons.checkbox,
                    size: 18,
                  ),
                ),
                AppSpacing.p8.gapH,
                Text(l10n.rememberFor30Days),
              ],
            ),
            Spacer(),
            GestureDetector(
              onTap: onPressedForgotPassword,
              child: Text(
                l10n.forgotPassword,
                style: textTheme.labelMedium?.copyWith(color: colors.link),
              ),
            ),
          ],
        ),
        AppSpacing.p24.gapV,
        SizedBox(
          width: double.infinity,
          child: isLoading
              ? const Center(child: CircularProgressIndicator())
              : MessMainButton(label: l10n.signIn, onPressed: onPressedSignIn),
        ),
        AppSpacing.p16.gapV,
        MessMainButton(
          label: l10n.signInWithGoogle,
          onPressed: onPressedSignInWithGoogle,
          backgroundColor: colors.surface2,
          textStyle: textTheme.labelLarge?.copyWith(color: colors.text1),
          iconPath: SvgIcons.google,
        ),

        AppSpacing.p24.gapV,
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          spacing: AppSpacing.p4,
          children: [
            Text(
              l10n.dontHaveAnAccount,
              style: textTheme.bodyMedium?.copyWith(color: colors.text2),
            ),
            GestureDetector(
              onTap: onPressedSignUp,
              child: Text(
                l10n.signUp,
                style: textTheme.labelMedium?.copyWith(color: colors.link),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
