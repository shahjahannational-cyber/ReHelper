import 'package:flutter/material.dart';

class DateUtils {
  /// Format date to string (e.g., "17 Jun 2024")
  static String formatDate(DateTime date) {
    const months = [
      'Jan',
      'Feb',
      'Mar',
      'Apr',
      'May',
      'Jun',
      'Jul',
      'Aug',
      'Sep',
      'Oct',
      'Nov',
      'Dec'
    ];
    return '${date.day} ${months[date.month - 1]} ${date.year}';
  }

  /// Format time to string (e.g., "14:30")
  static String formatTime(DateTime time) {
    return '${time.hour.toString().padLeft(2, '0')}:${time.minute.toString().padLeft(2, '0')}';
  }

  /// Format date and time (e.g., "17 Jun 2024, 14:30")
  static String formatDateTime(DateTime dateTime) {
    return '${formatDate(dateTime)}, ${formatTime(dateTime)}';
  }

  /// Get relative time (e.g., "2 hours ago")
  static String getRelativeTime(DateTime dateTime) {
    final now = DateTime.now();
    final difference = now.difference(dateTime);

    if (difference.inSeconds < 60) {
      return 'just now';
    } else if (difference.inMinutes < 60) {
      return '${difference.inMinutes} min ago';
    } else if (difference.inHours < 24) {
      return '${difference.inHours} hour${difference.inHours > 1 ? 's' : ''} ago';
    } else if (difference.inDays < 7) {
      return '${difference.inDays} day${difference.inDays > 1 ? 's' : ''} ago';
    } else {
      return formatDate(dateTime);
    }
  }

  /// Get day of week name
  static String getDayName(DateTime date) {
    const days = [
      'Monday',
      'Tuesday',
      'Wednesday',
      'Thursday',
      'Friday',
      'Saturday',
      'Sunday'
    ];
    return days[date.weekday - 1];
  }

  /// Get day of week short name
  static String getDayNameShort(DateTime date) {
    const days = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
    return days[date.weekday - 1];
  }

  /// Get month name
  static String getMonthName(int month) {
    const months = [
      'January',
      'February',
      'March',
      'April',
      'May',
      'June',
      'July',
      'August',
      'September',
      'October',
      'November',
      'December'
    ];
    return months[month - 1];
  }

  /// Check if date is today
  static bool isToday(DateTime date) {
    final now = DateTime.now();
    return date.year == now.year &&
        date.month == now.month &&
        date.day == now.day;
  }

  /// Check if date is yesterday
  static bool isYesterday(DateTime date) {
    final yesterday = DateTime.now().subtract(const Duration(days: 1));
    return date.year == yesterday.year &&
        date.month == yesterday.month &&
        date.day == yesterday.day;
  }

  /// Check if date is tomorrow
  static bool isTomorrow(DateTime date) {
    final tomorrow = DateTime.now().add(const Duration(days: 1));
    return date.year == tomorrow.year &&
        date.month == tomorrow.month &&
        date.day == tomorrow.day;
  }

  /// Get number of days between two dates
  static int daysBetween(DateTime from, DateTime to) {
    from = DateTime(from.year, from.month, from.day);
    to = DateTime(to.year, to.month, to.day);
    return (to.difference(from).inHours / 24).round();
  }

  /// Format duration (e.g., "2h 30m")
  static String formatDuration(Duration duration) {
    final hours = duration.inHours;
    final minutes = duration.inMinutes % 60;
    final seconds = duration.inSeconds % 60;

    if (hours > 0) {
      return '${hours}h ${minutes}m';
    } else if (minutes > 0) {
      return '${minutes}m ${seconds}s';
    } else {
      return '${seconds}s';
    }
  }

  /// Get week number of year
  static int getWeekNumber(DateTime date) {
    final janFirst = DateTime(date.year, 1, 1);
    final daysIntoYear = date.difference(janFirst).inDays;
    return ((daysIntoYear + janFirst.weekday - 1) / 7).ceil();
  }

  /// Parse time string (HH:mm) to Duration
  static Duration parseTime(String timeStr) {
    final parts = timeStr.split(':');
    if (parts.length != 2) return Duration.zero;
    try {
      final hours = int.parse(parts[0]);
      final minutes = int.parse(parts[1]);
      return Duration(hours: hours, minutes: minutes);
    } catch (_) {
      return Duration.zero;
    }
  }

  /// Convert Duration to time string (HH:mm)
  static String durationToTimeString(Duration duration) {
    final hours = duration.inHours.toString().padLeft(2, '0');
    final minutes = (duration.inMinutes % 60).toString().padLeft(2, '0');
    return '$hours:$minutes';
  }

  /// Get start of day
  static DateTime getStartOfDay(DateTime date) {
    return DateTime(date.year, date.month, date.day);
  }

  /// Get end of day
  static DateTime getEndOfDay(DateTime date) {
    return DateTime(date.year, date.month, date.day, 23, 59, 59);
  }

  /// Get start of week (Monday)
  static DateTime getStartOfWeek(DateTime date) {
    final dayOfWeek = date.weekday;
    final startOfWeek = date.subtract(Duration(days: dayOfWeek - 1));
    return getStartOfDay(startOfWeek);
  }

  /// Get end of week (Sunday)
  static DateTime getEndOfWeek(DateTime date) {
    final daysToAdd = DateTime.sunday - date.weekday;
    final endOfWeek = date.add(Duration(days: daysToAdd));
    return getEndOfDay(endOfWeek);
  }

  /// Get start of month
  static DateTime getStartOfMonth(DateTime date) {
    return DateTime(date.year, date.month, 1);
  }

  /// Get end of month
  static DateTime getEndOfMonth(DateTime date) {
    return DateTime(date.year, date.month + 1, 0, 23, 59, 59);
  }

  /// Get start of year
  static DateTime getStartOfYear(DateTime date) {
    return DateTime(date.year, 1, 1);
  }

  /// Get end of year
  static DateTime getEndOfYear(DateTime date) {
    return DateTime(date.year, 12, 31, 23, 59, 59);
  }

  /// Check if two times are the same (ignoring date)
  static bool isSameTime(DateTime time1, DateTime time2) {
    return time1.hour == time2.hour && time1.minute == time2.minute;
  }

  /// Get list of dates in range
  static List<DateTime> getDateRange(DateTime start, DateTime end) {
    final dates = <DateTime>[];
    var current = start;
    while (current.isBefore(end) || current.isAtSameMomentAs(end)) {
      dates.add(current);
      current = current.add(const Duration(days: 1));
    }
    return dates;
  }
}

extension DateTimeExtension on DateTime {
  bool get isToday => DateUtils.isToday(this);
  bool get isYesterday => DateUtils.isYesterday(this);
  bool get isTomorrow => DateUtils.isTomorrow(this);
  
  String get formattedDate => DateUtils.formatDate(this);
  String get formattedTime => DateUtils.formatTime(this);
  String get formattedDateTime => DateUtils.formatDateTime(this);
  String get relativeTime => DateUtils.getRelativeTime(this);
  
  DateTime get startOfDay => DateUtils.getStartOfDay(this);
  DateTime get endOfDay => DateUtils.getEndOfDay(this);
  DateTime get startOfWeek => DateUtils.getStartOfWeek(this);
  DateTime get endOfWeek => DateUtils.getEndOfWeek(this);
  DateTime get startOfMonth => DateUtils.getStartOfMonth(this);
  DateTime get endOfMonth => DateUtils.getEndOfMonth(this);
  DateTime get startOfYear => DateUtils.getStartOfYear(this);
  DateTime get endOfYear => DateUtils.getEndOfYear(this);
}

extension DurationExtension on Duration {
  String get formatted => DateUtils.formatDuration(this);
  String get timeString => DateUtils.durationToTimeString(this);
}
