import 'package:flutter/material.dart';
import 'package:talk_design/talk_design.dart';

class DialogPage extends StatefulWidget {
  const DialogPage({super.key});

  @override
  State<DialogPage> createState() => _DialogPageState();
}

class _DialogPageState extends State<DialogPage> {
  String _lastAction = '（尚未操作）';

  void _log(String action) => setState(() => _lastAction = action);

  void _showSingleLine() {
    showDialog<void>(
      context: context,
      barrierColor: Colors.black54,
      builder: (_) => Dialog(
        backgroundColor: Colors.transparent,
        elevation: 0,
        child: TalkDialog(
          title: '确认删除这条消息吗？',
          onClose: () => Navigator.pop(context),
          cancelLabel: '取消',
          onCancel: () {
            Navigator.pop(context);
            _log('单行文本 → 取消');
          },
          confirmLabel: '删除',
          onConfirm: () {
            Navigator.pop(context);
            _log('单行文本 → 删除');
          },
        ),
      ),
    );
  }

  void _showMultiLine() {
    showDialog<void>(
      context: context,
      barrierColor: Colors.black54,
      builder: (_) => Dialog(
        backgroundColor: Colors.transparent,
        elevation: 0,
        child: TalkDialog(
          title: '退出当前通话',
          message: '退出后将无法再加入此通话，是否确认退出？',
          onClose: () => Navigator.pop(context),
          cancelLabel: '取消',
          onCancel: () {
            Navigator.pop(context);
            _log('多行文本 → 取消');
          },
          confirmLabel: '退出',
          onConfirm: () {
            Navigator.pop(context);
            _log('多行文本 → 退出');
          },
        ),
      ),
    );
  }

  void _showDropdown() {
    showDialog<void>(
      context: context,
      barrierColor: Colors.black54,
      builder: (_) => Dialog(
        backgroundColor: Colors.transparent,
        elevation: 0,
        child: TalkDialog(
          title: '结束本次通话',
          onClose: () => Navigator.pop(context),
          cancelLabel: '取消',
          onCancel: () {
            Navigator.pop(context);
            _log('下拉按钮 → 取消');
          },
          confirmLabel: '结束通话',
          onConfirm: () {
            Navigator.pop(context);
            _log('下拉按钮 → 结束通话（主操作）');
          },
          confirmDropdownItems: const ['所有人离开', '仅自己离开'],
          onConfirmDropdownSelected: (value) {
            Navigator.pop(context);
            _log('下拉按钮 → $value');
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(TalkSpacing.l),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _Section(
            title: '单行文本',
            description: '标题单行，右上角关闭，取消 + 确认按钮',
            child: ElevatedButton(
              onPressed: _showSingleLine,
              child: const Text('打开弹框'),
            ),
          ),
          _Section(
            title: '多行文本',
            description: '标题 + 副文本（多行），按钮布局同上',
            child: ElevatedButton(
              onPressed: _showMultiLine,
              child: const Text('打开弹框'),
            ),
          ),
          _Section(
            title: '单行文本_按钮可下拉',
            description: '确认按钮右侧带下拉箭头，点击展开选项',
            child: ElevatedButton(
              onPressed: _showDropdown,
              child: const Text('打开弹框'),
            ),
          ),
          const Divider(height: 32),
          Text(
            '上次操作：$_lastAction',
            style: const TextStyle(fontSize: 13, color: Colors.black54),
          ),
        ],
      ),
    );
  }
}

// ── 分区布局 ───────────────────────────────────────────────────────────────────

class _Section extends StatelessWidget {
  const _Section({
    required this.title,
    required this.description,
    required this.child,
  });

  final String title;
  final String description;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: TalkSpacing.xl),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title,
              style: const TextStyle(fontSize: 12, color: Colors.black45)),
          const SizedBox(height: 2),
          Text(description,
              style: const TextStyle(fontSize: 11, color: Colors.black26)),
          const SizedBox(height: TalkSpacing.s),
          child,
        ],
      ),
    );
  }
}
