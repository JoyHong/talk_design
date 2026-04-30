import 'package:flutter/material.dart';

class TalkInputStyles extends ThemeExtension<TalkInputStyles> {
  const TalkInputStyles({
    required this.level1FillColor,
    required this.level2FillColor,
  });

  final Color level1FillColor;
  final Color level2FillColor;

  static const light = TalkInputStyles(
    level1FillColor: Color(0xFFF5F5F5),
    level2FillColor: Color(0xFFFFFFFF),
  );

  InputDecoration get level1 => InputDecoration(
        filled: true,
        fillColor: level1FillColor,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(4),
          borderSide: BorderSide.none,
        ),
        contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      );

  InputDecoration get level2 => InputDecoration(
        filled: true,
        fillColor: level2FillColor,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(4),
          borderSide: BorderSide.none,
        ),
        contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      );

  @override
  TalkInputStyles copyWith({
    Color? level1FillColor,
    Color? level2FillColor,
  }) =>
      TalkInputStyles(
        level1FillColor: level1FillColor ?? this.level1FillColor,
        level2FillColor: level2FillColor ?? this.level2FillColor,
      );

  @override
  TalkInputStyles lerp(TalkInputStyles? other, double t) {
    if (other is! TalkInputStyles) return this;
    return TalkInputStyles(
      level1FillColor: Color.lerp(level1FillColor, other.level1FillColor, t)!,
      level2FillColor: Color.lerp(level2FillColor, other.level2FillColor, t)!,
    );
  }
}
