import 'package:flutter/material.dart';
import 'package:mess_messenger_app/features/settings/presentation/pages/layouts/settings_layout/settings_tabs/account_tab_widget.dart';
import 'package:mess_messenger_app/features/settings/presentation/pages/layouts/settings_layout/settings_tabs/api_tab_widget.dart';
import 'package:mess_messenger_app/features/settings/presentation/pages/layouts/settings_layout/settings_tabs/billing_tab_widget.dart';
import 'package:mess_messenger_app/features/settings/presentation/pages/layouts/settings_layout/settings_tabs/general_tab_widget.dart';
import 'package:mess_messenger_app/features/settings/presentation/pages/layouts/settings_layout/settings_tabs/notification_tab_widget.dart';
import 'package:mess_messenger_app/features/settings/presentation/pages/layouts/settings_layout/settings_tabs/personalisation_tab_widget.dart';

class SettingsTabsWidget extends StatelessWidget {
  final TabController tabController;
  final DateTime? selectedDate;
  final TextEditingController nameController;
  final MenuController birthdayController;
  final TextEditingController emailController;
  final TextEditingController currentPasswordController;
  final TextEditingController newPasswordController;
  final TextEditingController phoneNumberController;

  const SettingsTabsWidget({
    super.key,
    required this.tabController,
    required this.selectedDate,
    required this.nameController,
    required this.birthdayController,
    required this.emailController,
    required this.currentPasswordController,
    required this.newPasswordController,
    required this.phoneNumberController,
  });

  @override
  Widget build(BuildContext context) {
    return TabBarView(
      controller: tabController,

      children: [
        GeneralTabWidget(),
        AccountTabWidget(
          nameController: nameController,
          birthdayController: birthdayController,
          selectedDate: selectedDate,
          emailFocusNode: FocusNode(),
          emailController: emailController,
          currentPasswordController: currentPasswordController,
          newPasswordController: newPasswordController,
          phoneNumberController: phoneNumberController,
        ),
        PersonalisationTabWidget(),
        BillingTabWidget(),
        NotificationTabWidget(),
        ApiTabWidget(),
      ],
    );
  }
}
