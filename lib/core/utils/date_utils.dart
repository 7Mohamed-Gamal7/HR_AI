import 'package:intl/intl.dart';
import '../constants/app_constants.dart';

/// Date and time utility functions
class AppDateUtils {
  /// Format date to string
  static String formatDate(DateTime date, {String? format}) {
    return DateFormat(format ?? AppConstants.displayDateFormat).format(date);
  }
  
  /// Format date time to string
  static String formatDateTime(DateTime dateTime, {String? format}) {
    return DateFormat(format ?? AppConstants.displayDateTimeFormat).format(dateTime);
  }
  
  /// Format time to string
  static String formatTime(DateTime time, {String? format}) {
    return DateFormat(format ?? AppConstants.displayTimeFormat).format(time);
  }
  
  /// Parse string to date
  static DateTime? parseDate(String dateString, {String? format}) {
    try {
      return DateFormat(format ?? AppConstants.dateFormat).parse(dateString);
    } catch (e) {
      return null;
    }
  }
  
  /// Parse string to date time
  static DateTime? parseDateTime(String dateTimeString, {String? format}) {
    try {
      return DateFormat(format ?? AppConstants.dateTimeFormat).parse(dateTimeString);
    } catch (e) {
      return null;
    }
  }
  
  /// Get current date without time
  static DateTime get today {
    final now = DateTime.now();
    return DateTime(now.year, now.month, now.day);
  }
  
  /// Get current date time
  static DateTime get now => DateTime.now();
  
  /// Check if date is today
  static bool isToday(DateTime date) {
    final now = DateTime.now();
    return date.year == now.year && date.month == now.month && date.day == now.day;
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
  
  /// Get difference in days between two dates
  static int daysBetween(DateTime from, DateTime to) {
    from = DateTime(from.year, from.month, from.day);
    to = DateTime(to.year, to.month, to.day);
    return to.difference(from).inDays;
  }
  
  /// Get difference in hours between two date times
  static int hoursBetween(DateTime from, DateTime to) {
    return to.difference(from).inHours;
  }
  
  /// Get difference in minutes between two date times
  static int minutesBetween(DateTime from, DateTime to) {
    return to.difference(from).inMinutes;
  }
  
  /// Get start of day
  static DateTime startOfDay(DateTime date) {
    return DateTime(date.year, date.month, date.day);
  }
  
  /// Get end of day
  static DateTime endOfDay(DateTime date) {
    return DateTime(date.year, date.month, date.day, 23, 59, 59, 999);
  }
  
  /// Get start of month
  static DateTime startOfMonth(DateTime date) {
    return DateTime(date.year, date.month, 1);
  }
  
  /// Get end of month
  static DateTime endOfMonth(DateTime date) {
    return DateTime(date.year, date.month + 1, 0, 23, 59, 59, 999);
  }
  
  /// Get start of year
  static DateTime startOfYear(DateTime date) {
    return DateTime(date.year, 1, 1);
  }
  
  /// Get end of year
  static DateTime endOfYear(DateTime date) {
    return DateTime(date.year, 12, 31, 23, 59, 59, 999);
  }
  
  /// Get start of week (Monday)
  static DateTime startOfWeek(DateTime date) {
    final daysToSubtract = date.weekday - 1;
    return startOfDay(date.subtract(Duration(days: daysToSubtract)));
  }
  
  /// Get end of week (Sunday)
  static DateTime endOfWeek(DateTime date) {
    final daysToAdd = 7 - date.weekday;
    return endOfDay(date.add(Duration(days: daysToAdd)));
  }
  
  /// Check if date is weekend (Friday or Saturday for Middle East)
  static bool isWeekend(DateTime date) {
    return date.weekday == DateTime.friday || date.weekday == DateTime.saturday;
  }
  
  /// Check if date is weekday
  static bool isWeekday(DateTime date) {
    return !isWeekend(date);
  }
  
  /// Get age from birth date
  static int getAge(DateTime birthDate) {
    final now = DateTime.now();
    int age = now.year - birthDate.year;
    
    if (now.month < birthDate.month || 
        (now.month == birthDate.month && now.day < birthDate.day)) {
      age--;
    }
    
    return age;
  }
  
  /// Get month name
  static String getMonthName(int month, {bool short = false}) {
    final date = DateTime(2000, month, 1);
    return DateFormat(short ? 'MMM' : 'MMMM').format(date);
  }
  
  /// Get day name
  static String getDayName(DateTime date, {bool short = false}) {
    return DateFormat(short ? 'EEE' : 'EEEE').format(date);
  }
  
  /// Get relative time string (e.g., "2 hours ago", "in 3 days")
  static String getRelativeTime(DateTime dateTime) {
    final now = DateTime.now();
    final difference = now.difference(dateTime);
    
    if (difference.isNegative) {
      // Future date
      final futureDiff = dateTime.difference(now);
      if (futureDiff.inDays > 0) {
        return 'in ${futureDiff.inDays} day${futureDiff.inDays > 1 ? 's' : ''}';
      } else if (futureDiff.inHours > 0) {
        return 'in ${futureDiff.inHours} hour${futureDiff.inHours > 1 ? 's' : ''}';
      } else if (futureDiff.inMinutes > 0) {
        return 'in ${futureDiff.inMinutes} minute${futureDiff.inMinutes > 1 ? 's' : ''}';
      } else {
        return 'in a moment';
      }
    } else {
      // Past date
      if (difference.inDays > 0) {
        return '${difference.inDays} day${difference.inDays > 1 ? 's' : ''} ago';
      } else if (difference.inHours > 0) {
        return '${difference.inHours} hour${difference.inHours > 1 ? 's' : ''} ago';
      } else if (difference.inMinutes > 0) {
        return '${difference.inMinutes} minute${difference.inMinutes > 1 ? 's' : ''} ago';
      } else {
        return 'just now';
      }
    }
  }
  
  /// Get working days between two dates (excluding weekends)
  static int getWorkingDays(DateTime startDate, DateTime endDate) {
    int workingDays = 0;
    DateTime current = startDate;
    
    while (current.isBefore(endDate) || current.isAtSameMomentAs(endDate)) {
      if (isWeekday(current)) {
        workingDays++;
      }
      current = current.add(const Duration(days: 1));
    }
    
    return workingDays;
  }
  
  /// Add working days to a date (excluding weekends)
  static DateTime addWorkingDays(DateTime date, int days) {
    DateTime result = date;
    int addedDays = 0;
    
    while (addedDays < days) {
      result = result.add(const Duration(days: 1));
      if (isWeekday(result)) {
        addedDays++;
      }
    }
    
    return result;
  }
  
  /// Check if two dates are on the same day
  static bool isSameDay(DateTime date1, DateTime date2) {
    return date1.year == date2.year && 
           date1.month == date2.month && 
           date1.day == date2.day;
  }
  
  /// Get time duration string (e.g., "2h 30m")
  static String formatDuration(Duration duration) {
    final hours = duration.inHours;
    final minutes = duration.inMinutes.remainder(60);
    
    if (hours > 0) {
      return '${hours}h ${minutes}m';
    } else {
      return '${minutes}m';
    }
  }
}

