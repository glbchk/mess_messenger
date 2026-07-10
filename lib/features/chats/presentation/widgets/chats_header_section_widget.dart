import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mess_messenger_app/core/constants/svg_icons.dart';
import 'package:mess_messenger_app/core/utils/spacing/app_spacing.dart';
import 'package:mess_messenger_app/core/widgets/mess_icon.dart';
import 'package:mess_messenger_app/theme/theme_extensions/theme_extension.dart';

class ChatsHeaderSectionWidget extends ConsumerWidget {
  final String sectionTitle;
  final VoidCallback onPressed;

  const ChatsHeaderSectionWidget({
    super.key,
    required this.sectionTitle,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colors = context.colors;
    final textTheme = context.textStyles;

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: EdgeInsets.only(top: 16, bottom: 10),
          child: Row(
            children: [
              const Center(child: MessIcon(SvgIcons.dropDownFold, size: 18)),
              AppSpacing.p8.gapH,
              Text(
                sectionTitle,
                style: textTheme.headlineMedium?.copyWith(color: colors.text1),
              ),
              const Spacer(),
              IconButton(
                icon: MessIcon(SvgIcons.add, size: 18),
                onPressed: onPressed,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
