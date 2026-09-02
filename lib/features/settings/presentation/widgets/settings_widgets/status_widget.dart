import 'package:flutter/material.dart';
import 'package:mess_messenger_app/features/settings/data/models/invoice_model.dart';
import 'package:mess_messenger_app/theme/theme_extensions/theme_extension.dart';

class StatusWidget extends StatelessWidget {
  final InvoiceStatus status;

  const StatusWidget({super.key, required this.status});

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final textTheme = context.textStyles;

    final isPaid = status == InvoiceStatus.paid;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: colors.surface3,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (isPaid) ...[
            Icon(Icons.check, size: 14, color: colors.text1),
            const SizedBox(width: 4),
          ],
          Text(
            isPaid ? 'Paid' : 'Awaiting',
            style: textTheme.labelMedium?.copyWith(
              color: colors.text1,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}
