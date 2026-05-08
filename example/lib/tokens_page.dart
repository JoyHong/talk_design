import 'package:flutter/material.dart';
import 'package:talk_design/talk_design.dart';

class TokensPage extends StatelessWidget {
  const TokensPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _sectionTitle('Shadows — 阴影'),
          const SizedBox(height: 8),
          Row(
            children: [
              _ShadowCard(label: 'card', shadows: TalkShadows.card),
              const SizedBox(width: 16),
              _ShadowCard(label: 'popup', shadows: TalkShadows.popup),
            ],
          ),
        ],
      ),
    );
  }

  static const _labelStyle = TextStyle(fontSize: 12, color: Colors.black45);

  Widget _sectionTitle(String text) => Padding(
        padding: const EdgeInsets.only(bottom: 8),
        child: Text(text, style: _labelStyle),
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
            borderRadius: BorderRadius.circular(8),
            boxShadow: shadows,
          ),
        ),
        const SizedBox(height: 8),
        Text(label, style: const TextStyle(fontSize: 12, color: Colors.black45)),
      ],
    );
  }
}