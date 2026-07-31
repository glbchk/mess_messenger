import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:mess_messenger_app/theme/theme_extensions/theme_extension.dart';
import 'package:responsive_framework/responsive_framework.dart';

final selectedBgColorProvider = StateProvider<Color>(
  (ref) => const Color(0xFFD2E3F7),
);

// 🎨 The list of colors from your design mockup
const List<Color> paletteColors = [
  Color(0xFFD2E3F7),
  Color(0xFFF7E8FA),
  Color(0xFFEAD2D7),
  Color(0xFFEAD7D5),
  Color(0xFFE7C4A9),
  Color(0xFFEAE39E),
  Color(0xFFFAF2DC),
  Color(0xFFDFE89D),
  Color(0xFF9DE0AD),
  Color(0xFFCBE7CE),
  Color(0xFFD0E5DF),
  Color(0xFFD0E9E8),
  Color(0xFF9CD5E4),
  Color(0xFFE6CAD6),
  Color(0xFFDEA6DF),
  Color(0xFFFCE6F2),
  Color(0xFFB1A2E0),
  Color(0xFFCBCBEB),
  Color(0xFFCCE8E7),
  Color(0xFFCCE4D5),
  Color(0xFFFAF2DC),
];

class PaletteWidget extends ConsumerWidget {
  final Color selectedColor;
  final double paletteWidth;
  final VoidCallback onTap;

  const PaletteWidget({
    super.key,
    required this.selectedColor,
    required this.paletteWidth,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colors = context.colors;
    final textTheme = context.textStyles;

    final bp = ResponsiveBreakpoints.of(context);

    // final selectedColor = ref.watch(selectedBgColorProvider);

    return SizedBox(
      width: paletteWidth,
      child: Wrap(
        spacing: 8, // ↔️ Horizontal space between circular items
        runSpacing: 8, // ↕️ Vertical space between rows
        children: paletteColors.map((color) {
          final isSelected = selectedColor == color;

          return GestureDetector(
            onTap: () {
              // Update the global state seamlessly on click
              ref.read(selectedBgColorProvider.notifier).state = color;
            },
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: color,
                shape: BoxShape.circle,
                // 💡 Optional: Add a subtle border highlight if the item is selected
                border: Border.all(
                  color: isSelected ? Colors.black54 : Colors.transparent,
                  width: 2,
                ),
              ),
              // 💡 Optional: Show a subtle checkmark or indicator inside the chosen color circle
              child: isSelected
                  ? const Icon(Icons.check, size: 18, color: Colors.black54)
                  : const SizedBox.shrink(),
            ),
          );
        }).toList(),
      ),
    );
  }
}
