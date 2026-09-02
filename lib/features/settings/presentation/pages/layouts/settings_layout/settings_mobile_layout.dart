import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mess_messenger_app/core/constants/svg_icons.dart';
import 'package:mess_messenger_app/core/widgets/dropdown_menu/dropdown_item_action_model.dart';
import 'package:mess_messenger_app/core/widgets/dropdown_menu/mess_icon_dropdown_button.dart';
import 'package:mess_messenger_app/features/settings/data/models/user_model.dart';
import 'package:mess_messenger_app/features/settings/presentation/pages/controllers/account_settings_controller.dart';
import 'package:mess_messenger_app/features/settings/presentation/pages/controllers/general_settings_controller.dart';
import 'package:mess_messenger_app/features/settings/presentation/pages/layouts/settings_layout/account_tab/account_mobile_tab_widget.dart';
import 'package:mess_messenger_app/features/settings/presentation/pages/layouts/settings_layout/api_tab/api_tab_widget.dart';
import 'package:mess_messenger_app/features/settings/presentation/pages/layouts/settings_layout/billing_tab/billing_mobile_tab_widget.dart';
import 'package:mess_messenger_app/features/settings/presentation/pages/layouts/settings_layout/general_tab/general_mobile_tab_widget.dart';
import 'package:mess_messenger_app/features/settings/presentation/pages/layouts/settings_layout/notification_tab/notification_mobile_tab_widget.dart';
import 'package:mess_messenger_app/features/settings/presentation/pages/layouts/settings_layout/personalization_tab/personalisation_mobile_tab_widget.dart';
import 'package:mess_messenger_app/features/settings/presentation/pages/ui_helpers/profile_header_delegate.dart';
import 'package:mess_messenger_app/features/settings/presentation/widgets/pinned_tab_bar_delegate.dart';
import 'package:mess_messenger_app/features/settings/user_providers/general_settings_ui_provider.dart';
import 'package:mess_messenger_app/localization/l10n/app_localizations.dart';
import 'package:mess_messenger_app/localization/supported_locales.dart';
import 'package:mess_messenger_app/theme/theme_extensions/theme_extension.dart';

class SettingsMobileLayout extends StatefulWidget {
  final AppLocalizations l10n;
  final UserModel userData;
  final GeneralSettingsUiNotifier view;
  final TabController tabController;
  final VoidCallback onPressedChangeAvatar;
  final VoidCallback onPressedLogoutFromAllDevices;
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
    required this.l10n,
    required this.userData,
    required this.view,
    required this.tabController,
    required this.languages,
    required this.generalSettingsController,
    required this.onPressedArchiveAllMessages,
    required this.selectedDate,
    required this.nameController,
    required this.birthdayController,
    required this.emailController,
    required this.currentPasswordController,
    required this.newPasswordController,
    required this.phoneNumberController,
    required this.accountSettingsController,
    required this.onPressedChangeAvatar,
    required this.onPressedLogoutFromAllDevices,
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
                    onTap: () => context.push('/support'),
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
              height: 64,
              backgroundColor: colors.bg,
              shadowColor: const Color(0x14000000),
              child: Container(
                margin: const EdgeInsets.only(
                  bottom: 16.0,
                  left: 16.0,
                  top: 16.0,
                ),
                child: TabBar(
                  controller: widget.tabController,
                  isScrollable: true,
                  labelPadding: const EdgeInsets.symmetric(horizontal: 8),
                  tabAlignment: TabAlignment.start,
                  dividerColor: colors.transparent,
                  indicatorSize: TabBarIndicatorSize.label,
                  indicator: BoxDecoration(
                    color: colors.textInverse,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  labelColor: colors.text2,
                  unselectedLabelColor: colors.text2,
                  labelStyle: textTheme.titleMedium,
                  overlayColor: const WidgetStatePropertyAll(
                    Colors.transparent,
                  ),
                  splashFactory: NoSplash.splashFactory,
                  tabs: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 18),
                      child: Tab(text: widget.l10n.general),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 18),
                      child: Tab(text: widget.l10n.account),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 18),
                      child: Tab(text: widget.l10n.personalisation),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 18),
                      child: Tab(text: widget.l10n.billing),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 18),
                      child: Tab(text: widget.l10n.notification),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 18),
                      child: Tab(text: widget.l10n.api),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
        body: TabBarView(
          controller: widget.tabController,

          children: [
            GeneralMobileTabWidget(
              l10n: widget.l10n,
              userData: widget.userData,
              view: widget.view,
              generalSettingsController: widget.generalSettingsController,
              languages: widget.languages,
              onPressedArchiveAllMessages: widget.onPressedArchiveAllMessages,
            ),
            AccountMobileTabWidget(
              l10n: widget.l10n,
              userData: widget.userData,
              accountSettingsController: widget.accountSettingsController,
              nameController: widget.nameController,
              birthdayController: widget.birthdayController,
              selectedDate: widget.selectedDate,
              emailFocusNode: FocusNode(),
              emailController: widget.emailController,
              currentPasswordController: widget.currentPasswordController,
              newPasswordController: widget.newPasswordController,
              phoneNumberController: widget.phoneNumberController,
            ),
            PersonalisationMobileTabWidget(
              l10n: widget.l10n,
              userData: widget.userData,
            ),
            BillingMobileTabWidget(
              l10n: widget.l10n,
              userData: widget.userData,
              onDownloadInvoices: (invoicesToDownload) {},
            ),
            NotificationMobileTabWidget(),
            ApiTabWidget(),
          ],
        ),
      ),
    );
  }
}
