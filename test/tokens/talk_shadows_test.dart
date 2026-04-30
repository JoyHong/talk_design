import 'package:flutter/painting.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:talk_design/src/tokens/talk_shadows.dart';

void main() {
  group('TalkShadows', () {
    test('card shadow is non-empty', () {
      expect(TalkShadows.card, isNotEmpty);
    });
    test('popup shadow has larger blur than card shadow', () {
      expect(
        TalkShadows.popup.first.blurRadius,
        greaterThan(TalkShadows.card.first.blurRadius),
      );
    });

    test('card shadow has expected properties', () {
      final shadow = TalkShadows.card.first;
      expect(shadow.color, const Color(0x0D000000));
      expect(shadow.blurRadius, 8.0);
      expect(shadow.offset, const Offset(0, 2));
    });

    test('popup shadow has expected properties', () {
      final shadow = TalkShadows.popup.first;
      expect(shadow.color, const Color(0x1A000000));
      expect(shadow.blurRadius, 16.0);
      expect(shadow.offset, const Offset(0, 4));
    });
  });
}
