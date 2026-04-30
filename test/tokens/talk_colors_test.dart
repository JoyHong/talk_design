import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:talk_design/src/tokens/talk_colors.dart';

void main() {
  group('TalkColors', () {
    test('light has correct main', () {
      expect(TalkColors.light.main, const Color(0xFFFF2C55));
    });

    test('light has all 17 tokens with correct values', () {
      final c = TalkColors.light;
      expect(c.textMain, const Color(0xFF262626));
      expect(c.textSecondary, const Color(0xFFAAAAAA));
      expect(c.backgroundLevel1, const Color(0xFFFFFFFF));
      expect(c.backgroundLevel2, const Color(0xFFF5F5F5));
      expect(c.cardLevel1, const Color(0xFFFFFFFF));
      expect(c.cardLevel2, const Color(0xFFFFFFFF));
      expect(c.inputBoxLevel1, const Color(0xFFF5F5F5));
      expect(c.inputBoxLevel2, const Color(0xFFFFFFFF));
      expect(c.messageBubble, const Color(0xFFF1F1F1));
      expect(c.listPopUpWindow, const Color(0xFFFFFFFF));
      expect(c.sidePopUp, const Color(0xFFF5F5F5));
      expect(c.buttonBlock, const Color(0xFFFFFFFF));
      expect(c.listCardMenuFloating, const Color(0x1A999999));
      expect(c.listCardMenuPressed, const Color(0x33999999));
      expect(c.success, const Color(0xFF39DB0C));
      expect(c.redDotError, const Color(0xFFFF3A2E));
    });

    test('copyWith replaces only specified field', () {
      final modified = TalkColors.light.copyWith(
        main: const Color(0xFF000000),
      );
      expect(modified.main, const Color(0xFF000000));
      expect(modified.textMain, TalkColors.light.textMain);
    });

    test('lerp at t=0 returns self values', () {
      final lerped = TalkColors.light.lerp(TalkColors.light, 0);
      expect(lerped.main, TalkColors.light.main);
    });
  });
}
