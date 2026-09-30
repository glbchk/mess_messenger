import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mess_messenger_app/core/constants/svg_icons.dart';
import 'package:mess_messenger_app/core/extensions/l10n_extension.dart';
import 'package:mess_messenger_app/core/utils/spacing/app_spacing.dart';
import 'package:mess_messenger_app/core/widgets/mess_text_button.dart';
import 'package:mess_messenger_app/features/contacts/presentation/widgets/reusable/contact_data_widget.dart';
import 'package:mess_messenger_app/theme/theme_extensions/theme_extension.dart';

class OverviewTabWidget extends ConsumerStatefulWidget {
  final String contactUserId;
  const OverviewTabWidget({super.key, required this.contactUserId});

  @override
  ConsumerState<OverviewTabWidget> createState() => _OverviewTabWidgetState();
}

class _OverviewTabWidgetState extends ConsumerState<OverviewTabWidget> {
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
              'Contact information',
              style: textTheme.titleMedium?.copyWith(color: colors.text1),
            ),
            AppSpacing.p12.gapV,

            ContactDataWidget(
              iconPath: SvgIcons.calls,
              title: 'Mobile',
              subtitle: '+32658029525',
              onPressed: () {},
            ),

            ContactDataWidget(
              iconPath: SvgIcons.message,
              title: 'Email',
              subtitle: '+Avawilliams@email.com',
              onPressed: () {},
            ),

            ContactDataWidget(
              iconPath: SvgIcons.category,
              title: 'Category',
              subtitle: 'Friends',
              onPressed: () {},
            ),

            AppSpacing.p24.gapV,

            MessTextButton(
              label: 'Show more contact information',
              textStyle: textTheme.headlineSmall?.copyWith(color: colors.link),
              onPressed: () {},
            ),

            AppSpacing.p64.gapV,
          ],
        ),
      ),
    );
  }
}
