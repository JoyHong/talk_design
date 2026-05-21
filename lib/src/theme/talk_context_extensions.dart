import 'package:flutter/material.dart';
import '../tokens/talk_colors.dart';
import '../tokens/talk_icons.dart';

extension TalkContextExtensions on BuildContext {
  TalkColors get talkColors => Theme.of(this).extension<TalkColors>()!;
  TalkIcons get talkIcons => Theme.of(this).extension<TalkIcons>()!;
}
