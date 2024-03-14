import 'package:flutter_test/flutter_test.dart';
import 'package:free_beta/gym/infrastructure/models/gym_model.dart';

void main() {
  test('fromFirebase creates model properly', () {
    var json = {
      'name': '',
      'password': '',
    };
    var gymModel = GymModel.fromFirebase('id', json);

    var expected = GymModel(id: 'id', name: '', password: '');

    expect(gymModel, expected);
  });
}
