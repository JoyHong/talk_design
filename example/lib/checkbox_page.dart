import 'package:flutter/material.dart';
import 'package:talk_design/talk_design.dart';

class CheckboxPage extends StatefulWidget {
  const CheckboxPage({super.key});

  @override
  State<CheckboxPage> createState() => _CheckboxPageState();
}

class _CheckboxPageState extends State<CheckboxPage> {
  bool _checked1 = false;
  bool _checked2 = true;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ── Figma 三态静态展示 ────────────────────────────────────────────
          _SectionLabel('Figma 规范三态'),
          _Hint('normal / checked / disable'),
          const SizedBox(height: 8),
          Row(
            children: [
              _StateItem(
                label: 'normal',
                child: TalkCheckbox(value: false, onChanged: (_) {}),
              ),
              const SizedBox(width: 24),
              _StateItem(
                label: 'checked',
                child: TalkCheckbox(value: true, onChanged: (_) {}),
              ),
              const SizedBox(width: 24),
              _StateItem(
                label: 'disable',
                child: const TalkCheckbox(value: true, onChanged: null),
              ),
            ],
          ),

          _Divider(),

          // ── 可交互示例 ────────────────────────────────────────────────────
          _SectionLabel('可交互'),
          _Hint('点击切换勾选状态'),
          const SizedBox(height: 8),
          _TalkCheckboxTile(
            label: '选项一',
            value: _checked1,
            onChanged: (v) => setState(() => _checked1 = v),
          ),
          const SizedBox(height: 12),
          _TalkCheckboxTile(
            label: '选项二（初始已勾选）',
            value: _checked2,
            onChanged: (v) => setState(() => _checked2 = v),
          ),

          _Divider(),

          // ── 禁用态 ────────────────────────────────────────────────────────
          _SectionLabel('禁用态'),
          _Hint('onChanged 为 null 时进入禁用态'),
          const SizedBox(height: 8),
          Row(
            children: [
              _StateItem(
                label: '禁用未选',
                child: const TalkCheckbox(value: false, onChanged: null),
              ),
              const SizedBox(width: 24),
              _StateItem(
                label: '禁用已选',
                child: const TalkCheckbox(value: true, onChanged: null),
              ),
            ],
          ),

          _Divider(),
        ],
      ),
    );
  }
}

class _TalkCheckboxTile extends StatelessWidget {
  const _TalkCheckboxTile({
    required this.label,
    required this.value,
    required this.onChanged,
  });

  final String label;
  final bool value;
  final ValueChanged<bool> onChanged;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onChanged(!value),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          TalkCheckbox(value: value, onChanged: onChanged),
          const SizedBox(width: 8),
          Text(
            label,
            style: TalkTypography.bodyMedium
                .copyWith(color: context.talkColors.textSecondary),
          ),
        ],
      ),
    );
  }
}

class _StateItem extends StatelessWidget {
  const _StateItem({required this.label, required this.child});
  final String label;
  final Widget child;

  @override
  Widget build(BuildContext context) => Column(
        children: [
          child,
          const SizedBox(height: 4),
          Text(
            label,
            style: TalkTypography.bodySmall
                .copyWith(color: context.talkColors.textSecondary),
          ),
        ],
      );
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
          style: TalkTypography.bodySmall
              .copyWith(color: context.talkColors.textSecondary),
        ),
      );
}

class _Divider extends StatelessWidget {
  const _Divider();

  @override
  Widget build(BuildContext context) =>
      const SizedBox(height: 32);
}
