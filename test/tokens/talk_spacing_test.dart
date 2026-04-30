import 'package:flutter_test/flutter_test.dart';
import 'package:talk_design/src/tokens/talk_spacing.dart';

void main() {
  group('TalkSpacing', () {
    test('spacing values are in ascending order', () {
      expect(TalkSpacing.xs < TalkSpacing.s, isTrue);
      expect(TalkSpacing.s < TalkSpacing.m, isTrue);
      expect(TalkSpacing.m < TalkSpacing.l, isTrue);
      expect(TalkSpacing.l < TalkSpacing.xl, isTrue);
      expect(TalkSpacing.xl < TalkSpacing.xxl, isTrue);
    });

    test('radius values are non-negative', () {
      expect(TalkSpacing.radiusS, greaterThanOrEqualTo(0));
      expect(TalkSpacing.radiusM, greaterThan(TalkSpacing.radiusS));
      expect(TalkSpacing.radiusL, greaterThan(TalkSpacing.radiusM));
    });
  });
}
