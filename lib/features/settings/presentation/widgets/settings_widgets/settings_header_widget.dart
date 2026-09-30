import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:mess_messenger_app/core/constants/app_images.dart';
import 'package:mess_messenger_app/core/router/app_routes.dart';
import 'package:mess_messenger_app/core/utils/spacing/app_spacing.dart';
import 'package:mess_messenger_app/features/auth/auth_providers/auth_providers.dart';
import 'package:mess_messenger_app/features/settings/presentation/widgets/settings_user_data_panel_widget.dart';

class SettingsHeaderWidget extends ConsumerWidget {
  final VoidCallback onPressedChangeAvatar;

  const SettingsHeaderWidget({super.key, required this.onPressedChangeAvatar});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      children: [
        Container(
          height: 220,
          width: double.infinity,
          clipBehavior: .antiAlias,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(24),
              topRight: Radius.circular(24),
            ),
          ),
          child: Image.asset(AppImages.settingsHeader, fit: .cover),
        ),
        AppSpacing.p20.gapV,
        SettingsUserDataPanelWidget(
          onPressedChangeAvatar: onPressedChangeAvatar,
          onPressedExportAccountData: () {},
          onPressedContactSupport: () {
            context.push(AppRoutes.support);
          },
          onPressedLogout: () {
            ref.read(authNotifierProvider.notifier).logout();
          },
        ),
      ],
    );
  }
}
