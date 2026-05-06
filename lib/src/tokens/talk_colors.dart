import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

class TalkColors extends ThemeExtension<TalkColors> {
  const TalkColors({
    required this.theme,
    required this.textPrimary,
    required this.textSecondary,
    required this.backgroundPrimary,
    required this.backgroundSecondary,
    required this.cardPrimary,
    required this.cardSecondary,
    required this.inputBoxPrimary,
    required this.inputBoxSecondary,
    required this.messageBubble,
    required this.listDialogBox,
    required this.sidePopUp,
    required this.buttonBlock,
    required this.listCardMenuFloating,
    required this.listCardMenuPressed,
    required this.success,
    required this.redDotError,
  });

  final Color theme;
  final Color textPrimary;
  final Color textSecondary;
  final Color backgroundPrimary;
  final Color backgroundSecondary;
  final Color cardPrimary;
  final Color cardSecondary;
  final Color inputBoxPrimary;
  final Color inputBoxSecondary;
  final Color messageBubble;
  final Color listDialogBox;
  final Color sidePopUp;
  final Color buttonBlock;
  final Color listCardMenuFloating;  // #999999 @ 10%
  final Color listCardMenuPressed;   // #999999 @ 20%
  final Color success;
  final Color redDotError;

  @internal
  static const light = TalkColors(
    theme: Color(0xFFFF2C55),
    textPrimary: Color(0xFF262626),
    textSecondary: Color(0xFFAAAAAA),
    backgroundPrimary: Color(0xFFFFFFFF),
    backgroundSecondary: Color(0xFFF5F5F5),
    cardPrimary: Color(0xFFFFFFFF),
    cardSecondary: Color(0xFFFFFFFF),
    inputBoxPrimary: Color(0xFFF5F5F5),
    inputBoxSecondary: Color(0xFFFFFFFF),
    messageBubble: Color(0xFFF1F1F1),
    listDialogBox: Color(0xFFFFFFFF),
    sidePopUp: Color(0xFFF5F5F5),
    buttonBlock: Color(0xFFFFFFFF),
    listCardMenuFloating: Color(0x1A999999),
    listCardMenuPressed: Color(0x33999999),
    success: Color(0xFF39DB0C),
    redDotError: Color(0xFFFF3A2E),
  );

  @override
  TalkColors copyWith({
    Color? theme,
    Color? textPrimary,
    Color? textSecondary,
    Color? backgroundPrimary,
    Color? backgroundSecondary,
    Color? cardPrimary,
    Color? cardSecondary,
    Color? inputBoxPrimary,
    Color? inputBoxSecondary,
    Color? messageBubble,
    Color? listDialogBox,
    Color? sidePopUp,
    Color? buttonBlock,
    Color? listCardMenuFloating,
    Color? listCardMenuPressed,
    Color? success,
    Color? redDotError,
  }) =>
      TalkColors(
        theme: theme ?? this.theme,
        textPrimary: textPrimary ?? this.textPrimary,
        textSecondary: textSecondary ?? this.textSecondary,
        backgroundPrimary: backgroundPrimary ?? this.backgroundPrimary,
        backgroundSecondary: backgroundSecondary ?? this.backgroundSecondary,
        cardPrimary: cardPrimary ?? this.cardPrimary,
        cardSecondary: cardSecondary ?? this.cardSecondary,
        inputBoxPrimary: inputBoxPrimary ?? this.inputBoxPrimary,
        inputBoxSecondary: inputBoxSecondary ?? this.inputBoxSecondary,
        messageBubble: messageBubble ?? this.messageBubble,
        listDialogBox: listDialogBox ?? this.listDialogBox,
        sidePopUp: sidePopUp ?? this.sidePopUp,
        buttonBlock: buttonBlock ?? this.buttonBlock,
        listCardMenuFloating: listCardMenuFloating ?? this.listCardMenuFloating,
        listCardMenuPressed: listCardMenuPressed ?? this.listCardMenuPressed,
        success: success ?? this.success,
        redDotError: redDotError ?? this.redDotError,
      );

  @override
  TalkColors lerp(TalkColors? other, double t) {
    if (other is! TalkColors) return this;
    return TalkColors(
      theme: Color.lerp(theme, other.theme, t)!,
      textPrimary: Color.lerp(textPrimary, other.textPrimary, t)!,
      textSecondary: Color.lerp(textSecondary, other.textSecondary, t)!,
      backgroundPrimary: Color.lerp(backgroundPrimary, other.backgroundPrimary, t)!,
      backgroundSecondary: Color.lerp(backgroundSecondary, other.backgroundSecondary, t)!,
      cardPrimary: Color.lerp(cardPrimary, other.cardPrimary, t)!,
      cardSecondary: Color.lerp(cardSecondary, other.cardSecondary, t)!,
      inputBoxPrimary: Color.lerp(inputBoxPrimary, other.inputBoxPrimary, t)!,
      inputBoxSecondary: Color.lerp(inputBoxSecondary, other.inputBoxSecondary, t)!,
      messageBubble: Color.lerp(messageBubble, other.messageBubble, t)!,
      listDialogBox: Color.lerp(listDialogBox, other.listDialogBox, t)!,
      sidePopUp: Color.lerp(sidePopUp, other.sidePopUp, t)!,
      buttonBlock: Color.lerp(buttonBlock, other.buttonBlock, t)!,
      listCardMenuFloating: Color.lerp(listCardMenuFloating, other.listCardMenuFloating, t)!,
      listCardMenuPressed: Color.lerp(listCardMenuPressed, other.listCardMenuPressed, t)!,
      success: Color.lerp(success, other.success, t)!,
      redDotError: Color.lerp(redDotError, other.redDotError, t)!,
    );
  }
}
