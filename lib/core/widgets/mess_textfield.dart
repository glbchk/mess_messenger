import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mess_messenger_app/core/utils/spacing/app_spacing.dart';
import 'package:mess_messenger_app/core/widgets/mess_icon.dart';
import 'package:mess_messenger_app/theme/theme_extensions/theme_extension.dart';

class MessTextField extends StatelessWidget {
  final TextEditingController? controller;
  final FocusNode? focusNode;
  final void Function(bool)? onFocusChange;
  final String? label;
  final double? spaceLabel;
  final double? height;
  final double? width;
  final double? radius;
  final String? hint;
  final String? error;
  final String? suffixIcon;
  final VoidCallback? onSuffixIconTap;
  final String? prefixIcon;
  final VoidCallback? onPrefixIconTap;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;
  final List<TextInputFormatter>? inputFormatters;
  final VoidCallback? onTap;
  final Function(String?)? onChanged;
  final TextCapitalization? textCapitalization;
  final bool? autofocus;
  final bool? readOnly;

  const MessTextField({
    super.key,
    this.controller,
    this.focusNode,
    this.onFocusChange,
    this.label,
    this.spaceLabel,
    this.height,
    this.width,
    this.radius,
    this.hint,
    this.error,
    this.suffixIcon,
    this.onSuffixIconTap,
    this.prefixIcon,
    this.onPrefixIconTap,
    this.keyboardType,
    this.textInputAction,
    this.inputFormatters,
    this.onTap,
    this.onChanged,
    this.textCapitalization,
    this.autofocus = false,
    this.readOnly = false,
  });

  @override
  Widget build(BuildContext context) {
    // debugPrint('MessTextField height param = $height');
    final colors = context.colors;
    final textTheme = context.textStyles;

    final borderStyle = OutlineInputBorder(
      borderRadius: BorderRadius.circular(radius ?? 16),
      borderSide: BorderSide.none,
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ?label != null
            ? Text(
                label ?? '',
                style: textTheme.bodySmall?.copyWith(
                  color: context.colors.text1,
                ),
              )
            : null,
        spaceLabel != 0 ? AppSpacing.p8.gapV : SizedBox(height: spaceLabel),
        SizedBox(
          height: height ?? 46,
          width: width ?? double.infinity,
          child: Focus(
            onFocusChange: onFocusChange,
            canRequestFocus: !(readOnly ?? false),
            child: TextField(
              controller: controller,
              readOnly: readOnly ?? false,
              focusNode: focusNode,
              autofocus: autofocus ?? false,
              expands: true,
              maxLines: null,
              minLines: null,
              textAlignVertical: TextAlignVertical.center,
              enableSuggestions: false,
              autocorrect: false,
              keyboardType: keyboardType,
              textInputAction: textInputAction,
              inputFormatters: inputFormatters,
              style: textTheme.bodyMedium?.copyWith(
                color: colors.textPlaceHolder,
              ),
              textCapitalization: textCapitalization ?? TextCapitalization.none,
              onTapUpOutside: (event) {
                FocusManager.instance.primaryFocus?.unfocus();
              },
              onTap: onTap,
              onChanged: (String value) => onChanged?.call(value),
              decoration: InputDecoration(
                hintText: hint,
                prefix: prefixIcon != null ? const SizedBox(width: 12) : null,
                hintStyle: textTheme.bodyMedium?.copyWith(
                  color: colors.textHint,
                ),
                // isDense: true, Needed to increase vertical padding
                filled: true,
                contentPadding: EdgeInsets.symmetric(horizontal: 16),
                prefixIcon: prefixIcon != null
                    ? GestureDetector(
                        onTap: onPrefixIconTap,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 20.0),
                          child: SizedBox(
                            width: 24,
                            height: 24,
                            child: MessIcon(prefixIcon ?? ''),
                          ),
                        ),
                      )
                    : null,
                suffixIcon: suffixIcon != null
                    ? GestureDetector(
                        onTap: onSuffixIconTap,
                        child: Padding(
                          padding: const EdgeInsets.only(right: 16.0),
                          child: SizedBox(
                            width: 24,
                            height: 24,
                            child: MessIcon(suffixIcon ?? ''),
                          ),
                        ),
                      )
                    : null,
                fillColor: colors.surface2,
                hoverColor: colors.surface4,
                border: borderStyle,
                enabledBorder: borderStyle,
                focusedBorder: borderStyle,
                disabledBorder: borderStyle,
                errorBorder: borderStyle,
                focusedErrorBorder: borderStyle,
              ),
            ),
          ),
        ),

        if (error?.isNotEmpty ?? false)
          Padding(
            padding: const EdgeInsets.only(top: 4),
            child: Text(
              error ?? '',
              style: textTheme.bodySmall?.copyWith(color: colors.textHint),
            ),
          ),
      ],
    );
  }
}
