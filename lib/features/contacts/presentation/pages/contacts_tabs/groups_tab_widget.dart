import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mess_messenger_app/core/extensions/l10n_extension.dart';
import 'package:mess_messenger_app/core/utils/spacing/app_spacing.dart';
import 'package:mess_messenger_app/features/contacts/presentation/widgets/reusable/contact_data_widget.dart';
import 'package:mess_messenger_app/theme/theme_extensions/theme_extension.dart';

class GroupsTabWidget extends ConsumerStatefulWidget {
  final String contactUserId;
  const GroupsTabWidget({super.key, required this.contactUserId});

  @override
  ConsumerState<GroupsTabWidget> createState() => _GroupsTabWidgetState();
}

class _GroupsTabWidgetState extends ConsumerState<GroupsTabWidget> {
  final groupsInCommon = [
    "Kat's birthday party",
    'Summer 2026',
    'Professional writers',
    'Writer circle LA',
  ];

  final mockedPhotos = [
    'assets/images/user_images/Avatar image-1.png',
    'assets/images/user_images/Avatar image-2.png',
    'assets/images/user_images/Avatar image-3.png',
    'assets/images/user_images/Avatar image-4.png',
    'assets/images/user_images/Avatar image-5.png',
    'assets/images/user_images/Avatar image-6.png',
  ];

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final textTheme = context.textStyles;

    final l10n = context.l10n;

    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Padding(
        padding: const EdgeInsets.only(left: 32, top: 12, right: 32),
        child: Column(
          crossAxisAlignment: .start,
          children: [
            Text(
              'Groups in common',
              style: textTheme.titleMedium?.copyWith(color: colors.text1),
            ),
            AppSpacing.p12.gapV,

            ...List.generate(groupsInCommon.length, (index) {
              return ContactDataWidget(
                title: groupsInCommon[index],
                subtitle: '20 members',
                photoPath: mockedPhotos[index],
                onPressed: () {},
              );
            }),

            AppSpacing.p64.gapV,
          ],
        ),
      ),
    );
  }
}
