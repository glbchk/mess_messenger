import 'package:flutter/material.dart';
import 'package:mess_messenger_app/core/constants/svg_icons.dart';
import 'package:mess_messenger_app/core/utils/spacing/app_spacing.dart';
import 'package:mess_messenger_app/core/widgets/mess_icon.dart';
import 'package:mess_messenger_app/theme/theme_extensions/theme_extension.dart';

class CustomSearchField extends StatefulWidget {
  final TextEditingController controller;
  final Function(String?)? onChanged;
  final String? hintText;
  final bool autoFocus;

  const CustomSearchField({
    super.key,
    required this.controller,
    this.onChanged,
    this.hintText,
    this.autoFocus = false,
  });

  @override
  State<CustomSearchField> createState() => _CustomSearchFieldState();
}

class _CustomSearchFieldState extends State<CustomSearchField> {
  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final textTheme = context.textStyles;

    return Container(
      height: 72,
      // color: colors.errorColor,
      alignment: .center,
      child: TextField(
        controller: widget.controller,
        onChanged: widget.onChanged,
        autofocus: widget.autoFocus,
        decoration: InputDecoration(
          hintText: widget.hintText ?? 'Type a command or search here...',
          hintStyle: textTheme.headlineMedium?.copyWith(
            color: colors.textPlaceHolder,
          ),
          prefixIcon: Padding(
            padding: const EdgeInsets.only(left: 24.0),
            child: SizedBox(
              width: 24,
              height: 24,
              child: MessIcon(SvgIcons.search),
            ),
          ),
          suffixIcon: ValueListenableBuilder<TextEditingValue>(
            valueListenable: widget.controller,
            builder: (context, value, child) {
              return value.text.isNotEmpty
                  ? GestureDetector(
                      onTap: () {
                        widget.controller.clear();
                      },
                      child: Padding(
                        padding: const EdgeInsets.only(right: 38.0),
                        child: SizedBox(
                          width: 24,
                          height: 24,
                          child: MessIcon(SvgIcons.close),
                        ),
                      ),
                    )
                  : const SizedBox.shrink();
            },
          ),
          border: .none,
          prefix: AppSpacing.p12.gapH,
          contentPadding: const EdgeInsets.symmetric(vertical: 16.0),
        ),
        style: textTheme.headlineMedium?.copyWith(color: colors.text1),
      ),
    );
  }
}
