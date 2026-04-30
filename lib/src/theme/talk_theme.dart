import 'package:flutter/material.dart';
import '../tokens/talk_colors.dart';
import '../components/talk_input_styles.dart';

class TalkTheme {
  const TalkTheme._();

  static ThemeData light() => ThemeData(
        useMaterial3: true,
        fontFamily: 'Roboto',
        colorScheme: ColorScheme.fromSeed(seedColor: TalkColors.light.main),
        extensions: const [
          TalkColors.light,
          TalkInputStyles.light,
        ],
      );
}
