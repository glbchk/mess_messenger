import 'package:flutter/material.dart';
import 'package:mess_messenger_app/core/constants/svg_icons.dart';
import 'package:mess_messenger_app/core/widgets/mess_icon.dart';
import 'package:mess_messenger_app/theme/theme_extensions/theme_extension.dart';

class ActionPillButton extends StatelessWidget {
  final VoidCallback onVideoTap;
  final VoidCallback onPhoneTap;

  const ActionPillButton({
    super.key,
    required this.onVideoTap,
    required this.onPhoneTap,
  });

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;

    return Material(
      color: colors.surface2,
      borderRadius: BorderRadius.circular(16),
      clipBehavior: .antiAlias,
      child: SizedBox(
        height: 44,
        child: Row(
          mainAxisSize: .min,
          children: [
            InkWell(
              onTap: onVideoTap,
              hoverColor: colors.surface4,
              splashColor: colors.surface4,
              child: SizedBox(
                width: 54,
                height: double.infinity,
                child: Center(child: MessIcon(SvgIcons.video, size: 20)),
              ),
            ),

            Container(
              width: 1,
              height: double.infinity,
              color: colors.surface4,
            ),

            InkWell(
              onTap: onPhoneTap,
              hoverColor: colors.surface4,
              splashColor: colors.surface4,
              child: SizedBox(
                width: 54,
                height: double.infinity,
                child: Center(child: MessIcon(SvgIcons.calls, size: 20)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
