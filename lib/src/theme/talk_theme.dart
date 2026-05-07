import 'package:flutter/material.dart';
import '../tokens/talk_colors.dart';
import '../tokens/talk_typography.dart';

class TalkTheme {
  const TalkTheme._();

  static ThemeData light() {
    final base = ThemeData(
      useMaterial3: true,
      fontFamily: 'Roboto',
      colorScheme: ColorScheme.fromSeed(seedColor: TalkColors.light.theme),
      extensions: const [
        TalkColors.light,
      ],
    );
    return base.copyWith(
      scaffoldBackgroundColor: TalkColors.light.backgroundPrimary,
      textTheme: base.textTheme.copyWith(
        labelLarge: base.textTheme.labelLarge!.copyWith(letterSpacing: 0),
      ),
      menuTheme: MenuThemeData(
        style: MenuStyle(
          backgroundColor: WidgetStatePropertyAll(TalkColors.light.listDialogBox),
          elevation: const WidgetStatePropertyAll(8),
          shadowColor: const WidgetStatePropertyAll(Color(0x26000000)),
          surfaceTintColor: const WidgetStatePropertyAll(Colors.transparent),
          shape: const WidgetStatePropertyAll(
            RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(4))),
          ),
          padding: const WidgetStatePropertyAll(EdgeInsets.symmetric(vertical: 8)),
          minimumSize: const WidgetStatePropertyAll(Size(160, 0)),
          maximumSize: const WidgetStatePropertyAll(Size(280, double.infinity)),
        ),
      ),
      menuButtonTheme: MenuButtonThemeData(
        style: ButtonStyle(
          textStyle: const WidgetStatePropertyAll(TalkTypography.bodyMedium),
          foregroundColor: WidgetStatePropertyAll(TalkColors.light.textPrimary),
          iconColor: WidgetStatePropertyAll(TalkColors.light.textPrimary),
          iconSize: const WidgetStatePropertyAll(20),
          backgroundColor: WidgetStateProperty.resolveWith((states) {
            if (states.contains(WidgetState.hovered)) {
              return TalkColors.light.listCardMenuFloating;
            }
            if (states.contains(WidgetState.pressed)) {
              return TalkColors.light.listCardMenuPressed;
            }
            return Colors.transparent;
          }),
          overlayColor: const WidgetStatePropertyAll(Colors.transparent),
          padding: const WidgetStatePropertyAll(
            EdgeInsets.symmetric(horizontal: 12, vertical: 12),
          ),
          minimumSize: const WidgetStatePropertyAll(Size(160, 44)),
          shape: const WidgetStatePropertyAll(RoundedRectangleBorder()),
        ),
      ),
    );
  }
}
