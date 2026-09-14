import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mess_messenger_app/core/extensions/l10n_extension.dart';
import 'package:mess_messenger_app/core/utils/spacing/app_spacing.dart';
import 'package:mess_messenger_app/core/widgets/dropdown_menu_widget.dart';
import 'package:mess_messenger_app/features/settings/data/models/user_model.dart';
import 'package:mess_messenger_app/features/settings/presentation/pages/ui_helpers/build_title_widget.dart';
import 'package:mess_messenger_app/features/settings/presentation/pages/ui_helpers/checkbox_row_widget.dart';
import 'package:mess_messenger_app/features/settings/presentation/pages/ui_helpers/palette_widget.dart';
import 'package:mess_messenger_app/features/settings/user_providers/data_providers/user_providers.dart';
import 'package:mess_messenger_app/theme/providers/theme_provider.dart';
import 'package:mess_messenger_app/theme/theme_extensions/theme_extension.dart';
import 'package:responsive_framework/responsive_framework.dart';

class PersonalisationDesktopTabWidget extends ConsumerStatefulWidget {
  final UserModel? userData;

  const PersonalisationDesktopTabWidget({super.key, this.userData});

  @override
  ConsumerState<PersonalisationDesktopTabWidget> createState() =>
      _PersonalisationDesktopTabWidgetState();
}

class _PersonalisationDesktopTabWidgetState
    extends ConsumerState<PersonalisationDesktopTabWidget> {
  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final textTheme = context.textStyles;

    final l10n = context.l10n;

    final bp = ResponsiveBreakpoints.of(context);
    final labelColumnWidth = (bp.screenWidth * 0.2).clamp(240.0, 380.0);
    final fieldsWidth = bp.isDesktop
        ? bp.screenWidth * 0.25
        : bp.screenWidth * 0.4;

    late final themeMenuController = MenuController();
    late final textSizeMenuController = MenuController();

    final personalization = ref
        .watch(userNotifierProvider)
        .userData
        ?.personalizationSettings;
    final selectedIndex = personalization?.backgroundColorIndex ?? 0;

    final currentTheme = [];
    final currentTextSize = [];

    final currentThemeMode = ref.watch(appThemeProvider);
    String themeModeToLabel(ThemeMode mode) => switch (mode) {
      ThemeMode.system => 'System Default',
      ThemeMode.light => 'Light',
      ThemeMode.dark => 'Dark',
    };
    ThemeMode labelToThemeMode(String label) => switch (label) {
      'Light' => ThemeMode.light,
      'Dark' => ThemeMode.dark,
      _ => ThemeMode.system,
    };

    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Padding(
        padding: const EdgeInsets.only(left: 32, top: 12, right: 32),
        child: Column(
          crossAxisAlignment: .start,
          children: [
            Text(
              'Personalisation',
              style: textTheme.headlineLarge?.copyWith(color: colors.text1),
            ),
            AppSpacing.p32.gapV,
            Row(
              crossAxisAlignment: .center,
              children: [
                // Left Column: Fixed Width Label
                SizedBox(
                  width:
                      labelColumnWidth, // 💡 Adjust this width value to shift the middle column left or right
                  child: BuildTitleWidget(title: 'Theme'),
                ),
                DropdownMenuWidget(
                  values: ['System Default', 'Light', 'Dark'],
                  value: themeModeToLabel(currentThemeMode),
                  constraintSize: fieldsWidth,
                  onChanged: (selectedTheme) {
                    ref
                        .read(userNotifierProvider.notifier)
                        .updateThemeMode(selectedTheme);
                  },
                ),
              ],
            ),
            AppSpacing.p32.gapV,
            LayoutBuilder(
              builder: (context, constraints) {
                return Row(
                  crossAxisAlignment: .start,
                  children: [
                    // Left Column: Fixed Width Label
                    SizedBox(
                      width: labelColumnWidth,
                      // 💡 Adjust this width value to shift the middle column left or right
                      child: BuildTitleWidget(title: 'Background'),
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: .start,
                        children: [
                          PaletteWidget(
                            selectedIndex: selectedIndex,
                            paletteWidth: math.min(bp.screenWidth * 0.45, 330),
                            onColorSelected: (index) {
                              ref
                                  .read(userNotifierProvider.notifier)
                                  .updateBackgroundColor(index);
                            },
                          ),
                          AppSpacing.p24.gapV,
                          CheckboxRowWidget(
                            title: 'Default background',
                            isChecked: true,
                            onTap: () {},
                          ),
                        ],
                      ),
                    ),
                  ],
                );
              },
            ),

            AppSpacing.p32.gapV,
            Row(
              crossAxisAlignment: .center,
              children: [
                // Left Column: Fixed Width Label
                Padding(
                  padding: const EdgeInsets.only(bottom: 24.0),
                  child: SizedBox(
                    width:
                        labelColumnWidth, // 💡 Adjust this width value to shift the middle column left or right
                    child: BuildTitleWidget(title: 'Text size'),
                  ),
                ),
                Column(
                  crossAxisAlignment: .start,
                  children: [
                    DropdownMenuWidget(
                      values: ['100%', '80%', '60%'],
                      value: '100%',
                      constraintSize: fieldsWidth,
                      onChanged: (selectedTheme) {
                        //TODO: NEED TO FIX, NOT SURE HOW IMPLEMENT
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
                      'Use +/- to increase or decrease your text size',
                      style: textTheme.labelMedium?.copyWith(
                        color: colors.text2,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            AppSpacing.p64.gapV,
          ],
        ),
      ),
    );
  }
}
