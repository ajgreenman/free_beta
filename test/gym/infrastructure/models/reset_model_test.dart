import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:free_beta/gym/infrastructure/models/reset_model.dart';

void main() {
  group('ResetModel', () {
    test('fromFirebase creates model properly', () {
      var now = Timestamp.now();
      var json = {
        'date': now,
        'isDeleted': false,
      };
      var resetModel = ResetModel.fromFirebase('id', json);

      var expected = ResetModel(id: 'id', date: now.toDate(), sections: []);

      expect(resetModel.date, expected.date);
    });
  });

  group('ResetFormModel', () {
    test('fromResetModel creates model properly', () {
      var now = DateTime.now();

      var resetFormModel = ResetFormModel.fromResetModel(
        ResetModel(id: '', date: now, sections: []),
      );

      var expected = ResetFormModel(date: now, sections: []);

      expect(resetFormModel.date, expected.date);
    });
  });
}
