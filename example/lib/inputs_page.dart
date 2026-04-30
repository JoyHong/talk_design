import 'package:flutter/material.dart';
import 'package:talk_design/talk_design.dart';

class InputsPage extends StatelessWidget {
  const InputsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final inputStyles = context.talkInputStyles;

    return SingleChildScrollView(
      padding: const EdgeInsets.all(TalkSpacing.l),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'level1 — 灰底输入框',
            style: TextStyle(
              fontSize: 12,
              color: Colors.black45,
            ),
          ),
          const SizedBox(height: TalkSpacing.s),
          TextField(decoration: inputStyles.level1.copyWith(hintText: '请输入内容…')),
          const SizedBox(height: TalkSpacing.xl),
          const Text(
            'level2 — 白底输入框',
            style: TextStyle(
              fontSize: 12,
              color: Colors.black45,
            ),
          ),
          const SizedBox(height: TalkSpacing.s),
          DecoratedBox(
            decoration: BoxDecoration(
              color: context.talkColors.backgroundLevel2,
              borderRadius: BorderRadius.circular(TalkSpacing.radiusM),
            ),
            child: Padding(
              padding: const EdgeInsets.all(TalkSpacing.m),
              child: TextField(decoration: inputStyles.level2.copyWith(hintText: '白底场景下的输入框…')),
            ),
          ),
          const SizedBox(height: TalkSpacing.xl),
          const Text(
            'level1 — 多行输入',
            style: TextStyle(
              fontSize: 12,
              color: Colors.black45,
            ),
          ),
          const SizedBox(height: TalkSpacing.s),
          TextField(
            maxLines: 4,
            decoration: inputStyles.level1.copyWith(hintText: '多行文本输入…'),
          ),
        ],
      ),
    );
  }
}
