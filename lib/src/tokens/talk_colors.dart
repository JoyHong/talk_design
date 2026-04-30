import 'package:flutter/material.dart';

class TalkColors extends ThemeExtension<TalkColors> {
  const TalkColors({
    required this.themeColor,
    required this.textMain,
    required this.textSecondary,
    required this.backgroundLevel1,
    required this.backgroundLevel2,
    required this.cardLevel1,
    required this.cardLevel2,
    required this.inputBoxLevel1,
    required this.inputBoxLevel2,
    required this.messageBubble,
    required this.listPopUpWindow,
    required this.sidePopUp,
    required this.buttonBlock,
    required this.listCardMenuFloating,
    required this.listCardMenuPressed,
    required this.success,
    required this.redDotError,
  });

  final Color themeColor;
  final Color textMain;
  final Color textSecondary;
  final Color backgroundLevel1;
  final Color backgroundLevel2;
  final Color cardLevel1;
  final Color cardLevel2;
  final Color inputBoxLevel1;
  final Color inputBoxLevel2;
  final Color messageBubble;
  final Color listPopUpWindow;
  final Color sidePopUp;
  final Color buttonBlock;
  final Color listCardMenuFloating;  // #999999 @ 10%
  final Color listCardMenuPressed;   // #999999 @ 20%
  final Color success;
  final Color redDotError;

  static const light = TalkColors(
    themeColor: Color(0xFFFF2C55),
    textMain: Color(0xFF262626),
    textSecondary: Color(0xFFAAAAAA),
    backgroundLevel1: Color(0xFFFFFFFF),
    backgroundLevel2: Color(0xFFF5F5F5),
    cardLevel1: Color(0xFFFFFFFF),
    cardLevel2: Color(0xFFFFFFFF),
    inputBoxLevel1: Color(0xFFF5F5F5),
    inputBoxLevel2: Color(0xFFFFFFFF),
    messageBubble: Color(0xFFF1F1F1),
    listPopUpWindow: Color(0xFFFFFFFF),
    sidePopUp: Color(0xFFF5F5F5),
    buttonBlock: Color(0xFFFFFFFF),
    listCardMenuFloating: Color(0x1A999999),
    listCardMenuPressed: Color(0x33999999),
    success: Color(0xFF39DB0C),
    redDotError: Color(0xFFFF3A2E),
  );

  @override
  TalkColors copyWith({
    Color? themeColor,
    Color? textMain,
    Color? textSecondary,
    Color? backgroundLevel1,
    Color? backgroundLevel2,
    Color? cardLevel1,
    Color? cardLevel2,
    Color? inputBoxLevel1,
    Color? inputBoxLevel2,
    Color? messageBubble,
    Color? listPopUpWindow,
    Color? sidePopUp,
    Color? buttonBlock,
    Color? listCardMenuFloating,
    Color? listCardMenuPressed,
    Color? success,
    Color? redDotError,
  }) =>
      TalkColors(
        themeColor: themeColor ?? this.themeColor,
        textMain: textMain ?? this.textMain,
        textSecondary: textSecondary ?? this.textSecondary,
        backgroundLevel1: backgroundLevel1 ?? this.backgroundLevel1,
        backgroundLevel2: backgroundLevel2 ?? this.backgroundLevel2,
        cardLevel1: cardLevel1 ?? this.cardLevel1,
        cardLevel2: cardLevel2 ?? this.cardLevel2,
        inputBoxLevel1: inputBoxLevel1 ?? this.inputBoxLevel1,
        inputBoxLevel2: inputBoxLevel2 ?? this.inputBoxLevel2,
        messageBubble: messageBubble ?? this.messageBubble,
        listPopUpWindow: listPopUpWindow ?? this.listPopUpWindow,
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
      themeColor: Color.lerp(themeColor, other.themeColor, t)!,
      textMain: Color.lerp(textMain, other.textMain, t)!,
      textSecondary: Color.lerp(textSecondary, other.textSecondary, t)!,
      backgroundLevel1: Color.lerp(backgroundLevel1, other.backgroundLevel1, t)!,
      backgroundLevel2: Color.lerp(backgroundLevel2, other.backgroundLevel2, t)!,
      cardLevel1: Color.lerp(cardLevel1, other.cardLevel1, t)!,
      cardLevel2: Color.lerp(cardLevel2, other.cardLevel2, t)!,
      inputBoxLevel1: Color.lerp(inputBoxLevel1, other.inputBoxLevel1, t)!,
      inputBoxLevel2: Color.lerp(inputBoxLevel2, other.inputBoxLevel2, t)!,
      messageBubble: Color.lerp(messageBubble, other.messageBubble, t)!,
      listPopUpWindow: Color.lerp(listPopUpWindow, other.listPopUpWindow, t)!,
      sidePopUp: Color.lerp(sidePopUp, other.sidePopUp, t)!,
      buttonBlock: Color.lerp(buttonBlock, other.buttonBlock, t)!,
      listCardMenuFloating: Color.lerp(listCardMenuFloating, other.listCardMenuFloating, t)!,
      listCardMenuPressed: Color.lerp(listCardMenuPressed, other.listCardMenuPressed, t)!,
      success: Color.lerp(success, other.success, t)!,
      redDotError: Color.lerp(redDotError, other.redDotError, t)!,
    );
  }
}
