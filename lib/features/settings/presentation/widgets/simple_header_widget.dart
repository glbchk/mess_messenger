import 'package:flutter/material.dart';
import 'package:mess_messenger_app/core/constants/svg_icons.dart';
import 'package:mess_messenger_app/core/widgets/mess_icon_button.dart';
import 'package:mess_messenger_app/core/widgets/mess_main_button.dart';
import 'package:mess_messenger_app/features/settings/data/models/user_model.dart';
import 'package:mess_messenger_app/theme/theme_extensions/theme_extension.dart';

class SimpleHeaderWidget extends StatelessWidget {
  final UserModel userData;
  final VoidCallback onPressed;
  final bool showBackButton;
  final VoidCallback? onBackButtonPressed;
  final VoidCallback? onPressedShowDetails;

  const SimpleHeaderWidget({
    super.key,
    required this.userData,
    required this.onPressed,
    this.showBackButton = false,
    this.onBackButtonPressed,
    this.onPressedShowDetails,
  });

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final textTheme = context.textStyles;

    return Container(
      height: 84,
      decoration: BoxDecoration(
        // color: Colors.red, //colors.transparent,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
        border: Border(bottom: BorderSide(color: colors.border2, width: 1.0)),
      ),

      child: Padding(
        padding: const EdgeInsets.only(left: 24, top: 24, right: 24),
        child: Row(
          crossAxisAlignment: .start,
          mainAxisAlignment: MainAxisAlignment.center,
          spacing: 12,
          children: [
            Text(
              'Support',
              style: textTheme.headlineLarge?.copyWith(color: colors.text1),
            ),
            Spacer(),
            // MessMainButton(label: 'Show details', onPressed: () {}),
            MessMainButton(
              label: 'Show details',
              height: 32,
              width: 136,
              backgroundColor: colors.bg,
              borderColor: colors.border2,
              textStyle: textTheme.labelMedium?.copyWith(color: colors.text1),
              onPressed: onPressedShowDetails,
            ),
            // DropdownMenuWidget(
            //   values: [],
            //   value: '',
            //   onChanged: (String value) {},
            // ),
            MessIconButton(
              isButtonFilled: true,
              buttonSize: 36,
              iconSize: 16,
              SvgIcons.menuHorizontal,
              onPressed: () {},
            ),
          ],
        ),
      ),
    );
  }
}
