import 'package:flutter/material.dart';

// 所有样式均不设置 color，颜色由 Text widget 继承 DefaultTextStyle（即 TalkTheme 中的 bodyMedium）获得
// 即默认颜色就是主文本色（textPrimary）
abstract final class TalkTypography {
  // ── Display ─────────────────────────────────────────────────────────────────
  static const TextStyle displayLarge = TextStyle(
    fontFamily: 'Roboto',
    fontSize: 57,
    height: 64 / 57,
    fontWeight: FontWeight.bold,
  );
  static const TextStyle displayMedium = TextStyle(
    fontFamily: 'Roboto',
    fontSize: 45,
    height: 52 / 45,
    fontWeight: FontWeight.bold,
  );
  static const TextStyle displaySmall = TextStyle(
    fontFamily: 'Roboto',
    fontSize: 36,
    height: 44 / 36,
    fontWeight: FontWeight.bold,
  );

  // ── Headline ─────────────────────────────────────────────────────────────────
  static const TextStyle headlineLarge = TextStyle(
    fontFamily: 'Roboto',
    fontSize: 32,
    height: 40 / 32,
    fontWeight: FontWeight.bold,
  );
  static const TextStyle headlineMedium = TextStyle(
    fontFamily: 'Roboto',
    fontSize: 28,
    height: 36 / 28,
    fontWeight: FontWeight.bold,
  );
  static const TextStyle headlineMedium2 = TextStyle(
    fontFamily: 'Roboto',
    fontSize: 26,
    height: 34 / 26,
    fontWeight: FontWeight.bold,
  );
  static const TextStyle headlineSmall = TextStyle(
    fontFamily: 'Roboto',
    fontSize: 24,
    height: 32 / 24,
    fontWeight: FontWeight.bold,
  );
  static const TextStyle headlineSmall2 = TextStyle(
    fontFamily: 'Roboto',
    fontSize: 20,
    height: 28 / 20,
    fontWeight: FontWeight.bold,
  );
  static const TextStyle headlineSmall3 = TextStyle(
    fontFamily: 'Roboto',
    fontSize: 18,
    height: 26 / 18,
    fontWeight: FontWeight.bold,
  );

  // ── Title ────────────────────────────────────────────────────────────────────
  static const TextStyle titleLarge = TextStyle(
    fontFamily: 'Roboto',
    fontSize: 22,
    height: 28 / 22,
    fontWeight: FontWeight.bold,
  );
  static const TextStyle titleMedium = TextStyle(
    fontFamily: 'Roboto',
    fontSize: 16,
    height: 24 / 16,
    fontWeight: FontWeight.bold,
  );
  static const TextStyle titleSmall = TextStyle(
    fontFamily: 'Roboto',
    fontSize: 14,
    height: 20 / 14,
    fontWeight: FontWeight.bold,
  );

  // ── Label ────────────────────────────────────────────────────────────────────
  static const TextStyle labelLarge = TextStyle(
    fontFamily: 'Roboto',
    fontSize: 14,
    height: 20 / 14,
    fontWeight: FontWeight.bold,
  );
  static const TextStyle labelMedium = TextStyle(
    fontFamily: 'Roboto',
    fontSize: 12,
    height: 16 / 12,
    fontWeight: FontWeight.bold,
  );
  static const TextStyle labelSmall = TextStyle(
    fontFamily: 'Roboto',
    fontSize: 11,
    height: 16 / 11,
    fontWeight: FontWeight.bold,
  );

  // ── Body ─────────────────────────────────────────────────────────────────────
  static const TextStyle bodyLarge2 = TextStyle(
    fontFamily: 'Roboto',
    fontSize: 18,
    height: 26 / 18,
    fontWeight: FontWeight.w500,
  );
  static const TextStyle bodyLarge = TextStyle(
    fontFamily: 'Roboto',
    fontSize: 16,
    height: 24 / 16,
    fontWeight: FontWeight.w500,
  );
  static const TextStyle bodyMedium = TextStyle(
    fontFamily: 'Roboto',
    fontSize: 14,
    height: 20 / 14,
    fontWeight: FontWeight.w500,
  );
  static const TextStyle bodySmall = TextStyle(
    fontFamily: 'Roboto',
    fontSize: 12,
    height: 16 / 12,
    fontWeight: FontWeight.w500,
  );
}
