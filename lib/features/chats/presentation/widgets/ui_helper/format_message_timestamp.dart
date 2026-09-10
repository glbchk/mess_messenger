import 'package:intl/intl.dart';

String formatMessageTimestamp(DateTime? dateTime) {
  final date = dateTime ?? DateTime.now();
  final now = DateTime.now();
  final difference = now.difference(date);

  final timeString = DateFormat('h:mma').format(date).toLowerCase();

  if (difference.inMinutes < 1) {
    return 'Just now';
  }

  if (date.year == now.year && date.month == now.month && date.day == now.day) {
    return 'Today $timeString';
  }

  if (difference.inDays < 7 && difference.isNegative == false) {
    final dayName = DateFormat('EEEE').format(date);
    return '$dayName $timeString';
  }

  final dateString = DateFormat('MMM d').format(date);
  return '$dateString $timeString';
}
