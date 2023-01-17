import 'package:flutter/foundation.dart';
import 'package:intl/intl.dart';

enum Day {
  sunday,
  monday,
  tuesday,
  wednesday,
  thursday,
  friday,
  saturday,
}

Day currentDay() {
  return Day.values.firstWhere(
    (day) =>
        describeEnum(day) ==
        DateFormat('EEEE').format(DateTime.now()).toLowerCase(),
  );
}
