import 'package:flutter/material.dart';
import 'package:talk_design/talk_design.dart';

class LoadingPage extends StatelessWidget {
  const LoadingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(TalkSpacing.l),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _Section(
            title: '环形不确定进度指示器 — 常用尺寸',
            description: '12 / 16 / 28 / 40 / 60，颜色默认 main',
            children: const [
              TalkLoadingIndicator(size: 12),
              TalkLoadingIndicator(size: 16),
              TalkLoadingIndicator(size: 28),
              TalkLoadingIndicator(size: 40),
              TalkLoadingIndicator(size: 60),
            ],
          ),
          _Section(
            title: '自定义颜色',
            description: '通过 color 参数覆盖，可用于消息发送中等场景',
            children: [
              TalkLoadingIndicator(size: 16, color: context.talkColors.textSecondary),
              TalkLoadingIndicator(size: 28, color: context.talkColors.textSecondary),
              TalkLoadingIndicator(size: 40, color: context.talkColors.textSecondary),
            ],
          ),
          _Section(
            title: '典型用法 — 消息发送中',
            description: '与消息气泡行内对齐，使用 textSecondary 灰色',
            children: [
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: TalkSpacing.m,
                      vertical: TalkSpacing.s,
                    ),
                    decoration: BoxDecoration(
                      color: context.talkColors.receivedMessageBubble,
                      borderRadius: BorderRadius.circular(TalkSpacing.m),
                    ),
                    child: const Text('正在发送中...'),
                  ),
                  const SizedBox(width: TalkSpacing.xs),
                  TalkLoadingIndicator(size: 16, color: context.talkColors.textSecondary),
                ],
              ),
            ],
          ),
          _Section(
            title: '典型用法 — 全屏加载',
            description: '使用较大尺寸配合说明文字',
            children: [
              Container(
                width: double.infinity,
                height: 160,
                decoration: BoxDecoration(
                  color: context.talkColors.backgroundSecondary,
                  borderRadius: BorderRadius.circular(TalkSpacing.m),
                ),
                child: const Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TalkLoadingIndicator(size: 60),
                    SizedBox(height: TalkSpacing.m),
                    Text('加载中，请稍候…'),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
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
