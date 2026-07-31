import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mess_messenger_app/core/utils/spacing/app_spacing.dart';
import 'package:mess_messenger_app/core/widgets/dropdown_menu_widget.dart';
import 'package:mess_messenger_app/core/widgets/mess_main_button.dart';
import 'package:mess_messenger_app/features/settings/data/models/user_model.dart';
import 'package:mess_messenger_app/features/settings/presentation/pages/layouts/general_tab/general_desktop_tab_widget.dart';
import 'package:mess_messenger_app/features/settings/presentation/pages/ui_helpers/build_title_widget.dart';
import 'package:mess_messenger_app/features/settings/presentation/pages/ui_helpers/checkbox_row_widget.dart';
import 'package:mess_messenger_app/features/settings/presentation/widgets/custom_switch.dart';
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
  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final textTheme = context.textStyles;

    final bp = ResponsiveBreakpoints.of(context);

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
            AppSpacing.p36.gapV,
            BuildTitleWidget(title: 'Login'),
            AppSpacing.p12.gapV,
            Row(
              spacing: 8,
              mainAxisSize: MainAxisSize.min,
              children: [
                CustomSwitch(
                  value: isOn,
                  onChanged: (bool value) {
                    setState(() {
                      ref.read(loginSwitchProvider.notifier).state = value;
                    });
                  },
                ),
                Text(
                  isOn ? 'On' : 'Off',
                  style: textTheme.bodyLarge?.copyWith(color: colors.text1),
                ),
              ],
            ),
            AppSpacing.p24.gapV,
            BuildTitleWidget(title: 'Language'),
            AppSpacing.p12.gapV,
            DropdownMenuWidget(
              languages: ['Default', 'English', 'Spanish'],
              menuController: menuController,
              constraintSize: bp.screenWidth * 0.8,
            ),
            AppSpacing.p24.gapV,
            Text(
              'Password',
              style: textTheme.titleMedium?.copyWith(color: colors.text2),
            ),
            AppSpacing.p12.gapV,
            CheckboxRowWidget(
              title: 'Photo',
              isChecked: isPhotoChecked,
              onTap: () {
                ref.read(photoCheckboxProvider.notifier).state =
                    !isPhotoChecked;
              },
            ),
            AppSpacing.p8.gapV,
            CheckboxRowWidget(
              title: 'Audio',
              isChecked: isAudioChecked,
              onTap: () {
                ref.read(audioCheckboxProvider.notifier).state =
                    !isAudioChecked;
              },
            ),
            AppSpacing.p8.gapV,
            CheckboxRowWidget(
              title: 'Video',
              isChecked: isVideoChecked,
              onTap: () {
                ref.read(videoCheckboxProvider.notifier).state =
                    !isVideoChecked;
              },
            ),
            AppSpacing.p8.gapV,
            CheckboxRowWidget(
              title: 'Document',
              isChecked: isDocumentChecked,
              onTap: () {
                ref.read(documentCheckboxProvider.notifier).state =
                    !isDocumentChecked;
              },
            ),
            AppSpacing.p32.gapV,
            SizedBox(
              width:
                  320, // 💡 Adjust this width value to shift the middle column left or right
              child: BuildTitleWidget(title: 'Messages'),
            ),
            AppSpacing.p12.gapV,
            MessMainButton(
              height: 48,
              width: 122,
              label: 'Archive All',
              textColor: colors.text1,
              backgroundColor: colors.surface2,
              onPressed: () {},
            ),
            AppSpacing.p32.gapV,
            MessMainButton(label: 'Save Changes', onPressed: () {}),
            AppSpacing.p64.gapV,
          ],
        ),
      ),
    );
  }
}
