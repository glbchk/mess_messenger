import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mess_messenger_app/core/constants/app_images.dart';
import 'package:mess_messenger_app/features/auth/auth_providers/auth_providers.dart';
import 'package:mess_messenger_app/features/auth/presentation/widgets/footer_row_widget.dart';
import 'package:mess_messenger_app/features/auth/presentation/widgets/logo_row_widget.dart';
import 'package:mess_messenger_app/theme/theme_extensions/theme_extension.dart';
import 'package:responsive_framework/responsive_framework.dart';

class AuthTabletAndDesktopLayout extends ConsumerWidget {
  final Widget formContent;
  final double formMaxWidth;

  const AuthTabletAndDesktopLayout({
    super.key,
    required this.formContent,
    required this.formMaxWidth,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colors = context.colors;
    final bp = ResponsiveBreakpoints.of(context);

    final imageWidth = bp.isTablet
        ? (bp.screenWidth * 0.3).clamp(280.0, 380.0)
        : bp.screenWidth * 0.5;

    return Scaffold(
      body: Row(
        children: [
          Expanded(
            child: Container(
              color: colors.surface0,
              child: Column(
                crossAxisAlignment: .start,
                children: [
                  LogoRowWidget(),
                  Expanded(
                    child: Center(
                      child: ConstrainedBox(
                        constraints: BoxConstraints(maxWidth: formMaxWidth),
                        child: formContent,
                      ),
                    ),
                  ),
                  FooterWidget(
                    onPressedChangeLanguage: ref
                        .read(authNotifierProvider.notifier)
                        .toggleLanguage,
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            width: imageWidth,
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
