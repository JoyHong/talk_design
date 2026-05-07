import 'package:flutter/material.dart';
import 'package:talk_design/talk_design.dart';

class ToastPage extends StatelessWidget {
  const ToastPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(TalkSpacing.l),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _Section(
            title: '纯文本 Toast',
            description: '宽度随文本内容自适应，圆角 20px，白底阴影',
            children: [
              _TriggerButton(
                label: '操作成功',
                onPressed: (ctx) => TalkToast.show(ctx, '操作成功'),
              ),
              _TriggerButton(
                label: '较长提示信息',
                onPressed: (ctx) =>
                    TalkToast.show(ctx, '这是一条较长的提示信息，宽度自适应'),
              ),
            ],
          ),
          _Section(
            title: '带图标 Toast',
            description: '前置图标固定 20×20，与文字间距 8px',
            children: [
              _TriggerButton(
                label: '复制成功',
                onPressed: (ctx) => TalkToast.show(
                  ctx,
                  '复制成功',
                  icon: Icon(Icons.check_circle_outline,
                      color: ctx.talkColors.success),
                ),
              ),
              _TriggerButton(
                label: '链接已复制',
                onPressed: (ctx) => TalkToast.show(
                  ctx,
                  '链接已复制',
                  icon: Icon(Icons.link,
                      color: ctx.talkColors.textSecondary),
                ),
              ),
              _TriggerButton(
                label: '操作失败',
                onPressed: (ctx) => TalkToast.show(
                  ctx,
                  '操作失败，请重试',
                  icon: Icon(Icons.error_outline,
                      color: ctx.talkColors.redDotError),
                ),
              ),
            ],
          ),
          _Section(
            title: '成功 / 失败 Toast',
            description: '使用 TalkIcons.correct / TalkIcons.error 内置 SVG 图标',
            children: [
              _TriggerButton(
                label: '成功 Toast',
                onPressed: (ctx) => TalkToast.showSuccess(ctx, '保存成功'),
              ),
              _TriggerButton(
                label: '失败 Toast',
                onPressed: (ctx) => TalkToast.showError(ctx, '操作失败，请重试'),
              ),
            ],
          ),
          _Section(
            title: '时长与偏移',
            description: '控制 Toast 显示时长和顶部偏移量',
            children: [
              _TriggerButton(
                label: 'Long 时长 (4 秒)',
                onPressed: (ctx) => TalkToast.show(
                  ctx,
                  '这条 toast 会显示 4 秒',
                  duration: TalkToastDuration.long,
                ),
              ),
              _TriggerButton(
                label: 'Short 时长 (1.5 秒)',
                onPressed: (ctx) => TalkToast.show(
                  ctx,
                  '1.5 秒后消失',
                  duration: TalkToastDuration.short,
                ),
              ),
              _TriggerButton(
                label: '自定义顶部偏移',
                onPressed: (ctx) => TalkToast.show(
                  ctx,
                  '距顶部 60px',
                  topOffset: 60,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _TriggerButton extends StatelessWidget {
  const _TriggerButton({required this.label, required this.onPressed});

  final String label;
  final void Function(BuildContext) onPressed;

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: () => onPressed(context),
      child: Text(label),
    );
  }
}

class _Section extends StatelessWidget {
  const _Section({
    required this.title,
    required this.children,
    this.description,
  });

  final String title;
  final String? description;
  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: TalkSpacing.xl),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: Theme.of(context).textTheme.titleSmall),
          if (description != null) ...[
            const SizedBox(height: TalkSpacing.xs),
            Text(
              description!,
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: context.talkColors.textSecondary,
                  ),
            ),
          ],
          const SizedBox(height: TalkSpacing.m),
          Wrap(
            spacing: TalkSpacing.l,
            runSpacing: TalkSpacing.m,
            crossAxisAlignment: WrapCrossAlignment.center,
            children: children,
          ),
        ],
      ),
    );
  }
}
