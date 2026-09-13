import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mess_messenger_app/core/extensions/l10n_extension.dart';

String formatMessageTimestamp(DateTime? dateTime, BuildContext context) {
  final date = dateTime ?? DateTime.now();
  final now = DateTime.now();
  final difference = now.difference(date);
  final l10n = context.l10n;

  final timeString = DateFormat('h:mma').format(date).toLowerCase();

  if (difference.inMinutes < 1) {
    return l10n.justNow;
  }

  if (date.year == now.year && date.month == now.month && date.day == now.day) {
    return '${l10n.today} $timeString';
  }

  if (difference.inDays < 7 && difference.isNegative == false) {
    final dayName = DateFormat('EEEE').format(date);
    return '$dayName $timeString';
  }

  final dateString = DateFormat('MMM d').format(date);
  return '$dateString $timeString';
}
