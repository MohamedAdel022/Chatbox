import 'package:intl/intl.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

/// Service responsible for all time-related operations in the app
/// Provides consistent time handling, formatting and time zone conversions
class TimeService {
  /// Returns the current UTC time
  DateTime getNow() {
    return DateTime.now().toUtc();
  }

  /// Formats time for message timestamps in chat
  String formatMessageTime(DateTime time) {
    final now = DateTime.now();
    final localTime = time.toLocal();

    // If the message is from today, just show the time
    if (localTime.year == now.year &&
        localTime.month == now.month &&
        localTime.day == now.day) {
      return DateFormat('h:mm a').format(localTime);
    }

    // If the message is from yesterday
    final yesterday = now.subtract(const Duration(days: 1));
    if (localTime.year == yesterday.year &&
        localTime.month == yesterday.month &&
        localTime.day == yesterday.day) {
      return 'Yesterday ${DateFormat('h:mm a').format(localTime)}';
    }

    // If the message is from this week
    if (now.difference(localTime).inDays < 7) {
      return '${DateFormat('EEEE').format(localTime)} ${DateFormat('h:mm a').format(localTime)}';
    }

    // Otherwise show the full date
    return DateFormat('MMM d, yyyy h:mm a').format(localTime);
  }

  /// Formats time for chat list preview (more compact)
  String formatChatListTime(DateTime time) {
    final now = DateTime.now();
    final localTime = time.toLocal();
    final difference = now.difference(localTime);

    // Recent times (less than 10 hours ago)
    if (difference.inHours < 10) {
      if (difference.inMinutes < 1) {
        return 'Just now';
      } else if (difference.inMinutes < 60) {
        return '${difference.inMinutes} min ago';
      } else {
        return '${difference.inHours} ${difference.inHours == 1 ? 'hour' : 'hours'} ago';
      }
    }

    // Today, just show time
    if (localTime.year == now.year &&
        localTime.month == now.month &&
        localTime.day == now.day) {
      return DateFormat('h:mm a').format(localTime);
    }

    // Yesterday
    final yesterday = now.subtract(const Duration(days: 1));
    if (localTime.year == yesterday.year &&
        localTime.month == yesterday.month &&
        localTime.day == yesterday.day) {
      return 'Yesterday';
    }

    // This week, show day name
    if (now.difference(localTime).inDays < 7) {
      return DateFormat('EEEE').format(localTime);
    }

    // This year, show month and day
    if (localTime.year == now.year) {
      return DateFormat('MMM d').format(localTime);
    }

    // Different year
    return DateFormat('MM/dd/yy').format(localTime);
  }

  /// Standardizes a timestamp for storage (always UTC)
  DateTime standardizeTime(DateTime time) {
    return time.toUtc();
  }

  /// Converts DateTime to Firestore Timestamp for storage
  Timestamp toFirestoreTimestamp(DateTime time) {
    return Timestamp.fromDate(standardizeTime(time));
  }

  /// Gets current time as a Firestore Timestamp
  Timestamp getNowTimestamp() {
    return Timestamp.fromDate(getNow());
  }

  /// Converts a timestamp to the user's local time zone
  DateTime toLocalTime(DateTime utcTime) {
    return utcTime.toLocal();
  }
}
