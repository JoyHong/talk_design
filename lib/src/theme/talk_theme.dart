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
        // Material 3 默认有 0.1 的 letterSpacing，与设计稿不符
        labelLarge: base.textTheme.labelLarge!.copyWith(letterSpacing: 0),
        // Material 将 bodyMedium 设为 DefaultTextStyle，覆盖此颜色使无显式 color 的 Text 默认呈现 textPrimary
        bodyMedium: base.textTheme.bodyMedium!.copyWith(color: TalkColors.light.textPrimary),
      ),
      menuTheme: MenuThemeData(
        style: MenuStyle(
          backgroundColor: WidgetStatePropertyAll(TalkColors.light.listDialogBox),
          elevation: const WidgetStatePropertyAll(4),
          // 让 elevation 系数直接作用在纯黑色上
          // 在 elevation 4 下 Flutter M3 会产生清晰可见的阴影（key shadow ≈ 14% 黑、ambient shadow ≈ 12% 黑，视觉上与 Figma 的 15% 接近）。
          shadowColor: const WidgetStatePropertyAll(Colors.black),
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
              return TalkColors.light.listCardMenuHovered;
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
          minimumSize: const WidgetStatePropertyAll(Size(130, 44)),
          shape: const WidgetStatePropertyAll(RoundedRectangleBorder()),
        ),
      ),
    );
  }
}
