import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:talk_design/src/components/talk_input_styles.dart';

void main() {
  group('TalkInputStyles', () {
    test('light level1 fill color is #F5F5F5', () {
      expect(TalkInputStyles.light.level1.fillColor, const Color(0xFFF5F5F5));
    });

    test('light level2 fill color is #FFFFFF', () {
      expect(TalkInputStyles.light.level2.fillColor, const Color(0xFFFFFFFF));
    });

    test('level1 and level2 are filled', () {
      expect(TalkInputStyles.light.level1.filled, isTrue);
      expect(TalkInputStyles.light.level2.filled, isTrue);
    });

    test('copyWith replaces only level1FillColor', () {
      final modified = TalkInputStyles.light.copyWith(
        level1FillColor: const Color(0xFF000000),
      );
      expect(modified.level1.fillColor, const Color(0xFF000000));
      expect(modified.level2.fillColor, TalkInputStyles.light.level2.fillColor);
    });

    test('level1 has no visible border', () {
      final decoration = TalkInputStyles.light.level1;
      expect(decoration.border, isA<OutlineInputBorder>());
      final border = decoration.border as OutlineInputBorder;
      expect(border.borderSide, BorderSide.none);
    });

    test('lerp at t=0 returns self values', () {
      final lerped = TalkInputStyles.light.lerp(TalkInputStyles.light, 0);
      expect(lerped.level1.fillColor, TalkInputStyles.light.level1.fillColor);
    });
  });
}
