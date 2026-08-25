import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mess_messenger_app/core/constants/svg_icons.dart';
import 'package:mess_messenger_app/core/utils/spacing/app_spacing.dart';
import 'package:mess_messenger_app/core/widgets/dropdown_menu/dropdown_item_action_model.dart';
import 'package:mess_messenger_app/core/widgets/dropdown_menu/mess_icon_dropdown_button.dart';
import 'package:mess_messenger_app/core/widgets/mess_icon.dart';
import 'package:mess_messenger_app/core/widgets/mobile_widgets/app_bar/mobile_app_bar.dart';
import 'package:mess_messenger_app/features/settings/data/models/user_model.dart';
import 'package:mess_messenger_app/features/settings/presentation/pages/layouts/account_tab/account_mobile_tab_widget.dart';
import 'package:mess_messenger_app/features/settings/presentation/pages/layouts/api_tab/api_tab_widget.dart';
import 'package:mess_messenger_app/features/settings/presentation/pages/layouts/billing_tab/billing_mobile_tab_widget.dart';
import 'package:mess_messenger_app/features/settings/presentation/pages/layouts/general_tab/general_mobile_tab_widget.dart';
import 'package:mess_messenger_app/features/settings/presentation/pages/layouts/notification_tab/notification_mobile_tab_widget.dart';
import 'package:mess_messenger_app/features/settings/presentation/pages/layouts/personalization_tab/personalisation_mobile_tab_widget.dart';
import 'package:mess_messenger_app/localization/l10n/app_localizations.dart';
import 'package:mess_messenger_app/theme/theme_extensions/theme_extension.dart';

class SettingsMobileLayout extends ConsumerStatefulWidget {
  final AppLocalizations l10n;
  final UserModel userData;
  final Future<void> Function() onPressed;
  final TabController tabController;
  final TextEditingController nameController;
  final MenuController birthdayController;
  final DateTime? selectedDate;
  final TextEditingController emailController;
  final TextEditingController phoneNumberController;
  final TextEditingController currentPasswordController;
  final TextEditingController newPasswordController;

  const SettingsMobileLayout({
    super.key,
    required this.l10n,
    required this.userData,
    required this.onPressed,
    required this.tabController,
    required this.nameController,
    required this.birthdayController,
    required this.selectedDate,
    required this.emailController,
    required this.phoneNumberController,
    required this.currentPasswordController,
    required this.newPasswordController,
  });

  @override
  ConsumerState<SettingsMobileLayout> createState() =>
      _SettingsMobileLayoutState();
}

class _SettingsMobileLayoutState extends ConsumerState<SettingsMobileLayout> {
  void _confirmDeleteAccount() {
    print('DEBUG: delete account');
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final textTheme = context.textStyles;

    return Scaffold(
      extendBodyBehindAppBar: true,
      resizeToAvoidBottomInset: true,
      appBar: MobileAppBar(
        appBarBackgroundColor: colors.transparent,
        showAppBarContent: false,
        showBackButton: true,
        onPressedBack: () {
          Navigator.of(context).pop();
        },
        actions: [
          MessIconDropdownButton<DropdownItemAction>(
            svgAsset: SvgIcons.menuVert,
            isButtonFilled: true,
            borderWidth: 0,
            itemLabelBuilder: (item) => item.label,
            textColorBuilder: (item) => item.textColor,
            onItemTap: (item) => item.onTap(),
            items: [
              DropdownItemAction(label: 'Change avatar', onTap: () {}),
              DropdownItemAction(label: 'Export account data', onTap: () {}),
              DropdownItemAction(label: 'Active sessions', onTap: () {}),
              DropdownItemAction(label: 'Contact support', onTap: () {}),
              DropdownItemAction(
                label: 'Delete account',
                textColor: colors.errorColor,
                onTap: () => _confirmDeleteAccount(),
              ),
            ],

            // isButtonFilled: true,
            // borderWidth: 0,
            // // textColorBuilder: (item) {
            // //   if (item == 'Delete account') {
            // //     return colors.errorColor;
            // //   }
            // //   return null;
            // // },
          ),
          AppSpacing.p16.gapH,
        ],
      ),
      body: Container(
        color: colors.bg,
        child: Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header Image Banner
                SizedBox(
                  height: 220,
                  width: double.infinity,
                  child: Image.asset(
                    'assets/images/settings_header.png',
                    fit: BoxFit.cover,
                  ),
                ),
                AppSpacing.p64.gapV,

                // User Details
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.userData.name ?? 'Sylvia Reyes',
                        style: textTheme.displaySmall?.copyWith(
                          color: colors.text1,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        widget.userData.phoneNumber ?? '+44656548060',
                        style: textTheme.headlineMedium?.copyWith(
                          color: colors.text2,
                        ),
                      ),
                    ],
                  ),
                ),

                // Tab Navigation Bar
                Container(
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
                        padding: EdgeInsets.symmetric(horizontal: 18),
                        child: Tab(text: widget.l10n.general),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 18),
                        child: Tab(text: widget.l10n.account),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 18),
                        child: Tab(text: widget.l10n.personalisation),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 18),
                        child: Tab(text: widget.l10n.billing),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 18),
                        child: Tab(text: widget.l10n.notification),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 18),
                        child: Tab(text: widget.l10n.api),
                      ),
                    ],
                  ),
                ),

                // 💡 The magic happens here!
                // We wrap the TabBarView in an Expanded so it takes up the remaining screen height.
                Expanded(
                  child: TabBarView(
                    controller: widget.tabController,
                    children: [
                      // Tab 1: General (Uses our clean helper layout function below)
                      GeneralMobileTabWidget(
                        l10n: widget.l10n,
                        userData: widget.userData,
                      ),

                      // Tab 2: Account
                      AccountMobileTabWidget(
                        l10n: widget.l10n,
                        userData: widget.userData,
                        nameController: widget.nameController,
                        birthdayController: widget.birthdayController,
                        selectedDate: widget.selectedDate,
                        emailController: widget.emailController,
                        phoneNumberController: widget.phoneNumberController,
                        newPasswordController: widget.newPasswordController,
                        currentPasswordController:
                            widget.currentPasswordController,
                      ),

                      PersonalisationMobileTabWidget(
                        l10n: widget.l10n,
                        userData: widget.userData,
                      ),

                      BillingMobileTabWidget(
                        l10n: widget.l10n,
                        userData: widget.userData,
                        onDownloadInvoices: (invoicesToDownload) {
                          // Perform download or API request here
                        },
                      ),

                      NotificationMobileTabWidget(),

                      ApiTabWidget(),
                    ],
                  ),
                ),
              ],
            ),

            // Profile Avatar Stack Overlay
            Positioned(
              left: 24,
              top: 170,
              child: Stack(
                clipBehavior: Clip.none,
                children: [
                  CircleAvatar(
                    radius: 48,
                    backgroundColor: colors.surface4,
                    child: Text(
                      widget.userData.name?.substring(0, 1) ?? '?',
                      style: textTheme.displayMedium?.copyWith(
                        color: colors.iconContrast,
                      ),
                    ),
                  ),
                  Positioned(
                    right: -2,
                    bottom: -2,
                    child: Stack(
                      children: [
                        MessIcon(
                          SvgIcons.verifiedLabel,
                          color: colors.componentSpecific,
                        ),
                        MessIcon(SvgIcons.verifiedCheckmark, color: colors.bg),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
