import 'package:flutter/material.dart';
import 'package:mess_messenger_app/core/constants/svg_icons.dart';
import 'package:mess_messenger_app/core/utils/spacing/app_spacing.dart';
import 'package:mess_messenger_app/core/widgets/mess_icon.dart';
import 'package:mess_messenger_app/localization/l10n/app_localizations.dart';
import 'package:mess_messenger_app/theme/theme_extensions/theme_extension.dart';
import 'package:responsive_framework/responsive_framework.dart';

class SubscriptionPlanCard extends StatelessWidget {
  final bool value;
  final VoidCallback onTap;
  final String? label;
  final int? price;
  final String? description;
  final VoidCallback onPressedLearnMore;

  const SubscriptionPlanCard({
    super.key,
    required this.value,
    required this.onTap,
    this.label,
    this.price,
    this.description,
    required this.onPressedLearnMore,
  });

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final textTheme = context.textStyles;

    final l10n = AppLocalizations.of(context);
    final bp = ResponsiveBreakpoints.of(context);

    return GestureDetector(
      onTap: onTap,
      child: Stack(
        children: [
          Container(
            height: bp.isTablet ? 196 + 30 : 196,
            width: double.infinity,
            padding: EdgeInsets.all(16),
            decoration: BoxDecoration(
              border: Border.all(
                width: value ? 2 : 1,
                color: value ? colors.text1 : colors.surface4,
                strokeAlign: BorderSide.strokeAlignOutside,
              ),
              borderRadius: BorderRadius.all(Radius.circular(24)),
              color: value ? colors.textInverse : colors.bg,
            ),
            child: Column(
              crossAxisAlignment: .start,
              mainAxisSize: .min,
              children: [
                Text(
                  label ?? 'Free',
                  style: textTheme.headlineLarge?.copyWith(color: colors.text1),
                ),
                AppSpacing.p32.gapV,
                price != null
                    ? Row(
                        crossAxisAlignment: .end,
                        children: [
                          Text(
                            "\$",
                            style: textTheme.displayMedium?.copyWith(
                              color: colors.text1,
                            ),
                          ),
                          Text(
                            price.toString(),
                            style: textTheme.displayMedium?.copyWith(
                              color: colors.text1,
                            ),
                          ),
                          AppSpacing.p4.gapH,
                          Flexible(
                            child: Text(
                              l10n?.perMonth ?? '',
                              maxLines: 1,
                              overflow: .ellipsis,
                              style: textTheme.bodyLarge?.copyWith(
                                color: colors.text2,
                              ),
                            ),
                          ),
                        ],
                      )
                    : Text(
                        l10n?.free ?? '',
                        style: textTheme.displayMedium?.copyWith(
                          color: colors.text1,
                        ),
                      ),
                AppSpacing.p8.gapV,
                Text(
                  description ?? 'Limited features for individuals.',
                  maxLines: 1,
                  overflow: .ellipsis,
                  style: textTheme.bodyLarge?.copyWith(color: colors.text2),
                ),
                GestureDetector(
                  onTap: onPressedLearnMore,
                  child: Text(
                    l10n?.learnMore ?? '',
                    style: textTheme.bodyLarge?.copyWith(color: colors.link),
                  ),
                ),
              ],
            ),
          ),

          if (value)
            Positioned(
              top: 16,
              right: 16,
              child: Container(
                width: 16,
                height: 16,
                decoration: BoxDecoration(
                  color: colors.text1,
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                ),
                child: MessIcon(SvgIcons.verifiedCheckmark, color: colors.bg),
              ),
            ),
        ],
      ),
    );
  }
}
