import 'package:flutter/material.dart';
import 'package:mess_messenger_app/core/enums/enums.dart';
import 'package:mess_messenger_app/core/extensions/l10n_extension.dart';
import 'package:mess_messenger_app/theme/theme_extensions/theme_extension.dart';
import 'package:responsive_framework/responsive_framework.dart';

class ContactsTabsBar extends StatefulWidget {
  final TabController tabController;

  const ContactsTabsBar({super.key, required this.tabController});

  @override
  State<ContactsTabsBar> createState() => _ContactsTabsBarState();
}

class _ContactsTabsBarState extends State<ContactsTabsBar> {
  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final textTheme = context.textStyles;

    final l10n = context.l10n;

    final bp = ResponsiveBreakpoints.of(context);

    return Container(
      margin: const EdgeInsets.only(bottom: 16.0, top: 24.0),
      child: TabBar(
        controller: widget.tabController,
        isScrollable: true,
        padding: EdgeInsets.only(left: bp.isMobile ? 16.0 : 32.0),
        labelPadding: EdgeInsets.symmetric(horizontal: bp.isMobile ? 26 : 16),
        tabAlignment: .start,
        dividerColor: colors.border2,
        indicatorSize: .tab,
        indicator: UnderlineTabIndicator(
          borderSide: BorderSide(color: colors.link, width: 3.0),
        ),
        labelColor: colors.text1,
        unselectedLabelColor: colors.text2,
        labelStyle: textTheme.titleMedium,
        unselectedLabelStyle: textTheme.bodyMedium,
        overlayColor: WidgetStatePropertyAll(colors.transparent),
        splashFactory: NoSplash.splashFactory,
        tabs: ContactsTab.values.map((tab) {
          return Tab(height: 48, text: tab.title(l10n));
        }).toList(),
      ),
    );
  }
}
