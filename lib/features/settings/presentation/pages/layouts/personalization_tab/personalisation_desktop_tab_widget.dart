import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:mess_messenger_app/core/utils/spacing/app_spacing.dart';
import 'package:mess_messenger_app/core/widgets/dropdown_menu_widget.dart';
import 'package:mess_messenger_app/core/widgets/mess_main_button.dart';
import 'package:mess_messenger_app/features/settings/data/models/user_model.dart';
import 'package:mess_messenger_app/features/settings/presentation/pages/ui_helpers/build_title_widget.dart';
import 'package:mess_messenger_app/features/settings/presentation/pages/ui_helpers/checkbox_row_widget.dart';
import 'package:mess_messenger_app/features/settings/presentation/pages/ui_helpers/palette_widget.dart';
import 'package:mess_messenger_app/features/settings/user_providers/user_providers.dart';
import 'package:mess_messenger_app/localization/l10n/app_localizations.dart';
import 'package:mess_messenger_app/theme/theme_extensions/theme_extension.dart';
import 'package:responsive_framework/responsive_framework.dart';

final loginSwitchProvider = StateProvider<bool>((ref) => true);
final photoCheckboxProvider = StateProvider<bool>((ref) => true);
final audioCheckboxProvider = StateProvider<bool>((ref) => true);
final videoCheckboxProvider = StateProvider<bool>((ref) => true);
final documentCheckboxProvider = StateProvider<bool>((ref) => false);

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

    final l10n = AppLocalizations.of(context)!;

    final bp = ResponsiveBreakpoints.of(context);

    late final themeMenuController = MenuController();
    late final textSizeMenuController = MenuController();

    final selectedColor = ref.watch(selectedBgColorProvider);

    final currentTheme = [];
    final currentTextSize = [];

    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Padding(
        padding: const EdgeInsets.only(left: 32, top: 12, right: 32),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Personalisation',
              style: textTheme.headlineLarge?.copyWith(color: colors.text1),
            ),
            AppSpacing.p32.gapV,
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Left Column: Fixed Width Label
                SizedBox(
                  width: math.min(
                    bp.screenWidth * 0.25,
                    320,
                  ), // 💡 Adjust this width value to shift the middle column left or right
                  child: BuildTitleWidget(title: 'Theme'),
                ),
                DropdownMenuWidget(
                  languages: ['System Default', 'English', 'Spanish'],
                  value: 'System Default',
                  constraintSize: bp.screenWidth * 0.8,
                  onChanged: (selectedTheme) {
                    final userId = ref.read(userNotifierProvider).userData?.id;
                    if (userId == null) return;
                    ref
                        .read(userNotifierProvider.notifier)
                        .updateApplicationLanguage(userId, selectedTheme);
                  },
                ),
              ],
            ),
            AppSpacing.p32.gapV,
            LayoutBuilder(
              builder: (context, constraints) {
                return Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Left Column: Fixed Width Label
                    SizedBox(
                      width: math.min(bp.screenWidth * 0.25, 320),
                      // 💡 Adjust this width value to shift the middle column left or right
                      child: BuildTitleWidget(title: 'Background'),
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          PaletteWidget(
                            selectedColor: selectedColor,
                            paletteWidth: math.min(bp.screenWidth * 0.25, 280),
                            onTap: () {},
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
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Left Column: Fixed Width Label
                SizedBox(
                  width: math.min(
                    bp.screenWidth * 0.25,
                    320,
                  ), // 💡 Adjust this width value to shift the middle column left or right
                  child: BuildTitleWidget(title: 'Text size'),
                ),
                DropdownMenuWidget(
                  languages: ['100%', '80%', '60%'],
                  value: '100%',
                  constraintSize: bp.screenWidth * 0.8,
                  onChanged: (selectedTheme) {
                    final userId = ref.read(userNotifierProvider).userData?.id;
                    if (userId == null) return;
                    ref
                        .read(userNotifierProvider.notifier)
                        .updateApplicationLanguage(userId, '100%');
                  },
                ),
              ],
            ),
            AppSpacing.p32.gapV,
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Left Column: Fixed Width Label
                SizedBox(
                  width: math.min(
                    bp.screenWidth * 0.25,
                    320,
                  ), // 💡 Adjust this width value to shift the middle column left or right
                  child: BuildTitleWidget(title: 'Messages'),
                ),
                MessMainButton(
                  height: 32,
                  width: 122,
                  label: 'Archive All',
                  textColor: colors.text1,
                  backgroundColor: colors.surface2,
                  onPressed: () {},
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
