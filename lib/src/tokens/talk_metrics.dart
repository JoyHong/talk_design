import 'dart:ui';

abstract final class TalkMetrics {
  /// 菜单与触发元素之间的垂直间距，用于 [MenuAnchor.alignmentOffset]。
  static const Offset menuAnchorOffset = Offset(0, 8);

  // ── 布局规则 ─────────────────────────────────────────────────────────────────

  /// 内容与分栏/弹窗边框之间的最小内边距。
  ///
  /// 凡是内容放置于侧边栏、底部弹层或模态弹框内时，均应以此值作为水平（以及
  /// 适当情况下的垂直）内边距的最小值。
  static const double contentPaddingMin = 24.0;

  /// 卡片、列表等内容区的最大显示宽度。
  ///
  /// 728px 已包含左右各 [contentPaddingMin]（24px）的内边距，因此实际可用内容
  /// 宽度为 680px。导航栏内容与 IM 会话视图不受此约束。
  static const double contentMaxWidth = 728.0;
}
