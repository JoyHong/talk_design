import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../theme/talk_context_extensions.dart';
import '../tokens/talk_icons.dart';
import '../tokens/talk_shadows.dart';
import '../tokens/talk_spacing.dart';
import '../tokens/talk_typography.dart';

/// Toast 展示时间。
enum TalkToastDuration {
  /// 短暂停留 1.5 秒
  short,

  /// 默认停留 2.5 秒
  normal,

  /// 较长停留 4 秒
  long,
}

/// Toast 提示组件。
///
/// 可作为独立 widget 嵌入布局，也可通过 [TalkToast.show] 在屏幕底部弹出
/// 并在指定时间后自动消失。
///
/// ```dart
/// // 弹出式用法（推荐）
/// TalkToast.show(context, '操作成功');
/// TalkToast.show(context, '已复制链接', icon: Icon(Icons.link, size: 20));
///
/// // 成功 / 失败快捷方式
/// TalkToast.showSuccess(context, '保存成功');
/// TalkToast.showError(context, '操作失败，请重试');
///
/// // 内嵌用法
/// TalkToast(message: '操作成功')
/// TalkToast(message: '已复制链接', icon: Icon(Icons.link, size: 20))
/// ```
class TalkToast extends StatelessWidget {
  const TalkToast({
    required this.message,
    this.icon,
    super.key,
  });

  /// 显示的文本内容。
  final String message;

  /// 可选前置图标，内部固定渲染为 20×20。
  final Widget? icon;

  /// 在屏幕顶部居中弹出一个自动消失的 toast。
  ///
  /// [duration] 控制显示时长，[topOffset] 控制距顶部的距离（默认 30px）。
  static void show(
    BuildContext context,
    String message, {
    Widget? icon,
    TalkToastDuration duration = TalkToastDuration.normal,
    double topOffset = 30,
  }) {
    final overlay = Overlay.of(context);
    late OverlayEntry entry;
    entry = OverlayEntry(
      builder: (_) => _TalkToastOverlay(
        message: message,
        icon: icon,
        duration: duration,
        topOffset: topOffset,
        onDismissed: entry.remove,
      ),
    );
    overlay.insert(entry);
  }

  /// 弹出「成功」toast，使用 [TalkIcons.correct] 图标。
  static void showSuccess(
    BuildContext context,
    String message, {
    TalkToastDuration duration = TalkToastDuration.normal,
    double topOffset = 30,
  }) {
    show(
      context,
      message,
      icon: SvgPicture.asset(TalkIcons.correct),
      duration: duration,
      topOffset: topOffset,
    );
  }

  /// 弹出「失败」toast，使用 [TalkIcons.error] 图标。
  static void showError(
    BuildContext context,
    String message, {
    TalkToastDuration duration = TalkToastDuration.normal,
    double topOffset = 30,
  }) {
    show(
      context,
      message,
      icon: SvgPicture.asset(TalkIcons.error),
      duration: duration,
      topOffset: topOffset,
    );
  }

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: context.talkColors.cardPrimary,
        borderRadius: BorderRadius.circular(20),
        boxShadow: TalkShadows.toast,
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: TalkSpacing.l,
          vertical: 10,
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (icon != null) ...[
              SizedBox(width: 20, height: 20, child: icon),
              const SizedBox(width: TalkSpacing.s),
            ],
            Text(
              message,
              style: TalkTypography.bodyMedium.copyWith(
                color: context.talkColors.textPrimary,
                decoration: TextDecoration.none,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _TalkToastOverlay extends StatefulWidget {
  const _TalkToastOverlay({
    required this.message,
    required this.duration,
    required this.topOffset,
    required this.onDismissed,
    this.icon,
  });

  final String message;
  final Widget? icon;
  final TalkToastDuration duration;
  final double topOffset;
  final VoidCallback onDismissed;

  @override
  State<_TalkToastOverlay> createState() => _TalkToastOverlayState();
}

class _TalkToastOverlayState extends State<_TalkToastOverlay>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _opacity;

  static const _fadeIn = Duration(milliseconds: 200);
  static const _fadeOut = Duration(milliseconds: 300);

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: _fadeIn);
    _opacity = CurvedAnimation(parent: _controller, curve: Curves.easeOut);

    _controller.forward();

    final stay = switch (widget.duration) {
      TalkToastDuration.short => const Duration(milliseconds: 1500),
      TalkToastDuration.normal => const Duration(milliseconds: 2500),
      TalkToastDuration.long => const Duration(milliseconds: 4000),
    };

    Future.delayed(stay, () async {
      if (!mounted) return;
      _controller.duration = _fadeOut;
      await _controller.reverse();
      if (mounted) widget.onDismissed();
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: widget.topOffset,
      left: 0,
      right: 0,
      child: FadeTransition(
        opacity: _opacity,
        child: Center(
          child: TalkToast(
            message: widget.message,
            icon: widget.icon,
          ),
        ),
      ),
    );
  }
}
