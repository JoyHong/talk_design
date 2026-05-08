import 'dart:async';

import 'package:flutter/material.dart';
import 'package:talk_design/talk_design.dart';

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
