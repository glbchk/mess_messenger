import 'package:mess_messenger_app/localization/l10n/app_localizations.dart';

enum ShellTab {
  chats(isPushed: false),
  calls(isPushed: false),
  contacts(isPushed: false),
  settings(isPushed: true);

  final bool isPushed;
  const ShellTab({required this.isPushed});
}

enum SubscriptionPlan { free, basic, pro }

enum SettingsTab {
  general,
  account,
  personalisation,
  billing,
  notification,
  api,
}

extension SettingsTabExtension on SettingsTab {
  String title(AppLocalizations l10n) {
    switch (this) {
      case SettingsTab.general:
        return l10n.general;
      case SettingsTab.account:
        return l10n.account;
      case SettingsTab.personalisation:
        return l10n.personalisation;
      case SettingsTab.billing:
        return l10n.billing;
      case SettingsTab.notification:
        return l10n.notification;
      case SettingsTab.api:
        return l10n.api;
    }
  }
}
