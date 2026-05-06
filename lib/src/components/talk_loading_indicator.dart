import 'dart:math' as math;
import 'package:flutter/material.dart';

import '../theme/talk_context_extensions.dart';

/// Loading 尺寸枚举，对应 Figma 规范。
enum TalkLoadingSize {
  /// 12 × 12
  small,

  /// 16 × 16
  medium,

  /// 28 × 28
  large,

  /// 40 × 40
  xlarge,

  /// 60 × 60
  xxlarge,
}

/// 环形不确定进度指示器，支持 5 种尺寸和自定义颜色。
///
/// ```dart
/// TalkLoadingIndicator(size: TalkLoadingSize.large)
/// TalkLoadingIndicator(size: TalkLoadingSize.medium, color: Colors.grey)
/// ```
class TalkLoadingIndicator extends StatelessWidget {
  const TalkLoadingIndicator({
    this.size = TalkLoadingSize.medium,
    this.color,
    super.key,
  });

  final TalkLoadingSize size;

  /// 覆盖默认颜色，默认使用 [TalkColors.main]。
  final Color? color;

  static const _sizeValues = {
    TalkLoadingSize.small: 12.0,
    TalkLoadingSize.medium: 16.0,
    TalkLoadingSize.large: 28.0,
    TalkLoadingSize.xlarge: 40.0,
    TalkLoadingSize.xxlarge: 60.0,
  };

  @override
  Widget build(BuildContext context) {
    final d = _sizeValues[size]!;
    return SizedBox.square(
      dimension: d,
      child: CircularProgressIndicator(
        strokeWidth: math.max(1.5, d / 10),
        valueColor: AlwaysStoppedAnimation(color ?? context.talkColors.main),
      ),
    );
  }
}
