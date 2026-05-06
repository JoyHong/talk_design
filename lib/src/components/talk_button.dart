import 'package:flutter/material.dart';

import '../theme/talk_context_extensions.dart';
import '../tokens/talk_colors.dart';
import '../tokens/talk_typography.dart';

enum _V {
  textTheme,
  textSecondary,
  fillTheme,
  fillThemeIcon,
  strokeSecondary,
  strokeSecondaryIcon,
  themeIcon,
  textSecondaryRipple,
  block,
}

/// Controls the size behavior of [TalkButton].
///
/// - [fixed]    → 固定 216 × 52（默认）
/// - [adaptive] → 内容自适应，最小 72 × 30，最大 400 × 50
/// - [fill]     → 撑满父容器宽度，最大不超过 400；高度固定 50
enum TalkButtonSize {
  fixed,
  adaptive,
  fill,
}

/// Figma 规范对应的完整按钮组件，覆盖所有 9 种变体。
///
/// 使用具名构造函数选择变体：
/// ```dart
/// TalkButton.fillTheme(label: '确认', onPressed: () {})
/// TalkButton.fillTheme(label: '确认', size: TalkButtonSize.fill, onPressed: () {})
/// TalkButton.themeIcon(icon: const Icon(Icons.add), onPressed: () {})
/// TalkButton.block(icon: const Icon(Icons.videocam), label: '视频', onPressed: () {})
/// ```
class TalkButton extends StatelessWidget {
  // ── 文字按钮（主题色） ──────────────────────────────────────────────────────
  const TalkButton.textTheme({
    required this.label,
    this.onPressed,
    this.size = TalkButtonSize.fixed,
    super.key,
  })  : _variant = _V.textTheme,
        icon = null;

  // ── 文字按钮（次要色） ──────────────────────────────────────────────────────
  const TalkButton.textSecondary({
    required this.label,
    this.onPressed,
    this.size = TalkButtonSize.fixed,
    super.key,
  })  : _variant = _V.textSecondary,
        icon = null;

  // ── 填充按钮（主题色，纯文字） ─────────────────────────────────────────────
  const TalkButton.fillTheme({
    required this.label,
    this.onPressed,
    this.size = TalkButtonSize.fixed,
    super.key,
  })  : _variant = _V.fillTheme,
        icon = null;

  // ── 填充按钮（主题色 + 图标） ──────────────────────────────────────────────
  const TalkButton.fillThemeIcon({
    required this.label,
    required this.icon,
    this.onPressed,
    this.size = TalkButtonSize.fixed,
    super.key,
  }) : _variant = _V.fillThemeIcon;

  // ── 描边按钮（纯文字） ─────────────────────────────────────────────────────
  const TalkButton.strokeSecondary({
    required this.label,
    this.onPressed,
    this.size = TalkButtonSize.fixed,
    super.key,
  })  : _variant = _V.strokeSecondary,
        icon = null;

  // ── 描边按钮（文字 + 图标） ────────────────────────────────────────────────
  const TalkButton.strokeSecondaryIcon({
    required this.label,
    required this.icon,
    this.onPressed,
    this.size = TalkButtonSize.fixed,
    super.key,
  }) : _variant = _V.strokeSecondaryIcon;

  // ── 纯图标按钮（36×36） ────────────────────────────────────────────────────
  const TalkButton.themeIcon({
    required this.icon,
    this.onPressed,
    super.key,
  })  : _variant = _V.themeIcon,
        label = null,
        size = TalkButtonSize.fixed;

  // ── 次要文字按钮（含悬停/按下背景） ──────────────────────────────────────
  const TalkButton.textSecondaryRipple({
    required this.label,
    this.onPressed,
    this.size = TalkButtonSize.fixed,
    super.key,
  })  : _variant = _V.textSecondaryRipple,
        icon = null;

  // ── 块状按钮（图标居上、文字居下的垂直布局，常用于工具栏/面板） ────────────
  const TalkButton.block({
    required this.label,
    required this.icon,
    this.onPressed,
    super.key,
  })  : _variant = _V.block,
        size = TalkButtonSize.fixed;

  final _V _variant;
  final String? label;
  final Widget? icon;
  final VoidCallback? onPressed;

  /// 尺寸模式，默认 [TalkButtonSize.fixed]（216 × 52）。
  final TalkButtonSize size;

  static const _noOverlay = WidgetStatePropertyAll<Color>(Colors.transparent);
  static const _noElevation = WidgetStatePropertyAll<double>(0);
  static const _stadiumShape =
      WidgetStatePropertyAll<OutlinedBorder>(StadiumBorder());
  static const _stdPadding = WidgetStatePropertyAll<EdgeInsetsGeometry>(
    EdgeInsets.symmetric(horizontal: 12, vertical: 16),
  );

  // ── 尺寸约束 ─────────────────────────────────────────────────────────────
  // fixed: 固定 216×52
  static const _fixedSize =
      WidgetStatePropertyAll<Size>(Size(216, 52));
  // adaptive: 最小 72×30，最大 400×50
  static const _adaptiveMin =
      WidgetStatePropertyAll<Size>(Size(72, 30));
  static const _adaptiveMax =
      WidgetStatePropertyAll<Size>(Size(400, 50));
  // fill: 撑满父容器（最大由外层 ConstrainedBox 限制到 400），高度 50
  static const _fillMin =
      WidgetStatePropertyAll<Size>(Size(double.infinity, 50));

  /// 当 [size] 为 [TalkButtonSize.fill] 时，用 ConstrainedBox 将宽度上限限为 400。
  Widget _wrapSize(Widget child) {
    if (size == TalkButtonSize.fill) {
      return ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 400),
        child: child,
      );
    }
    return child;
  }

  WidgetStateProperty<Size>? get _fixedSizeProp =>
      size == TalkButtonSize.fixed ? _fixedSize : null;

  WidgetStateProperty<Size>? get _minimumSizeProp => switch (size) {
        TalkButtonSize.adaptive => _adaptiveMin,
        TalkButtonSize.fill => _fillMin,
        _ => null,
      };

  WidgetStateProperty<Size>? get _maximumSizeProp =>
      size == TalkButtonSize.adaptive ? _adaptiveMax : null;

  @override
  Widget build(BuildContext context) {
    return _wrapSize(switch (_variant) {
      _V.fillTheme || _V.fillThemeIcon => _buildFill(context),
      _V.strokeSecondary || _V.strokeSecondaryIcon => _buildStroke(context),
      _V.themeIcon => _buildIconOnly(context),
      _V.block => _buildBlock(context),
      _ => _buildText(context),
    });
  }

  // ── 文字按钮（textTheme / textSecondary / textSecondaryRipple） ─────────────
  Widget _buildText(BuildContext context) {
    final colors = context.talkColors;
    return TextButton(
      onPressed: onPressed,
      style: ButtonStyle(
        foregroundColor: WidgetStateProperty.resolveWith((s) => _textForeground(s, colors)),
        backgroundColor: WidgetStateProperty.resolveWith((s) => _textBackground(s)),
        overlayColor: _noOverlay,
        textStyle: const WidgetStatePropertyAll(TalkTypography.bodyMedium),
        fixedSize: _fixedSizeProp,
        minimumSize: _minimumSizeProp,
        maximumSize: _maximumSizeProp,
        padding: _stdPadding,
        shape: _stadiumShape,
        elevation: _noElevation,
      ),
      child: Text(label!),
    );
  }

  Color _textForeground(Set<WidgetState> s, TalkColors colors) {
    if (s.contains(WidgetState.disabled)) {
      return _variant == _V.textTheme
          ? const Color(0x333C3C43)
          : const Color(0xFFD1D1D1);
    }
    return switch (_variant) {
      _V.textTheme => s.contains(WidgetState.pressed)
          ? const Color(0xFFE5284D)
          : s.contains(WidgetState.hovered)
              ? const Color(0xFFFF4569)
              : colors.main,
      _V.textSecondary => s.contains(WidgetState.pressed)
          ? const Color(0xFF777777)
          : s.contains(WidgetState.hovered)
              ? const Color(0xFF888888)
              : colors.textSecondary,
      _ => colors.textSecondary, // textSecondaryRipple 文字色不随状态变
    };
  }

  Color _textBackground(Set<WidgetState> s) {
    if (s.contains(WidgetState.pressed)) return const Color(0x33999999);
    if (s.contains(WidgetState.hovered)) return const Color(0x1A999999);
    return Colors.transparent;
  }

  // ── 填充按钮（fillTheme / fillThemeIcon） ──────────────────────────────────
  Widget _buildFill(BuildContext context) {
    final colors = context.talkColors;
    final hasIcon = _variant == _V.fillThemeIcon;
    return TextButton(
      onPressed: onPressed,
      style: ButtonStyle(
        backgroundColor: WidgetStateProperty.resolveWith((s) {
          if (s.contains(WidgetState.disabled)) return const Color(0x424F4F4F);
          if (s.contains(WidgetState.pressed)) return const Color(0xFFE5284D);
          if (s.contains(WidgetState.hovered)) return const Color(0xFFFF4569);
          return colors.main;
        }),
        foregroundColor: WidgetStateProperty.resolveWith((s) {
          if (s.contains(WidgetState.disabled)) return const Color(0x61000000);
          return Colors.white;
        }),
        overlayColor: _noOverlay,
        textStyle: WidgetStatePropertyAll(hasIcon ? TalkTypography.labelLarge : TalkTypography.bodyMedium),
        fixedSize: _fixedSizeProp,
        minimumSize: _minimumSizeProp,
        maximumSize: _maximumSizeProp,
        padding: _stdPadding,
        shape: _stadiumShape,
        elevation: _noElevation,
      ),
      child: hasIcon
          ? Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconTheme.merge(data: const IconThemeData(size: 20), child: icon!),
                const SizedBox(width: 8),
                Text(label!),
              ],
            )
          : Text(label!),
    );
  }

  // ── 描边按钮（strokeSecondary / strokeSecondaryIcon） ──────────────────────
  Widget _buildStroke(BuildContext context) {
    final colors = context.talkColors;
    final hasIcon = _variant == _V.strokeSecondaryIcon;
    return TextButton(
      onPressed: onPressed,
      style: ButtonStyle(
        backgroundColor: WidgetStateProperty.resolveWith((s) {
          if (s.contains(WidgetState.pressed)) return const Color(0x40AAAAAA);
          if (s.contains(WidgetState.hovered)) return const Color(0x1FAAAAAA);
          return Colors.transparent;
        }),
        foregroundColor: WidgetStateProperty.resolveWith((s) {
          if (s.contains(WidgetState.disabled)) return const Color(0x61000000);
          return colors.textMain;
        }),
        side: WidgetStateProperty.resolveWith((s) {
          if (s.contains(WidgetState.disabled)) {
            return const BorderSide(color: Color(0x1F000000), width: 2);
          }
          return BorderSide(color: colors.textSecondary, width: 2);
        }),
        overlayColor: _noOverlay,
        textStyle: const WidgetStatePropertyAll(TalkTypography.bodyMedium),
        fixedSize: _fixedSizeProp,
        minimumSize: _minimumSizeProp,
        maximumSize: _maximumSizeProp,
        padding: _stdPadding,
        shape: _stadiumShape,
        elevation: _noElevation,
      ),
      child: hasIcon
          ? Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconTheme.merge(data: const IconThemeData(size: 20), child: icon!),
                const SizedBox(width: 10),
                Text(label!),
              ],
            )
          : Text(label!),
    );
  }

  // ── 纯图标按钮（themeIcon，36×36） ────────────────────────────────────────
  Widget _buildIconOnly(BuildContext context) {
    final colors = context.talkColors;
    return TextButton(
        onPressed: onPressed,
        style: ButtonStyle(
          backgroundColor: WidgetStateProperty.resolveWith((s) {
            if (s.contains(WidgetState.disabled)) return colors.listCardMenuPressed;
            if (s.contains(WidgetState.pressed)) return colors.listCardMenuPressed;
            if (s.contains(WidgetState.hovered)) return colors.listCardMenuFloating;
            return Colors.transparent;
          }),
          foregroundColor: WidgetStatePropertyAll(colors.main),
          overlayColor: _noOverlay,
          minimumSize: const WidgetStatePropertyAll(Size(36, 36)),
          maximumSize: const WidgetStatePropertyAll(Size(36, 36)),
          padding: const WidgetStatePropertyAll(EdgeInsets.all(8)),
          shape: const WidgetStatePropertyAll(CircleBorder()),
          elevation: _noElevation,
        ),
        child: icon!,
      );
  }

  // ── 块状按钮（图标居上、文字居下） ───────────────────────────────────────
  Widget _buildBlock(BuildContext context) {
    final colors = context.talkColors;
    return TextButton(
        onPressed: onPressed,
        style: ButtonStyle(
          backgroundColor: WidgetStateProperty.resolveWith((s) {
            if (s.contains(WidgetState.pressed)) return colors.listCardMenuPressed;
            if (s.contains(WidgetState.hovered)) return colors.listCardMenuFloating;
            return Colors.transparent;
          }),
          foregroundColor: WidgetStateProperty.resolveWith((s) {
            if (s.contains(WidgetState.disabled)) return const Color(0x333C3C43);
            return colors.main;
          }),
          overlayColor: _noOverlay,
          textStyle: const WidgetStatePropertyAll(TalkTypography.bodySmall),
          padding: const WidgetStatePropertyAll(
            EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          ),
          minimumSize: const WidgetStatePropertyAll(Size(56, 0)),
          shape: const WidgetStatePropertyAll(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(8)),
            ),
          ),
          elevation: _noElevation,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconTheme.merge(
              data: const IconThemeData(size: 24),
              child: icon!,
            ),
            const SizedBox(height: 8),
            Text(label!),
          ],
        ),
      );
  }
}
