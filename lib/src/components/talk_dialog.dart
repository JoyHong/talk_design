import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../theme/talk_context_extensions.dart';
import '../tokens/talk_icons.dart';
import '../tokens/talk_shadows.dart';
import '../tokens/talk_spacing.dart';
import '../tokens/talk_typography.dart';
import 'talk_button.dart';
import 'talk_loading_indicator.dart';

/// 显示 JusTalk 风格弹框，覆盖 3 种变体：
///
/// **变体 1 — 单行文本**
/// ```dart
/// showTalkDialog(
///   context: context,
///   title: '确认删除这条消息吗？',
///   onClose: () => Navigator.pop(context),
///   cancelLabel: '取消',
///   onCancel: () => Navigator.pop(context),
///   confirmLabel: '删除',
///   onConfirm: () {},
/// );
/// ```
///
/// **变体 2 — 多行文本**（传入 [message] 即为多行变体）
/// ```dart
/// showTalkDialog(
///   context: context,
///   title: '退出当前通话',
///   message: '退出后将无法再加入，请确认是否退出。',
///   ...
/// );
/// ```
///
/// **变体 3 — 确认按钮可下拉**（传入 [confirmDropdownItems] 即为分裂按钮变体）
/// ```dart
/// showTalkDialog(
///   context: context,
///   title: '结束本次通话',
///   confirmLabel: '结束通话',
///   confirmDropdownItems: const ['所有人离开', '仅自己离开'],
///   onConfirmDropdownSelected: (value) {},
///   ...
/// );
/// ```
///
/// **带 loading 的确认按钮**（传入 [onConfirmAsync] 即启用 loading 模式）
///
/// 点击确认后按钮进入 loading 状态，弹框禁止被关闭，直到业务逻辑结束：
/// - Future 正常完成 → 弹框自动关闭
/// - Future 抛出异常 → 确认按钮恢复正常状态，弹框保持打开
///
/// loading 期间关闭按钮和取消按钮均不可用。
///
/// ```dart
/// showTalkDialog(
///   context: context,
///   title: '确认提交吗？',
///   cancelLabel: '取消',
///   confirmLabel: '提交',
///   onConfirmAsync: () async {
///     await submitData(); // 成功 → 弹框关闭；抛出异常 → 按钮恢复
///   },
/// );
/// ```
Future<T?> showTalkDialog<T>({
  required BuildContext context,
  required String title,
  String? message,
  VoidCallback? onClose,
  required String cancelLabel,
  VoidCallback? onCancel,
  required String confirmLabel,
  VoidCallback? onConfirm,
  Future<void> Function()? onConfirmAsync,
  List<String>? confirmDropdownItems,
  ValueChanged<String>? onConfirmDropdownSelected,
  Future<void> Function(String)? onConfirmDropdownAsync,
  bool barrierDismissible = true,
}) {
  assert(
    onConfirm == null || onConfirmAsync == null,
    'onConfirm 和 onConfirmAsync 不能同时传入，请选择其一',
  );
  assert(
    onConfirmDropdownSelected == null || onConfirmDropdownAsync == null,
    'onConfirmDropdownSelected 和 onConfirmDropdownAsync 不能同时传入，请选择其一',
  );
  return showDialog<T>(
    context: context,
    barrierColor: Colors.black54,
    barrierDismissible: barrierDismissible,
    builder: (_) => Dialog(
      backgroundColor: Colors.transparent,
      elevation: 0,
      child: _TalkDialogContent(
        title: title,
        message: message,
        onClose: onClose,
        cancelLabel: cancelLabel,
        onCancel: onCancel,
        confirmLabel: confirmLabel,
        onConfirm: onConfirm,
        onConfirmAsync: onConfirmAsync,
        confirmDropdownItems: confirmDropdownItems,
        onConfirmDropdownSelected: onConfirmDropdownSelected,
        onConfirmDropdownAsync: onConfirmDropdownAsync,
      ),
    ),
  );
}

// ── 弹框内容 ────────────────────────────────────────────────────────────────────

class _TalkDialogContent extends StatefulWidget {
  const _TalkDialogContent({
    required this.title,
    this.message,
    this.onClose,
    required this.cancelLabel,
    this.onCancel,
    required this.confirmLabel,
    this.onConfirm,
    this.onConfirmAsync,
    this.confirmDropdownItems,
    this.onConfirmDropdownSelected,
    this.onConfirmDropdownAsync,
  });

  final String title;
  final String? message;
  final VoidCallback? onClose;
  final String cancelLabel;
  final VoidCallback? onCancel;
  final String confirmLabel;
  final VoidCallback? onConfirm;
  final Future<void> Function()? onConfirmAsync;
  final List<String>? confirmDropdownItems;
  final ValueChanged<String>? onConfirmDropdownSelected;
  final Future<void> Function(String)? onConfirmDropdownAsync;

  @override
  State<_TalkDialogContent> createState() => _TalkDialogContentState();
}

class _TalkDialogContentState extends State<_TalkDialogContent> {
  bool _isConfirmLoading = false;

  static const double _width = 420.0;
  static const double _radius = 20.0;
  static const double _titleToButtonGap = 40.0;

  Future<void> _handleConfirmAsync() async {
    setState(() => _isConfirmLoading = true);
    try {
      await widget.onConfirmAsync!();
      if (mounted) Navigator.pop(context);
    } catch (_) {
      if (mounted) setState(() => _isConfirmLoading = false);
    }
  }

  Future<void> _handleDropdownAsync(String value) async {
    setState(() => _isConfirmLoading = true);
    try {
      await widget.onConfirmDropdownAsync!(value);
      if (mounted) Navigator.pop(context);
    } catch (_) {
      if (mounted) setState(() => _isConfirmLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.talkColors;
    final isAsyncMode = widget.onConfirmAsync != null;
    return PopScope(
      canPop: !_isConfirmLoading,
      child: Container(
        width: _width,
        decoration: BoxDecoration(
          color: colors.listDialogBox,
          borderRadius: BorderRadius.circular(_radius),
          boxShadow: TalkShadows.popup,
        ),
        padding: const EdgeInsets.all(TalkSpacing.xl),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _TitleRow(
              title: widget.title,
              message: widget.message,
              onClose: widget.onClose,
              closeEnabled: !(isAsyncMode && _isConfirmLoading),
            ),
            const SizedBox(height: _titleToButtonGap),
            _ButtonRow(
              cancelLabel: widget.cancelLabel,
              onCancel: (isAsyncMode && _isConfirmLoading) ? null : widget.onCancel,
              confirmLabel: widget.confirmLabel,
              onConfirm: isAsyncMode ? _handleConfirmAsync : widget.onConfirm,
              isConfirmLoading: _isConfirmLoading,
              confirmDropdownItems: widget.confirmDropdownItems,
              onConfirmDropdownSelected: widget.onConfirmDropdownAsync != null
                  ? _handleDropdownAsync
                  : widget.onConfirmDropdownSelected,
            ),
          ],
        ),
      ),
    );
  }
}


// ── 标题区 ─────────────────────────────────────────────────────────────────────

class _TitleRow extends StatelessWidget {
  const _TitleRow({
    required this.title,
    this.message,
    this.onClose,
    this.closeEnabled = true,
  });

  final String title;
  final String? message;
  final VoidCallback? onClose;

  /// 为 false 时关闭按钮保留占位（防止布局偏移）但不可见、不可交互。
  final bool closeEnabled;

  @override
  Widget build(BuildContext context) {
    final colors = context.talkColors;
    final hasMessage = message != null;

    return Row(
      crossAxisAlignment:
          hasMessage ? CrossAxisAlignment.start : CrossAxisAlignment.center,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(title, style: TalkTypography.bodyLarge),
              if (hasMessage) ...[
                const SizedBox(height: TalkSpacing.m),
                Text(message!, style: TalkTypography.bodyMedium),
              ],
            ],
          ),
        ),
        if (onClose != null) ...[
          const SizedBox(width: TalkSpacing.m),
          IgnorePointer(
            ignoring: !closeEnabled,
            child: Opacity(
              opacity: closeEnabled ? 1.0 : 0.0,
              child: GestureDetector(
                onTap: onClose,
                child: SvgPicture.asset(
                  TalkIcons.close,
                  width: 16,
                  height: 16,
                  colorFilter: ColorFilter.mode(
                    colors.textSecondary,
                    BlendMode.srcIn,
                  ),
                ),
              ),
            ),
          ),
        ],
      ],
    );
  }
}

// ── 按钮行 ─────────────────────────────────────────────────────────────────────

class _ButtonRow extends StatelessWidget {
  const _ButtonRow({
    required this.cancelLabel,
    this.onCancel,
    required this.confirmLabel,
    this.onConfirm,
    this.isConfirmLoading = false,
    this.confirmDropdownItems,
    this.onConfirmDropdownSelected,
  });

  final String cancelLabel;
  final VoidCallback? onCancel;
  final String confirmLabel;
  final VoidCallback? onConfirm;
  final bool isConfirmLoading;
  final List<String>? confirmDropdownItems;
  final ValueChanged<String>? onConfirmDropdownSelected;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        TalkButton.strokeSecondaryCustom(label: cancelLabel, onPressed: onCancel, inDialog: true),
        const SizedBox(width: TalkSpacing.m),
        if (confirmDropdownItems != null)
          _DialogSplitButton(
            label: confirmLabel,
            onPressed: onConfirm,
            isLoading: isConfirmLoading,
            dropdownItems: confirmDropdownItems!,
            onDropdownSelected: onConfirmDropdownSelected,
          )
        else
          TalkButton.fillThemeCustom(
            label: confirmLabel,
            onPressed: isConfirmLoading ? null : onConfirm,
            isLoading: isConfirmLoading,
          ),
      ],
    );
  }
}

// ── 分裂确认按钮（文字 | 竖线分隔 | 下拉箭头） ──────────────────────────────────

class _DialogSplitButton extends StatefulWidget {
  const _DialogSplitButton({
    required this.label,
    this.onPressed,
    this.isLoading = false,
    required this.dropdownItems,
    this.onDropdownSelected,
  });

  final String label;
  final VoidCallback? onPressed;
  final bool isLoading;
  final List<String> dropdownItems;
  final ValueChanged<String>? onDropdownSelected;

  @override
  State<_DialogSplitButton> createState() => _DialogSplitButtonState();
}

class _DialogSplitButtonState extends State<_DialogSplitButton> {
  bool _isOpen = false;
  bool _isLeftHovered = false;
  bool _isLeftPressed = false;

  Color get _leftOverlay {
    if (_isLeftPressed) return Colors.white24;
    if (_isLeftHovered) return Colors.white12;
    return Colors.transparent;
  }

  @override
  Widget build(BuildContext context) {
    final themeColor = context.talkColors.theme;
    final isLoading = widget.isLoading;

    return MenuAnchor(
      onOpen: () => setState(() => _isOpen = true),
      onClose: () => setState(() => _isOpen = false),
      alignmentOffset: TalkSpacing.menuAnchorOffset,
      menuChildren: [
        for (final item in widget.dropdownItems)
          MenuItemButton(
            onPressed: () => widget.onDropdownSelected?.call(item),
            child: Text(item),
          ),
      ],
      builder: (context, controller, _) => Stack(
        children: [
          Container(
            height: 36,
            decoration: BoxDecoration(
              color: isLoading ? const Color(0x424F4F4F) : themeColor,
              borderRadius: BorderRadius.circular(30),
            ),
            child: Opacity(
              opacity: isLoading ? 0.0 : 1.0,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // 左侧：主操作区
                  MouseRegion(
                    cursor: SystemMouseCursors.click,
                    onEnter: (_) => setState(() => _isLeftHovered = true),
                    onExit: (_) => setState(() => _isLeftHovered = false),
                    child: GestureDetector(
                      onTap: widget.onPressed,
                      onTapDown: (_) => setState(() => _isLeftPressed = true),
                      onTapUp: (_) => setState(() => _isLeftPressed = false),
                      onTapCancel: () => setState(() => _isLeftPressed = false),
                      child: Container(
                        constraints: const BoxConstraints(minWidth: 75),
                        padding: const EdgeInsets.only(left: 16, right: 8),
                        height: 36,
                        alignment: Alignment.center,
                        child: Text(
                          widget.label,
                          style: TalkTypography.bodyMedium.copyWith(color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                  // 竖线分隔符
                  Container(
                    width: 1,
                    height: 16,
                    color: Colors.white.withValues(alpha: 0.4),
                  ),
                  // 右侧：下拉箭头区
                  GestureDetector(
                    onTap: controller.isOpen ? controller.close : controller.open,
                    child: Container(
                      height: 36,
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      alignment: Alignment.center,
                      child: AnimatedRotation(
                        turns: _isOpen ? 0.5 : 0,
                        duration: const Duration(milliseconds: 150),
                        child: SvgPicture.asset(
                          TalkIcons.arrowDown,
                          width: 16,
                          height: 16,
                          colorFilter: const ColorFilter.mode(
                            Colors.white,
                            BlendMode.srcIn,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          // loading 时居中显示 indicator，整体尺寸由上方 Row 占位保持不变
          if (isLoading)
            const Positioned.fill(
              child: Center(
                child: TalkLoadingIndicator(size: 12, color: Colors.white),
              ),
            ),
          // 整体叠加层：仅由左侧 hover/press 触发，右侧事件穿透
          if (!isLoading && _leftOverlay != Colors.transparent)
            Positioned.fill(
              child: IgnorePointer(
                child: Container(
                  decoration: BoxDecoration(
                    color: _leftOverlay,
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
