import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mess_messenger_app/features/settings/presentation/pages/delegates/pinned_tab_bar_delegate.dart';
import 'package:mess_messenger_app/features/settings/presentation/widgets/reusable/settings_tab_bar.dart';
import 'package:mess_messenger_app/features/settings/presentation/widgets/reusable/settings_tabs_widget.dart';
import 'package:mess_messenger_app/features/settings/presentation/widgets/settings_widgets/settings_foldable_bar.dart';
import 'package:mess_messenger_app/theme/theme_extensions/theme_extension.dart';

class SettingsMobileLayout extends ConsumerStatefulWidget {
  final TabController tabController;
  final VoidCallback onPressedChangeAvatar;
  final VoidCallback onPressedContactSupport;
  final DateTime? selectedDate;
  final TextEditingController nameController;
  final MenuController birthdayController;
  final TextEditingController emailController;
  final TextEditingController currentPasswordController;
  final TextEditingController newPasswordController;
  final TextEditingController phoneNumberController;

  const SettingsMobileLayout({
    super.key,
    required this.tabController,
    required this.onPressedChangeAvatar,
    required this.onPressedContactSupport,
    required this.selectedDate,
    required this.nameController,
    required this.birthdayController,
    required this.emailController,
    required this.currentPasswordController,
    required this.newPasswordController,
    required this.phoneNumberController,
  });

  @override
  ConsumerState<SettingsMobileLayout> createState() =>
      _SettingsMobileLayoutState();
}

class _SettingsMobileLayoutState extends ConsumerState<SettingsMobileLayout> {
  @override
  Widget build(BuildContext context) {
    final colors = context.colors;

    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: colors.bg,
      body: SettingsFoldableBar(
        header: SliverPersistentHeader(
          pinned: true,
          delegate: PinnedTabBarDelegate(
            height: 90,
            backgroundColor: colors.bg,
            shadowColor: const Color(0x14000000),
            child: SettingsTabsBar(tabController: widget.tabController),
          ),
        ),
        onPressedChangeAvatar: widget.onPressedChangeAvatar,
        onPressedContactSupport: widget.onPressedContactSupport,
        body: SettingsTabsWidget(
          tabController: widget.tabController,
          selectedDate: widget.selectedDate,
          nameController: widget.nameController,
          birthdayController: widget.birthdayController,
          emailController: widget.emailController,
          currentPasswordController: widget.currentPasswordController,
          newPasswordController: widget.newPasswordController,
          phoneNumberController: widget.phoneNumberController,
        ),
      ),
    );
  }
}
