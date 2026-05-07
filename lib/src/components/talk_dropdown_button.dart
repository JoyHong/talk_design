import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:talk_design/src/theme/talk_context_extensions.dart';
import 'package:talk_design/src/tokens/talk_typography.dart';

import '../tokens/talk_icons.dart';

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
  static const _buttonBg = Color(0x1449454F);  // rgba(73,69,79,0.08)
  static const _textColor = Color(0xFF49454F); // M3 on-surface-variant
  static const _minWidth = 130.0;
  static const _maxWidth = 200.0;
  // left padding(12) + min gap(12) + icon(14) + right padding(8)
  static const _fixedExtras = 12.0 + 12.0 + 14.0 + 8.0;

  bool _isOpen = false;

  String get _selectedLabel =>
      widget.items.firstWhere((i) => i.value == widget.value).label;

  /// 根据当前选中文字自然宽度同步计算按钮宽度，clamp 到 [_minWidth, _maxWidth]。
  double _computeWidth() {
    final tp = TextPainter(
      text: TextSpan(text: _selectedLabel, style: TalkTypography.bodyMedium),
      textDirection: TextDirection.ltr,
      maxLines: 1,
    )..layout(maxWidth: _maxWidth - _fixedExtras);
    return (tp.width + _fixedExtras).clamp(_minWidth, _maxWidth);
  }

  @override
  Widget build(BuildContext context) {
    final themeColor = Theme.of(context).colorScheme.primary;
    final width = _computeWidth();

    return MenuAnchor(
      onOpen: () => setState(() => _isOpen = true),
      onClose: () => setState(() => _isOpen = false),
      style: MenuStyle(
        minimumSize: WidgetStatePropertyAll(Size(width, 0)),
        maximumSize: WidgetStatePropertyAll(Size(width, double.infinity)),
      ),
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
          width: width,
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
                  style: TalkTypography.bodyMedium.copyWith(color: _textColor),
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
      trailingIcon: isSelected ? Icon(Icons.check, size: 14, color: themeColor) : null,
      style: const ButtonStyle(
        padding: WidgetStatePropertyAll(
          EdgeInsets.symmetric(horizontal: 12, vertical: 14),
        ),
        minimumSize: WidgetStatePropertyAll(Size(0, 0)),
      ),
      child: Text(label),
    );
  }
}
