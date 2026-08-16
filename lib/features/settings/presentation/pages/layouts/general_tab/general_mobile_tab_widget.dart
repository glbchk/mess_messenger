import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mess_messenger_app/core/utils/spacing/app_spacing.dart';
import 'package:mess_messenger_app/core/widgets/dropdown_menu_widget.dart';
import 'package:mess_messenger_app/core/widgets/mess_main_button.dart';
import 'package:mess_messenger_app/features/settings/data/models/user_model.dart';
import 'package:mess_messenger_app/features/settings/presentation/pages/ui_helpers/build_title_widget.dart';
import 'package:mess_messenger_app/features/settings/presentation/pages/ui_helpers/checkbox_row_widget.dart';
import 'package:mess_messenger_app/features/settings/presentation/widgets/custom_switch.dart';
import 'package:mess_messenger_app/features/settings/user_providers/user_providers.dart';
import 'package:mess_messenger_app/localization/l10n/app_localizations.dart';
import 'package:mess_messenger_app/localization/supported_locales.dart';
import 'package:mess_messenger_app/theme/theme_extensions/theme_extension.dart';
import 'package:responsive_framework/responsive_framework.dart';

class GeneralMobileTabWidget extends ConsumerStatefulWidget {
  final AppLocalizations l10n;
  final UserModel? userData;

  const GeneralMobileTabWidget({super.key, required this.l10n, this.userData});

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

    final userState = ref.watch(userNotifierProvider);
    final userData = userState.userData;

    if (userData == null) {
      return const CircularProgressIndicator();
    }

    final userGeneralSettings = userData.generalSettings;

    final isOn = userGeneralSettings?.isLoggedIn ?? false;
    final isPhotoChecked =
        userGeneralSettings?.isPhotoPasswordProtected ?? false;
    final isAudioChecked =
        userGeneralSettings?.isAudioPasswordProtected ?? false;
    final isVideoChecked =
        userGeneralSettings?.isVideoPasswordProtected ?? false;
    final isDocumentChecked =
        userGeneralSettings?.isDocumentPasswordProtected ?? false;

    final languages = getSupportedLanguages(widget.l10n);

    final currentLanguageCode = userGeneralSettings?.language;
    final currentLanguageDisplay = currentLanguageCode == null
        ? widget.l10n.systemDefault
        : (languages
                  .where((l) => l.code == currentLanguageCode)
                  .firstOrNull
                  ?.displayName ??
              widget.l10n.systemDefault);

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
            AppSpacing.p36.gapV,
            BuildTitleWidget(title: widget.l10n.logIn),
            AppSpacing.p12.gapV,
            Row(
              spacing: 8,
              mainAxisSize: MainAxisSize.min,
              children: [
                CustomSwitch(
                  value: isOn,
                  onChanged: (value) {
                    ref
                        .read(userNotifierProvider.notifier)
                        .updateIsLoggedIn(value);
                  },
                ),
                Text(
                  isOn ? widget.l10n.on : widget.l10n.off,
                  style: textTheme.bodyLarge?.copyWith(color: colors.text1),
                ),
              ],
            ),
            AppSpacing.p24.gapV,
            BuildTitleWidget(title: widget.l10n.language),
            AppSpacing.p12.gapV,
            DropdownMenuWidget(
              languages: [
                widget.l10n.systemDefault,
                ...languages.map((l) => l.displayName),
              ],
              value: currentLanguageDisplay,
              constraintSize: bp.screenWidth * 0.8,
              onChanged: (selectedLanguage) {
                final isSystemDefault =
                    selectedLanguage == widget.l10n.systemDefault;
                final localeCode = isSystemDefault
                    ? null
                    : languages
                          .where((l) => l.displayName == selectedLanguage)
                          .firstOrNull
                          ?.code;
                if (!isSystemDefault && localeCode == null) return;

                ref
                    .read(userNotifierProvider.notifier)
                    .updateLanguage(selectedLanguage);
              },
            ),
            AppSpacing.p24.gapV,
            Text(
              widget.l10n.password,
              style: textTheme.titleMedium?.copyWith(color: colors.text2),
            ),
            AppSpacing.p12.gapV,
            CheckboxRowWidget(
              title: widget.l10n.photo,
              isChecked: isPhotoChecked,
              onTap: () {
                ref
                    .read(userNotifierProvider.notifier)
                    .updateIsPhotoPasswordProtected(!isPhotoChecked);
              },
            ),
            AppSpacing.p8.gapV,
            CheckboxRowWidget(
              title: widget.l10n.audio,
              isChecked: isAudioChecked,
              onTap: () {
                ref
                    .read(userNotifierProvider.notifier)
                    .updateIsAudioPasswordProtected(!isAudioChecked);
              },
            ),
            AppSpacing.p8.gapV,
            CheckboxRowWidget(
              title: widget.l10n.video,
              isChecked: isVideoChecked,
              onTap: () {
                ref
                    .read(userNotifierProvider.notifier)
                    .updateIsVideoPasswordProtected(!isVideoChecked);
              },
            ),
            AppSpacing.p8.gapV,
            CheckboxRowWidget(
              title: widget.l10n.document,
              isChecked: isDocumentChecked,
              onTap: () {
                ref
                    .read(userNotifierProvider.notifier)
                    .updateIsDocumentPasswordProtected(!isDocumentChecked);
              },
            ),
            AppSpacing.p32.gapV,
            SizedBox(
              width:
                  320, // 💡 Adjust this width value to shift the middle column left or right
              child: BuildTitleWidget(title: widget.l10n.messages),
            ),
            AppSpacing.p12.gapV,
            MessMainButton(
              height: 48,
              width: 192,
              label: widget.l10n.archiveAll,
              textColor: colors.text1,
              backgroundColor: colors.surface2,
              onPressed: () {}, //TODO: Need to be implemented!
            ),
            AppSpacing.p64.gapV,
          ],
        ),
      ),
    );
  }
}
