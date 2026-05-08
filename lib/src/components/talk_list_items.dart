import 'package:flutter/material.dart';

import '../theme/talk_context_extensions.dart';
import '../tokens/talk_typography.dart';
import 'talk_button.dart';

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
      borderRadius: BorderRadius.circular(24),
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
      borderRadius: BorderRadius.circular(24),
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
      borderRadius: BorderRadius.circular(24),
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
      borderRadius: BorderRadius.circular(24),
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
