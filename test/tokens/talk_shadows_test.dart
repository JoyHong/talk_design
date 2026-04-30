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
  });
}
