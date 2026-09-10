import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mess_messenger_app/core/constants/svg_icons.dart';
import 'package:mess_messenger_app/core/utils/spacing/app_spacing.dart';
import 'package:mess_messenger_app/core/widgets/mess_icon.dart';
import 'package:mess_messenger_app/theme/theme_extensions/theme_extension.dart';

class MessPasswordField extends StatelessWidget {
  final TextEditingController? controller;
  final FocusNode? focusNode;
  final void Function(bool)? onFocusChange;
  final String? label;
  final double? spaceLabel;
  final double? height;
  final String? hint;
  final String? error;
  final VoidCallback? onSuffixIconTap;
  final String? prefixIcon;
  final VoidCallback? onPrefixIconTap;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;
  final List<TextInputFormatter>? inputFormatters;
  final VoidCallback? onTap;
  final Function(String?)? onChanged;
  final TextCapitalization? textCapitalization;
  final bool? showPassword;
  final bool? autofocus;
  final bool? readOnly;

  const MessPasswordField({
    super.key,
    this.controller,
    this.focusNode,
    this.onFocusChange,
    this.label,
    this.spaceLabel,
    this.height,
    this.hint,
    this.error,
    this.onSuffixIconTap,
    this.prefixIcon,
    this.onPrefixIconTap,
    this.showPassword,
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
    final colors = context.colors;
    final textTheme = context.textStyles;

    final borderStyle = OutlineInputBorder(
      borderRadius: BorderRadius.circular(16),
      borderSide: BorderSide.none,
    );

    return Column(
      crossAxisAlignment: .start,
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
          child: Focus(
            onFocusChange: onFocusChange,
            canRequestFocus: !(readOnly ?? false),
            child: TextField(
              controller: controller,
              readOnly: readOnly ?? false,
              focusNode: focusNode,
              autofocus: autofocus ?? false,
              maxLines: 1,
              textAlignVertical: TextAlignVertical.center,
              obscureText: showPassword == true ? false : true,
              enableSuggestions: false,
              autocorrect: false,
              keyboardType: keyboardType,
              textInputAction: textInputAction,
              autofillHints: const [AutofillHints.password],
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
                prefix: prefixIcon != null ? const SizedBox(width: 8) : null,
                hintStyle: textTheme.bodyMedium?.copyWith(
                  color: colors.textHint,
                ),
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
                suffixIcon: GestureDetector(
                  onTap: onSuffixIconTap,
                  child: Padding(
                    padding: const EdgeInsets.only(
                      left: 12,
                      top: 12,
                      right: 16,
                      bottom: 12,
                    ),
                    child: MessIcon(
                      showPassword != true ? SvgIcons.viewOff : SvgIcons.view,
                      size: 18,
                    ),
                  ),
                ),
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
