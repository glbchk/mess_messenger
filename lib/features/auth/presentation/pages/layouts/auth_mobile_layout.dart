import 'package:flutter/material.dart';
import 'package:mess_messenger_app/core/constants/svg_icons.dart';
import 'package:mess_messenger_app/core/widgets/mess_icon.dart';
import 'package:mess_messenger_app/core/widgets/mess_icon_button.dart';
import 'package:mess_messenger_app/theme/theme_extensions/theme_extension.dart';

class AuthMobileLayout extends StatelessWidget {
  final Widget formContent;
  final PreferredSizeWidget? appBar;
  final VoidCallback onSignOutPressed;

  const AuthMobileLayout({
    super.key,
    required this.formContent,
    this.appBar,
    required this.onSignOutPressed,
  });

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final textTheme = context.textStyles;

    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: colors.surface0,
      appBar: AppBar(
        backgroundColor: colors.surface0,
        leading: Padding(
          padding: const EdgeInsets.only(left: 16),
          child: MessIcon(SvgIcons.logo, size: 40),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16),
            child: Container(
              height: 40,
              width: 40,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: colors.surface2,
              ),
              child: IconButton(
                onPressed: () => onSignOutPressed(),
                icon: const Icon(Icons.logout, color: Colors.red),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 16),
            child: Container(
              height: 40,
              width: 40,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: colors.surface2,
              ),
              child: MessIconButton(
                SvgIcons.menuVert,
                isButtonFilled: true,
                borderWidth: 0,
                onPressed: () {},
              ),
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            return SingleChildScrollView(
              child: ConstrainedBox(
                constraints: BoxConstraints(minHeight: constraints.maxHeight),
                child: IntrinsicHeight(
                  child: Column(
                    crossAxisAlignment: .start,
                    children: [
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 36),
                          child: Center(child: formContent),
                        ),
                      ),
                      Container(
                        height: 68,
                        color: colors.surface0,
                        padding: const EdgeInsets.only(
                          top: 26,
                          left: 20,
                          bottom: 26,
                        ),
                        child: Text(
                          '©Mess Messenger 2026',
                          style: textTheme.bodyMedium?.copyWith(
                            color: colors.text2,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
