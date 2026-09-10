import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mess_messenger_app/core/utils/spacing/app_spacing.dart';
import 'package:mess_messenger_app/core/widgets/dropdown_menu_widget.dart';
import 'package:mess_messenger_app/features/settings/data/models/user_model.dart';
import 'package:mess_messenger_app/features/settings/presentation/pages/ui_helpers/build_title_widget.dart';
import 'package:mess_messenger_app/features/settings/presentation/pages/ui_helpers/checkbox_row_widget.dart';
import 'package:mess_messenger_app/features/settings/presentation/pages/ui_helpers/palette_widget.dart';
import 'package:mess_messenger_app/features/settings/user_providers/data_providers/user_providers.dart';
import 'package:mess_messenger_app/localization/l10n/app_localizations.dart';
import 'package:mess_messenger_app/theme/providers/theme_provider.dart';
import 'package:mess_messenger_app/theme/theme_extensions/theme_extension.dart';
import 'package:responsive_framework/responsive_framework.dart';

class PersonalisationMobileTabWidget extends ConsumerStatefulWidget {
  final AppLocalizations l10n;
  final UserModel? userData;

  const PersonalisationMobileTabWidget({
    super.key,
    required this.l10n,
    this.userData,
  });

  @override
  ConsumerState<PersonalisationMobileTabWidget> createState() =>
      _PersonalisationMobileTabWidgetState();
}

class _PersonalisationMobileTabWidgetState
    extends ConsumerState<PersonalisationMobileTabWidget> {
  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final textTheme = context.textStyles;

    final bp = ResponsiveBreakpoints.of(context);

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
            AppSpacing.p36.gapV,
            BuildTitleWidget(title: 'Theme'),
            AppSpacing.p12.gapV,
            DropdownMenuWidget(
              values: ['System Default', 'Light', 'Dark'],
              constraintSize: 400,
              value: themeModeToLabel(currentThemeMode),
              // constraintSize: bp.screenWidth * 0.8,
              onChanged: (selectedTheme) {
                ref
                    .read(appThemeProvider.notifier)
                    .setTheme(labelToThemeMode(selectedTheme));
              },
            ),
            AppSpacing.p24.gapV,
            Text(
              'Background',
              style: textTheme.titleMedium?.copyWith(color: colors.text2),
            ),
            AppSpacing.p12.gapV,

            PaletteWidget(
              selectedIndex: selectedIndex,
              paletteWidth: bp.screenWidth * 0.7,
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

            AppSpacing.p32.gapV,
            BuildTitleWidget(title: 'Text size'),
            AppSpacing.p12.gapV,
            DropdownMenuWidget(
              values: ['100%', '80%', '60%'],
              constraintSize: 400,
              value: '100%',
              // constraintSize: bp.screenWidth * 0.8,
              onChanged: (selectedTheme) {
                //TODO: NEED TO FIX, NOT SURE HOW IMPLEMENT
                final userId = ref.read(userNotifierProvider).userData?.id;
                if (userId == null) return;
                // ref
                //     .read(userNotifierProvider.notifier)
                //     .dropdownSelectLanguage(userId, '100%');
              },
            ),
            AppSpacing.p4.gapV,
            Text(
              'Use +/- to increase or decrease your text size',
              style: textTheme.labelMedium?.copyWith(color: colors.text2),
            ),
            AppSpacing.p192.gapV,
          ],
        ),
      ),
    );
  }
}
