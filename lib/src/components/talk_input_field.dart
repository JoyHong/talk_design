import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../theme/talk_context_extensions.dart';
import '../tokens/talk_colors.dart';
import '../tokens/talk_metrics.dart';
import '../tokens/talk_typography.dart';
import 'talk_loading_indicator.dart';

// ── Shared helpers ────────────────────────────────────────────────────────────

const double _kRadius = 10.0;
const double _kSearchRadius = 28.0;
const BoxConstraints _kIconConstraints = BoxConstraints(minWidth: 0, minHeight: 0);

OutlineInputBorder _border(double radius) => OutlineInputBorder(
      borderRadius: BorderRadius.circular(radius),
      borderSide: BorderSide.none,
    );

/// 文本输入框。
/// 规则：有焦点且有内容时在右侧显示清空图标；[isLoading] 为 true 时右侧显示加载指示器，清空图标不显示。
class TalkTextField extends StatefulWidget {
  const TalkTextField({
    this.controller,
    this.focusNode,
    this.hintText,
    this.onChanged,
    this.onSubmitted,
    this.textInputAction,
    this.isLoading = false,
    this.maxLength,
    super.key,
  });

  final TextEditingController? controller;
  final FocusNode? focusNode;
  final String? hintText;
  final ValueChanged<String>? onChanged;
  final ValueChanged<String>? onSubmitted;
  final TextInputAction? textInputAction;

  /// 为 true 时在右侧显示加载指示器，清空图标不显示。
  final bool isLoading;

  /// 最大输入字符数，为 null 时不限制。
  final int? maxLength;

  @override
  State<TalkTextField> createState() => _TalkTextFieldState();
}

class _TalkTextFieldState extends State<TalkTextField> {
  late TextEditingController _controller;
  late FocusNode _focusNode;
  bool _hasFocus = false;

  @override
  void initState() {
    super.initState();
    _controller = widget.controller ?? TextEditingController();
    _focusNode = widget.focusNode ?? FocusNode();
    _focusNode.addListener(_onFocusChange);
    _controller.addListener(_rebuild);
  }

  @override
  void didUpdateWidget(TalkTextField old) {
    super.didUpdateWidget(old);
    if (old.controller != widget.controller) {
      _controller.removeListener(_rebuild);
      if (old.controller == null) _controller.dispose();
      _controller = widget.controller ?? TextEditingController();
      _controller.addListener(_rebuild);
    }
    if (old.focusNode != widget.focusNode) {
      _focusNode.removeListener(_onFocusChange);
      if (old.focusNode == null) _focusNode.dispose();
      _focusNode = widget.focusNode ?? FocusNode();
      _focusNode.addListener(_onFocusChange);
    }
  }

  void _onFocusChange() => setState(() => _hasFocus = _focusNode.hasFocus);
  void _rebuild() => setState(() {});

  @override
  void dispose() {
    _focusNode.removeListener(_onFocusChange);
    _controller.removeListener(_rebuild);
    if (widget.controller == null) _controller.dispose();
    if (widget.focusNode == null) _focusNode.dispose();
    super.dispose();
  }

  bool get _showClear => _hasFocus && _controller.text.isNotEmpty;

  @override
  Widget build(BuildContext context) {
    final colors = context.talkColors;
    final icons = context.talkIcons;
    return TextField(
      controller: _controller,
      focusNode: _focusNode,
      cursorColor: colors.theme,
      style: TalkTypography.bodyMedium.copyWith(color: colors.textPrimary),
      textAlignVertical: TextAlignVertical.center,
      textInputAction: widget.textInputAction,
      maxLength: widget.maxLength,
      decoration: InputDecoration(
        hintText: widget.hintText,
        hintStyle: TalkTypography.bodyMedium.copyWith(color: colors.textSecondary),
        filled: true,
        fillColor: colors.inputBoxPrimary,
        border: _border(_kRadius),
        enabledBorder: _border(_kRadius),
        focusedBorder: _border(_kRadius),
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        isDense: true, // 开启紧凑模式，消除默认的最小高度和多余间距
        counterText: '',
        suffixIcon: widget.isLoading
            ? Padding(
                padding: const EdgeInsets.only(right: 16),
                child: TalkLoadingIndicator(size: 12, color: colors.textPrimary),
              )
            : _showClear
                ? MouseRegion(
                    cursor: SystemMouseCursors.click,
                    child: GestureDetector(
                      onTap: () {
                        _controller.clear();
                        widget.onChanged?.call('');
                      },
                      child: Padding(
                        padding: const EdgeInsets.only(right: 16),
                        child: SvgPicture.asset(icons.clear, width: 16, height: 16,
                            colorFilter: ColorFilter.mode(colors.textSecondary, BlendMode.srcIn)),
                      ),
                    ),
                  )
                : null,
        suffixIconConstraints: _kIconConstraints,
      ),
      onChanged: widget.onChanged,
      onSubmitted: widget.onSubmitted,
    );
  }
}

/// 密码输入框。
/// 规则：有焦点或鼠标悬浮时在右侧显示明文/密文切换图标。
class TalkPasswordField extends StatefulWidget {
  const TalkPasswordField({
    this.controller,
    this.focusNode,
    this.hintText,
    this.onChanged,
    this.onSubmitted,
    this.textInputAction,
    this.maxLength,
    super.key,
  });

  final TextEditingController? controller;
  final FocusNode? focusNode;
  final String? hintText;
  final ValueChanged<String>? onChanged;
  final ValueChanged<String>? onSubmitted;
  final TextInputAction? textInputAction;

  /// 最大输入字符数，为 null 时不限制。
  final int? maxLength;

  @override
  State<TalkPasswordField> createState() => _TalkPasswordFieldState();
}

class _TalkPasswordFieldState extends State<TalkPasswordField> {
  late TextEditingController _controller;
  late FocusNode _focusNode;
  bool _hasFocus = false;
  bool _isHovered = false;
  bool _obscure = true;

  @override
  void initState() {
    super.initState();
    _controller = widget.controller ?? TextEditingController();
    _focusNode = widget.focusNode ?? FocusNode();
    _focusNode.addListener(_onFocusChange);
  }

  @override
  void didUpdateWidget(TalkPasswordField old) {
    super.didUpdateWidget(old);
    if (old.controller != widget.controller) {
      if (old.controller == null) _controller.dispose();
      _controller = widget.controller ?? TextEditingController();
    }
    if (old.focusNode != widget.focusNode) {
      _focusNode.removeListener(_onFocusChange);
      if (old.focusNode == null) _focusNode.dispose();
      _focusNode = widget.focusNode ?? FocusNode();
      _focusNode.addListener(_onFocusChange);
    }
  }

  void _onFocusChange() => setState(() => _hasFocus = _focusNode.hasFocus);

  @override
  void dispose() {
    _focusNode.removeListener(_onFocusChange);
    if (widget.controller == null) _controller.dispose();
    if (widget.focusNode == null) _focusNode.dispose();
    super.dispose();
  }

  bool get _showToggle => _hasFocus || _isHovered;

  @override
  Widget build(BuildContext context) {
    final colors = context.talkColors;
    final icons = context.talkIcons;
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: TextField(
        controller: _controller,
        focusNode: _focusNode,
        obscureText: _obscure,
        cursorColor: colors.theme,
        style: TalkTypography.bodyMedium.copyWith(color: colors.textPrimary),
        textAlignVertical: TextAlignVertical.center,
        textInputAction: widget.textInputAction,
        maxLength: widget.maxLength,
        decoration: InputDecoration(
          hintText: widget.hintText,
          hintStyle: TalkTypography.bodyMedium.copyWith(color: colors.textSecondary),
          filled: true,
          fillColor: colors.inputBoxPrimary,
          border: _border(_kRadius),
          enabledBorder: _border(_kRadius),
          focusedBorder: _border(_kRadius),
          contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          isDense: true,
          counterText: '',
          suffixIcon: _showToggle
              ? MouseRegion(
                  cursor: SystemMouseCursors.click,
                  child: GestureDetector(
                    onTap: () => setState(() => _obscure = !_obscure),
                    child: Padding(
                      padding: const EdgeInsets.only(right: 16),
                      child: SvgPicture.asset(
                        _obscure ? icons.passwordShow : icons.passwordHide,
                        width: 20,
                        height: 20,
                        colorFilter: ColorFilter.mode(colors.textPrimary, BlendMode.srcIn),
                      ),
                    ),
                  ),
                )
              : null,
          suffixIconConstraints: _kIconConstraints,
        ),
        onChanged: widget.onChanged,
        onSubmitted: widget.onSubmitted,
      ),
    );
  }
}

/// 文本+自定义图标输入框。
/// 规则：图标始终显示，尺寸固定 20×20；提供图标点击回调。
class TalkIconTextField extends StatelessWidget {
  const TalkIconTextField({
    required this.icon,
    this.controller,
    this.focusNode,
    this.hintText,
    this.onChanged,
    this.onSubmitted,
    this.onIconTap,
    this.textInputAction,
    this.maxLength,
    super.key,
  });

  final Widget icon;
  final TextEditingController? controller;
  final FocusNode? focusNode;
  final String? hintText;
  final ValueChanged<String>? onChanged;
  final ValueChanged<String>? onSubmitted;

  /// 点击右侧图标的回调。
  final VoidCallback? onIconTap;
  final TextInputAction? textInputAction;

  /// 最大输入字符数，为 null 时不限制。
  final int? maxLength;

  @override
  Widget build(BuildContext context) {
    final colors = context.talkColors;
    return TextField(
      controller: controller,
      focusNode: focusNode,
      cursorColor: colors.theme,
      style: TalkTypography.bodyMedium.copyWith(color: colors.textPrimary),
      textAlignVertical: TextAlignVertical.center,
      textInputAction: textInputAction,
      maxLength: maxLength,
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: TalkTypography.bodyMedium.copyWith(color: colors.textSecondary),
        filled: true,
        fillColor: colors.inputBoxPrimary,
        border: _border(_kRadius),
        enabledBorder: _border(_kRadius),
        focusedBorder: _border(_kRadius),
        contentPadding: const EdgeInsets.only(left: 16, top: 16, bottom: 16),
        isDense: true,
        counterText: '',
        suffixIcon: MouseRegion(
          cursor: onIconTap != null
              ? SystemMouseCursors.click
              : SystemMouseCursors.basic,
          child: GestureDetector(
            onTap: onIconTap,
            child: Padding(
              padding: const EdgeInsets.all(8),
              child: SizedBox.square(dimension: 20, child: icon),
            ),
          ),
        ),
        suffixIconConstraints: _kIconConstraints,
      ),
      onChanged: onChanged,
      onSubmitted: onSubmitted,
    );
  }
}

/// 带过滤和高亮的下拉输入框。
///
/// - 点击箭头或输入框获焦时展开选项列表
/// - 输入内容后自动过滤选项，匹配子串以主题色高亮
/// - 点击选项后将文字填入输入框并关闭下拉
class TalkDropdownTextField extends StatefulWidget {
  const TalkDropdownTextField({
    required this.items,
    this.controller,
    this.focusNode,
    this.hintText,
    this.onChanged,
    this.onSelected,
    super.key,
  });

  final List<String> items;
  final TextEditingController? controller;
  final FocusNode? focusNode;
  final String? hintText;
  final ValueChanged<String>? onChanged;

  /// 从下拉列表选中某一项时触发。
  final ValueChanged<String>? onSelected;

  @override
  State<TalkDropdownTextField> createState() => _TalkDropdownTextFieldState();
}

class _TalkDropdownTextFieldState extends State<TalkDropdownTextField> {
  final _menuController = MenuController();
  final _anchorKey = GlobalKey();
  late TextEditingController _controller;
  late FocusNode _focusNode;
  bool _isOpen = false;
  List<String> _filtered = const [];
  double _maxMenuHeight = 240;

  @override
  void initState() {
    super.initState();
    _controller = widget.controller ?? TextEditingController();
    _focusNode = widget.focusNode ?? FocusNode();
    final q = _controller.text.toLowerCase();
    _filtered = q.isEmpty
        ? widget.items
        : widget.items.where((item) => item.toLowerCase().contains(q)).toList();
    _controller.addListener(_rebuild);
  }

  @override
  void didUpdateWidget(TalkDropdownTextField old) {
    super.didUpdateWidget(old);
    if (old.controller != widget.controller) {
      _controller.removeListener(_rebuild);
      if (old.controller == null) _controller.dispose();
      _controller = widget.controller ?? TextEditingController();
      _controller.addListener(_rebuild);
    }
    if (old.focusNode != widget.focusNode) {
      if (old.focusNode == null) _focusNode.dispose();
      _focusNode = widget.focusNode ?? FocusNode();
    }
    if (!identical(old.items, widget.items)) {
      _applyFilter(_controller.text);
    }
  }

  void _rebuild() => setState(() {});

  void _applyFilter(String query) {
    final q = query.toLowerCase();
    setState(() {
      _filtered = q.isEmpty
          ? widget.items
          : widget.items.where((item) => item.toLowerCase().contains(q)).toList();
    });
  }

  /// 测量输入框在屏幕中的位置，计算上方/下方可用空间，
  /// 取较大值作为菜单最大高度，防止菜单遮住输入框。
  void _updateMaxMenuHeight() {
    final ctx = _anchorKey.currentContext;
    if (ctx == null) return;
    final box = ctx.findRenderObject() as RenderBox?;
    if (box == null) return;
    final pos = box.localToGlobal(Offset.zero);
    final mq = MediaQuery.of(ctx);
    final screenHeight = mq.size.height - mq.viewInsets.bottom;
    const gap = 8.0; // menuAnchorOffset.dy
    final spaceBelow = screenHeight - pos.dy - box.size.height - gap;
    final spaceAbove = pos.dy - gap;
    final newMax = max(spaceBelow, spaceAbove).clamp(80.0, double.infinity);
    if ((newMax - _maxMenuHeight).abs() > 1) {
      setState(() => _maxMenuHeight = newMax);
    }
  }

  void _openMenu() {
    _updateMaxMenuHeight();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted && !_menuController.isOpen) _menuController.open();
    });
  }

  void _onTextChanged(String value) {
    _applyFilter(value);
    if (_filtered.isNotEmpty && !_menuController.isOpen) {
      _openMenu();
    } else if (_filtered.isEmpty && _menuController.isOpen) {
      _menuController.close();
    }
    widget.onChanged?.call(value);
  }

  void _onSelect(String item) {
    _controller.text = item;
    _controller.selection = TextSelection.fromPosition(TextPosition(offset: item.length));
    _menuController.close();
    _applyFilter(item);
    widget.onSelected?.call(item);
    widget.onChanged?.call(item);
  }

  @override
  void dispose() {
    _controller.removeListener(_rebuild);
    if (widget.controller == null) _controller.dispose();
    if (widget.focusNode == null) _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.talkColors;
    final icons = context.talkIcons;
    final query = _controller.text;

    return LayoutBuilder(
      key: _anchorKey,
      builder: (context, constraints) => MenuAnchor(
        controller: _menuController,
        crossAxisUnconstrained: false,
        onOpen: () => setState(() => _isOpen = true),
        onClose: () => setState(() => _isOpen = false),
        alignmentOffset: TalkMetrics.menuAnchorOffset,
        style: MenuStyle(
          // Avoid forcing a minWidth that can exceed the menu panel's incoming
          // overlay constraints (e.g. on narrow windows), which would result in
          // "NOT NORMALIZED" BoxConstraints.
          // Height is computed dynamically in _updateMaxMenuHeight() so the menu
          // never extends beyond the available space in its opening direction.
          maximumSize: WidgetStatePropertyAll(
            Size(constraints.maxWidth.isFinite ? constraints.maxWidth : 200, _maxMenuHeight),
          ),
        ),
        menuChildren: [
          for (int i = 0; i < _filtered.length; i++)
            SizedBox(
              width: constraints.maxWidth.isFinite ? constraints.maxWidth : null,
              child: _FilterMenuItem(
                label: _filtered[i],
                query: query,
                onPressed: () => _onSelect(_filtered[i]),
              ),
            ),
        ],
        builder: (context, controller, _) => TextField(
          controller: _controller,
          focusNode: _focusNode,
          cursorColor: colors.theme,
          style: TalkTypography.bodyMedium.copyWith(color: colors.textPrimary),
          textAlignVertical: TextAlignVertical.center,
          decoration: InputDecoration(
            hintText: widget.hintText,
            hintStyle: TalkTypography.bodyMedium.copyWith(color: colors.textSecondary),
            filled: true,
            fillColor: colors.inputBoxPrimary,
            border: _border(_kRadius),
            enabledBorder: _border(_kRadius),
            focusedBorder: _border(_kRadius),
            contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            isDense: true,
            suffixIcon: MouseRegion(
              cursor: SystemMouseCursors.click,
              child: GestureDetector(
                onTap: () => _menuController.isOpen ? _menuController.close() : _openMenu(),
                child: Padding(
                  padding: const EdgeInsets.only(right: 16),
                  child: AnimatedRotation(
                    turns: _isOpen ? 0.5 : 0,
                    duration: const Duration(milliseconds: 150),
                    child: SvgPicture.asset(
                      icons.arrowDown,
                      width: 16,
                      height: 16,
                      colorFilter: ColorFilter.mode(colors.textPrimary, BlendMode.srcIn),
                    ),
                  ),
                ),
              ),
            ),
            suffixIconConstraints: _kIconConstraints,
          ),
          onChanged: _onTextChanged,
          onTap: () {
            _applyFilter(_controller.text);
            _openMenu();
          },
        ),
      ),
    );
  }
}

class _FilterMenuItem extends StatelessWidget {
  const _FilterMenuItem({
    required this.label,
    required this.query,
    required this.onPressed,
  });

  final String label;
  final String query;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    final colors = context.talkColors;
    return MenuItemButton(
      onPressed: onPressed,
      child: _buildText(label, query, colors),
    );
  }

  Widget _buildText(String text, String query, TalkColors colors) {
    if (query.isEmpty) return Text(text);
    final lowerText = text.toLowerCase();
    final lowerQuery = query.toLowerCase();
    final idx = lowerText.indexOf(lowerQuery);
    if (idx < 0) return Text(text);
    return RichText(
      text: TextSpan(
        style: TalkTypography.bodyMedium.copyWith(color: colors.textPrimary),
        children: [
          if (idx > 0) TextSpan(text: text.substring(0, idx)),
          TextSpan(
            text: text.substring(idx, idx + query.length),
            style: TalkTypography.bodyMedium.copyWith(color: colors.theme),
          ),
          if (idx + query.length < text.length)
            TextSpan(text: text.substring(idx + query.length)),
        ],
      ),
    );
  }
}

/// 搜索输入框。
/// 规则：左侧搜索图标始终显示；有焦点且有内容时在右侧显示清空图标。
class TalkSearchField extends StatefulWidget {
  const TalkSearchField({
    this.controller,
    this.focusNode,
    this.hintText,
    this.onChanged,
    this.onSubmitted,
    this.textInputAction = TextInputAction.search,
    super.key,
  });

  final TextEditingController? controller;
  final FocusNode? focusNode;
  final String? hintText;
  final ValueChanged<String>? onChanged;
  final ValueChanged<String>? onSubmitted;
  final TextInputAction? textInputAction;

  @override
  State<TalkSearchField> createState() => _TalkSearchFieldState();
}

class _TalkSearchFieldState extends State<TalkSearchField> {
  late TextEditingController _controller;
  late FocusNode _focusNode;
  bool _hasFocus = false;

  @override
  void initState() {
    super.initState();
    _controller = widget.controller ?? TextEditingController();
    _focusNode = widget.focusNode ?? FocusNode();
    _focusNode.addListener(_onFocusChange);
    _controller.addListener(_rebuild);
  }

  @override
  void didUpdateWidget(TalkSearchField old) {
    super.didUpdateWidget(old);
    if (old.controller != widget.controller) {
      _controller.removeListener(_rebuild);
      if (old.controller == null) _controller.dispose();
      _controller = widget.controller ?? TextEditingController();
      _controller.addListener(_rebuild);
    }
    if (old.focusNode != widget.focusNode) {
      _focusNode.removeListener(_onFocusChange);
      if (old.focusNode == null) _focusNode.dispose();
      _focusNode = widget.focusNode ?? FocusNode();
      _focusNode.addListener(_onFocusChange);
    }
  }

  void _onFocusChange() => setState(() => _hasFocus = _focusNode.hasFocus);
  void _rebuild() => setState(() {});

  @override
  void dispose() {
    _focusNode.removeListener(_onFocusChange);
    _controller.removeListener(_rebuild);
    if (widget.controller == null) _controller.dispose();
    if (widget.focusNode == null) _focusNode.dispose();
    super.dispose();
  }

  bool get _showClear => _hasFocus && _controller.text.isNotEmpty;

  @override
  Widget build(BuildContext context) {
    final colors = context.talkColors;
    final icons = context.talkIcons;
    return TextField(
      controller: _controller,
      focusNode: _focusNode,
      cursorColor: colors.theme,
      style: TalkTypography.bodyMedium.copyWith(color: colors.textPrimary),
      textAlignVertical: TextAlignVertical.center,
      textInputAction: widget.textInputAction,
      decoration: InputDecoration(
        hintText: widget.hintText,
        hintStyle: TalkTypography.bodyMedium.copyWith(color: colors.textSecondary),
        filled: true,
        fillColor: colors.inputBoxPrimary,
        border: _border(_kSearchRadius),
        enabledBorder: _border(_kSearchRadius),
        focusedBorder: _border(_kSearchRadius),
        contentPadding: const EdgeInsets.symmetric(vertical: 10),
        isDense: true,
        prefixIcon: Padding(
          padding: const EdgeInsets.fromLTRB(16, 10, 4, 10),
          child: SvgPicture.asset(icons.search, width: 20, height: 20,
              colorFilter: ColorFilter.mode(colors.textSecondary, BlendMode.srcIn)),
        ),
        prefixIconConstraints: _kIconConstraints,
        suffixIcon: _showClear
            ? MouseRegion(
                cursor: SystemMouseCursors.click,
                child: GestureDetector(
                  onTap: () {
                      _controller.clear();
                      widget.onChanged?.call('');
                    },
                  child: Padding(
                    padding: const EdgeInsets.only(right: 12),
                    child: SvgPicture.asset(icons.clear, width: 16, height: 16,
                        colorFilter: ColorFilter.mode(colors.textSecondary, BlendMode.srcIn)),
                  ),
                ),
              )
            : null,
        suffixIconConstraints: _kIconConstraints,
      ),
      onChanged: widget.onChanged,
      onSubmitted: widget.onSubmitted,
    );
  }
}
