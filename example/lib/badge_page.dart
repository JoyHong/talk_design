import 'package:flutter/material.dart';
import 'package:talk_design/talk_design.dart';

class BadgePage extends StatelessWidget {
  const BadgePage({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const _Section(
            title: '纯红点 — TalkBadge.dot()',
            description: '直径 8px，无内容，用于最简提示',
            children: [TalkBadge.dot()],
          ),
          const _Section(
            title: 'Small 数字徽标（高度 16px）',
            description: '单个字符为圆形，多字符为胶囊形；字号 11px Bold',
            children: [
              TalkBadge(count: 1),
              TalkBadge(count: 9),
              TalkBadge(count: 10),
              TalkBadge(count: 99),
              TalkBadge(count: 100),
              TalkBadge(count: 999),
            ],
          ),
          const _Section(
            title: 'Large 数字徽标（高度 18px）',
            description: '单个字符为圆形，多字符为胶囊形；字号 12px Bold',
            children: [
              TalkBadge(count: 1, size: TalkBadgeSize.large),
              TalkBadge(count: 9, size: TalkBadgeSize.large),
              TalkBadge(count: 10, size: TalkBadgeSize.large),
              TalkBadge(count: 99, size: TalkBadgeSize.large),
              TalkBadge(count: 100, size: TalkBadgeSize.large),
              TalkBadge(count: 999, size: TalkBadgeSize.large),
            ],
          ),
          _Section(
            title: '典型用法 — 覆盖在头像右上角',
            description: '使用 Stack 将 TalkBadge 叠加在头像上',
            children: [
              _AvatarWithBadge(count: 3, avatarSize: 40),
              _AvatarWithBadge(count: 99, avatarSize: 40),
              _AvatarWithBadge(count: 100, avatarSize: 40),
              _AvatarWithBadge(count: 0, avatarSize: 40, dot: true),
            ],
          ),
          _Section(
            title: '典型用法 — 覆盖在图标右上角',
            description: '使用 Stack 将 TalkBadge 叠加在图标上',
            children: [
              _IconWithBadge(count: 5),
              _IconWithBadge(count: 99),
              _IconWithBadge(count: 100),
            ],
          ),
        ],
      ),
    );
  }
}

class _AvatarWithBadge extends StatelessWidget {
  const _AvatarWithBadge({
    required this.count,
    required this.avatarSize,
    this.dot = false,
  });

  final int count;
  final double avatarSize;
  final bool dot;

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Container(
          width: avatarSize,
          height: avatarSize,
          decoration: BoxDecoration(
            color: context.talkColors.backgroundSecondary,
            shape: BoxShape.circle,
          ),
          child: Icon(
            Icons.person,
            size: avatarSize * 0.6,
            color: context.talkColors.textSecondary,
          ),
        ),
        Positioned(
          top: -4,
          right: -4,
          child: dot ? const TalkBadge.dot() : TalkBadge(count: count),
        ),
      ],
    );
  }
}

class _IconWithBadge extends StatelessWidget {
  const _IconWithBadge({required this.count});

  final int count;

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Icon(Icons.chat_bubble_outline, size: 28, color: context.talkColors.textPrimary),
        Positioned(
          top: -6,
          right: -8,
          child: TalkBadge(count: count),
        ),
      ],
    );
  }
}

class _Section extends StatelessWidget {
  const _Section({
    required this.title,
    required this.children,
    this.description,
  });

  final String title;
  final String? description;
  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: Theme.of(context).textTheme.titleSmall),
          if (description != null) ...[
            const SizedBox(height: 4),
            Text(
              description!,
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: context.talkColors.textSecondary,
                  ),
            ),
          ],
          const SizedBox(height: 12),
          Wrap(
            spacing: 16,
            runSpacing: 12,
            crossAxisAlignment: WrapCrossAlignment.center,
            children: children,
          ),
        ],
      ),
    );
  }
}
