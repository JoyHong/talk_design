import 'package:flutter/material.dart';
import 'package:talk_design/talk_design.dart';

class TokensPage extends StatelessWidget {
  const TokensPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(TalkSpacing.l),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _sectionTitle('Typography — 字号'),
          ...[
            ('headline', TalkTypography.headline, TalkTypography.bold),
            ('title', TalkTypography.title, TalkTypography.semiBold),
            ('bodyLarge', TalkTypography.bodyLarge, TalkTypography.medium),
            ('body', TalkTypography.body, TalkTypography.regular),
            ('label', TalkTypography.label, TalkTypography.regular),
          ].map((e) => Padding(
                padding: const EdgeInsets.only(bottom: TalkSpacing.s),
                child: Text(
                  '${e.$1} — ${e.$2.toInt()}px',
                  style: TextStyle(fontSize: e.$2, fontWeight: e.$3),
                ),
              )),
          const SizedBox(height: TalkSpacing.xl),
          _sectionTitle('Spacing — 间距'),
          ...{
            'xs': TalkSpacing.xs,
            's': TalkSpacing.s,
            'm': TalkSpacing.m,
            'l': TalkSpacing.l,
            'xl': TalkSpacing.xl,
            'xxl': TalkSpacing.xxl,
          }.entries.map((e) => Padding(
                padding: const EdgeInsets.only(bottom: TalkSpacing.s),
                child: Row(
                  children: [
                    SizedBox(
                      width: 48,
                      child: Text(
                        e.key,
                        style: const TextStyle(
                          fontSize: TalkTypography.label,
                          color: Colors.black45,
                        ),
                      ),
                    ),
                    Container(
                      width: e.value * 2,
                      height: 20,
                      color: const Color(0xFFFF2C55),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      '${e.value.toInt()}px',
                      style: const TextStyle(fontSize: TalkTypography.label),
                    ),
                  ],
                ),
              )),
          const SizedBox(height: TalkSpacing.xl),
          _sectionTitle('Shadows — 阴影'),
          const SizedBox(height: TalkSpacing.s),
          Row(
            children: [
              _ShadowCard(label: 'card', shadows: TalkShadows.card),
              const SizedBox(width: TalkSpacing.l),
              _ShadowCard(label: 'popup', shadows: TalkShadows.popup),
            ],
          ),
          const SizedBox(height: TalkSpacing.xl),
          _sectionTitle('Radius — 圆角'),
          const SizedBox(height: TalkSpacing.s),
          Wrap(
            spacing: TalkSpacing.l,
            runSpacing: TalkSpacing.l,
            children: [
              _RadiusCard(label: 'radiusS', radius: TalkSpacing.radiusS),
              _RadiusCard(label: 'radiusM', radius: TalkSpacing.radiusM),
              _RadiusCard(label: 'radiusL', radius: TalkSpacing.radiusL),
              _RadiusCard(label: 'radiusFull', radius: 24),
            ],
          ),
        ],
      ),
    );
  }

  Widget _sectionTitle(String text) => Padding(
        padding: const EdgeInsets.only(bottom: TalkSpacing.s),
        child: Text(
          text,
          style: const TextStyle(
            fontSize: TalkTypography.label,
            color: Colors.black45,
          ),
        ),
      );
}

class _ShadowCard extends StatelessWidget {
  const _ShadowCard({required this.label, required this.shadows});

  final String label;
  final List<BoxShadow> shadows;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 80,
          height: 80,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(TalkSpacing.radiusM),
            boxShadow: shadows,
          ),
        ),
        const SizedBox(height: TalkSpacing.s),
        Text(label, style: const TextStyle(fontSize: TalkTypography.label, color: Colors.black45)),
      ],
    );
  }
}

class _RadiusCard extends StatelessWidget {
  const _RadiusCard({required this.label, required this.radius});

  final String label;
  final double radius;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 64,
          height: 64,
          decoration: BoxDecoration(
            color: const Color(0xFFFF2C55).withValues(alpha: 0.15),
            border: Border.all(color: const Color(0xFFFF2C55)),
            borderRadius: BorderRadius.circular(radius),
          ),
        ),
        const SizedBox(height: TalkSpacing.xs),
        Text(label, style: const TextStyle(fontSize: TalkTypography.label, color: Colors.black45)),
      ],
    );
  }
}
