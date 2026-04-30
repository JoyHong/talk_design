import 'package:flutter/material.dart';
import 'package:talk_design/talk_design.dart';

class TypographyPage extends StatelessWidget {
  const TypographyPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.symmetric(horizontal: TalkSpacing.l, vertical: TalkSpacing.m),
      children: const [
        _Category('Display'),
        _Row('DisplayLarge', '57 / 64 / Bold', DisplayLarge('设计系统 Design System')),
        _Row('DisplayMedium', '45 / 52 / Bold', DisplayMedium('设计系统 Design System')),
        _Row('DisplaySmall', '36 / 44 / Bold', DisplaySmall('设计系统 Design System')),
        _Category('Headline'),
        _Row('HeadlineLarge', '32 / 40 / Bold', HeadlineLarge('设计系统 Design System')),
        _Row('HeadlineMedium', '28 / 36 / Bold', HeadlineMedium('设计系统 Design System')),
        _Row('HeadlineMedium2', '26 / 34 / Bold', HeadlineMedium2('设计系统 Design System')),
        _Row('HeadlineSmall', '24 / 32 / Bold', HeadlineSmall('设计系统 Design System')),
        _Row('HeadlineSmall2', '20 / 28 / Bold', HeadlineSmall2('设计系统 Design System')),
        _Row('HeadlineSmall3', '18 / 26 / Bold', HeadlineSmall3('设计系统 Design System')),
        _Category('Title'),
        _Row('TitleLarge', '22 / 28 / Bold', TitleLarge('设计系统 Design System')),
        _Row('TitleMedium', '16 / 24 / Bold', TitleMedium('设计系统 Design System')),
        _Row('TitleSmall', '14 / 20 / Bold', TitleSmall('设计系统 Design System')),
        _Category('Label'),
        _Row('LabelLarge', '14 / 20 / Bold', LabelLarge('设计系统 Design System')),
        _Row('LabelMedium', '12 / 16 / Bold', LabelMedium('设计系统 Design System')),
        _Row('LabelSmall', '11 / 16 / Bold', LabelSmall('设计系统 Design System')),
        _Category('Body'),
        _Row('BodyExtraLarge', '18 / 26 / Medium', BodyExtraLarge('设计系统 Design System')),
        _Row('BodyLarge', '16 / 24 / Medium', BodyLarge('设计系统 Design System')),
        _Row('BodyMedium', '14 / 20 / Medium', BodyMedium('设计系统 Design System')),
        _Row('BodySmall', '12 / 16 / Medium', BodySmall('设计系统 Design System')),
        SizedBox(height: TalkSpacing.xl),
        _CustomColorDemo(),
      ],
    );
  }
}

class _Category extends StatelessWidget {
  const _Category(this.label);
  final String label;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: TalkSpacing.l, bottom: TalkSpacing.s),
      child: Row(
        children: [
          Text(
            label,
            style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w600, color: Color(0xFFFF2C55)),
          ),
          const SizedBox(width: TalkSpacing.s),
          const Expanded(child: Divider()),
        ],
      ),
    );
  }
}

class _Row extends StatelessWidget {
  const _Row(this.name, this.spec, this.sample);
  final String name;
  final String spec;
  final Widget sample;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: TalkSpacing.m),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          sample,
          const SizedBox(height: 4),
          Text(
            '$name  ·  $spec',
            style: const TextStyle(fontSize: 11, color: Colors.black38),
          ),
        ],
      ),
    );
  }
}

class _CustomColorDemo extends StatelessWidget {
  const _CustomColorDemo();

  @override
  Widget build(BuildContext context) {
    final colors = context.talkColors;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const _Category('自定义颜色示例'),
        TitleLarge('主题色文字', color: colors.main),
        const SizedBox(height: 4),
        const Text('TitleLarge(color: talkColors.main)', style: TextStyle(fontSize: 11, color: Colors.black38)),
        const SizedBox(height: TalkSpacing.m),
        TitleMedium('次要色文字', color: colors.textSecondary),
        const SizedBox(height: 4),
        const Text('TitleMedium(color: talkColors.textSecondary)', style: TextStyle(fontSize: 11, color: Colors.black38)),
      ],
    );
  }
}
