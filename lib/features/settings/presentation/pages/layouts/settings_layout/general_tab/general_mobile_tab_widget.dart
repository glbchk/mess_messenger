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

class GeneralMobileTabWidget extends ConsumerStatefulWidget {
  final AppLocalizations l10n;
  final UserModel? userData;
  final GeneralSettingsUiNotifier view;
  // final ValueChanged<bool> onLoginToggled;
  final List<SupportedLanguage> languages;
  final GeneralSettingsController generalSettingsController;
  // final ValueChanged<String> onLanguageSelected;
  // final ValueChanged<bool> isPhotoChecked;
  // final ValueChanged<bool> isAudioChecked;
  // final ValueChanged<bool> isVideoChecked;
  // final ValueChanged<bool> isDocumentChecked;
  final VoidCallback onPressedArchiveAllMessages;

  const GeneralMobileTabWidget({
    super.key,
    required this.l10n,
    this.userData,
    required this.view,
    // required this.onLoginToggled,
    required this.languages,
    required this.generalSettingsController,
    // required this.onLanguageSelected,
    // required this.isPhotoChecked,
    // required this.isAudioChecked,
    // required this.isVideoChecked,
    // required this.isDocumentChecked,
    required this.onPressedArchiveAllMessages,
  });

  @override
  ConsumerState<GeneralMobileTabWidget> createState() =>
      _GeneralMobileTabWidgetState();
}

class _GeneralMobileTabWidgetState
    extends ConsumerState<GeneralMobileTabWidget> {
  final MenuController menuController = MenuController();

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final textTheme = context.textStyles;

    final bp = ResponsiveBreakpoints.of(context);

    // final userState = ref.watch(userNotifierProvider);
    // final userData = userState.userData;

    // final userGeneralSettings = userData?.generalSettings;

    // final isOn = userGeneralSettings?.isLoggedIn ?? false;
    // final isPhotoChecked =
    //     userGeneralSettings?.isPhotoPasswordProtected ?? false;
    // final isAudioChecked =
    //     userGeneralSettings?.isAudioPasswordProtected ?? false;
    // final isVideoChecked =
    //     userGeneralSettings?.isVideoPasswordProtected ?? false;
    // final isDocumentChecked =
    //     userGeneralSettings?.isDocumentPasswordProtected ?? false;

    // final languages = getSupportedLanguages(widget.l10n);

    // final currentLanguageCode = userGeneralSettings?.language;
    // final currentLanguageDisplay = currentLanguageCode == null
    //     ? widget.l10n.systemDefault
    //     : (languages
    //               .where((l) => l.code == currentLanguageCode)
    //               .firstOrNull
    //               ?.displayName ??
    //           widget.l10n.systemDefault);

    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Padding(
        padding: const EdgeInsets.only(left: 32, top: 12, right: 32),
        child: Column(
          crossAxisAlignment: .start,
          children: [
            Text(
              widget.l10n.general,
              style: textTheme.headlineLarge?.copyWith(color: colors.text1),
            ),
            AppSpacing.p36.gapV,
            BuildTitleWidget(title: widget.l10n.logIn),
            AppSpacing.p12.gapV,
            Row(
              spacing: 8,
              mainAxisSize: MainAxisSize.min,
              children: [
                MessSwitch(
                  value: widget.view.isOn,
                  onChanged: widget.generalSettingsController.toggleLogin,
                ),
                Text(
                  widget.view.isOn ? widget.l10n.on : widget.l10n.off,
                  style: textTheme.bodyLarge?.copyWith(color: colors.text1),
                ),
              ],
            ),
            AppSpacing.p24.gapV,
            BuildTitleWidget(title: widget.l10n.language),
            AppSpacing.p12.gapV,
            DropdownMenuWidget(
              values: [
                widget.l10n.systemDefault,
                ...widget.languages.map((l) => l.displayName),
              ],
              value: widget.view.currentLanguageDisplay,
              constraintSize: bp.screenWidth * 0.8,
              onChanged: (displayName) => widget.generalSettingsController
                  .selectLanguage(displayName, widget.l10n),
            ),
            AppSpacing.p24.gapV,
            Text(
              widget.l10n.password,
              style: textTheme.titleMedium?.copyWith(color: colors.text2),
            ),
            AppSpacing.p12.gapV,
            CheckboxRowWidget(
              title: widget.l10n.photo,
              isChecked: widget.view.isPhotoChecked,
              onTap: () =>
                  widget.generalSettingsController.togglePhotoProtection,
            ),
            AppSpacing.p8.gapV,
            CheckboxRowWidget(
              title: widget.l10n.audio,
              isChecked: widget.view.isAudioChecked,
              onTap: () =>
                  widget.generalSettingsController.toggleAudioProtection,
            ),
            AppSpacing.p8.gapV,
            CheckboxRowWidget(
              title: widget.l10n.video,
              isChecked: widget.view.isVideoChecked,
              onTap: () =>
                  widget.generalSettingsController.toggleVideoProtection,
            ),
            AppSpacing.p8.gapV,
            CheckboxRowWidget(
              title: widget.l10n.document,
              isChecked: widget.view.isDocumentChecked,
              onTap: () =>
                  widget.generalSettingsController.toggleDocumentProtection,
            ),
            AppSpacing.p32.gapV,
            BuildTitleWidget(title: widget.l10n.messages),
            AppSpacing.p12.gapV,
            MessMainButton(
              height: 48,
              width: 192,
              label: widget.l10n.archiveAll,
              textColor: colors.text1,
              backgroundColor: colors.surface2,
              onPressed: widget.onPressedArchiveAllMessages,
            ),
            AppSpacing.p64.gapV,
          ],
        ),
      ),
    );
  }
}
