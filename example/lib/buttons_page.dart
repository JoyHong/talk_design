import 'dart:async';

import 'package:flutter/material.dart';
import 'package:talk_design/talk_design.dart';

// 验收用：固定宽度容器，展示 default/min/max 尺寸行为
class _SizedBox extends StatelessWidget {
  const _SizedBox({required this.width, required this.child});
  final double width;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return SizedBox(width: width, child: child);
  }
}

class ButtonsPage extends StatelessWidget {
  const ButtonsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(TalkSpacing.l),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _Section(title: 'fillTheme（填充主色）', children: [
            TalkButton.fillTheme(label: 'Normal', onPressed: () {}),
            const TalkButton.fillTheme(label: 'Disabled'),
            const TalkButton.fillTheme(label: 'Progress', isLoading: true),
          ]),
          _Section(title: 'fillThemeIcon（填充主色 + 图标）', children: [
            TalkButton.fillThemeIcon(
              label: 'With Icon',
              icon: const Icon(Icons.add),
              onPressed: () {},
            ),
            const TalkButton.fillThemeIcon(
              label: 'Progress',
              icon: Icon(Icons.add),
              isLoading: true,
            ),
          ]),
          _Section(title: 'textTheme（文字主色）', children: [
            TalkButton.textTheme(label: 'Normal', onPressed: () {}),
            const TalkButton.textTheme(label: 'Disabled'),
          ]),
          _Section(title: 'textSecondary（文字次要色）', children: [
            TalkButton.textSecondary(label: 'Normal', onPressed: () {}),
            const TalkButton.textSecondary(label: 'Disabled'),
          ]),
          _Section(title: 'strokeTheme（主题色描边）', children: [
            TalkButton.strokeTheme(label: 'Normal', onPressed: () {}),
            const TalkButton.strokeTheme(label: 'Disabled'),
            const TalkButton.strokeTheme(label: 'Progress', isLoading: true),
          ]),
          _Section(title: 'strokeSecondary（描边）', children: [
            TalkButton.strokeSecondary(label: 'Normal', onPressed: () {}),
            const TalkButton.strokeSecondary(label: 'Disabled'),
            const TalkButton.strokeSecondary(label: 'Progress', isLoading: true),
          ]),
          _Section(title: 'strokeSecondaryIcon（描边 + 图标）', children: [
            TalkButton.strokeSecondaryIcon(
              label: 'With Icon',
              icon: const Icon(Icons.search),
              onPressed: () {},
            ),
            const TalkButton.strokeSecondaryIcon(
              label: 'Progress',
              icon: Icon(Icons.search),
              isLoading: true,
            ),
          ]),
          _Section(title: 'themeIcon（纯图标）', children: [
            TalkButton.themeIcon(
              icon: const Icon(Icons.favorite),
              onPressed: () {},
            ),
            const TalkButton.themeIcon(icon: Icon(Icons.favorite)),
          ]),
          _Section(title: 'textSecondaryRipple（次要文字 + 水波纹）', children: [
            TalkButton.textSecondaryRipple(label: 'Normal', onPressed: () {}),
          ]),
          _Section(title: 'block（块状按钮）', children: [
            TalkButton.block(
              label: '视频',
              icon: const Icon(Icons.videocam),
              onPressed: () {},
            ),
            TalkButton.block(
              label: '语音',
              icon: const Icon(Icons.mic),
              onPressed: () {},
            ),
          ]),
          const _LoadingSection(),
          const _CustomVariantsSection(),
          const _DropdownSection(),
        ],
      ),
    );
  }
}

// ── isLoading 交互演示 ────────────────────────────────────────────────────────

class _LoadingSection extends StatefulWidget {
  const _LoadingSection();

  @override
  State<_LoadingSection> createState() => _LoadingSectionState();
}

class _LoadingSectionState extends State<_LoadingSection> {
  bool _fillLoading = false;
  bool _fillIconLoading = false;
  bool _strokeLoading = false;
  bool _strokeIconLoading = false;

  void _trigger(bool Function() getter, void Function(bool) setter) {
    if (getter()) return;
    setter(true);
    setState(() {});
    Timer(const Duration(seconds: 2), () {
      if (mounted) setState(() => setter(false));
    });
  }

  @override
  Widget build(BuildContext context) {
    return _Section(
      title: 'isLoading 交互演示（点击触发 2 秒 loading）',
      children: [
        TalkButton.fillTheme(
          label: _fillLoading ? 'Loading…' : '提交',
          isLoading: _fillLoading,
          onPressed: () => _trigger(() => _fillLoading, (v) => _fillLoading = v),
        ),
        TalkButton.fillThemeIcon(
          label: _fillIconLoading ? 'Loading…' : '上传',
          icon: const Icon(Icons.upload),
          isLoading: _fillIconLoading,
          onPressed: () => _trigger(() => _fillIconLoading, (v) => _fillIconLoading = v),
        ),
        TalkButton.strokeSecondary(
          label: _strokeLoading ? 'Loading…' : '保存',
          isLoading: _strokeLoading,
          onPressed: () => _trigger(() => _strokeLoading, (v) => _strokeLoading = v),
        ),
        TalkButton.strokeSecondaryIcon(
          label: _strokeIconLoading ? 'Loading…' : '搜索',
          icon: const Icon(Icons.search),
          isLoading: _strokeIconLoading,
          onPressed: () => _trigger(() => _strokeIconLoading, (v) => _strokeIconLoading = v),
        ),
      ],
    );
  }
}

// ── Custom 变体验收区 ─────────────────────────────────────────────────────────

class _CustomVariantsSection extends StatefulWidget {
  const _CustomVariantsSection();

  @override
  State<_CustomVariantsSection> createState() => _CustomVariantsSectionState();
}

class _CustomVariantsSectionState extends State<_CustomVariantsSection> {
  bool _fillLoading = false;
  bool _strokeThemeLoading = false;
  bool _strokeSecLoading = false;

  void _trigger(bool Function() getter, void Function(bool) setter) {
    if (getter()) return;
    setState(() => setter(true));
    Timer(const Duration(seconds: 2), () {
      if (mounted) setState(() => setter(false));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // ── fillThemeCustom ────────────────────────────────────────────────
        _Section(title: 'fillThemeCustom — 默认样式（107×36）', children: [
          TalkButton.fillThemeCustom(label: '确认', onPressed: () {}),
          const TalkButton.fillThemeCustom(label: '禁用'),
          const TalkButton.fillThemeCustom(label: 'Loading', isLoading: true),
        ]),
        _Section(title: 'fillThemeCustom — 自定义字体样式', children: [
          TalkButton.fillThemeCustom(
            label: '粗体白字',
            onPressed: () {},
            textStyle: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          TalkButton.fillThemeCustom(
            label: '黄色文字',
            onPressed: () {},
            textStyle: const TextStyle(
              fontSize: 12,
              color: Color(0xFFFFD700),
            ),
          ),
        ]),
        _Section(title: 'fillThemeCustom — 尺寸约束（最小 72×30 / 最大 400×52）', children: [
          _SizedBox(
            width: 50,
            child: TalkButton.fillThemeCustom(label: '窄', onPressed: () {}),
          ),
          _SizedBox(
            width: 420,
            child: TalkButton.fillThemeCustom(label: '超宽（限 400）', onPressed: () {}),
          ),
        ]),
        _Section(title: 'fillThemeCustom — Loading 交互（点击触发 2 秒）', children: [
          TalkButton.fillThemeCustom(
            label: _fillLoading ? 'Loading…' : '提交',
            isLoading: _fillLoading,
            onPressed: () => _trigger(() => _fillLoading, (v) => _fillLoading = v),
          ),
        ]),

        // ── strokeThemeCustom ──────────────────────────────────────────────
        _Section(title: 'strokeThemeCustom — 默认样式（107×36）', children: [
          TalkButton.strokeThemeCustom(label: '取消', onPressed: () {}),
          const TalkButton.strokeThemeCustom(label: '禁用'),
          const TalkButton.strokeThemeCustom(label: 'Loading', isLoading: true),
        ]),
        _Section(title: 'strokeThemeCustom — 自定义字体样式', children: [
          TalkButton.strokeThemeCustom(
            label: '斜体主色',
            onPressed: () {},
            textStyle: const TextStyle(
              fontStyle: FontStyle.italic,
              fontSize: 14,
            ),
          ),
          TalkButton.strokeThemeCustom(
            label: '绿色文字',
            onPressed: () {},
            textStyle: const TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w600,
              color: Color(0xFF2E7D32),
            ),
          ),
        ]),
        _Section(title: 'strokeThemeCustom — Loading 交互（点击触发 2 秒）', children: [
          TalkButton.strokeThemeCustom(
            label: _strokeThemeLoading ? 'Loading…' : '保存',
            isLoading: _strokeThemeLoading,
            onPressed: () => _trigger(() => _strokeThemeLoading, (v) => _strokeThemeLoading = v),
          ),
        ]),

        // ── strokeSecondaryCustom ──────────────────────────────────────────
        _Section(title: 'strokeSecondaryCustom — 默认样式（107×36）', children: [
          TalkButton.strokeSecondaryCustom(label: '次要操作', onPressed: () {}),
          const TalkButton.strokeSecondaryCustom(label: '禁用'),
          const TalkButton.strokeSecondaryCustom(label: 'Loading', isLoading: true),
        ]),
        _Section(title: 'strokeSecondaryCustom — 自定义字体样式', children: [
          TalkButton.strokeSecondaryCustom(
            label: '小号蓝字',
            onPressed: () {},
            textStyle: const TextStyle(
              fontSize: 11,
              color: Color(0xFF1565C0),
            ),
          ),
          TalkButton.strokeSecondaryCustom(
            label: '大号加粗',
            onPressed: () {},
            textStyle: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w700,
            ),
          ),
        ]),
        _Section(title: 'strokeSecondaryCustom — 尺寸约束（最小 72×30 / 最大 400×52）', children: [
          _SizedBox(
            width: 50,
            child: TalkButton.strokeSecondaryCustom(label: '窄', onPressed: () {}),
          ),
          _SizedBox(
            width: 420,
            child: TalkButton.strokeSecondaryCustom(label: '超宽（限 400）', onPressed: () {}),
          ),
        ]),
        _Section(title: 'strokeSecondaryCustom — Loading 交互（点击触发 2 秒）', children: [
          TalkButton.strokeSecondaryCustom(
            label: _strokeSecLoading ? 'Loading…' : '搜索',
            isLoading: _strokeSecLoading,
            onPressed: () => _trigger(() => _strokeSecLoading, (v) => _strokeSecLoading = v),
          ),
        ]),
      ],
    );
  }
}

// ── 下拉选择按钮示例 ─────────────────────────────────────────────────────────

class _DropdownSection extends StatefulWidget {
  const _DropdownSection();

  @override
  State<_DropdownSection> createState() => _DropdownSectionState();
}

class _DropdownSectionState extends State<_DropdownSection> {
  String _gender = 'Male';
  String _country = 'China';

  static const _genderItems = [
    TalkDropdownItem(value: 'Male', label: 'Male'),
    TalkDropdownItem(value: 'Female', label: 'Female'),
  ];

  static const _countryItems = [
    TalkDropdownItem(value: 'China', label: 'China'),
    TalkDropdownItem(value: 'United States of America', label: 'United States of America'),
    TalkDropdownItem(value: 'Japan', label: 'Japan'),
  ];

  @override
  Widget build(BuildContext context) {
    return _Section(
      title: 'dropdown（下拉选择）',
      children: [
        TalkDropdownButton<String>(
          value: _gender,
          items: _genderItems,
          onChanged: (v) => setState(() => _gender = v),
        ),
        TalkDropdownButton<String>(
          value: _country,
          items: _countryItems,
          onChanged: (v) => setState(() => _country = v),
        ),
      ],
    );
  }
}

class _Section extends StatelessWidget {
  const _Section({required this.title, required this.children});

  final String title;
  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: TalkSpacing.xl),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(fontSize: 12, color: Colors.black45),
          ),
          const SizedBox(height: TalkSpacing.s),
          Wrap(spacing: TalkSpacing.s, runSpacing: TalkSpacing.s, children: children),
        ],
      ),
    );
  }
}
