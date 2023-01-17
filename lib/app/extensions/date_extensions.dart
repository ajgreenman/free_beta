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

  DateTime copyWith({
    int? year,
    int? month,
    int? day,
    int? hour,
    int? minute,
    int? second,
  }) {
    return DateTime(
      year ?? this.year,
      month ?? this.month,
      day ?? this.day,
      hour ?? this.hour,
      minute ?? this.minute,
      second ?? this.second,
    );
  }

  String get stringify => DateFormat('MM/dd').format(this);
}

extension DateFormatExtensions on DateFormat {
  String formatWithNull(DateTime? dateTime) {
    if (dateTime == null) {
      return '-';
    }

    return this.format(dateTime);
  }
}
