import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mess_messenger_app/core/constants/svg_icons.dart';
import 'package:mess_messenger_app/core/widgets/mess_icon.dart';
import 'package:mess_messenger_app/features/settings/data/models/user_model.dart';
import 'package:mess_messenger_app/features/settings/user_providers/data_providers/user_providers.dart';
import 'package:mess_messenger_app/theme/theme_extensions/theme_extension.dart';

class SettingsProfileAvatarWidget extends ConsumerWidget {
  const SettingsProfileAvatarWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colors = context.colors;
    final textTheme = context.textStyles;

    final userData =
        ref.watch(userNotifierProvider).userData ?? UserModel(id: '');

    return Positioned(
      left: 32,
      top: 116,
      child: Stack(
        clipBehavior: .none,
        children: [
          CircleAvatar(
            radius: 96,
            backgroundColor: colors.surface4,
            backgroundImage: (userData.avatarUrl?.isNotEmpty ?? false)
                ? NetworkImage(userData.avatarUrl!)
                : null,
            child: (userData.avatarUrl?.isNotEmpty ?? false)
                ? null
                : Text(
                    userData.name?.substring(0, 1) ?? '?',
                    style: textTheme.displayLarge?.copyWith(
                      color: colors.iconContrast,
                    ),
                  ),
          ),

          Positioned(
            right: 15,
            bottom: 15,
            child: Stack(
              children: [
                MessIcon(
                  SvgIcons.verifiedLabel,
                  color: colors.componentSpecific,
                  size: 32,
                ),
                MessIcon(
                  SvgIcons.verifiedCheckmark,
                  color: colors.bg,
                  size: 32,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
