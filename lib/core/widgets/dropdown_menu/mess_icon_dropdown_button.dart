import 'package:flutter/material.dart';
import 'package:mess_messenger_app/core/widgets/mess_icon_button.dart';
import 'package:mess_messenger_app/features/settings/presentation/pages/ui_helpers/build_dropdown_item_widget.dart';
import 'package:mess_messenger_app/theme/theme_extensions/theme_extension.dart';

class MessIconDropdownButton<T> extends StatelessWidget {
  final String svgAsset;
  final List<T> items;
  final T? selectedValue;
  final ValueChanged<T>? onItemTap;
  final String Function(T item)? itemLabelBuilder;
  final Color? Function(T item)? textColorBuilder;
  final double iconSize;
  final double buttonSize;
  final Color? iconColor;
  final double? borderWidth;
  final bool isButtonFilled;

  const MessIconDropdownButton({
    super.key,
    required this.svgAsset,
    required this.items,
    this.selectedValue,
    this.onItemTap,
    this.itemLabelBuilder,
    this.textColorBuilder,
    this.iconSize = 24,
    this.buttonSize = 44,
    this.iconColor,
    this.borderWidth,
    this.isButtonFilled = false,
  });

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;

    return Directionality(
      textDirection: .rtl,
      child: MenuAnchor(
        alignmentOffset: const Offset(0, 8),
        style: MenuStyle(
          backgroundColor: WidgetStatePropertyAll(colors.bg),
          surfaceTintColor: WidgetStatePropertyAll(colors.transparent),
          elevation: const WidgetStatePropertyAll(12),
          shadowColor: WidgetStatePropertyAll(
            colors.shadowColor.withValues(alpha: 0.3),
          ),
          shape: WidgetStatePropertyAll(
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          ),
          minimumSize: WidgetStatePropertyAll(.zero),
          maximumSize: WidgetStatePropertyAll(Size(320, 400)),
        ),
        menuChildren: [
          for (final item in items)
            BuildDropdownItemWidget(
              value: itemLabelBuilder?.call(item) ?? item.toString(),
              selectedValue: selectedValue?.toString() ?? '',
              textColor: textColorBuilder?.call(item),
              onPressed: () {
                onItemTap?.call(item);
              },
            ),
        ],
        builder: (context, controller, child) {
          return MessIconButton(
            svgAsset,
            iconSize: iconSize,
            buttonSize: buttonSize,
            iconColor: iconColor,
            borderWidth: borderWidth,
            isButtonFilled: isButtonFilled,
            onPressed: () =>
                controller.isOpen ? controller.close() : controller.open(),
          );
        },
      ),
    );
  }
}
