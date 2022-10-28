import 'package:intl/intl.dart';

extension DateTimeExtensions on DateTime {
  bool isToday() {
    final now = DateTime.now();
    return now.year == year && now.month == month && now.day == day;
  }
}

extension DateFormatExtensions on DateFormat {
  String formatWithNull(DateTime? dateTime) {
    if (dateTime == null) {
      return '-';
    }

    return this.format(dateTime);
  }
}
