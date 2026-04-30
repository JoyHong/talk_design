import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:talk_design/talk_design.dart';

void main() {
  group('TalkTypography', () {
    // ── Display ───────────────────────────────────────────────────────────────

    test('displayLarge: 57/64/bold/textMain', () {
      expect(TalkTypography.displayLarge.fontSize, 57);
      expect(TalkTypography.displayLarge.height, closeTo(64 / 57, 0.001));
      expect(TalkTypography.displayLarge.fontWeight, FontWeight.bold);
      expect(TalkTypography.displayLarge.fontFamily, 'Roboto');
      expect(TalkTypography.displayLarge.color, const Color(0xFF262626));
    });

    test('displayMedium: 45/52/bold', () {
      expect(TalkTypography.displayMedium.fontSize, 45);
      expect(TalkTypography.displayMedium.height, closeTo(52 / 45, 0.001));
      expect(TalkTypography.displayMedium.fontWeight, FontWeight.bold);
    });

    test('displaySmall: 36/44/bold', () {
      expect(TalkTypography.displaySmall.fontSize, 36);
      expect(TalkTypography.displaySmall.height, closeTo(44 / 36, 0.001));
      expect(TalkTypography.displaySmall.fontWeight, FontWeight.bold);
    });

    // ── Headline ──────────────────────────────────────────────────────────────

    test('headlineLarge: 32/40/bold', () {
      expect(TalkTypography.headlineLarge.fontSize, 32);
      expect(TalkTypography.headlineLarge.height, closeTo(40 / 32, 0.001));
      expect(TalkTypography.headlineLarge.fontWeight, FontWeight.bold);
    });

    test('headlineMedium: 28/36/bold', () {
      expect(TalkTypography.headlineMedium.fontSize, 28);
      expect(TalkTypography.headlineMedium.height, closeTo(36 / 28, 0.001));
    });

    test('headlineMedium2: 26/34/bold', () {
      expect(TalkTypography.headlineMedium2.fontSize, 26);
      expect(TalkTypography.headlineMedium2.height, closeTo(34 / 26, 0.001));
    });

    test('headlineSmall: 24/32/bold', () {
      expect(TalkTypography.headlineSmall.fontSize, 24);
      expect(TalkTypography.headlineSmall.height, closeTo(32 / 24, 0.001));
    });

    test('headlineSmall2: 20/28/bold', () {
      expect(TalkTypography.headlineSmall2.fontSize, 20);
      expect(TalkTypography.headlineSmall2.height, closeTo(28 / 20, 0.001));
    });

    test('headlineSmall3: 18/26/bold', () {
      expect(TalkTypography.headlineSmall3.fontSize, 18);
      expect(TalkTypography.headlineSmall3.height, closeTo(26 / 18, 0.001));
    });

    // ── Title ─────────────────────────────────────────────────────────────────

    test('titleLarge: 22/28/bold', () {
      expect(TalkTypography.titleLarge.fontSize, 22);
      expect(TalkTypography.titleLarge.height, closeTo(28 / 22, 0.001));
      expect(TalkTypography.titleLarge.fontWeight, FontWeight.bold);
    });

    test('titleMedium: 16/24/bold', () {
      expect(TalkTypography.titleMedium.fontSize, 16);
      expect(TalkTypography.titleMedium.height, closeTo(24 / 16, 0.001));
    });

    test('titleSmall: 14/20/bold', () {
      expect(TalkTypography.titleSmall.fontSize, 14);
      expect(TalkTypography.titleSmall.height, closeTo(20 / 14, 0.001));
    });

    // ── Label ─────────────────────────────────────────────────────────────────

    test('labelLarge: 14/20/bold', () {
      expect(TalkTypography.labelLarge.fontSize, 14);
      expect(TalkTypography.labelLarge.height, closeTo(20 / 14, 0.001));
      expect(TalkTypography.labelLarge.fontWeight, FontWeight.bold);
    });

    test('labelMedium: 12/16/bold', () {
      expect(TalkTypography.labelMedium.fontSize, 12);
      expect(TalkTypography.labelMedium.height, closeTo(16 / 12, 0.001));
    });

    test('labelSmall: 11/16/bold', () {
      expect(TalkTypography.labelSmall.fontSize, 11);
      expect(TalkTypography.labelSmall.height, closeTo(16 / 11, 0.001));
    });

    // ── Body ──────────────────────────────────────────────────────────────────

    test('bodyLarge2: 18/26/w500', () {
      expect(TalkTypography.bodyLarge2.fontSize, 18);
      expect(TalkTypography.bodyLarge2.height, closeTo(26 / 18, 0.001));
      expect(TalkTypography.bodyLarge2.fontWeight, FontWeight.w500);
    });

    test('bodyLarge: 16/24/w500', () {
      expect(TalkTypography.bodyLarge.fontSize, 16);
      expect(TalkTypography.bodyLarge.height, closeTo(24 / 16, 0.001));
      expect(TalkTypography.bodyLarge.fontWeight, FontWeight.w500);
    });

    test('bodyMedium: 14/20/w500', () {
      expect(TalkTypography.bodyMedium.fontSize, 14);
      expect(TalkTypography.bodyMedium.height, closeTo(20 / 14, 0.001));
    });

    test('bodySmall: 12/16/w500', () {
      expect(TalkTypography.bodySmall.fontSize, 12);
      expect(TalkTypography.bodySmall.height, closeTo(16 / 12, 0.001));
      expect(TalkTypography.bodySmall.fontWeight, FontWeight.w500);
    });
  });
}
