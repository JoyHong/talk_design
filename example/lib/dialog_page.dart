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
    showTalkDialog(
      context: context,
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
    );
  }

  void _showMultiLine() {
    showTalkDialog(
      context: context,
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
    );
  }

  void _showDropdown() {
    showTalkDialog(
      context: context,
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
    );
  }

  void _showDropdownLoadingSuccess() {
    showTalkDialog(
      context: context,
      title: '结束本次通话',
      onClose: () => Navigator.pop(context),
      cancelLabel: '取消',
      onCancel: () {
        Navigator.pop(context);
        _log('下拉按钮 loading（成功）→ 取消');
      },
      confirmLabel: '结束通话',
      onConfirmAsync: () async {
        await Future.delayed(const Duration(seconds: 2));
        _log('下拉按钮 loading（成功）→ 结束通话完成');
        if (mounted) Navigator.pop(context);
      },
      confirmDropdownItems: const ['所有人离开', '仅自己离开'],
      onConfirmDropdownAsync: (value) async {
        await Future.delayed(const Duration(seconds: 2));
        _log('下拉按钮 loading（成功）→ $value 完成');
        if (mounted) Navigator.pop(context);
      },
    );
  }

  void _showDropdownLoadingFailure() {
    showTalkDialog(
      context: context,
      title: '结束本次通话',
      message: '此示例模拟业务失败：loading 结束后按钮恢复，弹框保持打开。',
      onClose: () => Navigator.pop(context),
      cancelLabel: '取消',
      onCancel: () {
        Navigator.pop(context);
        _log('下拉按钮 loading（失败）→ 取消');
      },
      confirmLabel: '结束通话',
      onConfirmAsync: () async {
        await Future.delayed(const Duration(seconds: 2));
        _log('下拉按钮 loading（失败）→ 结束通话失败，按钮已重置');
        throw Exception('模拟失败');
      },
      confirmDropdownItems: const ['所有人离开', '仅自己离开'],
      onConfirmDropdownAsync: (value) async {
        await Future.delayed(const Duration(seconds: 2));
        _log('下拉按钮 loading（失败）→ $value 失败，按钮已重置');
        throw Exception('模拟失败');
      },
    );
  }

  void _showLoadingSuccess() {
    showTalkDialog(
      context: context,
      title: '确认提交申请？',
      message: '提交后将进入审核流程，通常需要 1–3 个工作日。',
      onClose: () => Navigator.pop(context),
      cancelLabel: '取消',
      onCancel: () {
        Navigator.pop(context);
        _log('确认 loading（成功）→ 取消');
      },
      confirmLabel: '提交',
      onConfirmAsync: () async {
        await Future.delayed(const Duration(seconds: 2));
        _log('确认 loading（成功）→ 提交完成');
        if (mounted) Navigator.pop(context);
      },
    );
  }

  void _showLoadingFailure() {
    showTalkDialog(
      context: context,
      title: '确认提交申请？',
      message: '此示例模拟业务失败：loading 结束后按钮恢复，弹框保持打开。',
      onClose: () => Navigator.pop(context),
      cancelLabel: '取消',
      onCancel: () {
        Navigator.pop(context);
        _log('确认 loading（失败）→ 取消');
      },
      confirmLabel: '提交',
      onConfirmAsync: () async {
        await Future.delayed(const Duration(seconds: 2));
        _log('确认 loading（失败）→ 提交失败，按钮已重置');
        throw Exception('模拟失败');
      },
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
          _Section(
            title: '下拉分裂按钮 loading — 业务成功',
            description: '点击左侧主操作或下拉选项均进入 loading，2 秒后弹框自动关闭',
            child: ElevatedButton(
              onPressed: _showDropdownLoadingSuccess,
              child: const Text('打开弹框'),
            ),
          ),
          _Section(
            title: '下拉分裂按钮 loading — 业务失败',
            description: '点击左侧主操作或下拉选项均进入 loading，2 秒后按钮恢复、弹框保持打开',
            child: ElevatedButton(
              onPressed: _showDropdownLoadingFailure,
              child: const Text('打开弹框'),
            ),
          ),
          _Section(
            title: '确认按钮 loading — 业务成功',
            description: '点击提交后按钮进入 loading，2 秒后弹框自动关闭',
            child: ElevatedButton(
              onPressed: _showLoadingSuccess,
              child: const Text('打开弹框'),
            ),
          ),
          _Section(
            title: '确认按钮 loading — 业务失败',
            description: '点击提交后按钮进入 loading，2 秒后按钮恢复、弹框保持打开',
            child: ElevatedButton(
              onPressed: _showLoadingFailure,
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
