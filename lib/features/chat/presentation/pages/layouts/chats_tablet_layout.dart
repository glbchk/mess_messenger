import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mess_messenger_app/core/utils/colors/app_colors.dart';
import 'package:mess_messenger_app/core/widgets/web_widgets/web_side_menu.dart';
import 'package:mess_messenger_app/theme/theme_extensions/theme_extension.dart';
import 'package:responsive_framework/responsive_framework.dart';

class ChatsTabletLayout extends StatelessWidget {
  // final Widget formContent;

  const ChatsTabletLayout({super.key});

  @override
  Widget build(BuildContext context) {
    bool isDarkMode = Theme.of(context).brightness == Brightness.dark;

    final colors = context.colors;
    final textTheme = context.textStyles;
    final bp = ResponsiveBreakpoints.of(context);

    final sectionWidth = bp.isDesktop
        ? bp.screenWidth * 0.25
        : bp.screenWidth * 0.35;

    return Scaffold(
      body: Row(
        children: [
          const WebSideMenu(),

          const VerticalDivider(width: 1, thickness: 1, color: Colors.black12),

          Expanded(
            child: Container(
              color: colors.surface0,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildLogoRow(isDarkMode, colors, textTheme),
                  Expanded(
                    child: Center(
                      child: ConstrainedBox(
                        constraints: BoxConstraints(maxWidth: sectionWidth),
                        child: Center(child: Text('Some content')),
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

  Widget _buildLogoRow(bool isDarkMode, AppColors colors, TextTheme textTheme) {
    return Row(
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 32.0, top: 32.0),
          child: Row(
            children: [
              SvgPicture.asset(
                isDarkMode
                    ? 'assets/icons/mess_logo_light.svg'
                    : 'assets/icons/mess_logo_dark.svg',
                height: 34,
              ),
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
