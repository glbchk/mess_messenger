import 'package:flutter/material.dart';
import 'package:mess_messenger_app/theme/theme_extensions/theme_extension.dart';

class CustomSwitch extends StatelessWidget {
  final bool value;
  final ValueChanged<bool> onChanged;
  // final Color activeTrackColor;
  // final Color inactiveTrackColor;
  // final Color thumbColor;

  const CustomSwitch({
    super.key,
    required this.value,
    required this.onChanged,
    // this.activeTrackColor = colors.text1,
    // this.inactiveTrackColor = colors.surface3,
    // this.thumbColor = Colors.white,
  });

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;

    return GestureDetector(
      onTap: () => onChanged(!value),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        width: 48, // 💡 Customize width of the switch
        height: 26, // 💡 Customize height of the switch
        padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: value ? colors.text1 : colors.surface3,
        ),
        child: AnimatedAlign(
          duration: const Duration(milliseconds: 200),
          alignment: value ? Alignment.centerRight : Alignment.centerLeft,
          child: Container(
            width: 18, // 💡 Customize thumb size
            height: 18,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: colors.bg,
              // ── Custom Thumb Shadow ─────────────────────────
              boxShadow: [
                BoxShadow(
                  color: colors.text1.withValues(alpha: 0.16), // Shadow color
                  blurRadius: 3, // Softness of the shadow
                  spreadRadius: 0, // Size of the shadow
                  offset: const Offset(0, 1), // Downward position (x, y)
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
