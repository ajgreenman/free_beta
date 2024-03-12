import 'package:flutter_test/flutter_test.dart';
import 'package:free_beta/app/enums/day.dart';
import 'package:free_beta/class/infrastructure/models/day_model.dart';

void main() {
  group('DayModel', () {
    test('fromFirebase parses json into a model', () {
      var day = Day.sunday;
      var image = 'image.png';
      var json = {
        'image': image,
      };

      var dayModel = DayModel.fromFirebase(day.name, json);

      expect(dayModel.day, day);
      expect(dayModel.image, image);
    });
  });
}
