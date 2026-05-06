import 'package:flutter/material.dart';
import '../tokens/talk_colors.dart';

extension TalkContextExtensions on BuildContext {
  TalkColors get talkColors => Theme.of(this).extension<TalkColors>()!;
}
