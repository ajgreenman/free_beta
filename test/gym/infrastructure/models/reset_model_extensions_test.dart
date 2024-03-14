import 'package:flutter_test/flutter_test.dart';
import 'package:free_beta/gym/infrastructure/models/reset_model.dart';
import 'package:free_beta/gym/infrastructure/models/reset_model_extensions.dart';

void main() {
  test('pastResets finds only previous resets', () async {
    var passResets = resets.pastResets;

    expect(passResets.length, 2);
  });
  test('nextResets finds only unique future resets', () async {
    var futureResets = resets.nextResets;

    expect(futureResets.length, 2);
  });
  test('nextReset finds only the next reset', () async {
    var nextReset = resets.nextReset;

    expect(nextReset, today);
  });
  test('latestReset finds only most recent reset', () async {
    var latestReset = resets.latestReset;

    expect(latestReset, yesterday);
  });
}

var yesterday = ResetModel(
  id: '',
  date: DateTime.now().subtract(Duration(days: 1)),
  sections: [],
);

var today = ResetModel(
  id: '',
  date: DateTime.now(),
  sections: [],
);

var resets = [
  ResetModel(
    id: '',
    date: DateTime.now().subtract(Duration(days: 2)),
    sections: [],
  ),
  ResetModel(
    id: '',
    date: DateTime.now().add(Duration(days: 1)),
    sections: [],
  ),
  yesterday,
  today,
  ResetModel(
    id: '',
    date: DateTime.now(),
    sections: [],
  ),
];
