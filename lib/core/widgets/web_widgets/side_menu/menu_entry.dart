import 'dart:ui';

sealed class MenuEntry {
  const MenuEntry();
}

class MenuItem extends MenuEntry {
  final String id;
  final String iconPath;
  final String label;
  final VoidCallback onTap;

  const MenuItem({
    required this.id,
    required this.iconPath,
    required this.label,
    required this.onTap,
  });
}

class FlexSpacer extends MenuEntry {
  const FlexSpacer();
}

class ColumnExtension extends MenuEntry {
  const ColumnExtension();
}
