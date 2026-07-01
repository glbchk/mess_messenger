import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mess_messenger_app/core/utils/spacing/app_spacing.dart';
import 'package:mess_messenger_app/features/chat/presentation/widgets/chat_tile_widget.dart';
import 'package:mess_messenger_app/theme/theme_extensions/theme_extension.dart';

class ChatsBlockWidget extends ConsumerWidget {
  final String groupTitle;

  const ChatsBlockWidget({super.key, required this.groupTitle});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colors = context.colors;
    final textTheme = context.textStyles;

    // final l10n = AppLocalizations.of(context)!;
    //
    // bool isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: EdgeInsets.only(top: 16, bottom: 10),
          child: Row(
            children: [
              Center(
                child: SvgPicture.asset(
                  'assets/icons/arrow_drop_down.svg',
                  height: 18,
                  width: 18,
                ),
              ),
              AppSpacing.p8.gapH,
              Text(
                groupTitle,
                style: textTheme.headlineMedium?.copyWith(color: colors.text1),
              ),
              Spacer(),
              Center(
                child: SvgPicture.asset(
                  'assets/icons/add.svg',
                  height: 18,
                  width: 18,
                ),
              ),
            ],
          ),
        ),
        // AppSpacing.p24.gapV,
        ...List.generate(5, (index) {
          return ChatTileWidget(
            iconPath: 'assets/icons/folders.svg',
            title: 'Another content $index',
            subtitle: 'Another subtitle $index',
          );
        }),
      ],
    );
  }
}
