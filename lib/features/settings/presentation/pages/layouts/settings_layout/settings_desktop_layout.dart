import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:mess_messenger_app/core/constants/svg_icons.dart';
import 'package:mess_messenger_app/core/router/app_routes.dart';
import 'package:mess_messenger_app/core/utils/spacing/app_spacing.dart';
import 'package:mess_messenger_app/core/widgets/mess_icon.dart';
import 'package:mess_messenger_app/core/widgets/web_widgets/side_menu/web_side_menu.dart';
import 'package:mess_messenger_app/features/auth/auth_providers/auth_providers.dart';
import 'package:mess_messenger_app/features/settings/data/models/user_model.dart';
import 'package:mess_messenger_app/features/settings/presentation/pages/controllers/account_settings_controller.dart';
import 'package:mess_messenger_app/features/settings/presentation/pages/controllers/general_settings_controller.dart';
import 'package:mess_messenger_app/features/settings/presentation/pages/layouts/settings_layout/account_tab/account_desktop_tab_widget.dart';
import 'package:mess_messenger_app/features/settings/presentation/pages/layouts/settings_layout/api_tab/api_tab_widget.dart';
import 'package:mess_messenger_app/features/settings/presentation/pages/layouts/settings_layout/billing_tab/billing_desktop_tab_widget.dart';
import 'package:mess_messenger_app/features/settings/presentation/pages/layouts/settings_layout/general_tab/general_desktop_tab_widget.dart';
import 'package:mess_messenger_app/features/settings/presentation/pages/layouts/settings_layout/notification_tab/notification_desktop_tab_widget.dart';
import 'package:mess_messenger_app/features/settings/presentation/pages/layouts/settings_layout/personalization_tab/personalisation_desktop_tab_widget.dart';
import 'package:mess_messenger_app/features/settings/presentation/widgets/settings_user_data_panel_widget.dart';
import 'package:mess_messenger_app/features/settings/user_providers/ui_providers/general_settings_ui_provider.dart';
import 'package:mess_messenger_app/localization/l10n/app_localizations.dart';
import 'package:mess_messenger_app/localization/supported_locales.dart';
import 'package:mess_messenger_app/theme/theme_extensions/theme_extension.dart';

class SettingsDesktopLayout extends ConsumerStatefulWidget {
  final AppLocalizations l10n;
  final UserModel userData;
  final GeneralSettingsUiNotifier view;
  final GeneralSettingsController generalSettingsController;
  final List<SupportedLanguage> languages;
  final TabController tabController;
  final VoidCallback onPressedChangeAvatar;
  final VoidCallback onPressedLogoutFromAllDevices;
  final VoidCallback onPressedArchiveAllMessages;
  final AccountSettingsController accountSettingsController;
  final TextEditingController nameController;
  final MenuController birthdayController;
  final DateTime? selectedDate;
  final TextEditingController emailController;
  final TextEditingController currentPasswordController;
  final TextEditingController newPasswordController;
  final TextEditingController phoneNumberController;

  const SettingsDesktopLayout({
    super.key,
    required this.l10n,
    required this.userData,
    required this.view,
    required this.generalSettingsController,
    required this.languages,
    required this.tabController,
    required this.onPressedChangeAvatar,
    required this.onPressedLogoutFromAllDevices,
    required this.onPressedArchiveAllMessages,
    required this.accountSettingsController,
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
    final textTheme = context.textStyles;
    // final bp = ResponsiveBreakpoints.of(context);

    // final sectionWidth = bp.isDesktop
    //     ? bp.screenWidth * 0.25
    //     : bp.screenWidth * 0.35;

    return Scaffold(
      body: Row(
        crossAxisAlignment: .stretch,
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
                    crossAxisAlignment: .start,
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
                        onPressedTerminateAllActiveSessions:
                            widget.onPressedLogoutFromAllDevices,
                        onPressedContactSupport: () {
                          context.push(AppRoutes.support);
                        },
                        onPressedLogout: () {
                          ref.read(authNotifierProvider.notifier).logout();
                        },
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
                          mouseCursor: SystemMouseCursors.click,
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
                              view: widget.view,
                              generalSettingsController:
                                  widget.generalSettingsController,
                              languages: widget.languages,
                              onPressedArchiveAllMessages:
                                  widget.onPressedArchiveAllMessages,
                            ),
                            AccountDesktopTabWidget(
                              l10n: widget.l10n,
                              userData: widget.userData,
                              accountSettingsController:
                                  widget.accountSettingsController,
                              nameController: widget.nameController,
                              birthdayController: widget.birthdayController,
                              selectedDate: widget.selectedDate,
                              emailFocusNode: FocusNode(),
                              emailController: widget.emailController,
                              currentPasswordController:
                                  widget.currentPasswordController,
                              newPasswordController:
                                  widget.newPasswordController,
                              phoneNumberController:
                                  widget.phoneNumberController,
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
                          backgroundImage:
                              (widget.userData.avatarUrl?.isNotEmpty ?? false)
                              ? NetworkImage(widget.userData.avatarUrl!)
                              : null,
                          child:
                              (widget.userData.avatarUrl?.isNotEmpty ?? false)
                              ? null
                              : Text(
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
