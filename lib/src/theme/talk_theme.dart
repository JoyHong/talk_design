import 'package:flutter/material.dart';
import '../tokens/talk_colors.dart';
import '../components/talk_button_styles.dart';
import '../components/talk_input_styles.dart';

class TalkTheme {
  static ThemeData light() => ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: TalkColors.light.themeColor),
        extensions: [
          TalkColors.light,
          TalkButtonStyles.light,
          TalkInputStyles.light,
        ],
      );
}
