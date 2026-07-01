import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mess_messenger_app/core/utils/spacing/app_spacing.dart';
import 'package:mess_messenger_app/core/widgets/mess_textfield.dart';
import 'package:mess_messenger_app/core/widgets/web_widgets/web_side_menu.dart';
import 'package:mess_messenger_app/features/chat/presentation/widgets/chats_block_widget.dart';
import 'package:mess_messenger_app/features/chat/presentation/widgets/headline_widget.dart';
import 'package:mess_messenger_app/theme/theme_extensions/theme_extension.dart';
import 'package:responsive_framework/responsive_framework.dart';

class ChatsDesktopLayout extends StatelessWidget {
  // final Widget formContent;

  const ChatsDesktopLayout({super.key});

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
        crossAxisAlignment: CrossAxisAlignment.stretch, // 👈 fix overflow
        children: [
          const WebSideMenu(),

          // const VerticalDivider(width: 1, thickness: 1, color: Colors.black12),
          Container(
            width: sectionWidth,
            color: colors.surface0,
            child: Container(
              padding: EdgeInsets.only(left: 24, top: 12, right: 24),
              margin: EdgeInsets.all(20),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(20)),
                border: Border.all(width: 2, color: Colors.red),
                color: Colors.white,
              ),
              child: Column(
                children: [
                  HeadlineWidget(
                    title: 'Chats',
                    iconPath: 'assets/icons/add.svg',
                  ),
                  MessTextField(
                    height: 56,
                    hint: 'Search here...',
                    prefixIcon: SvgPicture.asset(
                      'assets/icons/search.svg',
                      height: 24,
                      width: 24,
                    ),
                  ),
                  AppSpacing.p12.gapV,

                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          ChatsBlockWidget(groupTitle: 'Groups'),
                          ChatsBlockWidget(groupTitle: 'Chat'),
                          Text('Some content'),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  'assets/images/empty_screen_logo.png',
                  // fit: BoxFit.fitHeight,
                  width: 300,
                  height: 300,
                ),
                AppSpacing.p20.gapV,
                Text(
                  'Messenger',
                  style: textTheme.headlineLarge?.copyWith(color: colors.text1),
                ),
                AppSpacing.p8.gapV,
                Text(
                  'Your personal messages are end-to-end \nencrypted.',
                  style: textTheme.bodyLarge?.copyWith(color: colors.text2),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
