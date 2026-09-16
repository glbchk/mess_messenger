import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mess_messenger_app/features/settings/data/models/notification_settings_model.dart';
import 'package:mess_messenger_app/features/settings/data/models/user_model.dart';
import 'package:mess_messenger_app/features/settings/presentation/widgets/reusable/notification_card_widget.dart';
import 'package:mess_messenger_app/features/settings/presentation/widgets/reusable/notification_selector.dart';
import 'package:mess_messenger_app/features/settings/user_providers/data_providers/user_providers.dart';
import 'package:mess_messenger_app/localization/l10n/app_localizations.dart';
import 'package:mess_messenger_app/theme/theme_extensions/theme_extension.dart';

class NotificationTabWidget extends ConsumerStatefulWidget {
  const NotificationTabWidget({super.key});

  @override
  ConsumerState<NotificationTabWidget> createState() =>
      _NotificationTabWidgetState();
}

class _NotificationTabWidgetState extends ConsumerState<NotificationTabWidget> {
  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final textTheme = context.textStyles;

    final l10n = AppLocalizations.of(context)!;

    final userData =
        ref.watch(userNotifierProvider).userData ?? UserModel(id: '');

    final notificationSettings =
        userData.notificationSettings ?? NotificationSettingsModel.defaults();

    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Padding(
        padding: const EdgeInsets.only(left: 32, top: 12, right: 32),
        child: Column(
          crossAxisAlignment: .start,
          children: [
            Text(
              l10n.notification,
              style: textTheme.headlineLarge?.copyWith(color: colors.text1),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 34.0, bottom: 24.0),
              child: NotificationCardWidget(
                onDismissPressed: () {},
                onLearnMorePressed: () {},
              ),
            ),
            NotificationSelector(
              title: l10n.communication,
              description: l10n.communicationDescription,
              firstValue: notificationSettings.communicationEmail,
              secondValue: notificationSettings.communicationDesktop,
              thirdValue: notificationSettings.communicationPush,
              onFirstSwitchChanged: (value) => ref
                  .read(userNotifierProvider.notifier)
                  .updateNotificationSettings(communicationEmail: value),
              onSecondSwitchChanged: (value) => ref
                  .read(userNotifierProvider.notifier)
                  .updateNotificationSettings(communicationDesktop: value),
              onThirdSwitchChanged: (value) => ref
                  .read(userNotifierProvider.notifier)
                  .updateNotificationSettings(communicationPush: value),
            ),
            NotificationSelector(
              title: l10n.reminder,
              description: l10n.reminderDescription,
              firstValue: notificationSettings.reminderEmail,
              secondValue: notificationSettings.reminderDesktop,
              thirdValue: notificationSettings.reminderPush,
              onFirstSwitchChanged: (value) => ref
                  .read(userNotifierProvider.notifier)
                  .updateNotificationSettings(reminderEmail: value),
              onSecondSwitchChanged: (value) => ref
                  .read(userNotifierProvider.notifier)
                  .updateNotificationSettings(reminderDesktop: value),
              onThirdSwitchChanged: (value) => ref
                  .read(userNotifierProvider.notifier)
                  .updateNotificationSettings(reminderPush: value),
            ),
            NotificationSelector(
              title: l10n.announcementAndUpdate,
              description: l10n.announcementAndUpdateDescription,
              firstValue: notificationSettings.announcementEmail,
              secondValue: notificationSettings.announcementDesktop,
              thirdValue: notificationSettings.announcementPush,
              onFirstSwitchChanged: (value) => ref
                  .read(userNotifierProvider.notifier)
                  .updateNotificationSettings(announcementEmail: value),
              onSecondSwitchChanged: (value) => ref
                  .read(userNotifierProvider.notifier)
                  .updateNotificationSettings(announcementDesktop: value),
              onThirdSwitchChanged: (value) => ref
                  .read(userNotifierProvider.notifier)
                  .updateNotificationSettings(announcementPush: value),
            ),
            NotificationSelector(
              title: l10n.tips,
              description: l10n.tipsDescription,
              firstValue: notificationSettings.tipsEmail,
              secondValue: notificationSettings.tipsDesktop,
              thirdValue: notificationSettings.tipsPush,
              onFirstSwitchChanged: (value) => ref
                  .read(userNotifierProvider.notifier)
                  .updateNotificationSettings(tipsEmail: value),
              onSecondSwitchChanged: (value) => ref
                  .read(userNotifierProvider.notifier)
                  .updateNotificationSettings(tipsDesktop: value),
              onThirdSwitchChanged: (value) => ref
                  .read(userNotifierProvider.notifier)
                  .updateNotificationSettings(tipsPush: value),
            ),
          ],
        ),
      ),
    );
  }
}
