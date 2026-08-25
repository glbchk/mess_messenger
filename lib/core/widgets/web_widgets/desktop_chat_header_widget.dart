import 'package:flutter/material.dart';
import 'package:mess_messenger_app/core/constants/svg_icons.dart';
import 'package:mess_messenger_app/core/widgets/mess_main_button.dart';
import 'package:mess_messenger_app/core/widgets/user_data_content_widget.dart';
import 'package:mess_messenger_app/core/widgets/web_widgets/web_ui_helpers/build_web_header_action_button.dart';
import 'package:mess_messenger_app/features/settings/data/models/user_model.dart';
import 'package:mess_messenger_app/theme/theme_extensions/theme_extension.dart';

class DesktopChatHeaderWidget extends StatelessWidget {
  final UserModel userData;
  final VoidCallback onPressed;
  final bool showBackButton;
  final VoidCallback? onBackButtonPressed;

  const DesktopChatHeaderWidget({
    super.key,
    required this.userData,
    required this.onPressed,
    this.showBackButton = false,
    this.onBackButtonPressed,
  });

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final textTheme = context.textStyles;

    return Container(
      height: 112,
      decoration: BoxDecoration(
        // color: Colors.red, //colors.transparent,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
        border: Border(bottom: BorderSide(color: colors.border2, width: 1.0)),
      ),

      child: Padding(
        padding: const EdgeInsets.only(left: 24, top: 24, right: 24),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            UserDataContentWidget(userData: userData),
            Spacer(),
            Row(
              spacing: 12,
              children: [
                buildWebHeaderActionButton(
                  context: context,
                  iconPath: SvgIcons.add,
                  onPressed: () {},
                ),
                buildWebHeaderActionButton(
                  context: context,
                  iconPath: SvgIcons.calls,
                  onPressed: () {},
                ),
                MessMainButton(
                  label: 'View Profile',
                  height: 32,
                  width: 126,
                  textStyle: textTheme.labelMedium?.copyWith(
                    color: colors.textInverse,
                  ),
                  onPressed: () {},
                ),
                buildWebHeaderActionButton(
                  context: context,
                  iconPath: SvgIcons.menuVert,
                  onPressed: () {},
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
