import 'package:flutter/material.dart';

import '../theme/talk_context_extensions.dart';
import '../tokens/talk_typography.dart';

/// Badge 尺寸，对应 Figma 规范两档规格。
enum TalkBadgeSize {
  /// 高度 16px，字号 11px
  small,

  /// 高度 18px，字号 12px
  large,
}

/// 徽标组件，支持三种形态：
/// - `TalkBadge.dot` — 纯红点，直径 8px
/// - `TalkBadge(count: n)` — 数字徽标，超过 maxCount 显示 `maxCount+`
///
/// 尺寸通过 [TalkBadgeSize] 控制，颜色取自 [TalkColors.redDotError]。
///
/// ```dart
/// TalkBadge.dot()
/// TalkBadge(count: 5)
/// TalkBadge(count: 100, maxCount: 99, size: TalkBadgeSize.large)
/// ```
class TalkBadge extends StatelessWidget {
  const TalkBadge.dot({super.key})
      : _dot = true,
        count = 0,
        maxCount = 99,
        size = TalkBadgeSize.small;

  const TalkBadge({
    required this.count,
    this.maxCount = 99,
    this.size = TalkBadgeSize.small,
    super.key,
  }) : _dot = false;

  final bool _dot;

  /// 显示的数字。
  final int count;

  /// 超过此值时显示 `maxCount+`，默认 99。
  final int maxCount;

  final TalkBadgeSize size;

  @override
  Widget build(BuildContext context) {
    final bg = context.talkColors.redDotError;

    if (_dot) {
      return Container(
        width: 8,
        height: 8,
        decoration: BoxDecoration(color: bg, shape: BoxShape.circle),
      );
    }

    final isSmall = size == TalkBadgeSize.small;
    final diameter = isSmall ? 16.0 : 18.0;

    final label = count > maxCount ? '$maxCount+' : '$count';
    final isSingleChar = label.length == 1;

    final baseStyle = isSmall ? TalkTypography.labelSmall : TalkTypography.labelMedium;
    final textStyle = baseStyle.copyWith(color: Colors.white);

    if (isSingleChar) {
      return Container(
        width: diameter,
        height: diameter,
        decoration: BoxDecoration(color: bg, shape: BoxShape.circle),
        alignment: Alignment.center,
        child: Text(label, style: textStyle),
      );
    }

    return DecoratedBox(
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(diameter / 2),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: 4,
          vertical: isSmall ? 0 : 1,
        ),
        child: Text(label, style: textStyle),
      ),
    );
  }
}
