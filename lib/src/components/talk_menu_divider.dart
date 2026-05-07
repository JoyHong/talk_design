import 'package:flutter/material.dart';
import '../theme/talk_context_extensions.dart';

class TalkMenuDivider extends StatelessWidget {
  const TalkMenuDivider({super.key});

  @override
  Widget build(BuildContext context) {
    return Divider(
      height: 17,
      thickness: 1,
      color: context.talkColors.listCardMenuFloating,
    );
  }
}
