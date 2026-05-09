import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:talk_design/src/tokens/talk_colors.dart';

void main() {
  group('TalkColors', () {
    test('light has correct main', () {
      expect(TalkColors.light.theme, const Color(0xFFFF2C55));
    });

    test('light has all 22 tokens with correct values', () {
      final c = TalkColors.light;
      expect(c.textPrimary, const Color(0xFF262626));
      expect(c.textSecondary, const Color(0xFFAAAAAA));
      expect(c.backgroundPrimary, const Color(0xFFFFFFFF));
      expect(c.backgroundSecondary, const Color(0xFFF5F5F5));
      expect(c.cardPrimary, const Color(0xFFFFFFFF));
      expect(c.cardSecondary, const Color(0xFFFFFFFF));
      expect(c.inputBoxPrimary, const Color(0xFFF5F5F5));
      expect(c.inputBoxSecondary, const Color(0xFFFFFFFF));
      expect(c.receivedMessageBubble, const Color(0xFFF1F1F1));
      expect(c.receivedMessageBubblePressed, const Color(0xFFCDCDCD));
      expect(c.receivedMessageText, const Color(0xFF262626));
      expect(c.sentMessageBubble, const Color(0xFFFF2C55));
      expect(c.sentMessageBubblePressed, const Color(0xFFD92548));
      expect(c.sentMessageText, const Color(0xFFFFFFFF));
      expect(c.listDialogBox, const Color(0xFFFFFFFF));
      expect(c.sidePopUp, const Color(0xFFF5F5F5));
      expect(c.buttonBlock, const Color(0xFFFFFFFF));
      expect(c.listCardMenuHovered, const Color(0x1A999999));
      expect(c.listCardMenuPressed, const Color(0x33999999));
      expect(c.success, const Color(0xFF39DB0C));
      expect(c.redDotError, const Color(0xFFFF3A2E));
    });

    test('copyWith replaces only specified field', () {
      final modified = TalkColors.light.copyWith(
        theme: const Color(0xFF000000),
      );
      expect(modified.theme, const Color(0xFF000000));
      expect(modified.textPrimary, TalkColors.light.textPrimary);
    });

    test('lerp at t=0 returns self values', () {
      final lerped = TalkColors.light.lerp(TalkColors.light, 0);
      expect(lerped.theme, TalkColors.light.theme);
    });
  });
}
