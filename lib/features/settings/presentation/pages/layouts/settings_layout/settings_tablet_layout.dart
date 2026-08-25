import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mess_messenger_app/core/constants/svg_icons.dart';
import 'package:mess_messenger_app/core/utils/spacing/app_spacing.dart';
import 'package:mess_messenger_app/core/widgets/mess_icon.dart';
import 'package:mess_messenger_app/core/widgets/web_widgets/side_menu/web_side_menu.dart';
import 'package:mess_messenger_app/features/settings/data/models/user_model.dart';
import 'package:mess_messenger_app/features/settings/presentation/pages/layouts/account_tab/account_desktop_tab_widget.dart';
import 'package:mess_messenger_app/features/settings/presentation/pages/layouts/api_tab/api_tab_widget.dart';
import 'package:mess_messenger_app/features/settings/presentation/pages/layouts/billing_tab/billing_desktop_tab_widget.dart';
import 'package:mess_messenger_app/features/settings/presentation/pages/layouts/general_tab/general_desktop_tab_widget.dart';
import 'package:mess_messenger_app/features/settings/presentation/pages/layouts/notification_tab/notification_desktop_tab_widget.dart';
import 'package:mess_messenger_app/features/settings/presentation/pages/layouts/personalization_tab/personalisation_desktop_tab_widget.dart';
import 'package:mess_messenger_app/features/settings/presentation/widgets/settings_user_data_panel_widget.dart';
import 'package:mess_messenger_app/localization/l10n/app_localizations.dart';
import 'package:mess_messenger_app/theme/theme_extensions/theme_extension.dart';

class SettingsTabletLayout extends ConsumerStatefulWidget {
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
  final VoidCallback onPressedChangeAvatar;

  const SettingsTabletLayout({
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
    required this.onPressedChangeAvatar,
  });

  @override
  ConsumerState<SettingsTabletLayout> createState() =>
      _SettingsTabletLayoutState();
}

class _SettingsTabletLayoutState extends ConsumerState<SettingsTabletLayout> {
  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final textTheme = context.textStyles;

    return Scaffold(
      body: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          WebSideMenu(userData: widget.userData),

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
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        height: 220,
                        width: double.infinity,
                        clipBehavior: Clip.antiAlias,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(24),
                            topRight: Radius.circular(24),
                          ),
                        ),
                        child: Image.asset(
                          'assets/images/settings_header.png',
                          fit: BoxFit.cover,
                        ),
                      ),
                      AppSpacing.p20.gapV,
                      SettingsUserDataPanelWidget(
                        l10n: widget.l10n,
                        userData: widget.userData,
                        onPressedChangeAvatar: widget.onPressedChangeAvatar,
                        onPressedExportAccountData: () {},
                        onPressedTerminateAllActiveSessions: () {},
                        onPressedContactSupport: () {},
                        onPressedLogout: () {},
                      ),
                      Container(
                        margin: const EdgeInsets.only(
                          bottom: 16.0,
                          left: 16.0,
                          top: 24.0,
                        ),
                        child: TabBar(
                          controller: widget.tabController,
                          isScrollable: true,
                          labelPadding: const EdgeInsets.symmetric(
                            horizontal: 8,
                          ),
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

                      Expanded(
                        child: TabBarView(
                          controller: widget.tabController,
                          children: [
                            GeneralDesktopTabWidget(
                              l10n: widget.l10n,
                              userData: widget.userData,
                            ),
                            AccountDesktopTabWidget(
                              l10n: widget.l10n,
                              userData: widget.userData,
                              nameController: widget.nameController,
                              birthdayController: widget.birthdayController,
                              selectedDate: widget.selectedDate,
                              emailController: widget.emailController,
                              phoneNumberController:
                                  widget.phoneNumberController,
                              currentPasswordController:
                                  widget.currentPasswordController,
                              newPasswordController:
                                  widget.newPasswordController,
                            ),
                            PersonalisationDesktopTabWidget(
                              l10n: widget.l10n,
                              userData: widget.userData,
                            ),
                            BillingDesktopTabWidget(
                              l10n: widget.l10n,
                              userData: widget.userData,
                            ),
                            NotificationDesktopTabWidget(),
                            ApiTabWidget(),
                          ],
                        ),
                      ),
                    ],
                  ),

                  Positioned(
                    left: 32,
                    top: 116,
                    child: Stack(
                      clipBehavior: Clip.none,
                      children: [
                        CircleAvatar(
                          radius: 96,
                          backgroundColor: colors.surface4,
                          child: Text(
                            widget.userData.name?.substring(0, 1) ?? '?',
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
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
