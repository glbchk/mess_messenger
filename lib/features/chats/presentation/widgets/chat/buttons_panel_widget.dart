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
      alignment: WrapAlignment.spaceBetween,
      spacing: 32,
      runSpacing: 16,
      children: [
        PanelButton(SvgIcons.calls, label: 'Call'),
        PanelButton(SvgIcons.video, label: 'Video'),
        PanelButton(SvgIcons.email, label: 'Email'),
        if (isMenuDisabled == false)
          PanelButton(SvgIcons.menuHorizontal, label: 'More'),
      ],
    );
  }
}
