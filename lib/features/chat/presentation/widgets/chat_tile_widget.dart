import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mess_messenger_app/theme/theme_extensions/theme_extension.dart';

class ChatTileWidget extends ConsumerWidget {
  final String iconPath;
  final String? photoPath;
  final String title;
  final String subtitle;

  const ChatTileWidget({
    super.key,
    required this.iconPath,
    this.photoPath,
    required this.title,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colors = context.colors;
    final textTheme = context.textStyles;

    // final l10n = AppLocalizations.of(context)!;

    // bool isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return Container(
      // margin: EdgeInsets.symmetric(vertical: 12),
      color: Colors.transparent,
      height: 56,
      child: Row(
        spacing: 8,
        children: [
          Container(
            width: 32,
            height: 32,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(40)),
              color: colors.surface4,
            ),
            child: photoPath == null
                ? Center(
                    child: SvgPicture.asset(iconPath, height: 16, width: 16),
                  )
                : ClipRRect(
                    borderRadius: BorderRadius.circular(40),
                    child: Image.asset(photoPath ?? '', fit: BoxFit.cover),
                  ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            spacing: 1,
            children: [
              Text(
                title ?? 'After school',
                style: textTheme.bodyMedium?.copyWith(color: colors.text1),
              ),
              Text(
                subtitle ??
                    'Paul -  Come around at my house, I’m making food for two',
                style: textTheme.bodySmall?.copyWith(color: colors.text2),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
