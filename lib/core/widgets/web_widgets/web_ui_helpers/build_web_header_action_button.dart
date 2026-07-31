import 'package:flutter/material.dart';
import 'package:mess_messenger_app/core/widgets/mess_icon_button.dart';
import 'package:mess_messenger_app/theme/theme_extensions/theme_extension.dart';

MessIconButton buildWebHeaderActionButton({
  required BuildContext context,
  required String iconPath,
  double? size,
  double? buttonSize,
  required VoidCallback onPressed,
}) {
  final colors = context.colors;

  return MessIconButton(
    iconPath,
    iconSize: size ?? 20,
    buttonSize: buttonSize ?? 36,
    iconColor: colors.icon1,
    onPressed: () {
      onPressed();
    },
  );
}
