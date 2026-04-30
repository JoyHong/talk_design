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
        _Row('displayLarge', '57 / 64 / Bold', Text('设计系统 Design System', style: TalkTypography.displayLarge)),
        _Row('displayMedium', '45 / 52 / Bold', Text('设计系统 Design System', style: TalkTypography.displayMedium)),
        _Row('displaySmall', '36 / 44 / Bold', Text('设计系统 Design System', style: TalkTypography.displaySmall)),
        _Category('Headline'),
        _Row('headlineLarge', '32 / 40 / Bold', Text('设计系统 Design System', style: TalkTypography.headlineLarge)),
        _Row('headlineMedium', '28 / 36 / Bold', Text('设计系统 Design System', style: TalkTypography.headlineMedium)),
        _Row('headlineMedium2', '26 / 34 / Bold', Text('设计系统 Design System', style: TalkTypography.headlineMedium2)),
        _Row('headlineSmall', '24 / 32 / Bold', Text('设计系统 Design System', style: TalkTypography.headlineSmall)),
        _Row('headlineSmall2', '20 / 28 / Bold', Text('设计系统 Design System', style: TalkTypography.headlineSmall2)),
        _Row('headlineSmall3', '18 / 26 / Bold', Text('设计系统 Design System', style: TalkTypography.headlineSmall3)),
        _Category('Title'),
        _Row('titleLarge', '22 / 28 / Bold', Text('设计系统 Design System', style: TalkTypography.titleLarge)),
        _Row('titleMedium', '16 / 24 / Bold', Text('设计系统 Design System', style: TalkTypography.titleMedium)),
        _Row('titleSmall', '14 / 20 / Bold', Text('设计系统 Design System', style: TalkTypography.titleSmall)),
        _Category('Label'),
        _Row('labelLarge', '14 / 20 / Bold', Text('设计系统 Design System', style: TalkTypography.labelLarge)),
        _Row('labelMedium', '12 / 16 / Bold', Text('设计系统 Design System', style: TalkTypography.labelMedium)),
        _Row('labelSmall', '11 / 16 / Bold', Text('设计系统 Design System', style: TalkTypography.labelSmall)),
        _Category('Body'),
        _Row('bodyLarge2', '18 / 26 / Medium', Text('设计系统 Design System', style: TalkTypography.bodyLarge2)),
        _Row('bodyLarge', '16 / 24 / Medium', Text('设计系统 Design System', style: TalkTypography.bodyLarge)),
        _Row('bodyMedium', '14 / 20 / Medium', Text('设计系统 Design System', style: TalkTypography.bodyMedium)),
        _Row('bodySmall', '12 / 16 / Medium', Text('设计系统 Design System', style: TalkTypography.bodySmall)),
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
        Text('主题色文字', style: TalkTypography.titleLarge.copyWith(color: colors.main)),
        const SizedBox(height: 4),
        const Text('TalkTypography.titleLarge.copyWith(color: talkColors.main)', style: TextStyle(fontSize: 11, color: Colors.black38)),
        const SizedBox(height: TalkSpacing.m),
        Text('次要色文字', style: TalkTypography.titleMedium.copyWith(color: colors.textSecondary)),
        const SizedBox(height: 4),
        const Text('TalkTypography.titleMedium.copyWith(color: talkColors.textSecondary)', style: TextStyle(fontSize: 11, color: Colors.black38)),
      ],
    );
  }
}
