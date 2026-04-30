import 'package:flutter/material.dart';
import '../tokens/talk_colors.dart';
import '../components/talk_button_styles.dart';
import '../components/talk_input_styles.dart';

extension TalkContextExtensions on BuildContext {
  TalkColors get talkColors => Theme.of(this).extension<TalkColors>()!;
  TalkButtonStyles get talkButtonStyles => Theme.of(this).extension<TalkButtonStyles>()!;
  TalkInputStyles get talkInputStyles => Theme.of(this).extension<TalkInputStyles>()!;
}
