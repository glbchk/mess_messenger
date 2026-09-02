import 'package:flutter/material.dart';
import 'package:mess_messenger_app/core/widgets/mess_switch.dart';
import 'package:mess_messenger_app/theme/theme_extensions/theme_extension.dart';
import 'package:responsive_framework/responsive_framework.dart';

class NotificationSelector extends StatelessWidget {
  final String title;
  final String description;
  final bool firstValue;
  final bool secondValue;
  final bool thirdValue;
  final ValueChanged<bool> onFirstSwitchChanged;
  final ValueChanged<bool> onSecondSwitchChanged;
  final ValueChanged<bool> onThirdSwitchChanged;
  // final Color activeTrackColor;
  // final Color inactiveTrackColor;
  // final Color thumbColor;

  const NotificationSelector({
    super.key,
    required this.title,
    required this.description,
    required this.firstValue,
    required this.secondValue,
    required this.thirdValue,
    required this.onFirstSwitchChanged,
    required this.onSecondSwitchChanged,
    required this.onThirdSwitchChanged,
    // this.activeTrackColor = colors.text1,
    // this.inactiveTrackColor = colors.surface3,
    // this.thumbColor = Colors.white,
  });

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final textTheme = context.textStyles;

    final bp = ResponsiveBreakpoints.of(context);

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 24),
      decoration: BoxDecoration(
        border: Border(bottom: BorderSide(color: colors.surface3, width: 1)),
      ),
      child: bp.isMobile
          ? Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: 16,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: textTheme.titleMedium?.copyWith(
                        color: colors.text1,
                      ),
                    ),
                    Text(
                      description,
                      style: textTheme.bodyMedium?.copyWith(
                        color: colors.text2,
                      ),
                    ),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: 16,
                  children: [
                    Row(
                      spacing: 8,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        MessSwitch(
                          value: firstValue,
                          onChanged: (bool value) =>
                              onFirstSwitchChanged(!firstValue),
                        ),
                        Text(
                          'Email',
                          style: textTheme.bodyLarge?.copyWith(
                            color: colors.text1,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      spacing: 8,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        MessSwitch(
                          value: secondValue,
                          onChanged: (bool value) =>
                              onSecondSwitchChanged(!secondValue),
                        ),
                        Text(
                          'Desktop',
                          style: textTheme.bodyLarge?.copyWith(
                            color: colors.text1,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      spacing: 8,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        MessSwitch(
                          value: thirdValue,
                          onChanged: (bool value) =>
                              onThirdSwitchChanged(!thirdValue),
                        ),
                        Text(
                          'Push',
                          style: textTheme.bodyLarge?.copyWith(
                            color: colors.text1,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            )
          : Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: 32,
              children: [
                SizedBox(
                  width: 290,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: textTheme.titleMedium?.copyWith(
                          color: colors.text1,
                        ),
                      ),
                      Text(
                        description,
                        style: textTheme.bodyMedium?.copyWith(
                          color: colors.text2,
                        ),
                      ),
                    ],
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: 16,
                  children: [
                    Row(
                      spacing: 8,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        MessSwitch(
                          value: firstValue,
                          onChanged: (bool value) =>
                              onFirstSwitchChanged(!firstValue),
                        ),
                        Text(
                          'Email',
                          style: textTheme.bodyLarge?.copyWith(
                            color: colors.text1,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      spacing: 8,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        MessSwitch(
                          value: secondValue,
                          onChanged: (bool value) =>
                              onSecondSwitchChanged(!secondValue),
                        ),
                        Text(
                          'Desktop',
                          style: textTheme.bodyLarge?.copyWith(
                            color: colors.text1,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      spacing: 8,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        MessSwitch(
                          value: thirdValue,
                          onChanged: (bool value) =>
                              onThirdSwitchChanged(!thirdValue),
                        ),
                        Text(
                          'Push',
                          style: textTheme.bodyLarge?.copyWith(
                            color: colors.text1,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
    );

    // GestureDetector(
    //   onTap: () => onChanged(!firstValue),
    //   child: AnimatedContainer(
    //     duration: const Duration(milliseconds: 200),
    //     width: 48, // 💡 Customize width of the switch
    //     height: 26, // 💡 Customize height of the switch
    //     padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
    //     decoration: BoxDecoration(
    //       borderRadius: BorderRadius.circular(12),
    //       color: firstValue ? colors.text1 : colors.surface3,
    //     ),
    //     child: AnimatedAlign(
    //       duration: const Duration(milliseconds: 200),
    //       alignment: firstValue ? Alignment.centerRight : Alignment.centerLeft,
    //       child: Container(
    //         width: 18, // 💡 Customize thumb size
    //         height: 18,
    //         decoration: BoxDecoration(
    //           shape: BoxShape.circle,
    //           color: colors.bg,
    //           // ── Custom Thumb Shadow ─────────────────────────
    //           boxShadow: [
    //             BoxShadow(
    //               color: colors.text1.withValues(alpha: 0.16), // Shadow color
    //               blurRadius: 3, // Softness of the shadow
    //               spreadRadius: 0, // Size of the shadow
    //               offset: const Offset(0, 1), // Downward position (x, y)
    //             ),
    //           ],
    //         ),
    //       ),
    //     ),
    //   ),
    // );
  }
}
