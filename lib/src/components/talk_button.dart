import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:talk_design/src/components/talk_loading_indicator.dart';

import '../theme/talk_context_extensions.dart';
import '../tokens/talk_colors.dart';
import '../tokens/talk_icons.dart';
import '../tokens/talk_spacing.dart';
import '../tokens/talk_typography.dart';

enum _V {
  textTheme,
  textSecondary,
  fillTheme,
  fillThemeIcon,
  fillThemeCustom,
  strokeTheme,
  strokeThemeCustom,
  strokeSecondary,
  strokeSecondaryCustom,
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
        icon = null,
        isLoading = false,
        textStyle = null,
        inDialog = false;

  // ── 文字按钮（次要色） ──────────────────────────────────────────────────────
  const TalkButton.textSecondary({
    required this.label,
    this.onPressed,
    this.size = TalkButtonSize.fixed,
    super.key,
  })  : _variant = _V.textSecondary,
        icon = null,
        isLoading = false,
        textStyle = null,
        inDialog = false;

  // ── 填充按钮（主题色，纯文字） ─────────────────────────────────────────────
  const TalkButton.fillTheme({
    required this.label,
    this.onPressed,
    this.isLoading = false,
    this.size = TalkButtonSize.fixed,
    super.key,
  })  : _variant = _V.fillTheme,
        icon = null,
        textStyle = null,
        inDialog = false;

  // ── 填充按钮（主题色 + 图标） ──────────────────────────────────────────────
  const TalkButton.fillThemeIcon({
    required this.label,
    required this.icon,
    this.onPressed,
    this.isLoading = false,
    this.size = TalkButtonSize.fixed,
    super.key,
  })  : _variant = _V.fillThemeIcon,
        textStyle = null,
        inDialog = false;

  // ── 填充按钮（主题色，自定义字体样式） ────────────────────────────────────
  const TalkButton.fillThemeCustom({
    required this.label,
    this.onPressed,
    this.isLoading = false,
    this.textStyle,
    this.size = TalkButtonSize.fixed,
    super.key,
  })  : _variant = _V.fillThemeCustom,
        icon = null,
        inDialog = false;

  // ── 主题色描边按钮（文字 + 描边均为 Color_main） ──────────────────────────
  const TalkButton.strokeTheme({
    required this.label,
    this.onPressed,
    this.isLoading = false,
    this.size = TalkButtonSize.fixed,
    super.key,
  })  : _variant = _V.strokeTheme,
        icon = null,
        textStyle = null,
        inDialog = false;

  // ── 主题色描边按钮（自定义字体样式） ─────────────────────────────────────
  const TalkButton.strokeThemeCustom({
    required this.label,
    this.onPressed,
    this.isLoading = false,
    this.textStyle,
    this.size = TalkButtonSize.fixed,
    this.inDialog = false,
    super.key,
  })  : _variant = _V.strokeThemeCustom,
        icon = null;

  // ── 描边按钮（纯文字） ─────────────────────────────────────────────────────
  const TalkButton.strokeSecondary({
    required this.label,
    this.onPressed,
    this.isLoading = false,
    this.size = TalkButtonSize.fixed,
    super.key,
  })  : _variant = _V.strokeSecondary,
        icon = null,
        textStyle = null,
        inDialog = false;

  // ── 次要描边按钮（自定义字体样式） ───────────────────────────────────────
  const TalkButton.strokeSecondaryCustom({
    required this.label,
    this.onPressed,
    this.isLoading = false,
    this.textStyle,
    this.size = TalkButtonSize.fixed,
    this.inDialog = false,
    super.key,
  })  : _variant = _V.strokeSecondaryCustom,
        icon = null;

  // ── 描边按钮（文字 + 图标） ────────────────────────────────────────────────
  const TalkButton.strokeSecondaryIcon({
    required this.label,
    required this.icon,
    this.onPressed,
    this.isLoading = false,
    this.size = TalkButtonSize.fixed,
    super.key,
  })  : _variant = _V.strokeSecondaryIcon,
        textStyle = null,
        inDialog = false;

  // ── 纯图标按钮（36×36） ────────────────────────────────────────────────────
  const TalkButton.themeIcon({
    required this.icon,
    this.onPressed,
    super.key,
  })  : _variant = _V.themeIcon,
        label = null,
        size = TalkButtonSize.fixed,
        isLoading = false,
        textStyle = null,
        inDialog = false;

  // ── 次要文字按钮（含悬停/按下背景） ──────────────────────────────────────
  const TalkButton.textSecondaryRipple({
    required this.label,
    this.onPressed,
    this.size = TalkButtonSize.fixed,
    super.key,
  })  : _variant = _V.textSecondaryRipple,
        icon = null,
        isLoading = false,
        textStyle = null,
        inDialog = false;

  // ── 块状按钮（图标居上、文字居下的垂直布局，常用于工具栏/面板） ────────────
  const TalkButton.block({
    required this.label,
    required this.icon,
    this.onPressed,
    this.size = TalkButtonSize.adaptive,
    super.key,
  })  : _variant = _V.block,
        isLoading = false,
        textStyle = null,
        inDialog = false;

  final _V _variant;
  final String? label;
  final Widget? icon;
  final VoidCallback? onPressed;

  /// 是否显示加载中状态（仅适用于 fillTheme / fillThemeIcon / strokeSecondary /
  /// strokeSecondaryIcon / fillThemeCustom / strokeThemeCustom / strokeSecondaryCustom）。
  ///
  /// 为 `true` 时按钮呈现 disabled 外观并将文字/图标替换为圆形进度指示器。
  final bool isLoading;

  /// 自定义字体样式（含颜色），仅用于 *Custom 三种变体。
  ///
  /// 当 [textStyle.color] 非空时，该颜色用作正常态前景色；悬停/按下/禁用状态
  /// 仍沿用各变体的标准 overlay / 禁用颜色规则。
  final TextStyle? textStyle;

  /// 尺寸模式，默认 [TalkButtonSize.fixed]（216 × 52）。
  final TalkButtonSize size;

  /// 是否用于对话框内（仅 strokeThemeCustom / strokeSecondaryCustom）。
  ///
  /// `true` 时边框粗细为 1，否则为 2。
  final bool inDialog;

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

  // custom 变体：fixed 107×36，adaptive 最小 72×30 / 最大 400×52，fill 撑满×30，内边距 16/8
  static const _customFixedSize =
      WidgetStatePropertyAll<Size>(Size(107, 36));
  static const _customAdaptiveMin =
      WidgetStatePropertyAll<Size>(Size(72, 30));
  static const _customAdaptiveMax =
      WidgetStatePropertyAll<Size>(Size(400, 52));
  static const _customFillMin =
      WidgetStatePropertyAll<Size>(Size(double.infinity, 30));
  static const _customPadding = WidgetStatePropertyAll<EdgeInsetsGeometry>(
    EdgeInsets.symmetric(horizontal: 16, vertical: 8),
  );

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

  // custom 变体专属 size 计算属性
  WidgetStateProperty<Size>? get _customFixedSizeProp =>
      size == TalkButtonSize.fixed ? _customFixedSize : null;

  WidgetStateProperty<Size>? get _customMinimumSizeProp => switch (size) {
        TalkButtonSize.adaptive => _customAdaptiveMin,
        TalkButtonSize.fill => _customFillMin,
        _ => null,
      };

  WidgetStateProperty<Size>? get _customMaximumSizeProp =>
      size == TalkButtonSize.adaptive ? _customAdaptiveMax : null;

  // custom 变体 loading 指示器尺寸：根据实际按钮高度决定
  // 30–36 → 12，37–46 → 16，47+ → 20
  static double _loadingSizeForHeight(double h) {
    if (h >= 47) return 20;
    if (h >= 37) return 16;
    return 12;
  }

  // fixed 高度固定可直接计算；adaptive/fill 依赖父级约束，需由 LayoutBuilder 传入
  double _customLoadingSize(BoxConstraints constraints) {
    final h = size == TalkButtonSize.fixed
        ? _customFixedSize.value.height
        : constraints.maxHeight.isFinite
            ? constraints.maxHeight
            : _customAdaptiveMin.value.height; // 无约束时降级到最小高度
    return _loadingSizeForHeight(h);
  }

  @override
  Widget build(BuildContext context) {
    return _wrapSize(switch (_variant) {
      _V.fillTheme || _V.fillThemeIcon => _buildFillTheme(context),
      _V.fillThemeCustom => _buildFillThemeCustom(context),
      _V.strokeTheme => _buildStrokeTheme(context),
      _V.strokeThemeCustom => _buildStrokeThemeCustom(context),
      _V.strokeSecondary || _V.strokeSecondaryIcon => _buildStrokeSecondary(context),
      _V.strokeSecondaryCustom => _buildStrokeSecondaryCustom(context),
      _V.themeIcon => _buildThemeIcon(context),
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
        backgroundColor: const WidgetStatePropertyAll(Colors.transparent),
        overlayColor: WidgetStateProperty.resolveWith(_textOverlay),
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
              : colors.theme,
      _V.textSecondary => s.contains(WidgetState.pressed)
          ? const Color(0xFF777777)
          : s.contains(WidgetState.hovered)
              ? const Color(0xFF888888)
              : colors.textSecondary,
      _ => colors.textSecondary, // textSecondaryRipple 文字色不随状态变
    };
  }

  Color _textOverlay(Set<WidgetState> s) {
    if (s.contains(WidgetState.pressed)) return const Color(0x33999999);
    if (s.contains(WidgetState.hovered)) return const Color(0x1A999999);
    return Colors.transparent;
  }

  // ── 填充按钮（fillTheme / fillThemeIcon） ──────────────────────────────────
  Widget _buildFillTheme(BuildContext context) {
    final colors = context.talkColors;
    final hasIcon = _variant == _V.fillThemeIcon;
    return TextButton(
      onPressed: isLoading ? null : onPressed,
      style: ButtonStyle(
        backgroundColor: WidgetStateProperty.resolveWith((s) {
          if (s.contains(WidgetState.disabled)) return const Color(0x424F4F4F);
          return colors.theme;
        }),
        foregroundColor: WidgetStateProperty.resolveWith((s) {
          if (s.contains(WidgetState.disabled)) return const Color(0x61000000);
          return Colors.white;
        }),
        overlayColor: WidgetStateProperty.resolveWith((s) {
          if (s.contains(WidgetState.pressed)) return Colors.white24;
          if (s.contains(WidgetState.hovered)) return Colors.white12;
          return Colors.transparent;
        }),
        textStyle: const WidgetStatePropertyAll(TalkTypography.bodyMedium),
        fixedSize: _fixedSizeProp,
        minimumSize: _minimumSizeProp,
        maximumSize: _maximumSizeProp,
        padding: _stdPadding,
        shape: _stadiumShape,
        elevation: _noElevation,
      ),
      child: isLoading
          ? const TalkLoadingIndicator(size: 20, color: Color(0xFFFFFFFF))
          : hasIcon
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

  // ── fillThemeCustom：填充主色，自定义字体样式 ──────────────────────────────
  Widget _buildFillThemeCustom(BuildContext context) {
    final colors = context.talkColors;
    final customColor = textStyle?.color;
    final style = ButtonStyle(
      backgroundColor: WidgetStateProperty.resolveWith((s) {
        if (s.contains(WidgetState.disabled)) return const Color(0x424F4F4F);
        return colors.theme;
      }),
      foregroundColor: WidgetStateProperty.resolveWith((s) {
        if (s.contains(WidgetState.disabled)) return const Color(0x61000000);
        return customColor ?? Colors.white;
      }),
      overlayColor: WidgetStateProperty.resolveWith((s) {
        if (s.contains(WidgetState.pressed)) return Colors.white24;
        if (s.contains(WidgetState.hovered)) return Colors.white12;
        return Colors.transparent;
      }),
      textStyle: WidgetStatePropertyAll(textStyle ?? TalkTypography.bodyMedium),
      fixedSize: _customFixedSizeProp,
      minimumSize: _customMinimumSizeProp,
      maximumSize: _customMaximumSizeProp,
      padding: _customPadding,
      shape: _stadiumShape,
      elevation: _noElevation,
    );
    return LayoutBuilder(
      builder: (_, constraints) => TextButton(
        onPressed: isLoading ? null : onPressed,
        style: style,
        child: isLoading
            ? TalkLoadingIndicator(size: _customLoadingSize(constraints), color: const Color(0xFFFFFFFF))
            : Text(label!),
      ),
    );
  }

  // ── strokeTheme：主题色描边（文字 + 描边均为 Color_main） ────────────────────
  Widget _buildStrokeTheme(BuildContext context) {
    final colors = context.talkColors;
    return TextButton(
      onPressed: isLoading ? null : onPressed,
      style: ButtonStyle(
        backgroundColor: const WidgetStatePropertyAll(Colors.transparent),
        foregroundColor: WidgetStateProperty.resolveWith((s) {
          if (s.contains(WidgetState.disabled)) return const Color(0x61000000);
          return colors.theme;
        }),
        overlayColor: WidgetStateProperty.resolveWith((s) {
          if (s.contains(WidgetState.pressed)) return colors.theme.withValues(alpha: 0.20);
          if (s.contains(WidgetState.hovered)) return colors.theme.withValues(alpha: 0.12);
          return Colors.transparent;
        }),
        side: WidgetStateProperty.resolveWith((s) {
          if (s.contains(WidgetState.disabled)) {
            return const BorderSide(color: Color(0x1F000000), width: 2);
          }
          return BorderSide(color: colors.theme, width: 2);
        }),
        textStyle: const WidgetStatePropertyAll(TalkTypography.bodyMedium),
        fixedSize: _fixedSizeProp,
        minimumSize: _minimumSizeProp,
        maximumSize: _maximumSizeProp,
        padding: _stdPadding,
        shape: _stadiumShape,
        elevation: _noElevation,
      ),
      child: isLoading
          ? const TalkLoadingIndicator(size: 20, color: Color(0x61000000))
          : Text(label!),
    );
  }

  // ── strokeThemeCustom：主题色描边，自定义字体样式 ──────────────────────────
  Widget _buildStrokeThemeCustom(BuildContext context) {
    final colors = context.talkColors;
    final customColor = textStyle?.color;
    final borderWidth = inDialog ? 1.0 : 2.0;
    final style = ButtonStyle(
      backgroundColor: const WidgetStatePropertyAll(Colors.transparent),
      foregroundColor: WidgetStateProperty.resolveWith((s) {
        if (s.contains(WidgetState.disabled)) return const Color(0x61000000);
        return customColor ?? colors.theme;
      }),
      overlayColor: WidgetStateProperty.resolveWith((s) {
        if (s.contains(WidgetState.pressed)) return colors.theme.withValues(alpha: 0.20);
        if (s.contains(WidgetState.hovered)) return colors.theme.withValues(alpha: 0.12);
        return Colors.transparent;
      }),
      side: WidgetStateProperty.resolveWith((s) {
        if (s.contains(WidgetState.disabled)) {
          return BorderSide(color: const Color(0x1F000000), width: borderWidth);
        }
        return BorderSide(color: colors.theme, width: borderWidth);
      }),
      textStyle: WidgetStatePropertyAll(textStyle ?? TalkTypography.bodyMedium),
      fixedSize: _customFixedSizeProp,
      minimumSize: _customMinimumSizeProp,
      maximumSize: _customMaximumSizeProp,
      padding: _customPadding,
      shape: _stadiumShape,
      elevation: _noElevation,
    );
    return LayoutBuilder(
      builder: (_, constraints) => TextButton(
        onPressed: isLoading ? null : onPressed,
        style: style,
        child: isLoading
            ? TalkLoadingIndicator(size: _customLoadingSize(constraints), color: customColor ?? colors.theme)
            : Text(label!),
      ),
    );
  }

  // ── 描边按钮（strokeSecondary / strokeSecondaryIcon） ──────────────────────
  Widget _buildStrokeSecondary(BuildContext context) {
    final colors = context.talkColors;
    final hasIcon = _variant == _V.strokeSecondaryIcon;
    return TextButton(
      onPressed: isLoading ? null : onPressed,
      style: ButtonStyle(
        backgroundColor: const WidgetStatePropertyAll(Colors.transparent),
        foregroundColor: WidgetStateProperty.resolveWith((s) {
          if (s.contains(WidgetState.disabled)) return const Color(0x61000000);
          return colors.textPrimary;
        }),
        overlayColor: WidgetStateProperty.resolveWith((s) {
          if (s.contains(WidgetState.pressed)) return colors.textSecondary.withValues(alpha: 0.25);
          if (s.contains(WidgetState.hovered)) return colors.textSecondary.withValues(alpha: 0.12);
          return Colors.transparent;
        }),
        side: WidgetStateProperty.resolveWith((s) {
          if (s.contains(WidgetState.disabled)) {
            return const BorderSide(color: Color(0x1F000000), width: 2);
          }
          return BorderSide(color: colors.textSecondary, width: 2);
        }),
        textStyle: const WidgetStatePropertyAll(TalkTypography.bodyMedium),
        fixedSize: _fixedSizeProp,
        minimumSize: _minimumSizeProp,
        maximumSize: _maximumSizeProp,
        padding: _stdPadding,
        shape: _stadiumShape,
        elevation: _noElevation,
      ),
      child: isLoading
          ? const TalkLoadingIndicator(size: 20, color: Color(0x61000000))
          : hasIcon
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

  // ── strokeSecondaryCustom：次要色描边，自定义字体样式 ──────────────────────
  Widget _buildStrokeSecondaryCustom(BuildContext context) {
    final colors = context.talkColors;
    final customColor = textStyle?.color;
    final borderWidth = inDialog ? 1.0 : 2.0;
    final style = ButtonStyle(
      backgroundColor: const WidgetStatePropertyAll(Colors.transparent),
      foregroundColor: WidgetStateProperty.resolveWith((s) {
        if (s.contains(WidgetState.disabled)) return const Color(0x61000000);
        return customColor ?? colors.textPrimary;
      }),
      overlayColor: WidgetStateProperty.resolveWith((s) {
        if (s.contains(WidgetState.pressed)) return colors.textSecondary.withValues(alpha: 0.25);
        if (s.contains(WidgetState.hovered)) return colors.textSecondary.withValues(alpha: 0.12);
        return Colors.transparent;
      }),
      side: WidgetStateProperty.resolveWith((s) {
        if (s.contains(WidgetState.disabled)) {
          return BorderSide(color: const Color(0x1F000000), width: borderWidth);
        }
        return BorderSide(color: colors.textSecondary, width: borderWidth);
      }),
      textStyle: WidgetStatePropertyAll(textStyle ?? TalkTypography.bodyMedium),
      fixedSize: _customFixedSizeProp,
      minimumSize: _customMinimumSizeProp,
      maximumSize: _customMaximumSizeProp,
      padding: _customPadding,
      shape: _stadiumShape,
      elevation: _noElevation,
    );
    return LayoutBuilder(
      builder: (_, constraints) => TextButton(
        onPressed: isLoading ? null : onPressed,
        style: style,
        child: isLoading
            ? TalkLoadingIndicator(size: _customLoadingSize(constraints), color: const Color(0x61000000))
            : Text(label!),
      ),
    );
  }

  // ── 纯图标按钮（themeIcon，36×36） ────────────────────────────────────────
  Widget _buildThemeIcon(BuildContext context) {
    final colors = context.talkColors;
    return TextButton(
        onPressed: onPressed,
        style: ButtonStyle(
          backgroundColor: const WidgetStatePropertyAll(Colors.transparent),
          foregroundColor: WidgetStatePropertyAll(colors.theme),
          overlayColor: WidgetStateProperty.resolveWith((s) {
            if (s.contains(WidgetState.pressed)) return const Color(0x33999999);
            if (s.contains(WidgetState.hovered)) return const Color(0x1A999999);
            return Colors.transparent;
          }),
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
          backgroundColor: const WidgetStatePropertyAll(Colors.transparent),
          foregroundColor: WidgetStatePropertyAll(colors.theme),
          overlayColor: WidgetStateProperty.resolveWith((s) {
            if (s.contains(WidgetState.pressed)) return const Color(0x33999999);
            if (s.contains(WidgetState.hovered)) return const Color(0x1A999999);
            return Colors.transparent;
          }),
          textStyle: const WidgetStatePropertyAll(TalkTypography.bodySmall),
          padding: const WidgetStatePropertyAll(
            EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          ),
          minimumSize: size == TalkButtonSize.fill
              ? const WidgetStatePropertyAll(Size(double.infinity, 0))
              : null,
          shape: const WidgetStatePropertyAll(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(20)),
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
            const SizedBox(height: 12),
            Text(label!),
          ],
        ),
      );
  }
}

// ── 下拉选择按钮 ──────────────────────────────────────────────────────────────

/// 可选项数据。
class TalkDropdownItem<T> {
  const TalkDropdownItem({required this.value, required this.label});
  final T value;
  final String label;
}

/// Figma "下拉选择按钮"。
///
/// 按钮宽度自适应内容，最小 130，最大 200。弹出菜单宽度与按钮保持一致。
/// 点击后弹出选项列表，选中项右侧显示主题色勾选图标。
///
/// ```dart
/// TalkDropdownButton<String>(
///   value: _gender,
///   items: const [
///     TalkDropdownItem(value: 'Male',   label: 'Male'),
///     TalkDropdownItem(value: 'Female', label: 'Female'),
///   ],
///   onChanged: (v) => setState(() => _gender = v),
/// )
/// ```
class TalkDropdownButton<T> extends StatefulWidget {
  const TalkDropdownButton({
    required this.value,
    required this.items,
    required this.onChanged,
    super.key,
  });

  final T value;
  final List<TalkDropdownItem<T>> items;
  final ValueChanged<T> onChanged;

  @override
  State<TalkDropdownButton<T>> createState() => _TalkDropdownButtonState<T>();
}

class _TalkDropdownButtonState<T> extends State<TalkDropdownButton<T>> {
  static const _buttonBg = Color(0x1449454F);
  static const _minWidth = 130.0;
  static const _maxWidth = 200.0;
  // left padding(12) + min gap(12) + arrow icon(14) + right padding(8)
  static const _fixedExtras = 12.0 + 12.0 + 14.0 + 8.0;

  bool _isOpen = false;

  String get _selectedLabel =>
      widget.items.firstWhere((i) => i.value == widget.value).label;

  double _computeButtonWidth() {
    final tp = TextPainter(
      text: TextSpan(text: _selectedLabel, style: TalkTypography.bodyMedium),
      textDirection: TextDirection.ltr,
      maxLines: 1,
    )..layout(maxWidth: _maxWidth - _fixedExtras);
    return (tp.width + _fixedExtras).clamp(_minWidth, _maxWidth);
  }

@override
  Widget build(BuildContext context) {
    final themeColor = context.talkColors.theme;
    final buttonWidth = _computeButtonWidth();

    return MenuAnchor(
      onOpen: () => setState(() => _isOpen = true),
      onClose: () => setState(() => _isOpen = false),
      alignmentOffset: TalkSpacing.menuAnchorOffset,
      menuChildren: [
        for (final item in widget.items)
          _DropdownMenuItem(
            label: item.label,
            isSelected: item.value == widget.value,
            themeColor: themeColor,
            onPressed: () => widget.onChanged(item.value),
          ),
      ],
      builder: (context, controller, _) => GestureDetector(
        onTap: controller.isOpen ? controller.close : controller.open,
        child: Container(
          width: buttonWidth,
          height: 32,
          decoration: BoxDecoration(
            color: _buttonBg,
            borderRadius: BorderRadius.circular(8),
          ),
          padding: const EdgeInsets.only(left: 12, right: 8, top: 6, bottom: 6),
          child: Row(
            children: [
              Expanded(
                child: Text(
                  _selectedLabel,
                  style: TalkTypography.bodyMedium,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                ),
              ),
              const SizedBox(width: 12),
              AnimatedRotation(
                turns: _isOpen ? 0.5 : 0,
                duration: const Duration(milliseconds: 150),
                child: SvgPicture.asset(
                  TalkIcons.arrowDown,
                  width: 14,
                  height: 14,
                  colorFilter: ColorFilter.mode(
                    context.talkColors.textSecondary,
                    BlendMode.srcIn,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _DropdownMenuItem extends StatelessWidget {
  const _DropdownMenuItem({
    required this.label,
    required this.isSelected,
    required this.themeColor,
    required this.onPressed,
  });

  final String label;
  final bool isSelected;
  final Color themeColor;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return MenuItemButton(
      onPressed: onPressed,
      trailingIcon: SvgPicture.asset(
        TalkIcons.check,
        width: 14,
        height: 14,
        colorFilter: ColorFilter.mode(
          isSelected ? themeColor : Colors.transparent,
          BlendMode.srcIn,
        ),
      ),
      child: Text(label),
    );
  }
}
