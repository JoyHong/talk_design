import 'package:flutter_test/flutter_test.dart';
import 'package:talk_design/src/tokens/talk_typography.dart';

void main() {
  group('TalkTypography', () {
    test('font sizes are defined and in ascending order', () {
      expect(TalkTypography.label < TalkTypography.body, isTrue);
      expect(TalkTypography.body < TalkTypography.bodyLarge, isTrue);
      expect(TalkTypography.bodyLarge < TalkTypography.title, isTrue);
      expect(TalkTypography.title < TalkTypography.headline, isTrue);
    });

    test('has expected font size values', () {
      expect(TalkTypography.label, 12.0);
      expect(TalkTypography.body, 14.0);
      expect(TalkTypography.bodyLarge, 16.0);
      expect(TalkTypography.title, 18.0);
      expect(TalkTypography.headline, 22.0);
    });

    test('font weights are in ascending order', () {
      expect(TalkTypography.regular.index < TalkTypography.medium.index, isTrue);
      expect(TalkTypography.medium.index < TalkTypography.semiBold.index, isTrue);
      expect(TalkTypography.semiBold.index < TalkTypography.bold.index, isTrue);
    });

    test('line heights are in ascending order', () {
      expect(TalkTypography.lineHeightTight < TalkTypography.lineHeightNormal, isTrue);
      expect(TalkTypography.lineHeightNormal < TalkTypography.lineHeightLoose, isTrue);
    });
  });
}
