import 'package:flutter/material.dart';

import '../theme/talk_context_extensions.dart';
import '../tokens/talk_typography.dart';
import 'talk_button.dart';
import 'talk_checkbox.dart';

// ─────────────────────────────────────────────────────────────────────────────
// 头像列表 items
// ─────────────────────────────────────────────────────────────────────────────

/// 头像列表项 — 样式一：带勾选状态
///
/// 左侧头像(32×32)由 [avatar] 传入，右侧显示 [TalkCheckbox] 反映 [selected] 状态。
class TalkAvatarCheckListItem extends StatelessWidget {
  const TalkAvatarCheckListItem({
    super.key,
    required this.avatar,
    required this.name,
    required this.selected,
    this.onTap,
  });

  final Widget avatar;
  final String name;
  final bool selected;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 12),
        child: Row(
          children: [
            SizedBox(width: 32, height: 32, child: avatar),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                name,
                style: TalkTypography.bodyMedium,
              ),
            ),
            const SizedBox(width: 12),
            IgnorePointer(
              child: TalkCheckbox(
                value: selected,
                onChanged: (_) {},
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// 头像列表项 — 样式二：单行 / 双行（含可选副标题）
///
/// 左侧头像(44×44)由 [avatar] 传入。[subtitle] 为空时显示单行，有值时显示双行。
class TalkAvatarSimpleListItem extends StatelessWidget {
  const TalkAvatarSimpleListItem({
    super.key,
    required this.avatar,
    required this.name,
    this.subtitle,
    this.onTap,
  });

  final Widget avatar;
  final String name;
  final String? subtitle;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final colors = context.talkColors;
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Row(
          children: [
            SizedBox(width: 44, height: 44, child: avatar),
            const SizedBox(width: 16),
            Expanded(
              child: subtitle != null
                  ? Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          name,
                          style: TalkTypography.bodyMedium,
                        ),
                        const SizedBox(height: 2),
                        Text(
                          subtitle!,
                          style: TalkTypography.bodyMedium.copyWith(color: colors.textSecondary),
                        ),
                      ],
                    )
                  : Text(
                      name,
                      style: TalkTypography.bodyMedium,
                    ),
            ),
          ],
        ),
      ),
    );
  }
}

/// 头像列表项 — 样式三：消息预览（名称+时间 / 消息内容+未读数）
///
/// 左侧头像(44×44)由 [avatar] 传入。
/// [leadingIcon] 消息类型图标（可选，显示在消息文本前）。
/// [unreadBadge] 未读数 widget（可选，显示在消息文本后）。
class TalkAvatarMessageListItem extends StatelessWidget {
  const TalkAvatarMessageListItem({
    super.key,
    required this.avatar,
    required this.name,
    required this.message,
    this.time,
    this.leadingIcon,
    this.unreadBadge,
    this.onTap,
  });

  final Widget avatar;
  final String name;
  final String message;
  final String? time;
  final Widget? leadingIcon;
  final Widget? unreadBadge;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final colors = context.talkColors;
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 12),
        child: Row(
          children: [
            SizedBox(width: 44, height: 44, child: avatar),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          name,
                          style: TalkTypography.bodyMedium,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      if (time != null) ...[
                        const SizedBox(width: 8),
                        Text(
                          time!,
                          style: TalkTypography.bodySmall.copyWith(color: colors.textSecondary),
                        ),
                      ],
                    ],
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      if (leadingIcon != null) ...[
                        leadingIcon!,
                        const SizedBox(width: 8),
                      ],
                      Expanded(
                        child: Text(
                          message,
                          style: TalkTypography.bodySmall.copyWith(color: colors.textSecondary),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      if (unreadBadge != null) ...[
                        const SizedBox(width: 4),
                        unreadBadge!,
                      ],
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// 头像列表项 — 样式四：带操作按钮
///
/// 左侧头像(44×44)由 [avatar] 传入，右侧显示主题色描边按钮。
class TalkAvatarButtonListItem extends StatelessWidget {
  const TalkAvatarButtonListItem({
    super.key,
    required this.avatar,
    required this.name,
    this.subtitle,
    required this.buttonLabel,
    this.onButtonTap,
    this.onTap,
  });

  final Widget avatar;
  final String name;
  final String? subtitle;
  final String buttonLabel;
  final VoidCallback? onButtonTap;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final colors = context.talkColors;
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        child: Row(
          children: [
            SizedBox(width: 44, height: 44, child: avatar),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    name,
                    style: TalkTypography.bodyMedium,
                  ),
                  if (subtitle != null) ...[
                    const SizedBox(height: 4),
                    Text(
                      subtitle!,
                      style: TalkTypography.bodySmall.copyWith(color: colors.textSecondary),
                    ),
                  ],
                ],
              ),
            ),
            const SizedBox(width: 12),
            TalkButton.strokeThemeCustom(
              label: buttonLabel,
              onPressed: onButtonTap,
              size: TalkButtonSize.adaptive,
            ),
          ],
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// 常规列表 items
// ─────────────────────────────────────────────────────────────────────────────

/// 常规列表项 — 样式一：纯文本
///
/// 左侧主要文本 [title]，右侧可选次要文本 [trailing]。
class TalkTextListItem extends StatelessWidget {
  const TalkTextListItem({
    super.key,
    required this.title,
    this.trailing,
    this.onTap,
  });

  final String title;
  final String? trailing;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final colors = context.talkColors;
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 19),
        child: Row(
          children: [
            Expanded(
              child: Text(
                title,
                style: TalkTypography.bodyMedium,
              ),
            ),
            if (trailing != null)
              Text(
                trailing!,
                style: TalkTypography.bodyMedium.copyWith(color: colors.textSecondary),
              ),
          ],
        ),
      ),
    );
  }
}

/// 常规列表项 — 样式二：左侧图标 + 文本
///
/// [icon] 左侧图标 widget（20×20），由外部传入。
class TalkTextIconListItem extends StatelessWidget {
  const TalkTextIconListItem({
    super.key,
    required this.icon,
    required this.title,
    this.onTap,
  });

  final Widget icon;
  final String title;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 18),
        child: Row(
          children: [
            SizedBox(width: 20, height: 20, child: icon),
            const SizedBox(width: 16),
            Text(
              title,
              style: TalkTypography.bodyMedium,
            ),
          ],
        ),
      ),
    );
  }
}

/// 常规列表项 — 样式三：文本（主+副） + 右侧描边按钮
class TalkTextButtonListItem extends StatelessWidget {
  const TalkTextButtonListItem({
    super.key,
    required this.title,
    this.subtitle,
    required this.buttonLabel,
    this.onButtonTap,
    this.onTap,
  });

  final String title;
  final String? subtitle;
  final String buttonLabel;
  final VoidCallback? onButtonTap;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final colors = context.talkColors;
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    title,
                    style: TalkTypography.bodyMedium,
                  ),
                  if (subtitle != null) ...[
                    const SizedBox(height: 5),
                    Text(
                      subtitle!,
                      style: TalkTypography.bodySmall.copyWith(color: colors.textSecondary),
                    ),
                  ],
                ],
              ),
            ),
            const SizedBox(width: 16),
            TalkButton.strokeSecondaryCustom(
              label: buttonLabel,
              onPressed: onButtonTap,
              size: TalkButtonSize.adaptive,
            ),
          ],
        ),
      ),
    );
  }
}

/// 常规列表项 — 样式四：文本（单行/双行） + 右侧开关
///
/// [subtitle] 为空时显示单行，有值时显示双行。
class TalkTextSwitchListItem extends StatelessWidget {
  const TalkTextSwitchListItem({
    super.key,
    required this.title,
    this.subtitle,
    required this.value,
    this.onChanged,
    this.onTap,
  });

  final String title;
  final String? subtitle;
  final bool value;
  final ValueChanged<bool>? onChanged;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final colors = context.talkColors;
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: 24,
          vertical: subtitle != null ? 13 : 14,
        ),
        child: Row(
          children: [
            Expanded(
              child: subtitle != null
                  ? Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          title,
                          style: TalkTypography.bodyMedium,
                        ),
                        const SizedBox(height: 4),
                        Text(
                          subtitle!,
                          style: TalkTypography.bodySmall.copyWith(color: colors.textSecondary),
                        ),
                      ],
                    )
                  : Text(
                      title,
                      style: TalkTypography.bodyMedium,
                    ),
            ),
            const SizedBox(width: 16),
            Switch(
              value: value,
              onChanged: onChanged,
              activeThumbColor: Colors.white,
              activeTrackColor: colors.theme,
              inactiveThumbColor: Colors.white,
              inactiveTrackColor: colors.textSecondary.withValues(alpha: 0.3),
              materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
            ),
          ],
        ),
      ),
    );
  }
}
