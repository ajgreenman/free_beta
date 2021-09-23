import 'package:flutter_test/flutter_test.dart';
import 'package:free_beta/app/enums/enums.dart';

void main() {
  test('location display name returns properly', () {
    var boulder = Location.low.displayName;
    expect(boulder, 'Boulder Area');

    var mezzanine = Location.mezzanine.displayName;
    expect(mezzanine, 'Mezzanine');

    var tallWall = Location.high.displayName;
    expect(tallWall, 'Tall Wall');
  });
}
