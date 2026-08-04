import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mess_messenger_app/core/utils/spacing/app_spacing.dart';
import 'package:mess_messenger_app/core/utils/spacing/spacing_modifier.dart';
import 'package:mess_messenger_app/core/widgets/dropdown_menu_widget.dart';
import 'package:mess_messenger_app/core/widgets/mess_cancellation_button.dart';
import 'package:mess_messenger_app/core/widgets/mess_main_button.dart';
import 'package:mess_messenger_app/features/settings/data/models/user_model.dart';
import 'package:mess_messenger_app/features/settings/presentation/pages/ui_helpers/build_title_widget.dart';
import 'package:mess_messenger_app/features/settings/presentation/pages/ui_helpers/checkbox_row_widget.dart';
import 'package:mess_messenger_app/features/settings/presentation/pages/ui_helpers/palette_widget.dart';
import 'package:mess_messenger_app/features/settings/user_providers/user_providers.dart';
import 'package:mess_messenger_app/theme/theme_extensions/theme_extension.dart';
import 'package:responsive_framework/responsive_framework.dart';

class PersonalisationMobileTabWidget extends ConsumerStatefulWidget {
  final UserModel? userData;

  const PersonalisationMobileTabWidget({super.key, this.userData});

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

    final selectedColor = ref.watch(selectedBgColorProvider);

    final bool isVisibleButtons = true;

    final currentTheme = [];
    final currentTextSize = [];

    return Stack(
      children: [
        SingleChildScrollView(
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
                AppSpacing.p36.gapV,
                BuildTitleWidget(title: 'Theme'),
                AppSpacing.p12.gapV,
                DropdownMenuWidget(
                  languages: ['System Default', 'English', 'Spanish'],
                  constraintSize: 400,
                  value: 'System Default',
                  // constraintSize: bp.screenWidth * 0.8,
                  onChanged: (selectedTheme) {
                    final userId = ref.read(userNotifierProvider).userData?.id;
                    if (userId == null) return;
                    ref
                        .read(userNotifierProvider.notifier)
                        .updateApplicationLanguage(userId, selectedTheme);
                  },
                ),
                AppSpacing.p24.gapV,
                Text(
                  'Background',
                  style: textTheme.titleMedium?.copyWith(color: colors.text2),
                ),
                AppSpacing.p12.gapV,

                PaletteWidget(
                  selectedColor: selectedColor,
                  paletteWidth: bp.screenWidth * 0.7,
                  onTap: () {},
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
                  languages: ['100%', '80%', '60%'],
                  constraintSize: 400,
                  value: '100%',
                  // constraintSize: bp.screenWidth * 0.8,
                  onChanged: (selectedTheme) {
                    final userId = ref.read(userNotifierProvider).userData?.id;
                    if (userId == null) return;
                    ref
                        .read(userNotifierProvider.notifier)
                        .updateApplicationLanguage(userId, '100%');
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
        ),

        isVisibleButtons
            ? Positioned(
                bottom: 0,
                width: bp.screenWidth,
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 32,
                    vertical: 24,
                  ),
                  decoration: BoxDecoration(
                    color: colors.bg,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(16),
                      topRight: Radius.circular(16),
                    ),
                    boxShadow: [
                      BoxShadow(
                        offset: Offset(0, 1),
                        spreadRadius: 4,
                        blurRadius: 15,
                        color: colors.text1.withValues(alpha: 0.1),
                      ),
                    ],
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      MessMainButton(label: 'Save Changes', onPressed: () {}),
                      AppSpacing.p8.gapV,
                      MessCancellationButton(label: 'Cancel', onPressed: () {}),
                    ],
                  ),
                ),
              )
            : SpacingModifier.empty(),
      ],
    );
  }
}
