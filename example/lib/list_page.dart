import 'package:flutter/material.dart';
import 'package:talk_design/talk_design.dart';

class ListPage extends StatefulWidget {
  const ListPage({super.key});

  @override
  State<ListPage> createState() => _ListPageState();
}

class _ListPageState extends State<ListPage> {
  bool _checkItem1Selected = false;
  bool _checkItem2Selected = true;
  bool _switch1 = true;
  bool _switch2 = false;

  @override
  Widget build(BuildContext context) {
    const sectionStyle = TextStyle(
      fontSize: 12,
      color: Colors.black45,
      fontWeight: FontWeight.bold,
    );
    const divider = SizedBox(height: 24);

    final placeholder = Container(
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
        color: Color(0xFFD9D9D9),
      ),
    );

    final smallPlaceholder = Container(
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
        color: Color(0xFFD9D9D9),
      ),
    );

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ── 头像列表 ────────────────────────────────────────────────────────
          const Text('头像列表 — List_avatar_check', style: sectionStyle),
          const SizedBox(height: 8),
          TalkAvatarCheckListItem(
            avatar: smallPlaceholder,
            name: '未选中状态',
            selected: _checkItem1Selected,
            onTap: () => setState(() => _checkItem1Selected = !_checkItem1Selected),
          ),
          TalkAvatarCheckListItem(
            avatar: smallPlaceholder,
            name: '已选中状态',
            selected: _checkItem2Selected,
            onTap: () => setState(() => _checkItem2Selected = !_checkItem2Selected),
          ),

          divider,
          const Text('头像列表 — List_avatar_singleline', style: sectionStyle),
          const SizedBox(height: 8),
          TalkAvatarSimpleListItem(
            avatar: placeholder,
            name: 'Martha Walsh',
            onTap: () {},
          ),

          divider,
          const Text('头像列表 — List_avatar_multiline', style: sectionStyle),
          const SizedBox(height: 8),
          TalkAvatarSimpleListItem(
            avatar: placeholder,
            name: 'Martha Walsh',
            subtitle: '副标题文本',
            onTap: () {},
          ),

          divider,
          const Text('头像列表 — List_avatar_multiline_icon（消息预览）', style: sectionStyle),
          const SizedBox(height: 8),
          TalkAvatarMessageListItem(
            avatar: placeholder,
            name: 'Martha Walsh',
            message: 'I sent a message.',
            time: '09:41 AM',
            leadingIcon: Container(
              width: 14,
              height: 14,
              decoration: BoxDecoration(
                color: const Color(0xFFD9D9D9),
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            unreadBadge: Container(
              width: 16,
              height: 16,
              decoration: BoxDecoration(
                color: const Color(0xFFD9D9D9),
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            onTap: () {},
          ),
          const SizedBox(height: 8),
          TalkAvatarMessageListItem(
            avatar: placeholder,
            name: 'Bob Lee',
            message: 'Hello there!',
            time: '昨天',
            onTap: () {},
          ),

          divider,
          const Text('头像列表 — List_avatar_button', style: sectionStyle),
          const SizedBox(height: 8),
          TalkAvatarButtonListItem(
            avatar: placeholder,
            name: 'Martha Walsh',
            subtitle: 'I sent a message.',
            buttonLabel: '添加',
            onButtonTap: () {},
            onTap: () {},
          ),
          const SizedBox(height: 8),
          TalkAvatarButtonListItem(
            avatar: placeholder,
            name: 'Bob Lee',
            buttonLabel: '关注',
            onButtonTap: () {},
            onTap: () {},
          ),

          divider,
          const Divider(),
          divider,

          // ── 常规列表 ────────────────────────────────────────────────────────
          const Text('常规列表 — List_text（纯文本）', style: sectionStyle),
          const SizedBox(height: 8),
          TalkTextListItem(
            title: '列表项标题',
            onTap: () {},
          ),
          TalkTextListItem(
            title: '列表项标题',
            trailing: '副文本',
            onTap: () {},
          ),

          divider,
          const Text('常规列表 — List_text_icon（左图标）', style: sectionStyle),
          const SizedBox(height: 8),
          TalkTextIconListItem(
            icon: Container(
              decoration: BoxDecoration(
                color: const Color(0xFFD9D9D9),
                borderRadius: BorderRadius.circular(4),
              ),
            ),
            title: '列表项标题',
            onTap: () {},
          ),

          divider,
          const Text('常规列表 — List_text_button（带操作按钮）', style: sectionStyle),
          const SizedBox(height: 8),
          TalkTextButtonListItem(
            title: '列表项标题',
            subtitle: '描述文本',
            buttonLabel: '操作',
            onButtonTap: () {},
            onTap: () {},
          ),
          const SizedBox(height: 8),
          TalkTextButtonListItem(
            title: '无副标题列表项',
            buttonLabel: '操作',
            onButtonTap: () {},
            onTap: () {},
          ),

          divider,
          const Text('常规列表 — List_text_switch（单行开关）', style: sectionStyle),
          const SizedBox(height: 8),
          TalkTextSwitchListItem(
            title: '开关列表项（单行）',
            value: _switch1,
            onChanged: (v) => setState(() => _switch1 = v),
          ),

          divider,
          const Text('常规列表 — List_text_switch（双行开关）', style: sectionStyle),
          const SizedBox(height: 8),
          TalkTextSwitchListItem(
            title: '开关列表项',
            subtitle: '描述文本说明此项的详细信息',
            value: _switch2,
            onChanged: (v) => setState(() => _switch2 = v),
          ),

          const SizedBox(height: TalkSpacing.l),
        ],
      ),
    );
  }
}
