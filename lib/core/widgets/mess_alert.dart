import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mess_messenger_app/core/utils/spacing/app_spacing.dart';
import 'package:mess_messenger_app/core/widgets/mess_main_button.dart';
import 'package:mess_messenger_app/core/widgets/mess_textfield.dart';
import 'package:mess_messenger_app/core/widgets/mess_image_selector.dart';
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
  final Future<void> Function(XFile? selectedImage)? onConfirmWithImage;
  final bool? pictureSelectorEnabled;

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
    this.onConfirmWithImage,
    this.pictureSelectorEnabled = false,
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
    Future<void> Function(XFile? selectedImage)? onConfirmWithImage,
    bool? pictureSelectorEnabled,
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
        onConfirmWithImage: onConfirmWithImage,
        pictureSelectorEnabled: pictureSelectorEnabled,
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

  Uint8List? _previewBytes;
  final ImagePicker _picker = ImagePicker();

  @override
  void initState() {
    super.initState();
    _error1 = widget.textfieldError;
    _error2 = widget.textfield2Error;
  }

  bool _validateFields() {
    final val1 = widget.textfieldController?.text.trim() ?? '';
    final val2 = widget.textfield2Controller?.text.trim() ?? '';

    setState(() {
      _error1 = null;
      _error2 = null;
    });

    bool isValid = true;

    if (widget.textfieldController != null && val1.isEmpty) {
      _error1 = 'This field is required';
      isValid = false;
    }

    if (widget.textfield2Controller != null) {
      if (val2.isEmpty) {
        _error2 = 'This field is required';
        isValid = false;
      } else if (widget.textfieldController != null && val1 == val2) {
        _error2 = 'New password cannot be the same as current password';
        isValid = false;
      }
    }

    if (!isValid) setState(() {});
    return isValid;
  }

  Future<void> _submit(Future<void> Function() action) async {
    try {
      setState(() => _isLoading = true);
      await action();
      if (mounted) Navigator.pop(context);
    } catch (e) {
      if (mounted) {
        setState(() {
          _isLoading = false;
          _error1 = e.toString().replaceAll('Exception: ', '');
        });
      }
    }
  }

  Future<void> _handleConfirm() async {
    if (!_validateFields()) return;
    await _submit(() => widget.onConfirm?.call() ?? Future.value());
  }

  Future<void> _handleImagePick(ImageSource source) async {
    final XFile? pickedFile = await _picker.pickImage(source: source);
    if (pickedFile == null) return;
    final bytes = await pickedFile.readAsBytes();
    setState(() => _previewBytes = bytes);
    await _submit(
      () => widget.onConfirmWithImage?.call(pickedFile) ?? Future.value(),
    );
  }

  // Widget _buildImagePreview(dynamic colors) {
  //   return Column(
  //     children: [
  //       Container(
  //         height: 120,
  //         width: 120,
  //         decoration: BoxDecoration(
  //           color: colors.componentSpecific ?? Colors.grey[200],
  //           shape: BoxShape.circle,
  //           image: _selectedImage != null
  //               ? DecorationImage(
  //                   image: FileImage(_selectedImage!),
  //                   fit: BoxFit.cover,
  //                 )
  //               : null,
  //         ),
  //         child: _selectedImage == null
  //             ? const Icon(Icons.add_a_photo, size: 40, color: Colors.grey)
  //             : null,
  //       ),
  //       const SizedBox(height: 20),
  //     ],
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final textTheme = context.textStyles;
    final isPictureMode = widget.pictureSelectorEnabled ?? false;

    return AlertDialog(
      backgroundColor: colors.bg,
      insetPadding: const EdgeInsets.symmetric(horizontal: 20.0),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: .center,
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
          if (isPictureMode) MessImageSelector(imageBytes: _previewBytes),
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
      actions: isPictureMode
          ? [
              MessMainButton(
                label: _isLoading
                    ? 'Saving...'
                    : (widget.buttonLabel ?? 'Take a picture'),
                onPressed: _isLoading
                    ? null
                    : () => _handleImagePick(ImageSource.camera),
              ),
              if (widget.secondaryButtonLabel != null) ...[
                AppSpacing.p16.gapV,
                MessMainButton(
                  label: widget.secondaryButtonLabel!,
                  backgroundColor: colors.surface2,
                  textColor: colors.text1,
                  onPressed: _isLoading
                      ? null
                      : () => _handleImagePick(ImageSource.gallery),
                ),
              ],
            ]
          : [
              if (widget.textfieldController != null ||
                  widget.onConfirm != null)
                MessMainButton(
                  label: _isLoading
                      ? 'Saving...'
                      : (widget.buttonLabel ?? 'Confirm'),
                  onPressed: _isLoading ? null : _handleConfirm,
                ),
              if (widget.secondaryButtonLabel != null) ...[
                AppSpacing.p16.gapV,
                MessMainButton(
                  label: widget.secondaryButtonLabel!,
                  backgroundColor: colors.surface2,
                  textColor: colors.text1,
                  onPressed: widget.onSecondaryPressed,
                ),
              ],
            ],
    );
  }
}
