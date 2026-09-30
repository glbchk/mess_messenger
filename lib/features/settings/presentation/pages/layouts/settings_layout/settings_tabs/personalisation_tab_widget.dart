import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mess_messenger_app/core/extensions/l10n_extension.dart';
import 'package:mess_messenger_app/core/utils/colors/palette_colors.dart';
import 'package:mess_messenger_app/core/utils/spacing/app_spacing.dart';
import 'package:mess_messenger_app/core/widgets/dropdown_menu_widget.dart';
import 'package:mess_messenger_app/features/settings/presentation/widgets/reusable/adaptive_settings_item_widget.dart';
import 'package:mess_messenger_app/features/settings/presentation/widgets/reusable/checkbox_row_widget.dart';
import 'package:mess_messenger_app/features/settings/presentation/widgets/reusable/palette_widget.dart';
import 'package:mess_messenger_app/features/settings/presentation/widgets/ui_helpers/method_helpers.dart';
import 'package:mess_messenger_app/features/settings/user_providers/data_providers/user_providers.dart';
import 'package:mess_messenger_app/theme/providers/theme_provider.dart';
import 'package:mess_messenger_app/theme/theme_extensions/theme_extension.dart';
import 'package:responsive_framework/responsive_framework.dart';

class PersonalisationTabWidget extends ConsumerStatefulWidget {
  const PersonalisationTabWidget({super.key});

  @override
  ConsumerState<PersonalisationTabWidget> createState() =>
      _PersonalisationTabWidgetState();
}

class _PersonalisationTabWidgetState
    extends ConsumerState<PersonalisationTabWidget> {
  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final textTheme = context.textStyles;

    final l10n = context.l10n;

    final bp = ResponsiveBreakpoints.of(context);

    final personalization = ref
        .watch(userNotifierProvider)
        .userData
        ?.personalizationSettings;
    final selectedColor = Palette.fromName(personalization?.backgroundColorId);

    final themeOptions = ref.watch(themeModeOptionsProvider);
    final currentThemeLabel = ref.watch(currentThemeModeLabelProvider);

    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Padding(
        padding: const EdgeInsets.only(left: 32, top: 12, right: 32),
        child: Column(
          crossAxisAlignment: .start,
          children: [
            Text(
              l10n.personalisation,
              style: textTheme.headlineLarge?.copyWith(color: colors.text1),
            ),
            AppSpacing.p32.gapV,

            AdaptiveSettingsItemWidget(
              label: l10n.theme,
              labelWidth: context.getLabelWidth(),
              control: DropdownMenuWidget(
                values: themeOptions,
                value: currentThemeLabel,
                constraintSize: context.getFieldWidth(),
                onChanged: (selectedTheme) {
                  ref
                      .read(appThemeProvider.notifier)
                      .setThemeByLabel(selectedTheme);
                },
              ),
            ),
            AppSpacing.p16.gapV,
            AdaptiveSettingsItemWidget(
              label: l10n.background,
              labelWidth: context.getLabelWidth(),
              control: Column(
                crossAxisAlignment: .start,
                children: [
                  PaletteWidget(
                    selectedColor: selectedColor,
                    paletteWidth: math.min(
                      bp.isMobile ? bp.screenWidth : bp.screenWidth * 0.45,
                      bp.isMobile ? bp.screenWidth : 330,
                    ),
                    onColorSelected: (palette) {
                      ref
                          .read(userNotifierProvider.notifier)
                          .updateBackgroundColor(palette.name);
                    },
                  ),
                  AppSpacing.p24.gapV,
                  CheckboxRowWidget(
                    title: l10n.defaultBackground,
                    isChecked: true,
                    onTap: () {},
                  ),
                ],
              ),
            ),
            AppSpacing.p16.gapV,
            AdaptiveSettingsItemWidget(
              label: l10n.textSize,
              labelWidth: context.getLabelWidth(),
              control: Column(
                crossAxisAlignment: .start,
                children: [
                  DropdownMenuWidget(
                    values: ['100%', '80%', '60%'],
                    value: '100%',
                    constraintSize: context.getFieldWidth(),
                    onChanged: (selectedTheme) {
                      //TODO: NEED TO FIX, NOT SURE HOW TO IMPLEMENT
                      final userId = ref
                          .read(userNotifierProvider)
                          .userData
                          ?.id;
                      if (userId == null) return;
                      // ref
                      //     .read(userNotifierProvider.notifier)
                      //     .dropdownSelectLanguage(userId, '100%');
                    },
                  ),
                  AppSpacing.p8.gapV,
                  Text(
                    l10n.textSizeDescription,
                    style: textTheme.labelMedium?.copyWith(color: colors.text2),
                  ),
                ],
              ),
            ),
            AppSpacing.p16.gapV,
            AppSpacing.p64.gapV,
          ],
        ),
      ),
    );
  }
}
