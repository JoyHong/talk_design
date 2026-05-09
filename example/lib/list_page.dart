import 'package:flutter/material.dart';
import 'package:talk_design/talk_design.dart';

class ListPage extends StatefulWidget {
  const ListPage({super.key});

  @override
  State<ListPage> createState() => _ListPageState();
}

class _ListPageState extends State<ListPage> {
  bool _switch1 = true;
  bool _switch2 = false;
  bool _switch3 = true;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ── avatarListItem_status ──────────────────────────────────────
          _Section(title: 'avatarListItem_status', children: [
            TalkAvatarStatusItem(
              avatar: _colorAvatar(Colors.blue),
              name: 'Martha Walsh',
              timestamp: '09:30 AM',
              statusIcon: const Icon(Icons.videocam, size: 14, color: Color(0xFFAAAAAA)),
              preview: 'I sent a message.',
              badge: _badge('3'),
              onTap: () => _snack('Martha Walsh'),
            ),
            TalkAvatarStatusItem(
              avatar: _colorAvatar(Colors.purple),
              name: 'Very Long Name That Should Be Truncated By Ellipsis When Overflows',
              timestamp: '12:00 PM',
              preview: 'This is a very long preview message that exceeds the available width and should be truncated.',
              badge: _badge('99+'),
              onTap: () => _snack('Long Name'),
            ),
            TalkAvatarStatusItem(
              avatar: _colorAvatar(Colors.green),
              name: 'Alice',
              onTap: () => _snack('Alice'),
            ),
          ]),

          // ── avatarListItem_button ──────────────────────────────────────
          _Section(title: 'avatarListItem_button', children: [
            TalkAvatarButtonItem(
              avatar: _colorAvatar(Colors.orange),
              title: 'Bob Johnson',
              subtitle: 'I sent a message.',
              buttonLabel: '添加',
              onButtonPressed: () => _snack('按钮：添加'),
              onTap: () => _snack('Bob Johnson'),
            ),
            TalkAvatarButtonItem(
              avatar: _colorAvatar(Colors.teal),
              title: 'Long Name That Overflows The Available Space In Avatar Button Item',
              subtitle: 'Subtitle text that is also very long and will be truncated with ellipsis',
              buttonLabel: '已添加',
              onTap: () => _snack('Long Name'),
            ),
            TalkAvatarButtonItem(
              avatar: _colorAvatar(Colors.red),
              title: 'Charlie',
              buttonLabel: '关注',
              onButtonPressed: () => _snack('按钮：关注'),
              onTap: () => _snack('Charlie'),
            ),
            TalkAvatarButtonItem(
              avatar: _colorAvatar(Colors.blue),
              title: 'Diana',
              subtitle: 'With button icon',
              buttonIcon: const Icon(Icons.add),
              buttonLabel: 'Add',
              onButtonPressed: () => _snack('按钮：Add'),
              onTap: () => _snack('Diana'),
            ),
          ]),

          // ── List_base ──────────────────────────────────────────────────
          _Section(title: 'List_base（padding 24）', children: [
            TalkListBaseItem(
              icon: const Icon(Icons.person_outline, size: 20),
              label: 'Personal Info',
              trailing: 'Detail',
              onTap: () => _snack('Personal Info'),
            ),
            TalkListBaseItem(
              icon: const Icon(Icons.notifications_outlined, size: 20),
              label: 'Notifications',
              trailing: 'On',
              onTap: () => _snack('Notifications'),
            ),
            TalkListBaseItem(
              icon: const Icon(Icons.lock_outline, size: 20),
              label: 'A very long label that should be truncated by ellipsis when it overflows the row',
              trailing: 'Right',
              onTap: () => _snack('Long label'),
            ),
            TalkListBaseItem(
              label: 'No Icon Item',
              trailing: 'Looks good',
              onTap: () => _snack('No Icon Item'),
            ),
          ]),

          _Section(title: 'List_base（padding 10，compact）', children: [
            TalkListBaseItem(
              icon: const Icon(Icons.language, size: 20),
              label: 'Language',
              trailing: 'English',
              compact: true,
              onTap: () => _snack('Language'),
            ),
            TalkListBaseItem(
              icon: const Icon(Icons.dark_mode_outlined, size: 20),
              label: 'Dark Mode',
              compact: true,
              onTap: () => _snack('Dark Mode'),
            ),
          ]),

          // ── List_base_button ───────────────────────────────────────────
          _Section(title: 'List_base_button', children: [
            TalkListButtonItem(
              title: 'Hearing Protection Mode',
              subtitle: 'Daily Routine Mode',
              buttonLabel: '立即开启',
              onButtonPressed: () => _snack('按钮：立即开启'),
              onTap: () => _snack('Hearing Protection Mode'),
            ),
            TalkListButtonItem(
              title: 'Background Noise Reduction',
              buttonLabel: '设置',
              onButtonPressed: () => _snack('按钮：设置'),
              onTap: () => _snack('Background Noise Reduction'),
            ),
            TalkListButtonItem(
              title: 'A very long title that overflows and should be truncated by ellipsis',
              subtitle: 'Subtitle text that is also very long and will overflow',
              buttonLabel: '操作',
              onTap: () => _snack('Long title'),
            ),
            TalkListButtonItem(
              title: 'Settings with Icon',
              buttonIcon: const Icon(Icons.settings_outlined),
              buttonLabel: '配置',
              onButtonPressed: () => _snack('按钮：配置'),
              onTap: () => _snack('Settings with Icon'),
            ),
          ]),

          // ── List_base_switch ───────────────────────────────────────────
          _Section(title: 'List_base_switch（单行）', children: [
            TalkListSwitchItem(
              label: 'Receive Notifications',
              value: _switch1,
              onChanged: (v) => setState(() => _switch1 = v),
            ),
            TalkListSwitchItem(
              label: 'Auto Update',
              value: _switch2,
              onChanged: (v) => setState(() => _switch2 = v),
            ),
            TalkListSwitchItem(
              label: 'A very long single-line label text that will be truncated by ellipsis',
              value: _switch3,
              onChanged: (v) => setState(() => _switch3 = v),
            ),
          ]),

          _Section(title: 'List_base_switch（双行）', children: [
            TalkListSwitchItem(
              label: 'Hearing Protection Mode',
              subtitle: 'Automatically adjusts volume to safe levels',
              value: _switch1,
              onChanged: (v) => setState(() => _switch1 = v),
            ),
            TalkListSwitchItem(
              label: 'Background Noise Reduction',
              subtitle: 'Reduces ambient noise during calls',
              value: _switch2,
              onChanged: (v) => setState(() => _switch2 = v),
            ),
          ]),
        ],
      ),
    );
  }

  void _snack(String msg) => ScaffoldMessenger.of(context)
    ..clearSnackBars()
    ..showSnackBar(SnackBar(content: Text(msg), duration: const Duration(seconds: 1)));

  Widget _colorAvatar(Color color) => SizedBox.square(dimension: 32, child: CircleAvatar(backgroundColor: color));

  Widget _badge(String count) => SizedBox.square(
        dimension: 16,
        child: Container(
          decoration: const BoxDecoration(
            color: Color(0xFFFF2C55),
            shape: BoxShape.circle,
          ),
          alignment: Alignment.center,
          child: Text(
            count,
            style: const TextStyle(color: Colors.white, fontSize: 9, fontWeight: FontWeight.bold),
          ),
        ),
      );
}

// ── 分组标题 + 带边框的列表容器 ───────────────────────────────────────────────

class _Section extends StatelessWidget {
  const _Section({required this.title, required this.children});

  final String title;
  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(fontSize: 12, color: Colors.black45),
          ),
          const SizedBox(height: 8),
          DecoratedBox(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: const Color(0xFFE0E0E0)),
            ),
            child: Material(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
              clipBehavior: Clip.antiAlias,
              child: Column(
                children: [
                  for (int i = 0; i < children.length; i++) ...[
                    children[i],
                    if (i < children.length - 1)
                      const Divider(height: 1, indent: 16, endIndent: 16),
                  ],
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
