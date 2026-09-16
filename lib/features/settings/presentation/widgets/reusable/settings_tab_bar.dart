import 'package:flutter/material.dart';
import 'package:mess_messenger_app/core/enums/enums.dart';
import 'package:mess_messenger_app/core/extensions/l10n_extension.dart';
import 'package:mess_messenger_app/theme/theme_extensions/theme_extension.dart';

class SettingsTabsBar extends StatefulWidget {
  final TabController tabController;

  const SettingsTabsBar({super.key, required this.tabController});

  @override
  State<SettingsTabsBar> createState() => _SettingsTabsBarState();
}

class _SettingsTabsBarState extends State<SettingsTabsBar> {
  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final textTheme = context.textStyles;

    final l10n = context.l10n;

    return Container(
      margin: const EdgeInsets.only(bottom: 16.0, left: 16.0, top: 24.0),
      child: TabBar(
        controller: widget.tabController,
        isScrollable: true,
        labelPadding: const EdgeInsets.symmetric(horizontal: 8),
        tabAlignment: .start,
        dividerColor: colors.transparent,
        indicatorSize: TabBarIndicatorSize.label,
        indicator: BoxDecoration(
          color: colors.textInverse,
          borderRadius: BorderRadius.circular(16),
        ),
        labelColor: colors.text2,
        unselectedLabelColor: colors.text2,
        labelStyle: textTheme.titleMedium,
        overlayColor: WidgetStatePropertyAll(colors.transparent),
        splashFactory: NoSplash.splashFactory,
        tabs: SettingsTab.values.map((tab) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18),
            child: Tab(text: tab.title(l10n)),
          );
        }).toList(),
      ),
    );
  }
}
