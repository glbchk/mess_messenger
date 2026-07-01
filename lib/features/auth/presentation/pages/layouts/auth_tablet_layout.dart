import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mess_messenger_app/core/utils/colors/app_colors.dart';
import 'package:mess_messenger_app/theme/theme_extensions/theme_extension.dart';
import 'package:responsive_framework/responsive_framework.dart';

class AuthTabletLayout extends StatelessWidget {
  final Widget formContent;

  const AuthTabletLayout({super.key, required this.formContent});

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final textTheme = context.textStyles;
    final bp = ResponsiveBreakpoints.of(context);

    final sectionWidth = bp.isTablet
        ? bp.screenWidth * 0.35
        : bp.screenWidth * 0.5;

    return Scaffold(
      body: Row(
        children: [
          Expanded(
            child: Container(
              color: colors.surface0,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildLogoRow(colors, textTheme),
                  Expanded(
                    child: Center(
                      child: ConstrainedBox(
                        constraints: BoxConstraints(maxWidth: sectionWidth),
                        child: formContent,
                      ),
                    ),
                  ),
                  _buildFooter(colors, textTheme),
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
                  'assets/images/signup_image.png',
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

  Widget _buildLogoRow(AppColors colors, TextTheme textTheme) {
    return Row(
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 32.0, top: 32.0),
          child: Row(
            children: [
              SvgPicture.asset('assets/icons/mess_logo_light.svg', height: 34),
              const SizedBox(width: 10),
              Text(
                'Mess Messenger',
                style: textTheme.headlineLarge?.copyWith(color: colors.text1),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildFooter(AppColors colors, TextTheme textTheme) {
    return Container(
      height: 68,
      color: colors.surface0,
      padding: const EdgeInsets.only(top: 26, left: 32, bottom: 26),
      child: Text(
        '©Mess Messenger 2026',
        style: textTheme.bodyMedium?.copyWith(color: colors.text2),
      ),
    );
  }
}
