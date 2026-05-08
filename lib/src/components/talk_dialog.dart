import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../theme/talk_context_extensions.dart';
import '../tokens/talk_icons.dart';
import '../tokens/talk_shadows.dart';
import '../tokens/talk_spacing.dart';
import '../tokens/talk_typography.dart';
import 'talk_button.dart';

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
Future<T?> showTalkDialog<T>({
  required BuildContext context,
  required String title,
  String? message,
  VoidCallback? onClose,
  required String cancelLabel,
  VoidCallback? onCancel,
  required String confirmLabel,
  VoidCallback? onConfirm,
  List<String>? confirmDropdownItems,
  ValueChanged<String>? onConfirmDropdownSelected,
  bool barrierDismissible = true,
}) {
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
        confirmDropdownItems: confirmDropdownItems,
        onConfirmDropdownSelected: onConfirmDropdownSelected,
      ),
    ),
  );
}

// ── 弹框内容 ────────────────────────────────────────────────────────────────────

class _TalkDialogContent extends StatelessWidget {
  const _TalkDialogContent({
    required this.title,
    this.message,
    this.onClose,
    required this.cancelLabel,
    this.onCancel,
    required this.confirmLabel,
    this.onConfirm,
    this.confirmDropdownItems,
    this.onConfirmDropdownSelected,
  });

  final String title;
  final String? message;
  final VoidCallback? onClose;
  final String cancelLabel;
  final VoidCallback? onCancel;
  final String confirmLabel;
  final VoidCallback? onConfirm;
  final List<String>? confirmDropdownItems;
  final ValueChanged<String>? onConfirmDropdownSelected;

  static const double _width = 420.0;
  static const double _radius = 20.0;
  static const double _titleToButtonGap = 40.0;

  @override
  Widget build(BuildContext context) {
    final colors = context.talkColors;
    return Container(
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
          _TitleRow(title: title, message: message, onClose: onClose),
          const SizedBox(height: _titleToButtonGap),
          _ButtonRow(
            cancelLabel: cancelLabel,
            onCancel: onCancel,
            confirmLabel: confirmLabel,
            onConfirm: onConfirm,
            confirmDropdownItems: confirmDropdownItems,
            onConfirmDropdownSelected: onConfirmDropdownSelected,
          ),
        ],
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
  });

  final String title;
  final String? message;
  final VoidCallback? onClose;

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
          GestureDetector(
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
    this.confirmDropdownItems,
    this.onConfirmDropdownSelected,
  });

  final String cancelLabel;
  final VoidCallback? onCancel;
  final String confirmLabel;
  final VoidCallback? onConfirm;
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
            dropdownItems: confirmDropdownItems!,
            onDropdownSelected: onConfirmDropdownSelected,
          )
        else
          TalkButton.fillThemeCustom(label: confirmLabel, onPressed: onConfirm),
      ],
    );
  }
}

// ── 分裂确认按钮（文字 | 竖线分隔 | 下拉箭头） ──────────────────────────────────

class _DialogSplitButton extends StatefulWidget {
  const _DialogSplitButton({
    required this.label,
    this.onPressed,
    required this.dropdownItems,
    this.onDropdownSelected,
  });

  final String label;
  final VoidCallback? onPressed;
  final List<String> dropdownItems;
  final ValueChanged<String>? onDropdownSelected;

  @override
  State<_DialogSplitButton> createState() => _DialogSplitButtonState();
}

class _DialogSplitButtonState extends State<_DialogSplitButton> {
  bool _isOpen = false;

  @override
  Widget build(BuildContext context) {
    final themeColor = context.talkColors.theme;

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
      builder: (context, controller, _) => Container(
        height: 36,
        decoration: BoxDecoration(
          color: themeColor,
          borderRadius: BorderRadius.circular(30),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            // 左侧：主操作区
            GestureDetector(
              onTap: widget.onPressed,
              child: Container(
                constraints: const BoxConstraints(minWidth: 75),
                padding: const EdgeInsets.only(left: 16, right: 8),
                height: 36,
                alignment: Alignment.center,
                child: Text(
                  widget.label,
                  style:
                      TalkTypography.bodyMedium.copyWith(color: Colors.white),
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
    );
  }
}
