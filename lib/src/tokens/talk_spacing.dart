import 'dart:ui';

abstract final class TalkSpacing {
  static const double xs = 4.0;
  static const double s = 8.0;
  static const double m = 12.0;
  static const double l = 16.0;
  static const double xl = 24.0;
  static const double xxl = 32.0;

  static const double radiusS = 4.0;
  static const double radiusM = 8.0;
  static const double radiusL = 12.0;
  static const double radiusFull = 9999.0;

  /// 菜单与触发元素之间的垂直间距，用于 [MenuAnchor.alignmentOffset]。
  static const Offset menuAnchorOffset = Offset(0, s);
}
