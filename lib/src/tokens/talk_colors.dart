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
    required this.receivedMessageBubble,
    required this.receivedMessageBubblePressed,
    required this.receivedMessageText,
    required this.sentMessageBubble,
    required this.sentMessageBubblePressed,
    required this.sentMessageText,
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
  final Color receivedMessageBubble;
  final Color receivedMessageBubblePressed;  // 15% #000000 over receivedMessageBubble
  final Color receivedMessageText;
  final Color sentMessageBubble;
  final Color sentMessageBubblePressed;      // 15% #000000 over sentMessageBubble
  final Color sentMessageText;
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
    receivedMessageBubble: Color(0xFFF1F1F1),
    receivedMessageBubblePressed: Color(0xFFCDCDCD),
    receivedMessageText: Color(0xFF262626),
    sentMessageBubble: Color(0xFFFF2C55),
    sentMessageBubblePressed: Color(0xFFD92548),
    sentMessageText: Color(0xFFFFFFFF),
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
    Color? receivedMessageBubble,
    Color? receivedMessageBubblePressed,
    Color? receivedMessageText,
    Color? sentMessageBubble,
    Color? sentMessageBubblePressed,
    Color? sentMessageText,
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
        receivedMessageBubble: receivedMessageBubble ?? this.receivedMessageBubble,
        receivedMessageBubblePressed: receivedMessageBubblePressed ?? this.receivedMessageBubblePressed,
        receivedMessageText: receivedMessageText ?? this.receivedMessageText,
        sentMessageBubble: sentMessageBubble ?? this.sentMessageBubble,
        sentMessageBubblePressed: sentMessageBubblePressed ?? this.sentMessageBubblePressed,
        sentMessageText: sentMessageText ?? this.sentMessageText,
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
      receivedMessageBubble: Color.lerp(receivedMessageBubble, other.receivedMessageBubble, t)!,
      receivedMessageBubblePressed: Color.lerp(receivedMessageBubblePressed, other.receivedMessageBubblePressed, t)!,
      receivedMessageText: Color.lerp(receivedMessageText, other.receivedMessageText, t)!,
      sentMessageBubble: Color.lerp(sentMessageBubble, other.sentMessageBubble, t)!,
      sentMessageBubblePressed: Color.lerp(sentMessageBubblePressed, other.sentMessageBubblePressed, t)!,
      sentMessageText: Color.lerp(sentMessageText, other.sentMessageText, t)!,
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
