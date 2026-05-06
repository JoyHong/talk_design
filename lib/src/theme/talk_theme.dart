import 'package:flutter/material.dart';
import '../tokens/talk_colors.dart';
class TalkTheme {
  const TalkTheme._();

  static ThemeData light() {
    final base = ThemeData(
      useMaterial3: true,
      fontFamily: 'Roboto',
      colorScheme: ColorScheme.fromSeed(seedColor: TalkColors.light.main),
      extensions: const [
        TalkColors.light,
      ],
    );
    return base.copyWith(
      textTheme: base.textTheme.copyWith(
        labelLarge: base.textTheme.labelLarge!.copyWith(letterSpacing: 0),
      ),
    );
  }
}
