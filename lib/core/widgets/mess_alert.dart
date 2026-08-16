import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mess_messenger_app/core/utils/spacing/app_spacing.dart';
import 'package:mess_messenger_app/core/widgets/mess_main_button.dart';
import 'package:mess_messenger_app/core/widgets/mess_textfield.dart';
import 'package:mess_messenger_app/theme/theme_extensions/theme_extension.dart';

class MessAlertWidget extends ConsumerStatefulWidget {
  final String title;
  final String? message;
  final String? textfieldLabel;
  final String? textfieldHint;
  final TextEditingController? textfieldController;
  final String? textfieldError;
  final String? textfield2Label;
  final String? textfield2Hint;
  final TextEditingController? textfield2Controller;
  final String? textfield2Error;
  final String? buttonLabel;
  final String? secondaryButtonLabel; // NEW — e.g. "Later"
  final VoidCallback? onSecondaryPressed; // NEW — defaults to just closing
  final Future<void> Function()? onConfirm;

  const MessAlertWidget({
    super.key,
    required this.title,
    this.message,
    this.textfieldLabel,
    this.textfieldHint,
    this.textfieldController,
    this.textfieldError,
    this.textfield2Label,
    this.textfield2Hint,
    this.textfield2Controller,
    this.textfield2Error,
    this.buttonLabel,
    this.secondaryButtonLabel,
    this.onSecondaryPressed,
    this.onConfirm,
  });

  static Future<void> show({
    required BuildContext context,
    required WidgetRef ref,
    required String title,
    String? message,
    String? textfieldLabel,
    String? textfieldHint,
    TextEditingController? textfieldController,
    String? textfieldError,
    String? textfield2Label,
    String? textfield2Hint,
    TextEditingController? textfield2Controller,
    String? textfield2Error,
    String? buttonLabel,
    String? secondaryButtonLabel,
    VoidCallback? onSecondaryPressed,
    Future<void> Function()? onConfirm,
  }) {
    return showDialog(
      context: context,
      builder: (dialogContext) => MessAlertWidget(
        title: title,
        message: message,
        textfieldLabel: textfieldLabel,
        textfieldHint: textfieldHint,
        textfieldController: textfieldController,
        textfieldError: textfieldError,
        textfield2Label: textfield2Label,
        textfield2Hint: textfield2Hint,
        textfield2Controller: textfield2Controller,
        textfield2Error: textfield2Error,
        buttonLabel: buttonLabel,
        secondaryButtonLabel: secondaryButtonLabel,
        onSecondaryPressed: () {
          onSecondaryPressed?.call();
          if (dialogContext.mounted) Navigator.pop(dialogContext);
        },
        onConfirm: onConfirm,
      ),
    );
  }

  @override
  ConsumerState<MessAlertWidget> createState() => _MessAlertWidgetState();
}

class _MessAlertWidgetState extends ConsumerState<MessAlertWidget> {
  String? _error1;
  String? _error2;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _error1 = widget.textfieldError;
    _error2 = widget.textfield2Error;
  }

  Future<void> _validateAndSubmit() async {
    final val1 = widget.textfieldController?.text.trim() ?? '';
    final val2 = widget.textfield2Controller?.text.trim() ?? '';

    // Reset local errors before validating
    setState(() {
      _error1 = null;
      _error2 = null;
    });

    bool isValid = true;

    // 1. First field validation
    if (widget.textfieldController != null && val1.isEmpty) {
      _error1 = 'This field is required';
      isValid = false;
    }

    // 2. Second field validation
    if (widget.textfield2Controller != null) {
      if (val2.isEmpty) {
        _error2 = 'This field is required';
        isValid = false;
      } else if (widget.textfieldController != null && val1 == val2) {
        // Same password check
        _error2 = 'New password cannot be the same as current password';
        isValid = false;
      }
    }

    if (!isValid) {
      setState(() {});
      return;
    }

    // 3. Perform confirm action if validation passes
    try {
      setState(() => _isLoading = true);
      await widget.onConfirm?.call();
      if (mounted) Navigator.pop(context);
    } catch (e) {
      if (mounted) {
        setState(() {
          _isLoading = false;
          // Display API / Auth exception message in dialog
          _error1 = e.toString().replaceAll('Exception: ', '');
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final textTheme = context.textStyles;

    return AlertDialog(
      backgroundColor: colors.bg,
      insetPadding: const EdgeInsets.symmetric(horizontal: 20.0),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            margin: const EdgeInsets.symmetric(
              horizontal: 24.0,
              vertical: 10.0,
            ),
            child: Column(
              children: [
                Text(
                  widget.title,
                  style: textTheme.headlineLarge?.copyWith(color: colors.text1),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 12),
                Text(
                  widget.message ?? '',
                  style: textTheme.bodyLarge?.copyWith(color: colors.text2),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 30),
              ],
            ),
          ),
          // Only render the password field(s) if a controller was actually given
          if (widget.textfieldController != null) ...[
            MessTextField(
              label: widget.textfieldLabel ?? 'Label',
              controller: widget.textfieldController,
              autofocus: true,
              hint: widget.textfieldHint ?? 'Input values...',
              error: _error1,
              onChanged: (_) {
                if (_error1 != null) setState(() => _error1 = null);
              },
            ),
            const SizedBox(height: 20),
          ],
          if (widget.textfield2Controller != null) ...[
            MessTextField(
              label: widget.textfield2Label ?? 'Label',
              controller: widget.textfield2Controller,
              autofocus: true,
              hint: widget.textfield2Hint ?? 'Input values...',
              error: _error2,
              onChanged: (_) {
                if (_error2 != null) setState(() => _error2 = null);
              },
            ),
            const SizedBox(height: 20),
          ],
        ],
      ),
      actions: [
        if (widget.textfieldController != null)
          MessMainButton(
            label: _isLoading ? 'Saving...' : (widget.buttonLabel ?? 'Confirm'),
            onPressed: _isLoading ? null : _validateAndSubmit,
          ),
        if (widget.secondaryButtonLabel != null) ...[
          AppSpacing.p16.gapV,
          MessMainButton(
            label: widget.secondaryButtonLabel ?? '',
            backgroundColor: colors.surface2,
            textColor: colors.text1,
            onPressed: widget.onSecondaryPressed,
          ),
        ],
      ],
    );
  }
}
