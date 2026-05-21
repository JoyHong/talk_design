import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../theme/talk_context_extensions.dart';

/// Figma 规范的 Checkbox 控件，三种视觉状态与设计稿完全对应：
/// - normal（未勾选）、checked（已勾选）、disable（禁用）
///
/// 使用方式与 Flutter 内置 [Checkbox] 一致：
/// ```dart
/// TalkCheckbox(value: _checked, onChanged: (v) => setState(() => _checked = v))
/// ```
/// 禁用时将 [onChanged] 设为 null。
class TalkCheckbox extends StatelessWidget {
  const TalkCheckbox({
    super.key,
    required this.value,
    required this.onChanged,
  });

  final bool value;
  final ValueChanged<bool>? onChanged;

  bool get _disabled => onChanged == null;

  @override
  Widget build(BuildContext context) {
    final icons = context.talkIcons;
    final iconAsset = _disabled
        ? icons.correctFillingSmallDisable
        : value ? icons.correctFillingSmall : icons.circle;
    final icon = SvgPicture.asset(iconAsset, width: 16, height: 16);
    if (_disabled) return icon;
    return GestureDetector(
      onTap: () => onChanged!(!value),
      child: icon,
    );
  }
}
