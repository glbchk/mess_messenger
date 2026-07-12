import 'package:flutter/material.dart';
import 'package:mess_messenger_app/core/constants/app_images.dart';
import 'package:mess_messenger_app/features/auth/presentation/pages/ui_helpers/footer_row_widget.dart';
import 'package:mess_messenger_app/features/auth/presentation/pages/ui_helpers/logo_row_widget.dart';
import 'package:mess_messenger_app/theme/theme_extensions/theme_extension.dart';
import 'package:responsive_framework/responsive_framework.dart';

class AuthDesktopLayout extends StatelessWidget {
  final Widget formContent;

  const AuthDesktopLayout({super.key, required this.formContent});

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final textTheme = context.textStyles;
    final bp = ResponsiveBreakpoints.of(context);

    final sectionWidth = bp.isDesktop
        ? bp.screenWidth * 0.25
        : bp.screenWidth * 0.35;

    return Scaffold(
      body: Row(
        children: [
          Expanded(
            child: Container(
              color: colors.surface0,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  buildLogoRow(colors, textTheme),
                  Expanded(
                    child: Center(
                      child: ConstrainedBox(
                        constraints: BoxConstraints(maxWidth: sectionWidth),
                        child: formContent,
                      ),
                    ),
                  ),
                  buildFooter(colors, textTheme),
                ],
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(0, 16, 16, 16),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(32),
                child: Image.asset(
                  AppImages.signUpPageImage,
                  fit: BoxFit.cover,
                  width: double.infinity,
                  height: double.infinity,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

//TODO: Need to add option to change language on the entrance in the app

// AppSpacing.p32.gapV,
// MessMainButton(
//   label: l10n.changeLanguage,
//   onPressed: () {
//     final currentLocale = ref.read(appLanguageProvider);
//     final nextLocale = currentLocale.languageCode == 'en'
//         ? const Locale('uk')
//         : const Locale('en');
//
//     ref.read(appLanguageProvider.notifier).changeLanguage(nextLocale);
//   },
// ),
