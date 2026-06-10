import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mess_messenger_app/core/utils/spacing/app_spacing.dart';
import 'package:mess_messenger_app/core/widgets/mess_main_button.dart';
import 'package:mess_messenger_app/core/widgets/mess_textfield.dart';
import 'package:mess_messenger_app/localization/l10n/app_localizations.dart';
import 'package:mess_messenger_app/localization/providers/app_language_notifier.dart';
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

    final l10n = AppLocalizations.of(context)!;

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
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
        ),
        AppSpacing.p16.gapV,
        MessTextField(
          controller: emailController,
          label: l10n.emailLabel,
          hint: l10n.emailHint,
        ),
        AppSpacing.p16.gapV,
        MessTextField(
          isPassword: true,
          controller: passwordController,
          label: l10n.passwordLabel,
          hint: l10n.passwordHint,
          error: 'Some cool error', //TODO: Replace with real error
        ),
        AppSpacing.p24.gapV,
        SizedBox(
          width: double.infinity,
          child: isLoading
              ? const Center(child: CircularProgressIndicator())
              : MessMainButton(label: l10n.getStarted, onPressed: onPressed),
        ),
        AppSpacing.p16.gapV,
        MessMainButton(
          label: l10n.signUpWithGoogle,
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
              l10n.alreadyHaveAnAccount,
              style: textTheme.bodyMedium?.copyWith(color: colors.text2),
            ),
            Text(
              l10n.logIn,
              style: textTheme.labelMedium?.copyWith(color: colors.link),
            ),
          ],
        ),
        AppSpacing.p32.gapV,
        MessMainButton(
          label: l10n.changeLanguage,
          onPressed: () {
            final currentLocale = ref.read(appLanguageProvider);
            final nextLocale = currentLocale.languageCode == 'en'
                ? const Locale('uk')
                : const Locale('en');

            ref.read(appLanguageProvider.notifier).changeLanguage(nextLocale);
          },
        ),
      ],
    );
  }
}
