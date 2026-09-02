import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mess_messenger_app/core/utils/spacing/app_spacing.dart';
import 'package:mess_messenger_app/core/widgets/dropdown_menu_widget.dart';
import 'package:mess_messenger_app/core/widgets/mess_main_button.dart';
import 'package:mess_messenger_app/features/settings/data/models/user_model.dart';
import 'package:mess_messenger_app/features/settings/presentation/pages/controllers/general_settings_controller.dart';
import 'package:mess_messenger_app/features/settings/presentation/pages/ui_helpers/build_title_widget.dart';
import 'package:mess_messenger_app/features/settings/presentation/pages/ui_helpers/checkbox_row_widget.dart';
import 'package:mess_messenger_app/core/widgets/mess_switch.dart';
import 'package:mess_messenger_app/features/settings/user_providers/ui_providers/general_settings_ui_provider.dart';
import 'package:mess_messenger_app/localization/l10n/app_localizations.dart';
import 'package:mess_messenger_app/localization/supported_locales.dart';
import 'package:mess_messenger_app/theme/theme_extensions/theme_extension.dart';
import 'package:responsive_framework/responsive_framework.dart';

class GeneralDesktopTabWidget extends ConsumerStatefulWidget {
  final AppLocalizations l10n;
  final UserModel? userData;
  final GeneralSettingsUiNotifier view;
  final GeneralSettingsController generalSettingsController;
  final List<SupportedLanguage> languages;
  final VoidCallback onPressedArchiveAllMessages;

  const GeneralDesktopTabWidget({
    super.key,
    required this.l10n,
    this.userData,
    required this.view,
    required this.generalSettingsController,
    required this.languages,
    required this.onPressedArchiveAllMessages,
  });

  @override
  ConsumerState<GeneralDesktopTabWidget> createState() =>
      _GeneralDesktopTabWidgetState();
}

class _GeneralDesktopTabWidgetState
    extends ConsumerState<GeneralDesktopTabWidget> {
  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final textTheme = context.textStyles;

    final bp = ResponsiveBreakpoints.of(context);
    final labelColumnWidth = (bp.screenWidth * 0.2).clamp(240.0, 380.0);

    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Padding(
        padding: const EdgeInsets.only(left: 32, top: 12, right: 32),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.l10n.general,
              style: textTheme.headlineLarge?.copyWith(color: colors.text1),
            ),
            AppSpacing.p32.gapV,
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  width: labelColumnWidth,
                  child: BuildTitleWidget(title: widget.l10n.login),
                ),
                Expanded(
                  child: Row(
                    spacing: 8,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      MessSwitch(
                        value: widget.view.isOn,
                        onChanged: widget.generalSettingsController.toggleLogin,
                      ),
                      Text(
                        widget.view.isOn ? widget.l10n.on : widget.l10n.off,
                        style: textTheme.bodyLarge?.copyWith(
                          color: colors.text1,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            AppSpacing.p32.gapV,
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  width: labelColumnWidth,
                  child: BuildTitleWidget(title: widget.l10n.language),
                ),
                DropdownMenuWidget(
                  values: [
                    widget.l10n.systemDefault,
                    ...widget.languages.map((l) => l.displayName),
                  ],
                  value: widget.view.currentLanguageDisplay,
                  constraintSize: bp.isDesktop
                      ? bp.screenWidth * 0.25
                      : bp.screenWidth * 0.4,
                  // constraintSize: bp.screenWidth * 0.8,
                  onChanged: (displayName) => widget.generalSettingsController
                      .selectLanguage(displayName, widget.l10n),
                ),
              ],
            ),
            AppSpacing.p32.gapV,
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: labelColumnWidth,
                  child: BuildTitleWidget(title: widget.l10n.password),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CheckboxRowWidget(
                      title: widget.l10n.photo,
                      isChecked: widget.view.isPhotoChecked,
                      onTap: () => widget.generalSettingsController
                          .togglePhotoProtection(widget.view.isPhotoChecked),
                    ),
                    CheckboxRowWidget(
                      title: widget.l10n.audio,
                      isChecked: widget.view.isAudioChecked,
                      onTap: () => widget.generalSettingsController
                          .toggleAudioProtection(widget.view.isAudioChecked),
                    ),
                    CheckboxRowWidget(
                      title: widget.l10n.video,
                      isChecked: widget.view.isVideoChecked,
                      onTap: () => widget.generalSettingsController
                          .toggleVideoProtection(widget.view.isVideoChecked),
                    ),
                    CheckboxRowWidget(
                      title: widget.l10n.document,
                      isChecked: widget.view.isDocumentChecked,
                      onTap: () => widget.generalSettingsController
                          .toggleDocumentProtection(
                            widget.view.isDocumentChecked,
                          ),
                    ),
                  ],
                ),
              ],
            ),
            AppSpacing.p32.gapV,
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  width: labelColumnWidth,
                  child: BuildTitleWidget(title: widget.l10n.messages),
                ),
                MessMainButton(
                  height: 32,
                  width: 192,
                  label: widget.l10n.archiveAll,
                  textColor: colors.text1,
                  backgroundColor: colors.surface2,
                  onPressed: widget.onPressedArchiveAllMessages,
                ),
              ],
            ),
            AppSpacing.p32.gapV,
          ],
        ),
      ),
    );
  }
}
