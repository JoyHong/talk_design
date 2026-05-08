import 'package:flutter_test/flutter_test.dart';
import 'package:talk_design/src/tokens/talk_spacing.dart';

void main() {
  group('TalkSpacing', () {
    test('menuAnchorOffset has zero horizontal component', () {
      expect(TalkSpacing.menuAnchorOffset.dx, 0);
    });

    test('menuAnchorOffset has positive vertical component', () {
      expect(TalkSpacing.menuAnchorOffset.dy, greaterThan(0));
    });
  });
}
