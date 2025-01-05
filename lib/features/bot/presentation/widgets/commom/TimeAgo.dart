import 'package:intl/intl.dart';

String timeAgo(String? dateStr) {
  if (dateStr == null) return '';
  try {
    final currentTime = DateTime.now();
    final createdAt = DateTime.parse(dateStr);
    final difference = currentTime.difference(createdAt);

    if (difference.inDays >= 7) {
      final DateFormat dateFormat = DateFormat('dd/MM/yyyy');
      return dateFormat.format(createdAt);
    } else if (difference.inDays > 0) {
      return '${difference.inDays} day${difference.inDays > 1 ? 's' : ''} ago';
    } else if (difference.inHours > 0) {
      return '${difference.inHours} hour${difference.inHours > 1 ? 's' : ''} ago';
    } else if (difference.inMinutes > 0) {
      return '${difference.inMinutes} minute${difference.inMinutes > 1 ? 's' : ''} ago';
    } else {
      return 'Just now';
    }
  } catch (e) {
    return '';
  }
}
