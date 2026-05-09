import 'package:flutter/material.dart';

import '../theme/talk_context_extensions.dart';
import '../tokens/talk_typography.dart';
import 'talk_button.dart';

const _kRadius = BorderRadius.all(Radius.circular(20));

// ── 内部辅助：统一的列表行水波纹包裹 ────────────────────────────────────────
//
// hoverColor 由调用方传入，以便含子交互控件的变体可在鼠标移入子控件时将其置为
// transparent，从而实现"悬浮至按钮/开关时列表无悬浮效果"的规范要求。
class _ListInkWell extends StatelessWidget {
  const _ListInkWell({
    required this.onTap,
    required this.hoverColor,
    required this.splashColor,
    required this.child,
  });

  final VoidCallback? onTap;
  final Color hoverColor;
  final Color splashColor;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: _kRadius,
      hoverColor: hoverColor,
      splashColor: splashColor,
      highlightColor: Colors.transparent,
      child: child,
    );
  }
}

// ── TalkAvatarStatusItem ──────────────────────────────────────────────────

/// Figma avatarListItem_status — 带状态信息的头像列表项。
///
/// 内边距：水平 10，垂直 12。
/// 所有文本单行，超出宽度用省略号截断。
class TalkAvatarStatusItem extends StatelessWidget {
  const TalkAvatarStatusItem({
    required this.avatar,
    required this.name,
    this.timestamp,
    this.statusIcon,
    this.preview,
    this.badge,
    this.onTap,
    super.key,
  });

  /// 头像 Widget，由外部传入并控制尺寸和裁剪。
  final Widget avatar;

  /// 联系人名称，主文本色，单行省略。
  final String name;

  /// 右上角时间戳文字，次要文本色。
  final String? timestamp;

  /// 预览行左侧的状态图标（14×14）。
  final Widget? statusIcon;

  /// 消息预览文字，次要文本色，单行省略。
  final String? preview;

  /// 未读角标 Widget，由外部控制尺寸。
  final Widget? badge;

  /// 整行点击回调。
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final colors = context.talkColors;
    return _ListInkWell(
      onTap: onTap,
      hoverColor: colors.listCardMenuHovered,
      splashColor: colors.listCardMenuPressed,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 12),
        child: Row(
          children: [
            avatar,
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // 名称行：名字（左）+ 时间戳（右） + 可能的未读角标（当无预览时）
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          name,
                          style: TalkTypography.bodyMedium,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      if (timestamp != null)
                        Padding(
                          padding: const EdgeInsets.only(left: 4),
                          child: Text(
                            timestamp!,
                            style: TalkTypography.bodySmall
                                .copyWith(color: colors.textSecondary),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      if (statusIcon == null && preview == null && badge != null)
                        Padding(
                          padding: const EdgeInsets.only(left: 8),
                          child: badge!,
                        ),
                    ],
                  ),
                  if (statusIcon != null || preview != null) ...[
                    const SizedBox(height: 4),
                    // 预览行：状态图标 + 消息文字（flex）+ 未读角标
                    Row(
                      children: [
                        if (statusIcon != null) ...[
                          SizedBox.square(dimension: 14, child: statusIcon!),
                          const SizedBox(width: 8),
                        ],
                        Expanded(
                          child: Text(
                            preview ?? '',
                            style: TalkTypography.bodySmall
                                .copyWith(color: colors.textSecondary),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        if (badge != null)
                          Padding(
                            padding: const EdgeInsets.only(left: 8),
                            child: badge!,
                          ),
                      ],
                    ),
                  ],
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ── TalkAvatarButtonItem ──────────────────────────────────────────────────

/// Figma avatarListItem_button — 带操作按钮的头像列表项。
///
/// 内边距：水平 24，垂直 16。头像由外部控制尺寸与裁剪。
/// 右侧按钮使用主题色 2px 描边，胶囊形圆角。
/// 所有文本单行，超出宽度用省略号截断。
/// 鼠标悬浮至右侧按钮时，列表行不显示悬浮效果。
class TalkAvatarButtonItem extends StatefulWidget {
  const TalkAvatarButtonItem({
    required this.avatar,
    required this.title,
    this.subtitle,
    required this.buttonLabel,
    this.onButtonPressed,
    this.onTap,
    super.key,
  });

  /// 头像 Widget，由外部控制尺寸与裁剪。
  final Widget avatar;

  /// 主标题，主文本色，单行省略。
  final String title;

  /// 可选副标题，次要文本色，单行省略。
  final String? subtitle;

  /// 右侧按钮文字。
  final String buttonLabel;

  /// 右侧按钮点击回调，null 时按钮禁用。
  final VoidCallback? onButtonPressed;

  /// 整行点击回调（按钮区域除外）。
  final VoidCallback? onTap;

  @override
  State<TalkAvatarButtonItem> createState() => _TalkAvatarButtonItemState();
}

class _TalkAvatarButtonItemState extends State<TalkAvatarButtonItem> {
  bool _buttonHovered = false;

  @override
  Widget build(BuildContext context) {
    final colors = context.talkColors;
    return _ListInkWell(
      onTap: widget.onTap,
      hoverColor:
          _buttonHovered ? Colors.transparent : colors.listCardMenuHovered,
      splashColor: colors.listCardMenuPressed,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        child: Row(
          children: [
            Expanded(
              child: Row(
                children: [
                  widget.avatar,
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.title,
                          style: TalkTypography.bodyMedium,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        if (widget.subtitle != null) ...[
                          const SizedBox(height: 4),
                          Text(
                            widget.subtitle!,
                            style: TalkTypography.bodySmall
                                .copyWith(color: colors.textSecondary),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 12),
            MouseRegion(
              onEnter: (_) => setState(() => _buttonHovered = true),
              onExit: (_) => setState(() => _buttonHovered = false),
              child: TalkButton.strokeThemeCustom(
                label: widget.buttonLabel,
                onPressed: widget.onButtonPressed,
                size: TalkButtonSize.adaptive,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ── TalkListBaseItem ──────────────────────────────────────────────────────

/// Figma List_base — 带图标的基础列表项。
///
/// 左侧接受 20×20 图标 Widget，右侧可选附属文字。
/// [compact] 为 true 时水平内边距为 10，否则为 24；垂直内边距固定 18。
/// 所有文本单行，超出宽度用省略号截断。
class TalkListBaseItem extends StatelessWidget {
  const TalkListBaseItem({
    this.icon,
    required this.label,
    this.trailing,
    this.compact = false,
    this.onTap,
    super.key,
  });

  /// 左侧图标（20×20）。
  final Widget? icon;

  /// 主标签文字，主文本色，单行省略。
  final String label;

  /// 可选的右侧附属文字，次要文本色。
  final String? trailing;

  /// true 时水平内边距为 10（紧凑），false 时为 24（宽松，默认）。
  final bool compact;

  /// 整行点击回调。
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final colors = context.talkColors;
    return _ListInkWell(
      onTap: onTap,
      hoverColor: colors.listCardMenuHovered,
      splashColor: colors.listCardMenuPressed,
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: compact ? 10.0 : 24.0,
          vertical: 18,
        ),
        child: Row(
          children: [
            if (icon != null) ...[
              SizedBox.square(dimension: 20, child: icon!),
              const SizedBox(width: 16),
            ],
            Expanded(
              child: Text(
                label,
                style: TalkTypography.bodyMedium,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            if (trailing != null)
              Text(
                trailing!,
                style: TalkTypography.bodyMedium
                    .copyWith(color: colors.textSecondary),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
          ],
        ),
      ),
    );
  }
}

// ── TalkListButtonItem ────────────────────────────────────────────────────

/// Figma List_base_button — 带操作按钮的基础列表项。
///
/// 内边距：水平 24，垂直 16。
/// 右侧按钮使用次要色 1px 描边，胶囊形圆角。
/// 所有文本单行，超出宽度用省略号截断。
/// 鼠标悬浮至右侧按钮时，列表行不显示悬浮效果。
class TalkListButtonItem extends StatefulWidget {
  const TalkListButtonItem({
    required this.title,
    this.subtitle,
    required this.buttonLabel,
    this.onButtonPressed,
    this.onTap,
    super.key,
  });

  /// 主标题，主文本色，单行省略。
  final String title;

  /// 可选副标题，次要文本色，单行省略。
  final String? subtitle;

  /// 右侧按钮文字。
  final String buttonLabel;

  /// 右侧按钮点击回调，null 时按钮禁用。
  final VoidCallback? onButtonPressed;

  /// 整行点击回调（按钮区域除外）。
  final VoidCallback? onTap;

  @override
  State<TalkListButtonItem> createState() => _TalkListButtonItemState();
}

class _TalkListButtonItemState extends State<TalkListButtonItem> {
  bool _buttonHovered = false;

  @override
  Widget build(BuildContext context) {
    final colors = context.talkColors;
    return _ListInkWell(
      onTap: widget.onTap,
      hoverColor:
          _buttonHovered ? Colors.transparent : colors.listCardMenuHovered,
      splashColor: colors.listCardMenuPressed,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        child: Row(
          children: [
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.title,
                    style: TalkTypography.bodyMedium,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  if (widget.subtitle != null) ...[
                    const SizedBox(height: 5),
                    Text(
                      widget.subtitle!,
                      style: TalkTypography.bodySmall
                          .copyWith(color: colors.textSecondary),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ],
              ),
            ),
            const SizedBox(width: 16),
            MouseRegion(
              onEnter: (_) => setState(() => _buttonHovered = true),
              onExit: (_) => setState(() => _buttonHovered = false),
              child: TalkButton.strokeSecondaryCustom(
                label: widget.buttonLabel,
                onPressed: widget.onButtonPressed,
                size: TalkButtonSize.adaptive,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ── TalkListSwitchItem ────────────────────────────────────────────────────

/// Figma List_base_switch — 带开关的基础列表项。
///
/// [subtitle] 为 null 时为单行变体（垂直内边距 14）；
/// 非 null 时为双行变体（垂直内边距 13）。
/// 主文本单行省略，副文本同理。
class TalkListSwitchItem extends StatelessWidget {
  const TalkListSwitchItem({
    required this.label,
    this.subtitle,
    required this.value,
    this.onChanged,
    super.key,
  });

  /// 主标签文字，主文本色，单行省略。
  final String label;

  /// 可选副标签，次要文本色，单行省略；非 null 时呈现双行布局。
  final String? subtitle;

  /// 开关当前值。
  final bool value;

  /// 开关状态变化回调，null 时开关禁用。
  final ValueChanged<bool>? onChanged;

  @override
  Widget build(BuildContext context) {
    final colors = context.talkColors;
    final verticalPadding = subtitle == null ? 14.0 : 13.0;
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 24, vertical: verticalPadding),
      child: Row(
        children: [
          Expanded(
            child: subtitle == null
                ? Text(
                    label,
                    style: TalkTypography.bodyMedium,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  )
                : Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        label,
                        style: TalkTypography.bodyMedium,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 4),
                      Text(
                        subtitle!,
                        style: TalkTypography.bodySmall
                            .copyWith(color: colors.textSecondary),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
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
          ),
        ],
      ),
    );
  }
}
