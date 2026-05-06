import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../tokens/talk_icons.dart';

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

  String get _iconAsset {
    if (_disabled) return TalkIcons.checkboxDisabled;
    return value ? TalkIcons.checkboxChecked : TalkIcons.checkboxUnchecked;
  }

  @override
  Widget build(BuildContext context) {
    final icon = SvgPicture.asset(_iconAsset, width: 16, height: 16);
    if (_disabled) return icon;
    return GestureDetector(
      onTap: () => onChanged!(!value),
      child: icon,
    );
  }
}
