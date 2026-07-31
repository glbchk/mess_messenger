import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:mess_messenger_app/core/utils/spacing/app_spacing.dart';
import 'package:mess_messenger_app/core/widgets/dropdown_menu_widget.dart';
import 'package:mess_messenger_app/core/widgets/mess_main_button.dart';
import 'package:mess_messenger_app/features/settings/data/models/user_model.dart';
import 'package:mess_messenger_app/features/settings/presentation/pages/ui_helpers/build_title_widget.dart';
import 'package:mess_messenger_app/features/settings/presentation/pages/ui_helpers/checkbox_row_widget.dart';
import 'package:mess_messenger_app/features/settings/presentation/widgets/custom_switch.dart';
import 'package:mess_messenger_app/localization/l10n/app_localizations.dart';
import 'package:mess_messenger_app/theme/theme_extensions/theme_extension.dart';
import 'package:responsive_framework/responsive_framework.dart';

final loginSwitchProvider = StateProvider<bool>((ref) => true);
final photoCheckboxProvider = StateProvider<bool>((ref) => true);
final audioCheckboxProvider = StateProvider<bool>((ref) => true);
final videoCheckboxProvider = StateProvider<bool>((ref) => true);
final documentCheckboxProvider = StateProvider<bool>((ref) => false);

class GeneralDesktopTabWidget extends ConsumerStatefulWidget {
  final UserModel? userData;

  const GeneralDesktopTabWidget({super.key, this.userData});

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

    final l10n = AppLocalizations.of(context)!;

    final bp = ResponsiveBreakpoints.of(context);

    // bool isOn = true;

    late final menuController = MenuController();

    final isOn = ref.watch(loginSwitchProvider);
    final isPhotoChecked = ref.watch(photoCheckboxProvider);
    final isAudioChecked = ref.watch(audioCheckboxProvider);
    final isVideoChecked = ref.watch(videoCheckboxProvider);
    final isDocumentChecked = ref.watch(documentCheckboxProvider);

    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Padding(
        padding: const EdgeInsets.only(left: 32, top: 12, right: 32),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'General',
              style: textTheme.headlineLarge?.copyWith(color: colors.text1),
            ),
            AppSpacing.p32.gapV,
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Left Column: Fixed Width Label
                SizedBox(
                  width:
                      320, // 💡 Adjust this width value to shift the middle column left or right
                  child: BuildTitleWidget(title: 'Login'),
                ),
                Expanded(
                  child: Row(
                    spacing: 8,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      CustomSwitch(
                        value: isOn,
                        onChanged: (bool value) {
                          setState(() {
                            ref.read(loginSwitchProvider.notifier).state =
                                value;
                          });
                        },
                      ),
                      Text(
                        isOn ? 'On' : 'Off',
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
                // Left Column: Fixed Width Label
                SizedBox(
                  width:
                      320, // 💡 Adjust this width value to shift the middle column left or right
                  child: BuildTitleWidget(title: 'Language'),
                ),
                DropdownMenuWidget(
                  languages: ['Default', 'English', 'Spanish'],
                  menuController: menuController,
                ),
              ],
            ),
            AppSpacing.p32.gapV,
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width:
                      320, // 💡 Adjust this width value to shift the middle column left or right
                  child: BuildTitleWidget(title: 'Password'),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CheckboxRowWidget(
                      title: 'Photo',
                      isChecked: isPhotoChecked,
                      onTap: () {
                        ref.read(photoCheckboxProvider.notifier).state =
                            !isPhotoChecked;
                      },
                    ),
                    CheckboxRowWidget(
                      title: 'Audio',
                      isChecked: isAudioChecked,
                      onTap: () {
                        ref.read(audioCheckboxProvider.notifier).state =
                            !isAudioChecked;
                      },
                    ),
                    CheckboxRowWidget(
                      title: 'Video',
                      isChecked: isVideoChecked,
                      onTap: () {
                        ref.read(videoCheckboxProvider.notifier).state =
                            !isVideoChecked;
                      },
                    ),
                    CheckboxRowWidget(
                      title: 'Document',
                      isChecked: isDocumentChecked,
                      onTap: () {
                        ref.read(documentCheckboxProvider.notifier).state =
                            !isDocumentChecked;
                      },
                    ),
                  ],
                ),
              ],
            ),
            AppSpacing.p32.gapV,
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Left Column: Fixed Width Label
                SizedBox(
                  width:
                      320, // 💡 Adjust this width value to shift the middle column left or right
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
          ],
        ),
      ),
    );
  }
}
