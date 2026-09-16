import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mess_messenger_app/core/extensions/l10n_extension.dart';
import 'package:mess_messenger_app/core/utils/spacing/app_spacing.dart';
import 'package:mess_messenger_app/core/widgets/dropdown_menu_widget.dart';
import 'package:mess_messenger_app/core/widgets/mess_main_button.dart';
import 'package:mess_messenger_app/core/widgets/mess_switch.dart';
import 'package:mess_messenger_app/features/settings/data/models/user_model.dart';
import 'package:mess_messenger_app/features/settings/presentation/pages/controllers/general_settings_controller.dart';
import 'package:mess_messenger_app/features/settings/presentation/widgets/reusable/adaptive_settings_item_widget.dart';
import 'package:mess_messenger_app/features/settings/presentation/widgets/reusable/checkbox_row_widget.dart';
import 'package:mess_messenger_app/features/settings/presentation/widgets/ui_helpers/method_helpers.dart';
import 'package:mess_messenger_app/features/settings/user_providers/data_providers/user_providers.dart';
import 'package:mess_messenger_app/features/settings/user_providers/ui_providers/general_settings_ui_provider.dart';
import 'package:mess_messenger_app/localization/supported_locales.dart';
import 'package:mess_messenger_app/theme/theme_extensions/theme_extension.dart';

class GeneralTabWidget extends ConsumerStatefulWidget {
  const GeneralTabWidget({super.key});

  @override
  ConsumerState<GeneralTabWidget> createState() => _GeneralTabWidgetState();
}

class _GeneralTabWidgetState extends ConsumerState<GeneralTabWidget> {
  void onArchiveAllMessages() {
    print('DEBUG: Archive all messages');
    // TODO: implement archive-all
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final textTheme = context.textStyles;

    final l10n = context.l10n;

    final userData =
        ref.watch(userNotifierProvider).userData ?? UserModel(id: '');
    final languages = getSupportedLanguages(l10n);
    final view = buildGeneralSettingsView(userData, l10n);
    final generalSettingsController = ref.read(
      generalSettingsControllerProvider,
    );

    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Padding(
        padding: const EdgeInsets.only(left: 32, top: 12, right: 32),
        child: Column(
          crossAxisAlignment: .start,
          children: [
            Text(
              l10n.general,
              style: textTheme.headlineLarge?.copyWith(color: colors.text1),
            ),
            AppSpacing.p32.gapV,

            AdaptiveSettingsItemWidget(
              label: l10n.login,
              labelWidth: context.getLabelWidth(),
              control: Row(
                spacing: 8,
                mainAxisSize: MainAxisSize.min,
                children: [
                  MessSwitch(
                    value: view.isOn,
                    onChanged: generalSettingsController.toggleLogin,
                  ),
                  Text(
                    view.isOn ? l10n.on : l10n.off,
                    style: textTheme.bodyLarge?.copyWith(color: colors.text1),
                  ),
                ],
              ),
            ),
            AppSpacing.p16.gapV,
            AdaptiveSettingsItemWidget(
              label: l10n.language,
              labelWidth: context.getLabelWidth(),
              control: DropdownMenuWidget(
                values: [
                  l10n.systemDefault,
                  ...languages.map((l) => l.displayName),
                ],
                value: view.currentLanguageDisplay,
                constraintSize: context.getFieldWidth(),
                onChanged: (displayName) =>
                    generalSettingsController.selectLanguage(displayName, l10n),
              ),
            ),
            AppSpacing.p16.gapV,
            AdaptiveSettingsItemWidget(
              label: l10n.password,
              labelWidth: context.getLabelWidth(),
              control: Column(
                crossAxisAlignment: .start,
                children: [
                  CheckboxRowWidget(
                    title: l10n.photo,
                    isChecked: view.isPhotoChecked,
                    onTap: () => generalSettingsController
                        .togglePhotoProtection(view.isPhotoChecked),
                  ),
                  CheckboxRowWidget(
                    title: l10n.audio,
                    isChecked: view.isAudioChecked,
                    onTap: () => generalSettingsController
                        .toggleAudioProtection(view.isAudioChecked),
                  ),
                  CheckboxRowWidget(
                    title: l10n.video,
                    isChecked: view.isVideoChecked,
                    onTap: () => generalSettingsController
                        .toggleVideoProtection(view.isVideoChecked),
                  ),
                  CheckboxRowWidget(
                    title: l10n.document,
                    isChecked: view.isDocumentChecked,
                    onTap: () => generalSettingsController
                        .toggleDocumentProtection(view.isDocumentChecked),
                  ),
                ],
              ),
            ),
            AppSpacing.p16.gapV,
            AdaptiveSettingsItemWidget(
              label: l10n.messages,
              labelWidth: context.getLabelWidth(),
              control: MessMainButton(
                height: 32,
                width: 192,
                label: l10n.archiveAll,
                textColor: colors.text1,
                backgroundColor: colors.surface2,
                onPressed: () {
                  onArchiveAllMessages();
                },
              ),
            ),
            AppSpacing.p32.gapV,
          ],
        ),
      ),
    );
  }
}
