import 'package:flutter/material.dart';
import 'package:talk_design/talk_design.dart';

class ButtonsPage extends StatelessWidget {
  const ButtonsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final styles = context.talkButtonStyles;

    return SingleChildScrollView(
      padding: const EdgeInsets.all(TalkSpacing.l),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _Section(title: 'fillTheme（填充主色）', children: [
            ElevatedButton(
              style: styles.fillTheme,
              onPressed: () {},
              child: const Text('Normal'),
            ),
            ElevatedButton(
              style: styles.fillTheme,
              onPressed: null,
              child: const Text('Disabled'),
            ),
          ]),
          _Section(title: 'textTheme（文字主色）', children: [
            TextButton(
              style: styles.textTheme,
              onPressed: () {},
              child: const Text('Normal'),
            ),
            TextButton(
              style: styles.textTheme,
              onPressed: null,
              child: const Text('Disabled'),
            ),
          ]),
          _Section(title: 'textSecondary（文字次要色）', children: [
            TextButton(
              style: styles.textSecondary,
              onPressed: () {},
              child: const Text('Normal'),
            ),
            TextButton(
              style: styles.textSecondary,
              onPressed: null,
              child: const Text('Disabled'),
            ),
          ]),
          _Section(title: 'strokeSecondary（描边）', children: [
            OutlinedButton(
              style: styles.strokeSecondary,
              onPressed: () {},
              child: const Text('Normal'),
            ),
            OutlinedButton(
              style: styles.strokeSecondary,
              onPressed: null,
              child: const Text('Disabled'),
            ),
          ]),
          _Section(title: 'fillThemeIcon（填充主色 + 图标）', children: [
            ElevatedButton.icon(
              style: styles.fillThemeIcon,
              onPressed: () {},
              icon: const Icon(Icons.add),
              label: const Text('With Icon'),
            ),
          ]),
          _Section(title: 'strokeSecondaryIcon（描边 + 图标）', children: [
            OutlinedButton.icon(
              style: styles.strokeSecondaryIcon,
              onPressed: () {},
              icon: const Icon(Icons.search),
              label: const Text('With Icon'),
            ),
          ]),
          _Section(title: 'themeIcon（纯图标）', children: [
            ElevatedButton(
              style: styles.themeIcon,
              onPressed: () {},
              child: const Icon(Icons.favorite),
            ),
            ElevatedButton(
              style: styles.themeIcon,
              onPressed: null,
              child: const Icon(Icons.favorite),
            ),
          ]),
          _Section(title: 'textSecondaryRipple（次要文字 + 水波纹）', children: [
            TextButton(
              style: styles.textSecondaryRipple,
              onPressed: () {},
              child: const Text('Normal'),
            ),
          ]),
          _Section(title: 'block（块状按钮）', children: [
            _BlockButton(
              label: '视频',
              icon: Icons.videocam,
              colors: styles.block,
              onTap: () {},
            ),
            _BlockButton(
              label: '语音',
              icon: Icons.mic,
              colors: styles.block,
              onTap: () {},
            ),
          ]),
        ],
      ),
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
            style: const TextStyle(
              fontSize: 12,
              color: Colors.black45,
            ),
          ),
          const SizedBox(height: TalkSpacing.s),
          Wrap(spacing: TalkSpacing.s, runSpacing: TalkSpacing.s, children: children),
        ],
      ),
    );
  }
}

class _BlockButton extends StatelessWidget {
  const _BlockButton({
    required this.label,
    required this.icon,
    required this.colors,
    required this.onTap,
  });

  final String label;
  final IconData icon;
  final TalkBlockButtonColors colors;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(TalkSpacing.radiusM),
      child: Container(
        width: 80,
        height: 80,
        decoration: BoxDecoration(
          color: colors.normalBackground,
          borderRadius: BorderRadius.circular(TalkSpacing.radiusM),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: colors.foreground, size: 28),
            const SizedBox(height: 4),
            Text(
              label,
              style: TextStyle(
                fontSize: 12,
                color: colors.foreground,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
