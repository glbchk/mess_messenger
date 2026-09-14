import 'package:flutter/material.dart';
import 'package:mess_messenger_app/features/settings/data/models/user_model.dart';
import 'package:mess_messenger_app/features/settings/presentation/pages/controllers/account_settings_controller.dart';
import 'package:mess_messenger_app/features/settings/presentation/pages/controllers/general_settings_controller.dart';
import 'package:mess_messenger_app/features/settings/presentation/pages/layouts/settings_layout/account_tab/account_mobile_tab_widget.dart';
import 'package:mess_messenger_app/features/settings/presentation/pages/layouts/settings_layout/api_tab/api_tab_widget.dart';
import 'package:mess_messenger_app/features/settings/presentation/pages/layouts/settings_layout/billing_tab/billing_mobile_tab_widget.dart';
import 'package:mess_messenger_app/features/settings/presentation/pages/layouts/settings_layout/general_tab/general_mobile_tab_widget.dart';
import 'package:mess_messenger_app/features/settings/presentation/pages/layouts/settings_layout/notification_tab/notification_mobile_tab_widget.dart';
import 'package:mess_messenger_app/features/settings/presentation/pages/layouts/settings_layout/personalization_tab/personalisation_mobile_tab_widget.dart';
import 'package:mess_messenger_app/features/settings/user_providers/ui_providers/general_settings_ui_provider.dart';
import 'package:mess_messenger_app/localization/supported_locales.dart';
import 'package:mess_messenger_app/theme/theme_extensions/theme_extension.dart';

class SettingsTabsWidget extends StatelessWidget {
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

  const SettingsTabsWidget({
    super.key,
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
  Widget build(BuildContext context) {
    final colors = context.colors;
    final textTheme = context.textStyles;

    return TabBarView(
      controller: tabController,

      children: [
        GeneralMobileTabWidget(
          userData: userData,
          view: view,
          generalSettingsController: generalSettingsController,
          languages: languages,
          onPressedArchiveAllMessages: onPressedArchiveAllMessages,
        ),
        AccountMobileTabWidget(
          userData: userData,
          accountSettingsController: accountSettingsController,
          nameController: nameController,
          birthdayController: birthdayController,
          selectedDate: selectedDate,
          emailFocusNode: FocusNode(),
          emailController: emailController,
          currentPasswordController: currentPasswordController,
          newPasswordController: newPasswordController,
          phoneNumberController: phoneNumberController,
        ),
        PersonalisationMobileTabWidget(userData: userData),
        BillingMobileTabWidget(
          userData: userData,
          onDownloadInvoices: (invoicesToDownload) {},
        ),
        NotificationMobileTabWidget(),
        ApiTabWidget(),
      ],
    );
  }
}
