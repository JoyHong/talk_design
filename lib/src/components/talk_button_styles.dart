import 'package:flutter/material.dart';

class TalkBlockButtonColors {
  const TalkBlockButtonColors({
    required this.foreground,
    required this.normalBackground,
    required this.hoverBackground,
    required this.pressedBackground,
  });

  final Color foreground;
  final Color normalBackground;
  final Color hoverBackground;
  final Color pressedBackground;

  static const light = TalkBlockButtonColors(
    foreground: Color(0xFFFF2C55),
    normalBackground: Colors.transparent,
    hoverBackground: Color(0x1A999999),
    pressedBackground: Color(0x33999999),
  );
}

class TalkButtonStyles extends ThemeExtension<TalkButtonStyles> {
  TalkButtonStyles({
    required this.textTheme,
    required this.textSecondary,
    required this.fillTheme,
    required this.fillThemeIcon,
    required this.strokeSecondary,
    required this.strokeSecondaryIcon,
    required this.themeIcon,
    required this.textSecondaryRipple,
    required this.block,
  });

  final ButtonStyle textTheme;
  final ButtonStyle textSecondary;
  final ButtonStyle fillTheme;
  final ButtonStyle fillThemeIcon;
  final ButtonStyle strokeSecondary;
  final ButtonStyle strokeSecondaryIcon;
  final ButtonStyle themeIcon;
  final ButtonStyle textSecondaryRipple;
  final TalkBlockButtonColors block;

  static final light = TalkButtonStyles(
    textTheme: _textTheme(),
    textSecondary: _textSecondary(),
    // fillThemeIcon reuses fillTheme style per design spec; reserved for independent customization.
    fillTheme: _fillTheme(),
    fillThemeIcon: _fillTheme(),
    // strokeSecondaryIcon reuses strokeSecondary style per design spec; reserved for independent customization.
    strokeSecondary: _strokeSecondary(),
    strokeSecondaryIcon: _strokeSecondary(),
    themeIcon: _themeIcon(),
    textSecondaryRipple: _textSecondaryRipple(),
    block: TalkBlockButtonColors.light,
  );

  static ButtonStyle _textTheme() => ButtonStyle(
        backgroundColor: const WidgetStatePropertyAll(Colors.transparent),
        foregroundColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.disabled)) return const Color(0x333C3C43);
          if (states.contains(WidgetState.pressed)) return const Color(0xFFE5284D);
          if (states.contains(WidgetState.hovered)) return const Color(0xFFFF4569);
          return const Color(0xFFFF2C55);
        }),
        overlayColor: const WidgetStatePropertyAll(Colors.transparent),
        minimumSize: const WidgetStatePropertyAll(Size(72, 30)),
        maximumSize: const WidgetStatePropertyAll(Size(400, 52)),
        padding: const WidgetStatePropertyAll(EdgeInsets.symmetric(horizontal: 16)),
        shape: const WidgetStatePropertyAll(
          RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(4))),
        ),
        elevation: const WidgetStatePropertyAll(0),
      );

  static ButtonStyle _textSecondary() => ButtonStyle(
        backgroundColor: const WidgetStatePropertyAll(Colors.transparent),
        foregroundColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.disabled)) return const Color(0xFFD1D1D1);
          if (states.contains(WidgetState.pressed)) return const Color(0xFF777777);
          if (states.contains(WidgetState.hovered)) return const Color(0xFF888888);
          return const Color(0xFFAAAAAA);
        }),
        overlayColor: const WidgetStatePropertyAll(Colors.transparent),
        minimumSize: const WidgetStatePropertyAll(Size(72, 30)),
        maximumSize: const WidgetStatePropertyAll(Size(400, 52)),
        padding: const WidgetStatePropertyAll(EdgeInsets.symmetric(horizontal: 16)),
        shape: const WidgetStatePropertyAll(
          RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(4))),
        ),
        elevation: const WidgetStatePropertyAll(0),
      );

  static ButtonStyle _fillTheme() => ButtonStyle(
        backgroundColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.disabled)) return const Color(0x424F4F4F);
          if (states.contains(WidgetState.pressed)) return const Color(0xFFE5284D);
          if (states.contains(WidgetState.hovered)) return const Color(0xFFFF4569);
          return const Color(0xFFFF2C55);
        }),
        foregroundColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.disabled)) return const Color(0x61000000);
          return const Color(0xFFFFFFFF);
        }),
        overlayColor: const WidgetStatePropertyAll(Colors.transparent),
        minimumSize: const WidgetStatePropertyAll(Size(72, 30)),
        maximumSize: const WidgetStatePropertyAll(Size(400, 52)),
        padding: const WidgetStatePropertyAll(EdgeInsets.symmetric(horizontal: 16)),
        shape: const WidgetStatePropertyAll(
          RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(4))),
        ),
        elevation: const WidgetStatePropertyAll(0),
      );

  static ButtonStyle _strokeSecondary() => ButtonStyle(
        backgroundColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.disabled)) return Colors.transparent;
          if (states.contains(WidgetState.pressed)) return const Color(0x40AAAAAA);
          if (states.contains(WidgetState.hovered)) return const Color(0x1FAAAAAA);
          return Colors.transparent;
        }),
        foregroundColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.disabled)) return const Color(0x61000000);
          return const Color(0xFF262626);
        }),
        overlayColor: const WidgetStatePropertyAll(Colors.transparent),
        side: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.disabled)) {
            return const BorderSide(color: Color(0x1F000000));
          }
          return const BorderSide(color: Color(0xFFAAAAAA));
        }),
        minimumSize: const WidgetStatePropertyAll(Size(72, 30)),
        maximumSize: const WidgetStatePropertyAll(Size(400, 52)),
        padding: const WidgetStatePropertyAll(EdgeInsets.symmetric(horizontal: 16)),
        shape: const WidgetStatePropertyAll(
          RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(4))),
        ),
        elevation: const WidgetStatePropertyAll(0),
      );

  static ButtonStyle _themeIcon() => ButtonStyle(
        backgroundColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.disabled)) return const Color(0x33999999);
          if (states.contains(WidgetState.pressed)) return const Color(0x33999999);
          if (states.contains(WidgetState.hovered)) return const Color(0x1A999999);
          return Colors.transparent;
        }),
        foregroundColor: const WidgetStatePropertyAll(Color(0xFFFF2C55)),
        overlayColor: const WidgetStatePropertyAll(Colors.transparent),
        minimumSize: const WidgetStatePropertyAll(Size(36, 36)),
        maximumSize: const WidgetStatePropertyAll(Size(36, 36)),
        padding: const WidgetStatePropertyAll(EdgeInsets.all(8)),
        shape: const WidgetStatePropertyAll(CircleBorder()),
        elevation: const WidgetStatePropertyAll(0),
      );

  static ButtonStyle _textSecondaryRipple() => ButtonStyle(
        backgroundColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.disabled)) return Colors.transparent;
          if (states.contains(WidgetState.pressed)) return const Color(0x33999999);
          if (states.contains(WidgetState.hovered)) return const Color(0x1A999999);
          return Colors.transparent;
        }),
        foregroundColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.disabled)) return const Color(0xFFD1D1D1);
          return const Color(0xFFAAAAAA);
        }),
        overlayColor: const WidgetStatePropertyAll(Colors.transparent),
        minimumSize: const WidgetStatePropertyAll(Size(72, 30)),
        maximumSize: const WidgetStatePropertyAll(Size(400, 52)),
        padding: const WidgetStatePropertyAll(EdgeInsets.symmetric(horizontal: 16)),
        shape: const WidgetStatePropertyAll(
          RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(4))),
        ),
        elevation: const WidgetStatePropertyAll(0),
      );

  @override
  TalkButtonStyles copyWith({
    ButtonStyle? textTheme,
    ButtonStyle? textSecondary,
    ButtonStyle? fillTheme,
    ButtonStyle? fillThemeIcon,
    ButtonStyle? strokeSecondary,
    ButtonStyle? strokeSecondaryIcon,
    ButtonStyle? themeIcon,
    ButtonStyle? textSecondaryRipple,
    TalkBlockButtonColors? block,
  }) =>
      TalkButtonStyles(
        textTheme: textTheme ?? this.textTheme,
        textSecondary: textSecondary ?? this.textSecondary,
        fillTheme: fillTheme ?? this.fillTheme,
        fillThemeIcon: fillThemeIcon ?? this.fillThemeIcon,
        strokeSecondary: strokeSecondary ?? this.strokeSecondary,
        strokeSecondaryIcon: strokeSecondaryIcon ?? this.strokeSecondaryIcon,
        themeIcon: themeIcon ?? this.themeIcon,
        textSecondaryRipple: textSecondaryRipple ?? this.textSecondaryRipple,
        block: block ?? this.block,
      );

  @override
  TalkButtonStyles lerp(TalkButtonStyles? other, double t) {
    if (other is! TalkButtonStyles) return this;
    return TalkButtonStyles(
      textTheme: ButtonStyle.lerp(textTheme, other.textTheme, t) ?? textTheme,
      textSecondary: ButtonStyle.lerp(textSecondary, other.textSecondary, t) ?? textSecondary,
      fillTheme: ButtonStyle.lerp(fillTheme, other.fillTheme, t) ?? fillTheme,
      fillThemeIcon: ButtonStyle.lerp(fillThemeIcon, other.fillThemeIcon, t) ?? fillThemeIcon,
      strokeSecondary: ButtonStyle.lerp(strokeSecondary, other.strokeSecondary, t) ?? strokeSecondary,
      strokeSecondaryIcon: ButtonStyle.lerp(strokeSecondaryIcon, other.strokeSecondaryIcon, t) ?? strokeSecondaryIcon,
      themeIcon: ButtonStyle.lerp(themeIcon, other.themeIcon, t) ?? themeIcon,
      textSecondaryRipple: ButtonStyle.lerp(textSecondaryRipple, other.textSecondaryRipple, t) ?? textSecondaryRipple,
      block: t < 0.5 ? block : other.block,
    );
  }
}
