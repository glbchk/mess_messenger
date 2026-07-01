import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mess_messenger_app/core/utils/spacing/app_spacing.dart';
import 'package:mess_messenger_app/theme/theme_extensions/theme_extension.dart';

class MessTextField extends StatelessWidget {
  final TextEditingController? controller;
  final FocusNode? focusNode;
  final void Function(bool)? onFocusChange;
  final String? label;
  final double? spaceLabel;
  final double? height;
  final String? hint;
  final String? error;
  final Widget? suffixIcon;
  final Color? suffixIconColor;
  final VoidCallback? onSuffixIconTap;
  final Widget? prefixIcon;
  final Color? prefixIconColor;
  final VoidCallback? onPrefixIconTap;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;
  final List<TextInputFormatter>? inputFormatters;
  final VoidCallback? onTap;
  final Function(String?)? onChanged;
  final TextCapitalization? textCapitalization;
  final bool? isPassword;
  final bool? showPassword;
  final FormFieldValidator<String>? validator;
  final bool? autofocus;
  final bool? readOnly;
  final String? initialValue;

  const MessTextField({
    super.key,
    this.controller,
    this.focusNode,
    this.onFocusChange,
    this.label,
    this.spaceLabel,
    this.height,
    this.hint,
    this.error,
    this.suffixIcon,
    this.suffixIconColor,
    this.onSuffixIconTap,
    this.prefixIcon,
    this.prefixIconColor,
    this.onPrefixIconTap,
    this.isPassword,
    this.showPassword,
    this.keyboardType,
    this.textInputAction,
    this.inputFormatters,
    this.onTap,
    this.onChanged,
    this.textCapitalization,
    this.validator,
    this.autofocus = false,
    this.readOnly = false,
    this.initialValue,
  });

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final textTheme = context.textStyles;

    final borderStyle = OutlineInputBorder(
      borderRadius: BorderRadius.circular(32),
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
        AppSpacing.p8.gapV,
        Focus(
          onFocusChange: onFocusChange,
          canRequestFocus: !(readOnly ?? false),
          child: TextFormField(
            controller: controller,
            readOnly: readOnly ?? false,
            initialValue: initialValue,
            focusNode: focusNode,
            autofocus: autofocus ?? false,
            obscureText: isPassword == true ? !(showPassword ?? false) : false,
            enableSuggestions: isPassword == false,
            autocorrect: isPassword == false,
            keyboardType: keyboardType,
            textInputAction: textInputAction,
            autofillHints: isPassword ?? false
                ? const [AutofillHints.password]
                : null,
            inputFormatters: inputFormatters,
            validator: validator,
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
              contentPadding: const EdgeInsets.symmetric(horizontal: 16),
              hintStyle: textTheme.bodyMedium?.copyWith(color: colors.textHint),
              prefixIcon: prefixIcon != null
                  ? GestureDetector(
                      onTap: onPrefixIconTap,
                      child: IconTheme(
                        data: IconThemeData(
                          color: prefixIconColor ?? colors.text1,
                          size: 24,
                        ),
                        child: Padding(
                          padding: const EdgeInsets.only(left: 16.0),
                          child: SizedBox(
                            width: 24,
                            height: 24,
                            child: Center(child: prefixIcon!),
                          ),
                        ),
                      ),
                    )
                  : null,
              suffixIcon: isPassword == true
                  ? SizedBox(
                      width: 24,
                      height: 24,
                      child: GestureDetector(
                        onTap: onSuffixIconTap,
                        child: showPassword != true
                            ? SvgPicture.asset(
                                'assets/icons/view_off.svg',
                                width: 16,
                                height: 16,
                                fit: BoxFit.scaleDown,
                              )
                            : SvgPicture.asset(
                                'assets/icons/view.svg',
                                width: 16,
                                height: 16,
                                fit: BoxFit.scaleDown,
                              ),
                      ),
                    )
                  : suffixIcon,
              filled: true,
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
