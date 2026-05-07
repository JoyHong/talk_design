import 'package:flutter/material.dart';
import 'package:talk_design/talk_design.dart';

class MenuPage extends StatelessWidget {
  const MenuPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(TalkSpacing.l),
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _Section(
            title: '下拉选择按钮',
            description: '点击按钮弹出选项列表，当前选中项右侧显示勾选图标',
            child: _DropdownDemo(),
          ),
          _Section(
            title: '简单菜单（一级）',
            description: '点击右侧按钮，展示只有一级菜单项的菜单',
            child: _SimpleMenuDemo(),
          ),
          _Section(
            title: '带二级子菜单',
            description: '点击右侧按钮，展示含有二级子菜单的菜单。「管理好友」选项悬停时会弹出子菜单',
            child: _SubMenuDemo(),
          ),
        ],
      ),
    );
  }
}

// ── 下拉选择按钮示例 ─────────────────────────────────────────────────────────

class _DropdownDemo extends StatefulWidget {
  const _DropdownDemo();

  @override
  State<_DropdownDemo> createState() => _DropdownDemoState();
}

class _DropdownDemoState extends State<_DropdownDemo> {
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
    return Wrap(
      spacing: TalkSpacing.m,
      runSpacing: TalkSpacing.s,
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

// 仅覆写危险操作项的颜色，其余属性继承自 menuButtonTheme
ButtonStyle _dangerStyle(TalkColors colors) => ButtonStyle(
      foregroundColor: WidgetStatePropertyAll(colors.redDotError),
      iconColor: WidgetStatePropertyAll(colors.redDotError),
    );

// ── 一级菜单示例 ──────────────────────────────────────────────────────────────

class _SimpleMenuDemo extends StatelessWidget {
  const _SimpleMenuDemo();

  @override
  Widget build(BuildContext context) {
    return MenuAnchor(
      menuChildren: [
        MenuItemButton(
          leadingIcon: const Icon(Icons.person_remove_outlined),
          onPressed: () {},
          child: const Text('Delete friend'),
        ),
        MenuItemButton(
          leadingIcon: const Icon(Icons.block_outlined),
          onPressed: () {},
          child: const Text('Block'),
        ),
      ],
      builder: (context, controller, child) => _MoreButton(
        onPressed: controller.isOpen ? controller.close : controller.open,
      ),
    );
  }
}

// ── 二级子菜单示例 ────────────────────────────────────────────────────────────

class _SubMenuDemo extends StatelessWidget {
  const _SubMenuDemo();

  @override
  Widget build(BuildContext context) {
    final colors = context.talkColors;
    return MenuAnchor(
      menuChildren: [
        SubmenuButton(
          leadingIcon: const Icon(Icons.people_outlined),
          menuChildren: [
            MenuItemButton(
              leadingIcon: const Icon(Icons.person_remove_outlined),
              onPressed: () {},
              child: const Text('Delete friend'),
            ),
            MenuItemButton(
              leadingIcon: const Icon(Icons.block_outlined),
              onPressed: () {},
              child: const Text('Block'),
            ),
          ],
          child: const Text('Manage friendship'),
        ),

        MenuItemButton(
          leadingIcon: const Icon(Icons.push_pin_outlined),
          onPressed: () {},
          child: const Text('Sticky on top'),
        ),
        const TalkMenuDivider(),
        MenuItemButton(
          style: _dangerStyle(colors),
          leadingIcon: const Icon(Icons.delete_outline),
          onPressed: () {},
          child: const Text('Delete chat'),
        ),
      ],
      builder: (context, controller, child) => _MoreButton(
        onPressed: controller.isOpen ? controller.close : controller.open,
      ),
    );
  }
}

// ── 触发按钮 ──────────────────────────────────────────────────────────────────

class _MoreButton extends StatelessWidget {
  const _MoreButton({required this.onPressed});

  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    final colors = context.talkColors;
    return InkWell(
      borderRadius: BorderRadius.circular(20),
      onTap: onPressed,
      child: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: colors.listCardMenuFloating,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Icon(Icons.more_horiz, size: 20, color: colors.textPrimary),
      ),
    );
  }
}

// ── 分区布局 ──────────────────────────────────────────────────────────────────

class _Section extends StatelessWidget {
  const _Section({required this.title, required this.description, required this.child});

  final String title;
  final String description;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: TalkSpacing.xl),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: const TextStyle(fontSize: 12, color: Colors.black45)),
          const SizedBox(height: 2),
          Text(description, style: const TextStyle(fontSize: 11, color: Colors.black26)),
          const SizedBox(height: TalkSpacing.s),
          child,
        ],
      ),
    );
  }
}
