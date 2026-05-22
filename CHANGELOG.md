# Changelog

## 1.0.3

### 新增

- **TalkButton** — 新增 `TalkButton.back()` 变体，点击后自动调用 `Navigator.pop(context)` 完成返回导航。
- **TalkIcons** — 新增 47 个 SVG 图标 token，并在 example 中提供图标预览页面。
- **TalkFilterDropdownField** — 新增支持关键字过滤的下拉选择框组件，替代原 `TalkDropdownTextField`。

### 修复

- **TalkTextField / TalkSearchField** — 点击清除按钮时正确触发 `onChanged` 回调。

---

## 1.0.2

### 新增

- **TalkButton** — `TalkButton.themeIcon` 新增 `buttonSize` 参数，强制约束图标尺寸。

### 修复

- **TalkLoadingIndicator** — 加载指示器描边改为向内对齐，修正描边溢出边界的问题。

---

## 1.0.1

### 新增

- **TalkListItem** — `TalkListButtonItem` 和 `TalkAvatarButtonItem` 新增可选参数 `buttonIcon`（Widget）；提供时图标以 18 × 18 px 尺寸渲染，与按钮文字之间保持 8 px 间距。

### 破坏性变更

- **`TalkButton`** — 移除 `inDialog` 属性；需要对话框内 1px 边框效果的调用方请直接使用 `strokeThemeCustom` / `strokeSecondaryCustom` 变体。
- **`TalkColors`** — `listCardMenuFloating` 已重命名为 `listCardMenuHovered`，请更新直接引用该 token 的代码。

---

## 1.0.0

首个正式版本，完整的 JusTalk Flutter 设计系统。

### Design Tokens

- **TalkColors** — 17 个浅色主题颜色 token，含 6 个语义消息气泡颜色；作为 `ThemeExtension` 集成到主题
- **TalkTypography** — 与 Figma 规格对齐的文字样式 token 类，含 `BodyLarge2` 等级别
- **TalkSpacing / TalkMetrics** — 间距、圆角和布局常量（含 `contentPaddingMin`、`contentMaxWidth`）
- **TalkShadows** — 卡片与弹窗的 `BoxShadow` 预设
- **TalkAvatars** — 基于 UID 的默认头像选择 token
- **SVG 图标 token** — 统一的 SVG 图标引用，含关闭图标

### Components

- **TalkButton** — 完整按钮组件，支持 8 种变体（`fillTheme`、`fillThemeCustom`、`strokeTheme`、`strokeThemeCustom`、`strokeSecondaryCustom` 等）、loading 状态、固定/自适应/填充尺寸，以及对话框内 1px 边框模式
- **TalkTextField** — 带 loading 状态的输入框组件
- **TalkLoadingIndicator** — 通用加载指示器，接受任意 `double` 尺寸
- **TalkToast** — 仅通过 overlay API 展示的 Toast，SVG 图标驱动
- **`showTalkDialog`** — 函数式对话框 API，支持 `onConfirmAsync` 异步确认 loading 状态，关闭由调用方控制
- **TalkCheckbox** — 复选框组件

### Theme

- `TalkTheme.light()` — 将全部 token 与组件样式组装为 `ThemeData`，启用 Material 3
- `BuildContext` 扩展 — `talkColors`、`talkButtonStyles`、`talkInputStyles` 快捷访问器
- 内置 Roboto 字体（400 / 500 / 700），保证跨平台一致性
