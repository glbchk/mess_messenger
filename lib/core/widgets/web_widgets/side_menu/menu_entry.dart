sealed class MenuEntry {
  const MenuEntry();
}

class MenuItem extends MenuEntry {
  final String id;
  final String iconPath;
  final String label;
  const MenuItem({
    required this.id,
    required this.iconPath,
    required this.label,
  });
}

class FlexSpacer extends MenuEntry {
  const FlexSpacer();
}

class ColumnExtension extends MenuEntry {
  const ColumnExtension();
}
