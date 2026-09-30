import 'package:flutter/material.dart';
import 'package:mess_messenger_app/core/constants/svg_icons.dart';
import 'package:mess_messenger_app/core/extensions/l10n_extension.dart';
import 'package:mess_messenger_app/core/utils/spacing/app_spacing.dart';
import 'package:mess_messenger_app/core/widgets/mess_textfield.dart';
import 'package:mess_messenger_app/features/settings/presentation/widgets/reusable/adaptive_settings_item_widget.dart';
import 'package:mess_messenger_app/features/settings/presentation/widgets/ui_helpers/method_helpers.dart';
import 'package:mess_messenger_app/theme/theme_extensions/theme_extension.dart';

class ApiTabWidget extends StatelessWidget {
  const ApiTabWidget({super.key});

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
              l10n.api,
              style: textTheme.headlineLarge?.copyWith(color: colors.text1),
            ),
            AppSpacing.p36.gapV,

            AdaptiveSettingsItemWidget(
              label: l10n.currentPassword,
              labelWidth: context.getLabelWidth(),
              control: MessTextField(
                hint: '679134-678-3465',
                width: context.getFieldWidth(),
                readOnly: true,
                suffixIcon: SvgIcons.copy,
                onSuffixIconTap: () {},
              ),
            ),

            AppSpacing.p64.gapV,
          ],
        ),
      ),
    );
  }
}
