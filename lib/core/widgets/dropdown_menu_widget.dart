import 'package:flutter/material.dart';
import 'package:mess_messenger_app/core/constants/svg_icons.dart';
import 'package:mess_messenger_app/core/widgets/mess_icon.dart';
import 'package:mess_messenger_app/features/settings/presentation/pages/ui_helpers/build_dropdown_item_widget.dart';
import 'package:mess_messenger_app/theme/theme_extensions/theme_extension.dart';

class DropdownMenuWidget extends StatefulWidget {
  final List<String> languages;
  final MenuController menuController;
  final double constraintSize;

  const DropdownMenuWidget({
    super.key,
    required this.languages,
    required this.menuController,
    this.constraintSize = 288,
  });

  @override
  State<DropdownMenuWidget> createState() => _DropdownMenuWidgetState();
}

class _DropdownMenuWidgetState extends State<DropdownMenuWidget> {
  bool isOpen = false;
  String _selectedLanguage = 'Default';

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final textTheme = context.textStyles;

    return Align(
      alignment: Alignment.centerLeft,
      child: MenuAnchor(
        controller: widget.menuController,
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
          minimumSize: WidgetStatePropertyAll(Size(widget.constraintSize, 0)),
          maximumSize: WidgetStatePropertyAll(Size(widget.constraintSize, 400)),
        ),

        menuChildren: [
          for (final language in widget.languages)
            BuildDropdownItemWidget(
              value: language,
              selectedValue: _selectedLanguage,
              constraintSize: widget.constraintSize,
              onPressed: () => setState(() => _selectedLanguage = language),
            ),
        ],

        builder: (context, localController, child) {
          final isOpen = localController.isOpen;

          return ConstrainedBox(
            constraints: BoxConstraints(maxWidth: widget.constraintSize),
            child: InkWell(
              borderRadius: BorderRadius.circular(16),
              hoverColor: colors.surface4,
              splashColor: colors.surface2,
              onTap: () =>
                  isOpen ? localController.close() : localController.open(),
              child: Ink(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 12,
                ),
                decoration: BoxDecoration(
                  color: isOpen ? colors.bg : colors.surface2,
                  border: Border.all(
                    color: isOpen ? colors.border2 : colors.transparent,
                    width: 1,
                  ),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Row(
                  children: [
                    MessIcon(SvgIcons.globe, color: colors.text1, size: 20),
                    const SizedBox(width: 12),
                    Text(
                      _selectedLanguage,
                      style: textTheme.labelLarge?.copyWith(
                        color: colors.text1,
                      ),
                    ),
                    const Spacer(),
                    MessIcon(
                      isOpen ? SvgIcons.chevronUp : SvgIcons.chevronDown,
                      color: colors.text1,
                      size: 20,
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
