import 'package:flutter_test/flutter_test.dart';
import 'package:talk_design/src/tokens/talk_metrics.dart';

void main() {
  group('TalkMetrics', () {
    test('menuAnchorOffset has zero horizontal component', () {
      expect(TalkMetrics.menuAnchorOffset.dx, 0);
    });

    test('menuAnchorOffset has positive vertical component', () {
      expect(TalkMetrics.menuAnchorOffset.dy, greaterThan(0));
    });
  });
}
