import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mess_messenger_app/core/widgets/web_widgets/side_menu/web_side_menu.dart';
import 'package:mess_messenger_app/features/settings/presentation/widgets/reusable/settings_tab_bar.dart';
import 'package:mess_messenger_app/features/settings/presentation/widgets/reusable/settings_tabs_widget.dart';
import 'package:mess_messenger_app/features/settings/presentation/widgets/settings_widgets/settings_header_widget.dart';
import 'package:mess_messenger_app/features/settings/presentation/widgets/settings_widgets/settings_profile_avatar_widget.dart';
import 'package:mess_messenger_app/theme/theme_extensions/theme_extension.dart';

class SettingsDesktopLayout extends ConsumerStatefulWidget {
  final TabController tabController;
  final VoidCallback onPressedChangeAvatar;
  final TextEditingController nameController;
  final MenuController birthdayController;
  final DateTime? selectedDate;
  final TextEditingController emailController;
  final TextEditingController currentPasswordController;
  final TextEditingController newPasswordController;
  final TextEditingController phoneNumberController;

  const SettingsDesktopLayout({
    super.key,
    required this.tabController,
    required this.onPressedChangeAvatar,
    required this.nameController,
    required this.birthdayController,
    required this.selectedDate,
    required this.emailController,
    required this.currentPasswordController,
    required this.newPasswordController,
    required this.phoneNumberController,
  });

  @override
  ConsumerState<SettingsDesktopLayout> createState() =>
      _SettingsDesktopLayoutState();
}

class _SettingsDesktopLayoutState extends ConsumerState<SettingsDesktopLayout> {
  @override
  Widget build(BuildContext context) {
    final colors = context.colors;

    return Scaffold(
      body: Row(
        crossAxisAlignment: .stretch,
        children: [
          WebSideMenu(),

          Expanded(
            child: Container(
              margin: const EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                color: colors.bg,
                borderRadius: BorderRadius.circular(24),
              ),
              child: Stack(
                children: [
                  Column(
                    crossAxisAlignment: .start,
                    children: [
                      SettingsHeaderWidget(
                        onPressedChangeAvatar: widget.onPressedChangeAvatar,
                      ),
                      SettingsTabsBar(tabController: widget.tabController),

                      Expanded(
                        child: SettingsTabsWidget(
                          tabController: widget.tabController,
                          selectedDate: widget.selectedDate,
                          nameController: widget.nameController,
                          birthdayController: widget.birthdayController,
                          emailController: widget.emailController,
                          currentPasswordController:
                              widget.currentPasswordController,
                          newPasswordController: widget.newPasswordController,
                          phoneNumberController: widget.phoneNumberController,
                        ),
                      ),
                    ],
                  ),

                  SettingsProfileAvatarWidget(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
