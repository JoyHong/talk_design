import 'package:flutter/material.dart';
import 'package:talk_design/talk_design.dart';

class InputsPage extends StatefulWidget {
  const InputsPage({super.key});

  @override
  State<InputsPage> createState() => _InputsPageState();
}

class _InputsPageState extends State<InputsPage> {
  String? _filterSelected;
  final _dropdownController = TextEditingController(text: '+93');

  @override
  void dispose() {
    _dropdownController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ── 文本输入框 ──────────────────────────────────────────────────────
          _SectionLabel('文本输入框'),
          _Hint('有焦点且有内容时显示清空图标'),
          TalkTextField(hintText: '请输入内容…'),

          const SizedBox(height: 8),
          _Hint('isLoading=true：右侧显示加载指示器，清空图标不显示'),
          TalkTextField(hintText: '加载中…', isLoading: true),

          _Divider(),

          // ── 密码输入框 ──────────────────────────────────────────────────────
          _SectionLabel('密码输入框'),
          _Hint('有焦点或鼠标悬浮时显示明/密文切换图标'),
          TalkPasswordField(hintText: '请输入密码…'),

          _Divider(),

          // ── 文本+自定义图标 ─────────────────────────────────────────────────
          _SectionLabel('文本+自定义图标'),
          _Hint('图标始终显示（20×20）；点击图标触发回调'),
          TalkIconTextField(
            hintText: '选择日期…',
            icon: const Icon(Icons.calendar_today_outlined),
            onIconTap: () => ScaffoldMessenger.of(context)
                .showSnackBar(const SnackBar(content: Text('图标被点击'), duration: Duration(seconds: 1))),
          ),

          _Divider(),

          // ── 下拉输入框 ──────────────────────────────────────────────────────
          _SectionLabel('下拉输入框'),
          _Hint('输入时自动过滤，匹配子串主题色高亮'),
          TalkDropdownTextField(
            items: const ['Afghanistan (+93)', 'Aland Islands (+358)', 'Albania (+355)'],
            controller: _dropdownController,
            hintText: '请输入或选择城市…',
            onSelected: (v) => setState(() => _filterSelected = v),
          ),
          const SizedBox(height: 8),
          _Hint('已选：${_filterSelected ?? '未选择'}'),

          _Divider(),

          // ── 搜索框 ──────────────────────────────────────────────────────────
          _SectionLabel('搜索框'),
          _Hint('有焦点且有内容时显示清空图标；圆角为胶囊形'),
          TalkSearchField(hintText: '搜索…'),

          _Divider(),
        ],
      ),
    );
  }
}

class _SectionLabel extends StatelessWidget {
  const _SectionLabel(this.text);
  final String text;

  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.only(bottom: 8),
        child: Text(text, style: TalkTypography.titleSmall),
      );
}

class _Hint extends StatelessWidget {
  const _Hint(this.text);
  final String text;

  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.only(bottom: 8),
        child: Text(
          text,
          style: TalkTypography.bodySmall.copyWith(color: context.talkColors.textSecondary),
        ),
      );
}

class _Divider extends StatelessWidget {
  const _Divider();

  @override
  Widget build(BuildContext context) => const SizedBox(height: 32);
}
