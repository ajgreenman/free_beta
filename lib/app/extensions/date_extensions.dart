import 'dart:developer';

import 'package:intl/intl.dart';

extension DateTimeExtensions on DateTime {
  bool get isToday => _calculateDayDifference(DateTime.now()) == 0;

  bool get isBeforeToday => _calculateDayDifference(DateTime.now()) > 0;

  bool get isAfterToday => _calculateDayDifference(DateTime.now()) < 0;

  int _calculateDayDifference(DateTime date) {
    return DateTime(date.year, date.month, date.day)
        .difference(DateTime(year, month, day))
        .inDays;
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
