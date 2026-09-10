import 'package:flutter/material.dart';
import 'package:mess_messenger_app/core/constants/svg_icons.dart';
import 'package:mess_messenger_app/core/utils/spacing/app_spacing.dart';
import 'package:mess_messenger_app/core/widgets/mess_icon_button.dart';
import 'package:mess_messenger_app/theme/theme_extensions/theme_extension.dart';

class ChatsHeaderSectionWidget extends StatelessWidget {
  final String sectionTitle;
  final VoidCallback onPressed;

  const ChatsHeaderSectionWidget({
    super.key,
    required this.sectionTitle,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final textTheme = context.textStyles;

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: .start,
      children: [
        Container(
          margin: EdgeInsets.only(top: 16, bottom: 10),
          child: Row(
            children: [
              Center(
                child: MessIconButton(
                  SvgIcons.dropDownFold,
                  buttonSize: 30,
                  iconSize: 18,
                  borderWidth: 0,
                  onPressed: () {},
                ),
              ),
              AppSpacing.p8.gapH,
              Text(
                sectionTitle,
                style: textTheme.headlineMedium?.copyWith(color: colors.text1),
              ),
              const Spacer(),
              MessIconButton(
                SvgIcons.add,
                buttonSize: 30,
                iconSize: 18,
                borderWidth: 0,
                onPressed: onPressed,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
