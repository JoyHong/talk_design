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

  @override
  Widget build(BuildContext context) {
    const sectionStyle = TextStyle(
      fontSize: 12,
      color: Colors.black45,
      fontWeight: FontWeight.bold,
    );
    const divider = SizedBox(height: 24);
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
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

          const SizedBox(height: 16),
        ],
      ),
    );
  }
}
