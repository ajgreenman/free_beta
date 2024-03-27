import 'package:flutter_test/flutter_test.dart';
import 'package:free_beta/app/extensions/extensions.dart';

void main() {
  group('DateTimeExtensions', () {
    test('isToday', () {
      var today = DateTime.now();

      var result = today.isToday;

      expect(result, true);
    });
    test('isBeforeToday', () {
      var beforeToday = DateTime.now().subtract(Duration(days: 1));

      var result = beforeToday.isBeforeToday;

      expect(result, true);
    });
    test('isAfterToday', () {
      var afterToday = DateTime.now().add(Duration(days: 1));

      var result = afterToday.isAfterToday;

      expect(result, true);
    });
  });
}
