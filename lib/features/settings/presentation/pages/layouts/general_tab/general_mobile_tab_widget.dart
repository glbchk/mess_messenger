import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mess_messenger_app/core/utils/spacing/app_spacing.dart';
import 'package:mess_messenger_app/core/widgets/dropdown_menu_widget.dart';
import 'package:mess_messenger_app/core/widgets/mess_main_button.dart';
import 'package:mess_messenger_app/features/settings/data/models/general_settings_model.dart';
import 'package:mess_messenger_app/features/settings/data/models/user_model.dart';
import 'package:mess_messenger_app/features/settings/presentation/pages/ui_helpers/build_title_widget.dart';
import 'package:mess_messenger_app/features/settings/presentation/pages/ui_helpers/checkbox_row_widget.dart';
import 'package:mess_messenger_app/features/settings/presentation/widgets/custom_switch.dart';
import 'package:mess_messenger_app/features/settings/user_providers/general_settings_draft_provider.dart';
import 'package:mess_messenger_app/features/settings/user_providers/user_providers.dart';
import 'package:mess_messenger_app/localization/l10n/app_localizations.dart';
import 'package:mess_messenger_app/localization/supported_locales.dart';
import 'package:mess_messenger_app/theme/theme_extensions/theme_extension.dart';
import 'package:responsive_framework/responsive_framework.dart';

class GeneralMobileTabWidget extends ConsumerStatefulWidget {
  final UserModel? userData;

  const GeneralMobileTabWidget({super.key, this.userData});

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
    final l10n = AppLocalizations.of(context)!;

    final draft = ref.watch(generalSettingsDraftProvider);

    final saved =
        ref.watch(userNotifierProvider).userData?.generalSettings ??
        GeneralSettingsModel.defaults();

    final hasChanges = draft != saved;

    final isOn = draft.isLoggedIn ?? false;
    final isPhotoChecked = draft.isPhotoPasswordProtected ?? false;
    final isAudioChecked = draft.isAudioPasswordProtected ?? false;
    final isVideoChecked = draft.isVideoPasswordProtected ?? false;
    final isDocumentChecked = draft.isDocumentPasswordProtected ?? false;

    final languages = getSupportedLanguages(l10n);

    final currentLanguageCode = draft.language;
    final currentLanguageDisplay = currentLanguageCode == null
        ? l10n.systemDefault
        : (languages
                  .where((l) => l.code == currentLanguageCode)
                  .firstOrNull
                  ?.displayName ??
              l10n.systemDefault);

    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Padding(
        padding: const EdgeInsets.only(left: 32, top: 12, right: 32),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              l10n.general,
              style: textTheme.headlineLarge?.copyWith(color: colors.text1),
            ),
            AppSpacing.p36.gapV,
            BuildTitleWidget(title: l10n.logIn),
            AppSpacing.p12.gapV,
            Row(
              spacing: 8,
              mainAxisSize: MainAxisSize.min,
              children: [
                CustomSwitch(
                  value: isOn,
                  onChanged: (value) => ref
                      .read(generalSettingsDraftProvider.notifier)
                      .setLogin(value),
                ),
                Text(
                  isOn ? l10n.on : l10n.off,
                  style: textTheme.bodyLarge?.copyWith(color: colors.text1),
                ),
              ],
            ),
            AppSpacing.p24.gapV,
            BuildTitleWidget(title: l10n.language),
            AppSpacing.p12.gapV,
            DropdownMenuWidget(
              languages: [
                l10n.systemDefault,
                ...languages.map((l) => l.displayName),
              ],
              value: currentLanguageDisplay,
              constraintSize: bp.screenWidth * 0.8,
              onChanged: (selectedLanguage) {
                final isSystemDefault = selectedLanguage == l10n.systemDefault;
                final localeCode = isSystemDefault
                    ? null
                    : languages
                          .where((l) => l.displayName == selectedLanguage)
                          .firstOrNull
                          ?.code;

                if (!isSystemDefault && localeCode == null) return;

                ref
                    .read(generalSettingsDraftProvider.notifier)
                    .setLanguage(localeCode);
              },
            ),
            AppSpacing.p24.gapV,
            Text(
              l10n.password,
              style: textTheme.titleMedium?.copyWith(color: colors.text2),
            ),
            AppSpacing.p12.gapV,
            CheckboxRowWidget(
              title: l10n.photo,
              isChecked: isPhotoChecked,
              onTap: () =>
                  ref.read(generalSettingsDraftProvider.notifier).togglePhoto(),
            ),
            AppSpacing.p8.gapV,
            CheckboxRowWidget(
              title: l10n.audio,
              isChecked: isAudioChecked,
              onTap: () =>
                  ref.read(generalSettingsDraftProvider.notifier).toggleAudio(),
            ),
            AppSpacing.p8.gapV,
            CheckboxRowWidget(
              title: l10n.video,
              isChecked: isVideoChecked,
              onTap: () =>
                  ref.read(generalSettingsDraftProvider.notifier).toggleVideo(),
            ),
            AppSpacing.p8.gapV,
            CheckboxRowWidget(
              title: l10n.document,
              isChecked: isDocumentChecked,
              onTap: () => ref
                  .read(generalSettingsDraftProvider.notifier)
                  .toggleDocument(),
            ),
            AppSpacing.p32.gapV,
            SizedBox(
              width:
                  320, // 💡 Adjust this width value to shift the middle column left or right
              child: BuildTitleWidget(title: l10n.messages),
            ),
            AppSpacing.p12.gapV,
            MessMainButton(
              height: 48,
              width: 192,
              label: l10n.archiveAll,
              textColor: colors.text1,
              backgroundColor: colors.surface2,
              onPressed: () {},
            ),
            if (hasChanges) ...[
              AppSpacing.p32.gapV,
              MessMainButton(
                label: l10n.saveChanges,
                onPressed: () {
                  final userId = ref.read(userNotifierProvider).userData?.id;
                  if (userId == null) return;
                  ref
                      .read(userNotifierProvider.notifier)
                      .saveGeneralSettings(userId, draft);
                },
              ),
            ],
            AppSpacing.p64.gapV,
          ],
        ),
      ),
    );
  }
}
