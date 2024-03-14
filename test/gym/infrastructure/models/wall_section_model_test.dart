import 'package:flutter_test/flutter_test.dart';
import 'package:free_beta/app/enums/enums.dart';
import 'package:free_beta/gym/infrastructure/models/wall_section_model.dart';

void main() {
  group('WallSectionModel', () {
    test('fromFirebase parses json into a model', () {
      var section = 0;
      var location = WallLocation.boulder;
      var expected = WallSectionModel(
        wallLocation: location,
        wallSection: section,
      );
      var json = {
        'wallSection': section,
        'wallLocation': location.name,
      };

      var wallSectionModel = WallSectionModel.fromFirebase(json);

      expect(wallSectionModel, expected);
    });
  });
}
