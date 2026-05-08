import 'package:flutter/material.dart';
import 'package:talk_design/talk_design.dart';

class AvatarPage extends StatefulWidget {
  const AvatarPage({super.key});

  @override
  State<AvatarPage> createState() => _AvatarPageState();
}

class _AvatarPageState extends State<AvatarPage> {
  final _controller = TextEditingController();
  String? _uid;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    const labelStyle = TextStyle(fontSize: 12, color: Colors.black45);

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('默认头像 — UID 末尾数字对应 0-9', style: labelStyle),
          const SizedBox(height: 16),
          Wrap(
            spacing: 16,
            runSpacing: 16,
            children: List.generate(10, (i) {
              return Column(
                children: [
                  TalkAvatars.of('$i'),
                  const SizedBox(height: 4),
                  Text('UID …$i', style: labelStyle),
                ],
              );
            }),
          ),
          const SizedBox(height: 32),
          const Text('输入 UID 预览', style: labelStyle),
          const SizedBox(height: 8),
          Row(
            children: [
              Expanded(
                child: TextField(
                  controller: _controller,
                  decoration: const InputDecoration(
                    hintText: '输入任意 UID',
                    border: OutlineInputBorder(),
                    isDense: true,
                  ),
                  onChanged: (v) => setState(() => _uid = v.trim()),
                ),
              ),
              const SizedBox(width: 12),
              TalkAvatars.of(
                _uid?.isEmpty == true ? null : _uid,
                size: 56,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
