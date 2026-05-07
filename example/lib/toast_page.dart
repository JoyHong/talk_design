import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
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
          const _Section(
            title: '纯文本 Toast',
            description: '宽度随文本内容自适应，圆角 20px，白底阴影',
            children: [
              TalkToast(message: '操作成功'),
              TalkToast(message: '这是一条较长的提示信息，宽度自适应'),
            ],
          ),
          _Section(
            title: '带图标 Toast',
            description: '前置图标固定 20×20，与文字间距 8px',
            children: [
              TalkToast(
                message: '复制成功',
                icon: Icon(Icons.check_circle_outline,
                    color: context.talkColors.success),
              ),
              TalkToast(
                message: '链接已复制',
                icon: Icon(Icons.link,
                    color: context.talkColors.textSecondary),
              ),
              TalkToast(
                message: '操作失败，请重试',
                icon: Icon(Icons.error_outline,
                    color: context.talkColors.redDotError),
              ),
            ],
          ),
          _Section(
            title: '成功 / 失败 Toast',
            description: '使用 TalkIcons.correct / TalkIcons.error 内置 SVG 图标',
            children: [
              TalkToast(
                message: '保存成功',
                icon: SvgPicture.asset(TalkIcons.correct),
              ),
              TalkToast(
                message: '操作失败，请重试',
                icon: SvgPicture.asset(TalkIcons.error),
              ),
            ],
          ),
          _Section(
            title: '弹出式 Toast — TalkToast.show()',
            description: '点击按钮触发，底部居中弹出，自动消失',
            children: [
              _TriggerButton(
                label: '显示纯文本',
                onPressed: (ctx) => TalkToast.show(ctx, '操作成功'),
              ),
              _TriggerButton(
                label: '显示带图标',
                onPressed: (ctx) => TalkToast.show(
                  ctx,
                  '复制成功',
                  icon: Icon(Icons.check_circle_outline,
                      color: ctx.talkColors.success),
                ),
              ),
              _TriggerButton(
                label: '成功 Toast',
                onPressed: (ctx) => TalkToast.showSuccess(ctx, '保存成功'),
              ),
              _TriggerButton(
                label: '失败 Toast',
                onPressed: (ctx) => TalkToast.showError(ctx, '操作失败，请重试'),
              ),
              _TriggerButton(
                label: 'Long 时长',
                onPressed: (ctx) => TalkToast.show(
                  ctx,
                  '这条 toast 会显示 4 秒',
                  duration: TalkToastDuration.long,
                ),
              ),
              _TriggerButton(
                label: 'Short 时长',
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
