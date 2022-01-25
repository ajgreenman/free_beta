import 'package:intl/intl.dart';

extension DateFormatExtensions on DateFormat {
  String formatWithNull(DateTime? dateTime) {
    if (dateTime == null) {
      return '-';
    }

    return this.format(dateTime);
  }
}
