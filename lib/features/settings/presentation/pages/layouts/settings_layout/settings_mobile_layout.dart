import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mess_messenger_app/core/constants/svg_icons.dart';
import 'package:mess_messenger_app/core/widgets/dropdown_menu/dropdown_item_action_model.dart';
import 'package:mess_messenger_app/core/widgets/dropdown_menu/mess_icon_dropdown_button.dart';
import 'package:mess_messenger_app/features/settings/data/models/user_model.dart';
import 'package:mess_messenger_app/features/settings/presentation/pages/controllers/account_settings_controller.dart';
import 'package:mess_messenger_app/features/settings/presentation/pages/controllers/general_settings_controller.dart';
import 'package:mess_messenger_app/features/settings/presentation/pages/delegates/pinned_tab_bar_delegate.dart';
import 'package:mess_messenger_app/features/settings/presentation/pages/delegates/profile_header_delegate.dart';
import 'package:mess_messenger_app/features/settings/presentation/widgets/settings_tab_bar.dart';
import 'package:mess_messenger_app/features/settings/presentation/widgets/settings_tabs_widget.dart';
import 'package:mess_messenger_app/features/settings/user_providers/ui_providers/general_settings_ui_provider.dart';
import 'package:mess_messenger_app/localization/supported_locales.dart';
import 'package:mess_messenger_app/theme/theme_extensions/theme_extension.dart';

class SettingsMobileLayout extends StatefulWidget {
  final UserModel userData;
  final GeneralSettingsUiNotifier view;
  final TabController tabController;
  final VoidCallback onPressedChangeAvatar;
  final VoidCallback onPressedLogoutFromAllDevices;
  final VoidCallback onPressedContactSupport;
  final List<SupportedLanguage> languages;
  final GeneralSettingsController generalSettingsController;
  final VoidCallback onPressedArchiveAllMessages;
  final DateTime? selectedDate;
  final TextEditingController nameController;
  final MenuController birthdayController;
  final TextEditingController emailController;
  final TextEditingController currentPasswordController;
  final TextEditingController newPasswordController;
  final TextEditingController phoneNumberController;
  final AccountSettingsController accountSettingsController;

  const SettingsMobileLayout({
    super.key,
    required this.userData,
    required this.view,
    required this.tabController,
    required this.languages,
    required this.generalSettingsController,
    required this.onPressedArchiveAllMessages,
    required this.onPressedChangeAvatar,
    required this.onPressedLogoutFromAllDevices,
    required this.onPressedContactSupport,
    required this.selectedDate,
    required this.nameController,
    required this.birthdayController,
    required this.emailController,
    required this.currentPasswordController,
    required this.newPasswordController,
    required this.phoneNumberController,
    required this.accountSettingsController,
  });

  @override
  State<SettingsMobileLayout> createState() => _SettingsMobileLayoutState();
}

class _SettingsMobileLayoutState extends State<SettingsMobileLayout> {
  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final textTheme = context.textStyles;
    final topPadding = MediaQuery.paddingOf(context).top;

    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: colors.bg,
      body: NestedScrollView(
        physics: const BouncingScrollPhysics(),
        headerSliverBuilder: (context, innerBoxIsScrolled) => [
          SliverPersistentHeader(
            pinned: true,
            delegate: ProfileHeaderDelegate(
              topInset: topPadding,
              userData: widget.userData,
              textTheme: textTheme,
              colors: colors,
              onBack: () => context.pop(),
              actions: MessIconDropdownButton<DropdownItemAction>(
                svgAsset: SvgIcons.menuVert,
                isButtonFilled: true,
                borderWidth: 0,
                itemLabelBuilder: (item) => item.label,
                textColorBuilder: (item) => item.textColor,
                onItemTap: (item) => item.onTap(),
                items: [
                  DropdownItemAction(
                    label: 'Change avatar',
                    onTap: widget.onPressedChangeAvatar,
                  ),
                  DropdownItemAction(
                    label: 'Export account data',
                    onTap: () {},
                  ),
                  DropdownItemAction(
                    label: 'Active sessions',
                    onTap: widget.onPressedLogoutFromAllDevices,
                  ),
                  DropdownItemAction(
                    label: 'Contact support',
                    onTap: widget.onPressedContactSupport,
                  ),
                  DropdownItemAction(
                    label: 'Log out',
                    textColor: colors.errorColor,
                    onTap: () {},
                  ),
                ],
              ),
            ),
          ),
          SliverPersistentHeader(
            pinned: true,
            delegate: PinnedTabBarDelegate(
              height: 90,
              backgroundColor: colors.bg,
              shadowColor: const Color(0x14000000),
              child: SettingsTabsBar(tabController: widget.tabController),
            ),
          ),
        ],
        body: SettingsTabsWidget(
          tabController: widget.tabController,
          userData: widget.userData,
          view: widget.view,
          languages: widget.languages,
          generalSettingsController: widget.generalSettingsController,
          onPressedArchiveAllMessages: widget.onPressedArchiveAllMessages,
          selectedDate: widget.selectedDate,
          nameController: widget.nameController,
          birthdayController: widget.birthdayController,
          emailController: widget.emailController,
          currentPasswordController: widget.currentPasswordController,
          newPasswordController: widget.newPasswordController,
          phoneNumberController: widget.phoneNumberController,
          accountSettingsController: widget.accountSettingsController,
          onPressedChangeAvatar: () {},
          onPressedLogoutFromAllDevices: () {},
        ),
        // TabBarView(
        //   controller: widget.tabController,
        //
        //   children: [
        //     GeneralMobileTabWidget(
        //       userData: widget.userData,
        //       view: widget.view,
        //       generalSettingsController: widget.generalSettingsController,
        //       languages: widget.languages,
        //       onPressedArchiveAllMessages: widget.onPressedArchiveAllMessages,
        //     ),
        //     AccountMobileTabWidget(
        //       userData: widget.userData,
        //       accountSettingsController: widget.accountSettingsController,
        //       nameController: widget.nameController,
        //       birthdayController: widget.birthdayController,
        //       selectedDate: widget.selectedDate,
        //       emailFocusNode: FocusNode(),
        //       emailController: widget.emailController,
        //       currentPasswordController: widget.currentPasswordController,
        //       newPasswordController: widget.newPasswordController,
        //       phoneNumberController: widget.phoneNumberController,
        //     ),
        //     PersonalisationMobileTabWidget(userData: widget.userData),
        //     BillingMobileTabWidget(
        //       userData: widget.userData,
        //       onDownloadInvoices: (invoicesToDownload) {},
        //     ),
        //     NotificationMobileTabWidget(),
        //     ApiTabWidget(),
        //   ],
        // ),
      ),
    );
  }
}
