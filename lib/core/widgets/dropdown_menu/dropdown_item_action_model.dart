import 'package:flutter/material.dart';

class DropdownItemAction {
  final String label;
  final VoidCallback onTap;
  final Color? textColor;

  const DropdownItemAction({
    required this.label,
    required this.onTap,
    this.textColor,
  });
}
