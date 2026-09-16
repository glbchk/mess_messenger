import 'package:flutter/material.dart';
import 'package:mess_messenger_app/core/constants/svg_icons.dart';
import 'package:mess_messenger_app/core/extensions/l10n_extension.dart';
import 'package:mess_messenger_app/core/utils/spacing/app_spacing.dart';
import 'package:mess_messenger_app/core/widgets/mess_icon.dart';
import 'package:mess_messenger_app/features/settings/data/models/invoice_model.dart';
import 'package:mess_messenger_app/theme/theme_extensions/theme_extension.dart';

class StatusWidget extends StatelessWidget {
  final InvoiceStatus status;

  const StatusWidget({super.key, required this.status});

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final textTheme = context.textStyles;

    final l10n = context.l10n;

    final isPaid = status == InvoiceStatus.paid;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: colors.surface3,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        mainAxisSize: .min,
        children: [
          if (isPaid) ...[
            MessIcon(SvgIcons.check, size: 16, color: colors.text1),
            AppSpacing.p4.gapH,
          ],
          Text(
            isPaid ? l10n.paidStatus : l10n.awaitingStatus,
            style: textTheme.labelMedium?.copyWith(color: colors.text1),
          ),
        ],
      ),
    );
  }
}
