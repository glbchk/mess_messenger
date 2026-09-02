import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:mess_messenger_app/core/utils/colors/palette_colors.dart';
import 'package:mess_messenger_app/theme/theme_extensions/theme_extension.dart';
import 'package:responsive_framework/responsive_framework.dart';

final selectedBgColorProvider = StateProvider<Color>(
  (ref) => const Color(0xFFD2E3F7),
);

class PaletteWidget extends ConsumerWidget {
  final int selectedIndex;
  final double paletteWidth;
  final ValueChanged<int> onColorSelected;

  const PaletteWidget({
    super.key,
    required this.selectedIndex,
    required this.paletteWidth,
    required this.onColorSelected,
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
        children: List.generate(Palette.colors.length, (index) {
          final isSelected = index == selectedIndex;

          return GestureDetector(
            onTap: () => onColorSelected(index),
            // Update the global state seamlessly on click
            // ref.read(selectedBgColorProvider.notifier).state = color;
            // },
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: Palette.colors[index],
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
