import 'package:flutter_test/flutter_test.dart';
import 'package:free_beta/app/enums/enums.dart';

void main() {
  test('location display name returns properly', () {
    var boulder = ClimbType.boulder.displayName;
    expect(boulder, 'Boulder');

    var topRope = ClimbType.topRope.displayName;
    expect(topRope, 'Top Rope');

    var lead = ClimbType.lead.displayName;
    expect(lead, 'Lead');

    var autoBelay = ClimbType.autoBelay.displayName;
    expect(autoBelay, 'Auto-belay');
  });
}
