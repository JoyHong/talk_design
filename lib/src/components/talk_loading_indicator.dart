import 'dart:math' as math;
import 'package:flutter/material.dart';

import '../theme/talk_context_extensions.dart';

/// 环形不确定进度指示器，支持任意尺寸和自定义颜色。
///
/// ```dart
/// TalkLoadingIndicator(size: 28)
/// TalkLoadingIndicator(size: 24, color: Colors.grey)
/// ```
class TalkLoadingIndicator extends StatelessWidget {
  const TalkLoadingIndicator({
    this.size = 16,
    this.color,
    super.key,
  });

  final double size;

  /// 覆盖默认颜色，默认使用 [TalkColors.theme]。
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return SizedBox.square(
      dimension: size,
      child: CircularProgressIndicator(
        strokeWidth: math.max(1.5, size / 10),
        valueColor: AlwaysStoppedAnimation(color ?? context.talkColors.theme),
      ),
    );
  }
}
