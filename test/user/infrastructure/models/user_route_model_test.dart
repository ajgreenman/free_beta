import 'dart:developer';

import 'package:flutter_test/flutter_test.dart';
import 'package:free_beta/user/infrastructure/models/user_route_model.dart';

void main() {
  group('UserRouteModel', () {
    test('fromFirebase parses json into a model', () {
      var expected = UserRouteModel(
        userId: '',
        routeId: '',
        isCompleted: true,
        isFavorited: false,
      );
      var json = {
        'userId': '',
        'routeId': '',
        'isCompleted': 1,
        'isFavorited': 0,
      };

      var userRouteModel = UserRouteModel.fromJson(json);
      log(userRouteModel.toString());
      log(expected.toString());

      expect(userRouteModel, expected);
    });
  });
}
