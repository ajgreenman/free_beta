import 'package:flutter_test/flutter_test.dart';
import 'package:free_beta/app/enums/enums.dart';

void main() {
  test('location display name returns properly', () {
    var boulder = WallLocation.boulder.displayName;
    expect(boulder, 'Boulder Wall');

    var mezzanine = WallLocation.mezzanine.displayName;
    expect(mezzanine, 'Mezzanine');

    var tallWall = WallLocation.tall.displayName;
    expect(tallWall, 'Tall Wall');
  });
}
