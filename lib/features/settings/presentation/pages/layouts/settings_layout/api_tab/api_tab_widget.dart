import 'package:flutter/material.dart';
import 'package:mess_messenger_app/core/constants/svg_icons.dart';
import 'package:mess_messenger_app/core/utils/spacing/app_spacing.dart';
import 'package:mess_messenger_app/core/widgets/mess_textfield.dart';
import 'package:mess_messenger_app/features/settings/data/models/user_model.dart';
import 'package:mess_messenger_app/features/settings/presentation/pages/ui_helpers/build_title_widget.dart';
import 'package:mess_messenger_app/theme/theme_extensions/theme_extension.dart';
import 'package:responsive_framework/responsive_framework.dart';

class ApiTabWidget extends StatelessWidget {
  final UserModel? userData;

  const ApiTabWidget({super.key, this.userData});

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final textTheme = context.textStyles;

    final bp = ResponsiveBreakpoints.of(context);

    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Padding(
        padding: const EdgeInsets.only(left: 32, top: 12, right: 32),
        child: Column(
          crossAxisAlignment: .start,
          children: [
            Text(
              'API',
              style: textTheme.headlineLarge?.copyWith(color: colors.text1),
            ),
            AppSpacing.p36.gapV,

            bp.isMobile
                ? Column(
                    crossAxisAlignment: .start,
                    children: [
                      Text(
                        'Current password',
                        style: textTheme.titleMedium?.copyWith(
                          color: colors.text2,
                        ),
                      ),
                      AppSpacing.p4.gapV,
                      MessTextField(
                        hint: '679134-678-3465',
                        readOnly: true,
                        suffixIcon: SvgIcons.copy,
                        onSuffixIconTap: () {},
                      ),
                    ],
                  )
                : Row(
                    crossAxisAlignment: .center,
                    children: [
                      SizedBox(
                        width: 320,
                        child: BuildTitleWidget(title: 'Current password'),
                      ),
                      Expanded(
                        child: MessTextField(
                          width: 312,
                          hint: '679134-678-3465',
                          readOnly: true,
                          suffixIcon: SvgIcons.copy,
                          onSuffixIconTap: () {},
                        ),
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
