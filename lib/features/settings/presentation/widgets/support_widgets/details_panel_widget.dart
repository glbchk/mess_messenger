import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mess_messenger_app/core/constants/svg_icons.dart';
import 'package:mess_messenger_app/core/utils/spacing/app_spacing.dart';
import 'package:mess_messenger_app/core/widgets/mess_icon_button.dart';
import 'package:mess_messenger_app/features/settings/data/models/user_model.dart';
import 'package:mess_messenger_app/features/settings/presentation/widgets/support_widgets/details_content_widget.dart';
import 'package:mess_messenger_app/theme/theme_extensions/theme_extension.dart';
import 'package:responsive_framework/responsive_framework.dart';

class DetailsPanelWidget extends ConsumerStatefulWidget {
  final UserModel userData;
  final double sectionWidth;
  final List<SupportRequest> pastRequests;
  final VoidCallback onPressedClose;
  final ValueChanged<SupportRequest>? onSelectPastRequest;

  const DetailsPanelWidget({
    super.key,
    required this.userData,
    required this.sectionWidth,
    required this.pastRequests,
    required this.onPressedClose,
    this.onSelectPastRequest,
  });

  @override
  ConsumerState<DetailsPanelWidget> createState() =>
      _SupportChatDetailPanelState();
}

class _SupportChatDetailPanelState extends ConsumerState<DetailsPanelWidget> {
  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final textTheme = context.textStyles;

    return Container(
      width: widget.sectionWidth,
      color: colors.surface0,
      child: Container(
        padding: EdgeInsets.only(left: 24, top: 24, right: 24),
        margin: EdgeInsets.only(top: 20, right: 20, bottom: 20),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(24)),
          color: colors.bg,
        ),
        child: Column(
          crossAxisAlignment: .start,
          children: [
            Row(
              children: [
                Text(
                  'Details',
                  style: textTheme.headlineLarge?.copyWith(color: colors.text1),
                ),
                Spacer(),
                MessIconButton(
                  isButtonFilled: true,
                  SvgIcons.close,
                  buttonSize: 32,
                  iconSize: 16,
                  onPressed: widget.onPressedClose,
                ),
              ],
            ),
            AppSpacing.p12.gapV,
            DetailsContentWidget(
              title: 'Tags',
              tags: ['Billing', 'Subscription', 'Refund'],
              onPressed: () {},
            ),
            DetailsContentWidget(
              title: 'Assigned',
              label: 'View all',
              assigned: ['Peter', 'Ryan'],
              onPressed: () {},
            ),
            DetailsContentWidget(
              title: 'Account',
              label: 'Edit',
              userData: widget.userData,
              onPressed: () {},
            ),
            DetailsContentWidget(
              title: 'Past Requests',
              pastRequests: widget.pastRequests,
              onSelectRequest: widget.onSelectPastRequest,
              onPressed: () {},
            ),
          ],
        ),
      ),
    );
  }
}
