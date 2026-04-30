import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

class TalkInputStyles extends ThemeExtension<TalkInputStyles> {
  const TalkInputStyles({
    required this.level1FillColor,
    required this.level2FillColor,
  });

  final Color level1FillColor;
  final Color level2FillColor;

  @internal
  static const TalkInputStyles light = TalkInputStyles(
    level1FillColor: Color(0xFFF5F5F5),
    level2FillColor: Color(0xFFFFFFFF),
  );

  InputDecoration _buildDecoration(Color fillColor) => InputDecoration(
        filled: true,
        fillColor: fillColor,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(4),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(4),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(4),
          borderSide: BorderSide.none,
        ),
        contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      );

  InputDecoration get level1 => _buildDecoration(level1FillColor);

  InputDecoration get level2 => _buildDecoration(level2FillColor);

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
