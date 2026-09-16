import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mess_messenger_app/core/utils/colors/palette_colors.dart';
import 'package:mess_messenger_app/theme/theme_extensions/theme_extension.dart';

class PaletteWidget extends ConsumerWidget {
  final Palette selectedColor;
  final double paletteWidth;
  final ValueChanged<Palette> onColorSelected;

  const PaletteWidget({
    super.key,
    required this.selectedColor,
    required this.paletteWidth,
    required this.onColorSelected,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colors = context.colors;

    return SizedBox(
      width: paletteWidth,
      child: Wrap(
        spacing: 8,
        runSpacing: 8,
        children: Palette.values.map((palette) {
          final isSelected = palette == selectedColor;

          return GestureDetector(
            onTap: () => onColorSelected(palette),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: palette.color,
                shape: .circle,
                border: Border.all(
                  color: isSelected ? colors.icon1 : Colors.transparent,
                  width: 2,
                ),
              ),
              child: isSelected
                  ? Icon(Icons.check, size: 18, color: colors.icon1)
                  : const SizedBox.shrink(),
            ),
          );
        }).toList(),
      ),
    );
  }
}
