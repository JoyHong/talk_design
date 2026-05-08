import 'package:flutter/material.dart';
import 'package:talk_design/talk_design.dart';

class InputsPage extends StatefulWidget {
  const InputsPage({super.key});

  @override
  State<InputsPage> createState() => _InputsPageState();
}

class _InputsPageState extends State<InputsPage> {
  String _dropdownStatus = '未展开';

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(TalkSpacing.l),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ── 文本输入框 ──────────────────────────────────────────────────────
          _SectionLabel('文本输入框'),
          _Hint('有焦点且有内容时显示清空图标'),
          TalkTextField(hintText: '请输入内容…'),

          const SizedBox(height: TalkSpacing.s),
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
          _Hint('点击箭头切换下拉状态，两种状态均可输入'),
          TalkDropdownTextField(
            hintText: '请选择或输入…',
            onDropdownToggle: (isDropdown) =>
                setState(() => _dropdownStatus = isDropdown ? '已展开' : '已收起'),
          ),
          const SizedBox(height: TalkSpacing.s),
          _Hint('回调状态：$_dropdownStatus'),

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
        padding: const EdgeInsets.only(bottom: TalkSpacing.s),
        child: Text(text, style: TalkTypography.titleSmall),
      );
}

class _Hint extends StatelessWidget {
  const _Hint(this.text);
  final String text;

  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.only(bottom: TalkSpacing.s),
        child: Text(
          text,
          style: TalkTypography.bodySmall.copyWith(color: context.talkColors.textSecondary),
        ),
      );
}

class _Divider extends StatelessWidget {
  const _Divider();

  @override
  Widget build(BuildContext context) => const SizedBox(height: TalkSpacing.xxl);
}
