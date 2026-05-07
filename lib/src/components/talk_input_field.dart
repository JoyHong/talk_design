import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../theme/talk_context_extensions.dart';
import '../tokens/talk_icons.dart';
import '../tokens/talk_typography.dart';

// ── Shared helpers ────────────────────────────────────────────────────────────

const double _kRadius = 10.0;
const double _kSearchRadius = 28.0;
const BoxConstraints _kIconConstraints = BoxConstraints(minWidth: 0, minHeight: 0);

OutlineInputBorder _border(double radius) => OutlineInputBorder(
      borderRadius: BorderRadius.circular(radius),
      borderSide: BorderSide.none,
    );

/// 文本输入框。
/// 规则：有焦点且有内容时在右侧显示清空图标；否则不显示。
class TalkTextField extends StatefulWidget {
  const TalkTextField({
    this.controller,
    this.focusNode,
    this.hintText,
    this.onChanged,
    this.onSubmitted,
    this.textInputAction,
    super.key,
  });

  final TextEditingController? controller;
  final FocusNode? focusNode;
  final String? hintText;
  final ValueChanged<String>? onChanged;
  final ValueChanged<String>? onSubmitted;
  final TextInputAction? textInputAction;

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
    return TextField(
      controller: _controller,
      focusNode: _focusNode,
      cursorColor: colors.theme,
      style: TalkTypography.bodyMedium.copyWith(color: colors.textPrimary),
      textInputAction: widget.textInputAction,
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
        suffixIcon: _showClear
            ? MouseRegion(
                cursor: SystemMouseCursors.click,
                child: GestureDetector(
                  onTap: () => _controller.clear(),
                  child: Padding(
                    padding: const EdgeInsets.only(right: 16),
                    child: SvgPicture.asset(TalkIcons.clear, width: 16, height: 16,
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
    super.key,
  });

  final TextEditingController? controller;
  final FocusNode? focusNode;
  final String? hintText;
  final ValueChanged<String>? onChanged;
  final ValueChanged<String>? onSubmitted;
  final TextInputAction? textInputAction;

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
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: TextField(
        controller: _controller,
        focusNode: _focusNode,
        obscureText: _obscure,
        cursorColor: colors.theme,
        style: TalkTypography.bodyMedium.copyWith(color: colors.textPrimary),
        textInputAction: widget.textInputAction,
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
          suffixIcon: _showToggle
              ? MouseRegion(
                  cursor: SystemMouseCursors.click,
                  child: GestureDetector(
                    onTap: () => setState(() => _obscure = !_obscure),
                    child: Padding(
                      padding: const EdgeInsets.only(right: 16),
                      child: SvgPicture.asset(
                        _obscure ? TalkIcons.passwordShow : TalkIcons.passwordHide,
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

  @override
  Widget build(BuildContext context) {
    final colors = context.talkColors;
    return TextField(
      controller: controller,
      focusNode: focusNode,
      cursorColor: colors.theme,
      style: TalkTypography.bodyMedium.copyWith(color: colors.textPrimary),
      textInputAction: textInputAction,
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

/// 下拉输入框。
/// 规则：箭头图标随下拉状态自动更新；提供 [onDropdownToggle] 回调供外部实现下拉逻辑。
class TalkDropdownTextField extends StatefulWidget {
  const TalkDropdownTextField({
    this.controller,
    this.focusNode,
    this.hintText,
    this.onChanged,
    this.onSubmitted,
    this.onDropdownToggle,
    this.initialIsDropdown = false,
    this.textInputAction,
    super.key,
  });

  final TextEditingController? controller;
  final FocusNode? focusNode;
  final String? hintText;
  final ValueChanged<String>? onChanged;
  final ValueChanged<String>? onSubmitted;

  /// 箭头图标被点击后的回调，参数为切换后的新下拉状态。
  final ValueChanged<bool>? onDropdownToggle;

  /// 初始下拉状态，默认为 false（收起）。
  final bool initialIsDropdown;
  final TextInputAction? textInputAction;

  @override
  State<TalkDropdownTextField> createState() => _TalkDropdownTextFieldState();
}

class _TalkDropdownTextFieldState extends State<TalkDropdownTextField> {
  late bool _isDropdown;

  @override
  void initState() {
    super.initState();
    _isDropdown = widget.initialIsDropdown;
  }

  void _toggleDropdown() {
    setState(() => _isDropdown = !_isDropdown);
    widget.onDropdownToggle?.call(_isDropdown);
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.talkColors;
    return TextField(
      controller: widget.controller,
      focusNode: widget.focusNode,
      cursorColor: colors.theme,
      style: TalkTypography.bodyMedium.copyWith(color: colors.textPrimary),
      textInputAction: widget.textInputAction,
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
            onTap: _toggleDropdown,
            child: Padding(
              padding: const EdgeInsets.only(right: 16),
              child: AnimatedRotation(
                turns: _isDropdown ? 0.5 : 0,
                duration: const Duration(milliseconds: 150),
                child: SvgPicture.asset(
                  TalkIcons.arrowDown,
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
      onChanged: widget.onChanged,
      onSubmitted: widget.onSubmitted,
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
    return TextField(
      controller: _controller,
      focusNode: _focusNode,
      cursorColor: colors.theme,
      style: TalkTypography.bodyMedium.copyWith(color: colors.textPrimary),
      textInputAction: widget.textInputAction,
      decoration: InputDecoration(
        hintText: widget.hintText,
        hintStyle: TalkTypography.bodyMedium.copyWith(color: colors.textSecondary),
        filled: true,
        fillColor: colors.inputBoxPrimary,
        border: _border(_kSearchRadius),
        enabledBorder: _border(_kSearchRadius),
        focusedBorder: _border(_kSearchRadius),
        contentPadding: EdgeInsets.zero,
        isDense: true,
        prefixIcon: Padding(
          padding: const EdgeInsets.fromLTRB(16, 10, 4, 10),
          child: SvgPicture.asset(TalkIcons.search, width: 20, height: 20,
              colorFilter: ColorFilter.mode(colors.textSecondary, BlendMode.srcIn)),
        ),
        prefixIconConstraints: _kIconConstraints,
        suffixIcon: _showClear
            ? MouseRegion(
                cursor: SystemMouseCursors.click,
                child: GestureDetector(
                  onTap: () => _controller.clear(),
                  child: Padding(
                    padding: const EdgeInsets.only(right: 12),
                    child: SvgPicture.asset(TalkIcons.clear, width: 16, height: 16,
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
