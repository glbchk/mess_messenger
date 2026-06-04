import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mess_messenger_app/theme/theme_extensions/color_extension.dart';

class MessTextField extends StatelessWidget {
  final TextEditingController? controller;
  final FocusNode? focusNode;
  final void Function(bool)? onFocusChange;
  final String? label;
  final double? spaceLabel;
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
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: colors.text1,
                ),
              )
            : null,
        SizedBox(height: spaceLabel ?? 8.0),
        Focus(
          onFocusChange: onFocusChange,
          canRequestFocus: !(readOnly ?? false),
          child: SizedBox(
            height: 40,
            child: TextFormField(
              controller: controller,
              readOnly: readOnly ?? false,
              initialValue: initialValue,
              focusNode: focusNode,
              autofocus: autofocus ?? true,
              obscureText: isPassword == true
                  ? !(showPassword ?? false)
                  : false,
              enableSuggestions: isPassword == false,
              autocorrect: isPassword == false,
              keyboardType: keyboardType,
              textInputAction: textInputAction,
              autofillHints: isPassword ?? false
                  ? const [AutofillHints.password]
                  : null,
              inputFormatters: inputFormatters,
              validator: validator,
              style: TextStyle(color: colors.text1),
              textCapitalization: textCapitalization ?? TextCapitalization.none,
              onTapUpOutside: (event) {
                FocusManager.instance.primaryFocus?.unfocus();
              },
              onTap: onTap,
              onChanged: (String value) => onChanged?.call(value),
              decoration: InputDecoration(
                hintText: hint,
                hintStyle: TextStyle(color: colors.textPlaceHolder),
                contentPadding: const EdgeInsets.symmetric(horizontal: 16),
                prefixIcon: prefixIcon != null
                    ? GestureDetector(
                        onTap: onPrefixIconTap,
                        child: IconTheme(
                          data: IconThemeData(
                            color: prefixIconColor ?? colors.text1,
                            size: 24,
                          ),
                          child: SizedBox(
                            width: 24,
                            height: 24,
                            child: Center(child: prefixIcon!),
                          ),
                        ),
                      )
                    : null,
                suffixIcon: isPassword == true
                    ? IconButton(
                        icon: Icon(
                          showPassword != true
                              ? Icons.visibility_off
                              : Icons.visibility,
                        ),
                        onPressed: onSuffixIconTap,
                      )
                    : suffixIcon,
                filled: true,
                fillColor: colors.surface2,
                hoverColor: colors.text2,
                // fillColor: WidgetStateColor.resolveWith((states) {
                //   if (readOnly == true || states.contains(WidgetState.disabled)) {
                //     return colors.surface2;
                //   }
                //   // if (states.contains(WidgetState.focused)) {
                //   //   return colors.surface0;
                //   // }
                //   return colors.surface2;
                // }),
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
              style: TextStyle(color: colors.text1, fontSize: 12),
            ),
          ),
      ],
    );
  }
}
