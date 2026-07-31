import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mess_messenger_app/core/constants/svg_icons.dart';
import 'package:mess_messenger_app/core/utils/spacing/app_spacing.dart';
import 'package:mess_messenger_app/core/widgets/mess_icon.dart';
import 'package:mess_messenger_app/features/settings/data/models/user_model.dart';
import 'package:mess_messenger_app/features/settings/presentation/pages/layouts/notification_tab/notification_desktop_tab_widget.dart';
import 'package:mess_messenger_app/features/settings/presentation/widgets/notification_selector.dart';
import 'package:mess_messenger_app/theme/theme_extensions/theme_extension.dart';
import 'package:responsive_framework/responsive_framework.dart';

class NotificationMobileTabWidget extends ConsumerStatefulWidget {
  final UserModel? userData;

  const NotificationMobileTabWidget({super.key, this.userData});

  @override
  ConsumerState<NotificationMobileTabWidget> createState() =>
      _NotificationMobileTabWidgetState();
}

class _NotificationMobileTabWidgetState
    extends ConsumerState<NotificationMobileTabWidget> {
  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final textTheme = context.textStyles;

    final bp = ResponsiveBreakpoints.of(context);

    final isCommunicationEmailEnabled = ref.watch(
      communicationEmailSwitchProvider,
    );
    final isCommunicationDesktopEnabled = ref.watch(
      communicationDesktopSwitchProvider,
    );
    final isCommunicationPushEnabled = ref.watch(
      communicationPushSwitchProvider,
    );

    final isReminderEmailEnabled = ref.watch(reminderEmailSwitchProvider);
    final isReminderDesktopEnabled = ref.watch(reminderDesktopSwitchProvider);
    final isReminderPushEnabled = ref.watch(reminderPushSwitchProvider);

    final isAnnouncementEmailEnabled = ref.watch(
      announcementEmailSwitchProvider,
    );
    final isAnnouncementDesktopEnabled = ref.watch(
      announcementDesktopSwitchProvider,
    );
    final isAnnouncementPushEnabled = ref.watch(announcementPushSwitchProvider);

    final isTipsEmailEnabled = ref.watch(tipsEmailSwitchProvider);
    final isTipsDesktopEnabled = ref.watch(tipsDesktopSwitchProvider);
    final isTipsPushEnabled = ref.watch(tipsPushSwitchProvider);

    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Padding(
        padding: const EdgeInsets.only(left: 32, top: 12, right: 32),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Notification',
              style: textTheme.headlineLarge?.copyWith(color: colors.text1),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 38.0, bottom: 16.0),
              child: Container(
                decoration: BoxDecoration(
                  color: colors.textInverse,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 12.0,
                    horizontal: 16.0,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Important notifications',
                                style: textTheme.headlineMedium?.copyWith(
                                  color: colors.text1,
                                ),
                              ),
                              AppSpacing.p12.gapV,
                              Text(
                                'We may still send you important \nnotifications about your account.',
                                style: textTheme.bodyMedium?.copyWith(
                                  color: colors.text1,
                                ),
                              ),
                              AppSpacing.p8.gapV,
                              Row(
                                spacing: 12,
                                children: [
                                  Text(
                                    'Dismiss',
                                    style: textTheme.labelMedium?.copyWith(
                                      color: colors.link,
                                    ),
                                  ),
                                  Text(
                                    'Learn more',
                                    style: textTheme.labelMedium?.copyWith(
                                      color: colors.link,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          MessIcon(
                            SvgIcons.information,
                            color: colors.infoColor,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
            NotificationSelector(
              title: 'Communication',
              description:
                  'Receive notifications for comments, tags, change request and any new activity.',
              firstValue: isCommunicationEmailEnabled,
              secondValue: isCommunicationDesktopEnabled,
              thirdValue: isCommunicationPushEnabled,
              onFirstSwitchChanged: (bool value) {
                setState(() {
                  ref.read(communicationEmailSwitchProvider.notifier).state =
                      value;
                });
              },
              onSecondSwitchChanged: (bool value) {
                setState(() {
                  ref.read(communicationDesktopSwitchProvider.notifier).state =
                      value;
                });
              },
              onThirdSwitchChanged: (bool value) {
                setState(() {
                  ref.read(communicationPushSwitchProvider.notifier).state =
                      value;
                });
              },
            ),
            NotificationSelector(
              title: 'Reminder',
              description:
                  'These are notifications to remind you of updates you might have missed.',
              firstValue: isReminderEmailEnabled,
              secondValue: isReminderDesktopEnabled,
              thirdValue: isReminderPushEnabled,
              onFirstSwitchChanged: (bool value) {
                setState(() {
                  ref.read(reminderEmailSwitchProvider.notifier).state = value;
                });
              },
              onSecondSwitchChanged: (bool value) {
                setState(() {
                  ref.read(reminderDesktopSwitchProvider.notifier).state =
                      value;
                });
              },
              onThirdSwitchChanged: (bool value) {
                setState(() {
                  ref.read(reminderPushSwitchProvider.notifier).state = value;
                });
              },
            ),
            NotificationSelector(
              title: 'Announcement and update',
              description:
                  'Receive notifications about product updates, our newest features, improvements and bug fixes.',
              firstValue: isAnnouncementEmailEnabled,
              secondValue: isAnnouncementDesktopEnabled,
              thirdValue: isAnnouncementPushEnabled,
              onFirstSwitchChanged: (bool value) {
                setState(() {
                  ref.read(announcementEmailSwitchProvider.notifier).state =
                      value;
                });
              },
              onSecondSwitchChanged: (bool value) {
                setState(() {
                  ref.read(announcementDesktopSwitchProvider.notifier).state =
                      value;
                });
              },
              onThirdSwitchChanged: (bool value) {
                setState(() {
                  ref.read(announcementPushSwitchProvider.notifier).state =
                      value;
                });
              },
            ),
            NotificationSelector(
              title: 'Tips',
              description:
                  'Receive notifications with helpful advice on how to use features and suggested events.',
              firstValue: isTipsEmailEnabled,
              secondValue: isTipsDesktopEnabled,
              thirdValue: isTipsPushEnabled,
              onFirstSwitchChanged: (bool value) {
                setState(() {
                  ref.read(tipsEmailSwitchProvider.notifier).state = value;
                });
              },
              onSecondSwitchChanged: (bool value) {
                setState(() {
                  ref.read(tipsDesktopSwitchProvider.notifier).state = value;
                });
              },
              onThirdSwitchChanged: (bool value) {
                setState(() {
                  ref.read(tipsPushSwitchProvider.notifier).state = value;
                });
              },
            ),
            AppSpacing.p60.gapV,
          ],
        ),
      ),
    );
  }
}
