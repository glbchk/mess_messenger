import 'package:flutter/material.dart';
import 'package:mess_messenger_app/core/constants/svg_icons.dart';
import 'package:mess_messenger_app/core/extensions/l10n_extension.dart';
import 'package:mess_messenger_app/features/chats/presentation/widgets/reusable/panel_button.dart';

class ButtonsPanelWidget extends StatelessWidget {
  final bool? isMenuDisabled;
  const ButtonsPanelWidget({super.key, this.isMenuDisabled = false});

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    return Wrap(
      alignment: .spaceBetween,
      spacing: 32,
      runSpacing: 16,
      children: [
        PanelButton(SvgIcons.calls, label: l10n.call),
        PanelButton(SvgIcons.video, label: l10n.video),
        PanelButton(SvgIcons.email, label: l10n.email),
        if (isMenuDisabled == false)
          PanelButton(SvgIcons.menuHorizontal, label: l10n.more),
      ],
    );
  }
}
