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
        day.name == DateFormat('EEEE').format(DateTime.now()).toLowerCase(),
  );
}
