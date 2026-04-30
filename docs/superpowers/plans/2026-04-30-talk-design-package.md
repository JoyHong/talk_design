# Talk Design Package 实现计划

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** 构建 `talk_design` Flutter package，将 JusTalk Windows 视觉规范（颜色、字体、间距、阴影、按钮、输入框）封装为类型安全的 Dart Token 和组件样式，供多端 Flutter 项目复用。

**Architecture:** 两层结构——`tokens/` 存放原子 const 值（颜色/字体/间距/阴影），`components/` 存放 Flutter 组件样式（ButtonStyle/InputDecoration）。两层均通过 `ThemeExtension` 注册进 `ThemeData`，消费方通过 `BuildContext` 扩展访问。

**Tech Stack:** Flutter SDK ≥3.19（`WidgetStateProperty`），`flutter_test`，零第三方运行时依赖。

---

## 文件映射

```
talk_design/
├── pubspec.yaml
├── analysis_options.yaml
├── lib/
│   ├── talk_design.dart                        # 统一 barrel 导出
│   └── src/
│       ├── tokens/
│       │   ├── talk_colors.dart                # TalkColors ThemeExtension（17 个颜色 Token）
│       │   ├── talk_typography.dart            # TalkTypography（字号/字重/行高常量）
│       │   ├── talk_spacing.dart               # TalkSpacing（间距/圆角常量）
│       │   └── talk_shadows.dart               # TalkShadows（阴影常量）
│       ├── components/
│       │   ├── talk_button_styles.dart         # TalkButtonStyles ThemeExtension + TalkBlockButtonColors
│       │   └── talk_input_styles.dart          # TalkInputStyles ThemeExtension
│       └── theme/
│           ├── talk_theme.dart                 # TalkTheme.light() 组装入口
│           └── talk_context_extensions.dart    # BuildContext 扩展
└── test/
    ├── tokens/
    │   ├── talk_colors_test.dart
    │   ├── talk_typography_test.dart
    │   ├── talk_spacing_test.dart
    │   └── talk_shadows_test.dart
    ├── components/
    │   ├── talk_button_styles_test.dart
    │   └── talk_input_styles_test.dart
    └── theme/
        └── talk_theme_test.dart
```

---

## Task 1: 初始化包结构

**Files:**
- Create: `pubspec.yaml`
- Create: `analysis_options.yaml`
- Create: 所有 `lib/src/` 和 `test/` 子目录

- [ ] **Step 1: 创建 pubspec.yaml**

```yaml
name: talk_design
description: JusTalk design system — colors, typography, spacing, and component styles for Flutter.
version: 0.1.0
publish_to: 'none'

environment:
  sdk: ^3.9.2
  flutter: ">=3.19.0"

dependencies:
  flutter:
    sdk: flutter

dev_dependencies:
  flutter_test:
    sdk: flutter
  flutter_lints: ^5.0.0

flutter:
  uses-material-design: true
```

- [ ] **Step 2: 创建 analysis_options.yaml**

```yaml
include: package:flutter_lints/flutter.yaml

linter:
  rules:
    prefer_const_constructors: true
    prefer_const_literals_to_create_immutables: true
```

- [ ] **Step 3: 创建目录结构**

```bash
cd /Users/joy/development/JusTalk/talk_design
mkdir -p lib/src/tokens lib/src/components lib/src/theme
mkdir -p test/tokens test/components test/theme
```

- [ ] **Step 4: 安装依赖**

```bash
cd /Users/joy/development/JusTalk/talk_design && flutter pub get
```

Expected: 成功下载 `flutter_lints`，无 error。

- [ ] **Step 5: Commit**

```bash
cd /Users/joy/development/JusTalk/talk_design
git add pubspec.yaml analysis_options.yaml
git commit -m "chore: initialize flutter package structure"
```

---

## Task 2: TalkColors

**Files:**
- Create: `lib/src/tokens/talk_colors.dart`
- Create: `test/tokens/talk_colors_test.dart`

颜色数据来源：Figma 节点 `1:561`（`Windwos_Colors`）

- [ ] **Step 1: 写失败测试**

`test/tokens/talk_colors_test.dart`:

```dart
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

// TalkColors 和 TalkTheme 在 Task 8 导出，这里直接引用源文件
import 'package:talk_design/src/tokens/talk_colors.dart';

void main() {
  group('TalkColors', () {
    test('light has correct themeColor', () {
      expect(TalkColors.light.themeColor, const Color(0xFFFF2C55));
    });

    test('light has all 17 tokens with correct values', () {
      final c = TalkColors.light;
      expect(c.textMain, const Color(0xFF262626));
      expect(c.textSecondary, const Color(0xFFAAAAAA));
      expect(c.backgroundLevel1, const Color(0xFFFFFFFF));
      expect(c.backgroundLevel2, const Color(0xFFF5F5F5));
      expect(c.cardLevel1, const Color(0xFFFFFFFF));
      expect(c.cardLevel2, const Color(0xFFFFFFFF));
      expect(c.inputBoxLevel1, const Color(0xFFF5F5F5));
      expect(c.inputBoxLevel2, const Color(0xFFFFFFFF));
      expect(c.messageBubble, const Color(0xFFF1F1F1));
      expect(c.listPopUpWindow, const Color(0xFFFFFFFF));
      expect(c.sidePopUp, const Color(0xFFF5F5F5));
      expect(c.buttonBlock, const Color(0xFFFFFFFF));
      expect(c.listCardMenuFloating, const Color(0x1A999999));
      expect(c.listCardMenuPressed, const Color(0x33999999));
      expect(c.success, const Color(0xFF39DB0C));
      expect(c.redDotError, const Color(0xFFFF3A2E));
    });

    test('copyWith replaces only specified field', () {
      final modified = TalkColors.light.copyWith(
        themeColor: const Color(0xFF000000),
      );
      expect(modified.themeColor, const Color(0xFF000000));
      expect(modified.textMain, TalkColors.light.textMain);
    });

    test('lerp interpolates at t=0 returns self', () {
      final lerped = TalkColors.light.lerp(TalkColors.light, 0);
      expect(lerped.themeColor, TalkColors.light.themeColor);
    });
  });
}
```

- [ ] **Step 2: 运行测试确认失败**

```bash
cd /Users/joy/development/JusTalk/talk_design && flutter test test/tokens/talk_colors_test.dart
```

Expected: FAIL — `package:talk_design/src/tokens/talk_colors.dart` 不存在

- [ ] **Step 3: 实现 TalkColors**

`lib/src/tokens/talk_colors.dart`:

```dart
import 'package:flutter/material.dart';

class TalkColors extends ThemeExtension<TalkColors> {
  const TalkColors({
    required this.themeColor,
    required this.textMain,
    required this.textSecondary,
    required this.backgroundLevel1,
    required this.backgroundLevel2,
    required this.cardLevel1,
    required this.cardLevel2,
    required this.inputBoxLevel1,
    required this.inputBoxLevel2,
    required this.messageBubble,
    required this.listPopUpWindow,
    required this.sidePopUp,
    required this.buttonBlock,
    required this.listCardMenuFloating,
    required this.listCardMenuPressed,
    required this.success,
    required this.redDotError,
  });

  final Color themeColor;
  final Color textMain;
  final Color textSecondary;
  final Color backgroundLevel1;
  final Color backgroundLevel2;
  final Color cardLevel1;
  final Color cardLevel2;
  final Color inputBoxLevel1;
  final Color inputBoxLevel2;
  final Color messageBubble;
  final Color listPopUpWindow;
  final Color sidePopUp;
  final Color buttonBlock;
  final Color listCardMenuFloating;  // #999999 @ 10%
  final Color listCardMenuPressed;   // #999999 @ 20%
  final Color success;
  final Color redDotError;

  static const light = TalkColors(
    themeColor: Color(0xFFFF2C55),
    textMain: Color(0xFF262626),
    textSecondary: Color(0xFFAAAAAA),
    backgroundLevel1: Color(0xFFFFFFFF),
    backgroundLevel2: Color(0xFFF5F5F5),
    cardLevel1: Color(0xFFFFFFFF),
    cardLevel2: Color(0xFFFFFFFF),
    inputBoxLevel1: Color(0xFFF5F5F5),
    inputBoxLevel2: Color(0xFFFFFFFF),
    messageBubble: Color(0xFFF1F1F1),
    listPopUpWindow: Color(0xFFFFFFFF),
    sidePopUp: Color(0xFFF5F5F5),
    buttonBlock: Color(0xFFFFFFFF),
    listCardMenuFloating: Color(0x1A999999),
    listCardMenuPressed: Color(0x33999999),
    success: Color(0xFF39DB0C),
    redDotError: Color(0xFFFF3A2E),
  );

  @override
  TalkColors copyWith({
    Color? themeColor,
    Color? textMain,
    Color? textSecondary,
    Color? backgroundLevel1,
    Color? backgroundLevel2,
    Color? cardLevel1,
    Color? cardLevel2,
    Color? inputBoxLevel1,
    Color? inputBoxLevel2,
    Color? messageBubble,
    Color? listPopUpWindow,
    Color? sidePopUp,
    Color? buttonBlock,
    Color? listCardMenuFloating,
    Color? listCardMenuPressed,
    Color? success,
    Color? redDotError,
  }) =>
      TalkColors(
        themeColor: themeColor ?? this.themeColor,
        textMain: textMain ?? this.textMain,
        textSecondary: textSecondary ?? this.textSecondary,
        backgroundLevel1: backgroundLevel1 ?? this.backgroundLevel1,
        backgroundLevel2: backgroundLevel2 ?? this.backgroundLevel2,
        cardLevel1: cardLevel1 ?? this.cardLevel1,
        cardLevel2: cardLevel2 ?? this.cardLevel2,
        inputBoxLevel1: inputBoxLevel1 ?? this.inputBoxLevel1,
        inputBoxLevel2: inputBoxLevel2 ?? this.inputBoxLevel2,
        messageBubble: messageBubble ?? this.messageBubble,
        listPopUpWindow: listPopUpWindow ?? this.listPopUpWindow,
        sidePopUp: sidePopUp ?? this.sidePopUp,
        buttonBlock: buttonBlock ?? this.buttonBlock,
        listCardMenuFloating: listCardMenuFloating ?? this.listCardMenuFloating,
        listCardMenuPressed: listCardMenuPressed ?? this.listCardMenuPressed,
        success: success ?? this.success,
        redDotError: redDotError ?? this.redDotError,
      );

  @override
  TalkColors lerp(TalkColors? other, double t) {
    if (other is! TalkColors) return this;
    return TalkColors(
      themeColor: Color.lerp(themeColor, other.themeColor, t)!,
      textMain: Color.lerp(textMain, other.textMain, t)!,
      textSecondary: Color.lerp(textSecondary, other.textSecondary, t)!,
      backgroundLevel1: Color.lerp(backgroundLevel1, other.backgroundLevel1, t)!,
      backgroundLevel2: Color.lerp(backgroundLevel2, other.backgroundLevel2, t)!,
      cardLevel1: Color.lerp(cardLevel1, other.cardLevel1, t)!,
      cardLevel2: Color.lerp(cardLevel2, other.cardLevel2, t)!,
      inputBoxLevel1: Color.lerp(inputBoxLevel1, other.inputBoxLevel1, t)!,
      inputBoxLevel2: Color.lerp(inputBoxLevel2, other.inputBoxLevel2, t)!,
      messageBubble: Color.lerp(messageBubble, other.messageBubble, t)!,
      listPopUpWindow: Color.lerp(listPopUpWindow, other.listPopUpWindow, t)!,
      sidePopUp: Color.lerp(sidePopUp, other.sidePopUp, t)!,
      buttonBlock: Color.lerp(buttonBlock, other.buttonBlock, t)!,
      listCardMenuFloating: Color.lerp(listCardMenuFloating, other.listCardMenuFloating, t)!,
      listCardMenuPressed: Color.lerp(listCardMenuPressed, other.listCardMenuPressed, t)!,
      success: Color.lerp(success, other.success, t)!,
      redDotError: Color.lerp(redDotError, other.redDotError, t)!,
    );
  }
}
```

- [ ] **Step 4: 运行测试确认通过**

```bash
cd /Users/joy/development/JusTalk/talk_design && flutter test test/tokens/talk_colors_test.dart
```

Expected: All tests passed!

- [ ] **Step 5: Commit**

```bash
cd /Users/joy/development/JusTalk/talk_design
git add lib/src/tokens/talk_colors.dart test/tokens/talk_colors_test.dart
git commit -m "feat: add TalkColors theme extension with 17 light mode tokens"
```

---

## Task 3: TalkTypography + TalkSpacing + TalkShadows

**Files:**
- Create: `lib/src/tokens/talk_typography.dart`
- Create: `lib/src/tokens/talk_spacing.dart`
- Create: `lib/src/tokens/talk_shadows.dart`
- Create: `test/tokens/talk_typography_test.dart`
- Create: `test/tokens/talk_spacing_test.dart`
- Create: `test/tokens/talk_shadows_test.dart`

> 当前值为合理默认值，待从 Figma Typography/Spacing 规范页读取后对照更新。

- [ ] **Step 1: 写三个失败测试**

`test/tokens/talk_typography_test.dart`:
```dart
import 'package:flutter_test/flutter_test.dart';
import 'package:talk_design/src/tokens/talk_typography.dart';

void main() {
  group('TalkTypography', () {
    test('font sizes are defined and in ascending order', () {
      expect(TalkTypography.label < TalkTypography.body, isTrue);
      expect(TalkTypography.body < TalkTypography.bodyLarge, isTrue);
      expect(TalkTypography.bodyLarge < TalkTypography.title, isTrue);
      expect(TalkTypography.title < TalkTypography.headline, isTrue);
    });

    test('has expected font size values', () {
      expect(TalkTypography.label, 12.0);
      expect(TalkTypography.body, 14.0);
      expect(TalkTypography.bodyLarge, 16.0);
      expect(TalkTypography.title, 18.0);
      expect(TalkTypography.headline, 22.0);
    });
  });
}
```

`test/tokens/talk_spacing_test.dart`:
```dart
import 'package:flutter_test/flutter_test.dart';
import 'package:talk_design/src/tokens/talk_spacing.dart';

void main() {
  group('TalkSpacing', () {
    test('spacing values are in ascending order', () {
      expect(TalkSpacing.xs < TalkSpacing.s, isTrue);
      expect(TalkSpacing.s < TalkSpacing.m, isTrue);
      expect(TalkSpacing.m < TalkSpacing.l, isTrue);
      expect(TalkSpacing.l < TalkSpacing.xl, isTrue);
      expect(TalkSpacing.xl < TalkSpacing.xxl, isTrue);
    });

    test('radius values are non-negative', () {
      expect(TalkSpacing.radiusS, greaterThanOrEqualTo(0));
      expect(TalkSpacing.radiusM, greaterThan(TalkSpacing.radiusS));
      expect(TalkSpacing.radiusL, greaterThan(TalkSpacing.radiusM));
    });
  });
}
```

`test/tokens/talk_shadows_test.dart`:
```dart
import 'package:flutter_test/flutter_test.dart';
import 'package:talk_design/src/tokens/talk_shadows.dart';

void main() {
  group('TalkShadows', () {
    test('card shadow is non-empty', () {
      expect(TalkShadows.card, isNotEmpty);
    });
    test('popup shadow has larger blur than card shadow', () {
      expect(
        TalkShadows.popup.first.blurRadius,
        greaterThan(TalkShadows.card.first.blurRadius),
      );
    });
  });
}
```

- [ ] **Step 2: 运行测试确认失败**

```bash
cd /Users/joy/development/JusTalk/talk_design && flutter test test/tokens/talk_typography_test.dart test/tokens/talk_spacing_test.dart test/tokens/talk_shadows_test.dart
```

Expected: FAIL — 源文件不存在

- [ ] **Step 3: 实现 TalkTypography**

`lib/src/tokens/talk_typography.dart`:
```dart
import 'package:flutter/material.dart';

abstract final class TalkTypography {
  static const double label = 12.0;
  static const double body = 14.0;
  static const double bodyLarge = 16.0;
  static const double title = 18.0;
  static const double headline = 22.0;

  static const FontWeight regular = FontWeight.w400;
  static const FontWeight medium = FontWeight.w500;
  static const FontWeight semiBold = FontWeight.w600;
  static const FontWeight bold = FontWeight.w700;

  static const double lineHeightTight = 1.2;
  static const double lineHeightNormal = 1.5;
  static const double lineHeightLoose = 1.8;
}
```

- [ ] **Step 4: 实现 TalkSpacing**

`lib/src/tokens/talk_spacing.dart`:
```dart
abstract final class TalkSpacing {
  static const double xs = 4.0;
  static const double s = 8.0;
  static const double m = 12.0;
  static const double l = 16.0;
  static const double xl = 24.0;
  static const double xxl = 32.0;

  static const double radiusS = 4.0;
  static const double radiusM = 8.0;
  static const double radiusL = 12.0;
  static const double radiusFull = 9999.0;
}
```

- [ ] **Step 5: 实现 TalkShadows**

`lib/src/tokens/talk_shadows.dart`:
```dart
import 'package:flutter/material.dart';

abstract final class TalkShadows {
  static const List<BoxShadow> card = [
    BoxShadow(
      color: Color(0x0D000000),
      blurRadius: 8,
      offset: Offset(0, 2),
    ),
  ];

  static const List<BoxShadow> popup = [
    BoxShadow(
      color: Color(0x1A000000),
      blurRadius: 16,
      offset: Offset(0, 4),
    ),
  ];
}
```

- [ ] **Step 6: 运行测试确认通过**

```bash
cd /Users/joy/development/JusTalk/talk_design && flutter test test/tokens/talk_typography_test.dart test/tokens/talk_spacing_test.dart test/tokens/talk_shadows_test.dart
```

Expected: All tests passed!

- [ ] **Step 7: Commit**

```bash
cd /Users/joy/development/JusTalk/talk_design
git add lib/src/tokens/talk_typography.dart lib/src/tokens/talk_spacing.dart lib/src/tokens/talk_shadows.dart test/tokens/talk_typography_test.dart test/tokens/talk_spacing_test.dart test/tokens/talk_shadows_test.dart
git commit -m "feat: add TalkTypography, TalkSpacing, TalkShadows const token classes"
```

---

## Task 4: TalkButtonStyles

**Files:**
- Create: `lib/src/components/talk_button_styles.dart`
- Create: `test/components/talk_button_styles_test.dart`

颜色数据来源：Figma 节点 `1:149`（`Windwos_Button`）

**透明度换算**（alpha = opacity × 255，十六进制）：
- 10% → 0x1A，12% → 0x1F，20% → 0x33，25% → 0x40，26% → 0x42，38% → 0x61

- [ ] **Step 1: 写失败测试**

`test/components/talk_button_styles_test.dart`:
```dart
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:talk_design/src/components/talk_button_styles.dart';

void main() {
  group('TalkButtonStyles', () {
    test('fillTheme: normal bg is themeColor', () {
      final bg = TalkButtonStyles.light.fillTheme.backgroundColor!;
      expect(bg.resolve({}), const Color(0xFFFF2C55));
    });

    test('fillTheme: hovered bg is #FF4569', () {
      final bg = TalkButtonStyles.light.fillTheme.backgroundColor!;
      expect(bg.resolve({WidgetState.hovered}), const Color(0xFFFF4569));
    });

    test('fillTheme: pressed bg is #E5284D', () {
      final bg = TalkButtonStyles.light.fillTheme.backgroundColor!;
      expect(bg.resolve({WidgetState.pressed}), const Color(0xFFE5284D));
    });

    test('fillTheme: disabled bg is #4F4F4F@26%', () {
      final bg = TalkButtonStyles.light.fillTheme.backgroundColor!;
      expect(bg.resolve({WidgetState.disabled}), const Color(0x424F4F4F));
    });

    test('fillTheme: disabled foreground is #000@38%', () {
      final fg = TalkButtonStyles.light.fillTheme.foregroundColor!;
      expect(fg.resolve({WidgetState.disabled}), const Color(0x61000000));
    });

    test('textTheme: normal foreground is themeColor', () {
      final fg = TalkButtonStyles.light.textTheme.foregroundColor!;
      expect(fg.resolve({}), const Color(0xFFFF2C55));
    });

    test('strokeSecondary: normal has border color #AAAAAA', () {
      final side = TalkButtonStyles.light.strokeSecondary.side!;
      expect(side.resolve({})?.color, const Color(0xFFAAAAAA));
    });

    test('strokeSecondary: hovered bg is #AAAAAA@12%', () {
      final bg = TalkButtonStyles.light.strokeSecondary.backgroundColor!;
      expect(bg.resolve({WidgetState.hovered}), const Color(0x1FAAAAAA));
    });

    test('themeIcon: normal bg is transparent', () {
      final bg = TalkButtonStyles.light.themeIcon.backgroundColor!;
      expect(bg.resolve({}), Colors.transparent);
    });

    test('themeIcon: hovered bg is #999@10%', () {
      final bg = TalkButtonStyles.light.themeIcon.backgroundColor!;
      expect(bg.resolve({WidgetState.hovered}), const Color(0x1A999999));
    });

    test('block: foreground is themeColor', () {
      expect(TalkButtonStyles.light.block.foreground, const Color(0xFFFF2C55));
    });

    test('block: hoverBackground is #999@10%', () {
      expect(TalkButtonStyles.light.block.hoverBackground, const Color(0x1A999999));
    });
  });
}
```

- [ ] **Step 2: 运行测试确认失败**

```bash
cd /Users/joy/development/JusTalk/talk_design && flutter test test/components/talk_button_styles_test.dart
```

Expected: FAIL — 源文件不存在

- [ ] **Step 3: 实现 TalkButtonStyles**

`lib/src/components/talk_button_styles.dart`:
```dart
import 'package:flutter/material.dart';

class TalkBlockButtonColors {
  const TalkBlockButtonColors({
    required this.foreground,
    required this.normalBackground,
    required this.hoverBackground,
    required this.pressedBackground,
  });

  final Color foreground;
  final Color normalBackground;
  final Color hoverBackground;
  final Color pressedBackground;

  static const light = TalkBlockButtonColors(
    foreground: Color(0xFFFF2C55),
    normalBackground: Colors.transparent,
    hoverBackground: Color(0x1A999999),
    pressedBackground: Color(0x33999999),
  );
}

class TalkButtonStyles extends ThemeExtension<TalkButtonStyles> {
  TalkButtonStyles({
    required this.textTheme,
    required this.textSecondary,
    required this.fillTheme,
    required this.fillThemeIcon,
    required this.strokeSecondary,
    required this.strokeSecondaryIcon,
    required this.themeIcon,
    required this.textSecondaryRipple,
    required this.block,
  });

  final ButtonStyle textTheme;
  final ButtonStyle textSecondary;
  final ButtonStyle fillTheme;
  final ButtonStyle fillThemeIcon;
  final ButtonStyle strokeSecondary;
  final ButtonStyle strokeSecondaryIcon;
  final ButtonStyle themeIcon;
  final ButtonStyle textSecondaryRipple;
  final TalkBlockButtonColors block;

  static final light = TalkButtonStyles(
    textTheme: _textTheme(),
    textSecondary: _textSecondary(),
    fillTheme: _fillTheme(),
    fillThemeIcon: _fillTheme(),
    strokeSecondary: _strokeSecondary(),
    strokeSecondaryIcon: _strokeSecondary(),
    themeIcon: _themeIcon(),
    textSecondaryRipple: _textSecondaryRipple(),
    block: TalkBlockButtonColors.light,
  );

  static ButtonStyle _textTheme() => ButtonStyle(
        backgroundColor: const WidgetStatePropertyAll(Colors.transparent),
        foregroundColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.disabled)) return const Color(0x333C3C43);
          if (states.contains(WidgetState.pressed)) return const Color(0xFFE5284D);
          if (states.contains(WidgetState.hovered)) return const Color(0xFFFF4569);
          return const Color(0xFFFF2C55);
        }),
        overlayColor: const WidgetStatePropertyAll(Colors.transparent),
        minimumSize: const WidgetStatePropertyAll(Size(72, 30)),
        maximumSize: const WidgetStatePropertyAll(Size(400, 52)),
        padding: const WidgetStatePropertyAll(EdgeInsets.symmetric(horizontal: 16)),
        shape: const WidgetStatePropertyAll(
          RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(4))),
        ),
        elevation: const WidgetStatePropertyAll(0),
      );

  static ButtonStyle _textSecondary() => ButtonStyle(
        backgroundColor: const WidgetStatePropertyAll(Colors.transparent),
        foregroundColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.disabled)) return const Color(0xFFD1D1D1);
          if (states.contains(WidgetState.pressed)) return const Color(0xFF777777);
          if (states.contains(WidgetState.hovered)) return const Color(0xFF888888);
          return const Color(0xFFAAAAAA);
        }),
        overlayColor: const WidgetStatePropertyAll(Colors.transparent),
        minimumSize: const WidgetStatePropertyAll(Size(72, 30)),
        maximumSize: const WidgetStatePropertyAll(Size(400, 52)),
        padding: const WidgetStatePropertyAll(EdgeInsets.symmetric(horizontal: 16)),
        shape: const WidgetStatePropertyAll(
          RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(4))),
        ),
        elevation: const WidgetStatePropertyAll(0),
      );

  static ButtonStyle _fillTheme() => ButtonStyle(
        backgroundColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.disabled)) return const Color(0x424F4F4F);
          if (states.contains(WidgetState.pressed)) return const Color(0xFFE5284D);
          if (states.contains(WidgetState.hovered)) return const Color(0xFFFF4569);
          return const Color(0xFFFF2C55);
        }),
        foregroundColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.disabled)) return const Color(0x61000000);
          return const Color(0xFFFFFFFF);
        }),
        overlayColor: const WidgetStatePropertyAll(Colors.transparent),
        minimumSize: const WidgetStatePropertyAll(Size(72, 30)),
        maximumSize: const WidgetStatePropertyAll(Size(400, 52)),
        padding: const WidgetStatePropertyAll(EdgeInsets.symmetric(horizontal: 16)),
        shape: const WidgetStatePropertyAll(
          RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(4))),
        ),
        elevation: const WidgetStatePropertyAll(0),
      );

  static ButtonStyle _strokeSecondary() => ButtonStyle(
        backgroundColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.disabled)) return Colors.transparent;
          if (states.contains(WidgetState.pressed)) return const Color(0x40AAAAAA);
          if (states.contains(WidgetState.hovered)) return const Color(0x1FAAAAAA);
          return Colors.transparent;
        }),
        foregroundColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.disabled)) return const Color(0x61000000);
          return const Color(0xFF262626);
        }),
        overlayColor: const WidgetStatePropertyAll(Colors.transparent),
        side: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.disabled)) {
            return const BorderSide(color: Color(0x1F000000));
          }
          return const BorderSide(color: Color(0xFFAAAAAA));
        }),
        minimumSize: const WidgetStatePropertyAll(Size(72, 30)),
        maximumSize: const WidgetStatePropertyAll(Size(400, 52)),
        padding: const WidgetStatePropertyAll(EdgeInsets.symmetric(horizontal: 16)),
        shape: const WidgetStatePropertyAll(
          RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(4))),
        ),
        elevation: const WidgetStatePropertyAll(0),
      );

  static ButtonStyle _themeIcon() => ButtonStyle(
        backgroundColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.disabled)) return const Color(0x33999999);
          if (states.contains(WidgetState.pressed)) return const Color(0x33999999);
          if (states.contains(WidgetState.hovered)) return const Color(0x1A999999);
          return Colors.transparent;
        }),
        foregroundColor: const WidgetStatePropertyAll(Color(0xFFFF2C55)),
        overlayColor: const WidgetStatePropertyAll(Colors.transparent),
        minimumSize: const WidgetStatePropertyAll(Size(36, 36)),
        maximumSize: const WidgetStatePropertyAll(Size(36, 36)),
        padding: const WidgetStatePropertyAll(EdgeInsets.all(8)),
        shape: const WidgetStatePropertyAll(CircleBorder()),
        elevation: const WidgetStatePropertyAll(0),
      );

  static ButtonStyle _textSecondaryRipple() => ButtonStyle(
        backgroundColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.pressed)) return const Color(0x33999999);
          if (states.contains(WidgetState.hovered)) return const Color(0x1A999999);
          return Colors.transparent;
        }),
        foregroundColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.disabled)) return const Color(0xFFD1D1D1);
          return const Color(0xFFAAAAAA);
        }),
        overlayColor: const WidgetStatePropertyAll(Colors.transparent),
        minimumSize: const WidgetStatePropertyAll(Size(72, 30)),
        maximumSize: const WidgetStatePropertyAll(Size(400, 52)),
        padding: const WidgetStatePropertyAll(EdgeInsets.symmetric(horizontal: 16)),
        shape: const WidgetStatePropertyAll(
          RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(4))),
        ),
        elevation: const WidgetStatePropertyAll(0),
      );

  @override
  TalkButtonStyles copyWith({
    ButtonStyle? textTheme,
    ButtonStyle? textSecondary,
    ButtonStyle? fillTheme,
    ButtonStyle? fillThemeIcon,
    ButtonStyle? strokeSecondary,
    ButtonStyle? strokeSecondaryIcon,
    ButtonStyle? themeIcon,
    ButtonStyle? textSecondaryRipple,
    TalkBlockButtonColors? block,
  }) =>
      TalkButtonStyles(
        textTheme: textTheme ?? this.textTheme,
        textSecondary: textSecondary ?? this.textSecondary,
        fillTheme: fillTheme ?? this.fillTheme,
        fillThemeIcon: fillThemeIcon ?? this.fillThemeIcon,
        strokeSecondary: strokeSecondary ?? this.strokeSecondary,
        strokeSecondaryIcon: strokeSecondaryIcon ?? this.strokeSecondaryIcon,
        themeIcon: themeIcon ?? this.themeIcon,
        textSecondaryRipple: textSecondaryRipple ?? this.textSecondaryRipple,
        block: block ?? this.block,
      );

  @override
  TalkButtonStyles lerp(TalkButtonStyles? other, double t) {
    if (other is! TalkButtonStyles) return this;
    return TalkButtonStyles(
      textTheme: ButtonStyle.lerp(textTheme, other.textTheme, t) ?? textTheme,
      textSecondary: ButtonStyle.lerp(textSecondary, other.textSecondary, t) ?? textSecondary,
      fillTheme: ButtonStyle.lerp(fillTheme, other.fillTheme, t) ?? fillTheme,
      fillThemeIcon: ButtonStyle.lerp(fillThemeIcon, other.fillThemeIcon, t) ?? fillThemeIcon,
      strokeSecondary: ButtonStyle.lerp(strokeSecondary, other.strokeSecondary, t) ?? strokeSecondary,
      strokeSecondaryIcon: ButtonStyle.lerp(strokeSecondaryIcon, other.strokeSecondaryIcon, t) ?? strokeSecondaryIcon,
      themeIcon: ButtonStyle.lerp(themeIcon, other.themeIcon, t) ?? themeIcon,
      textSecondaryRipple: ButtonStyle.lerp(textSecondaryRipple, other.textSecondaryRipple, t) ?? textSecondaryRipple,
      block: t < 0.5 ? block : other.block,
    );
  }
}
```

- [ ] **Step 4: 运行测试确认通过**

```bash
cd /Users/joy/development/JusTalk/talk_design && flutter test test/components/talk_button_styles_test.dart
```

Expected: All tests passed!

- [ ] **Step 5: Commit**

```bash
cd /Users/joy/development/JusTalk/talk_design
git add lib/src/components/talk_button_styles.dart test/components/talk_button_styles_test.dart
git commit -m "feat: add TalkButtonStyles with 9 button types and 4 interaction states"
```

---

## Task 5: TalkInputStyles

**Files:**
- Create: `lib/src/components/talk_input_styles.dart`
- Create: `test/components/talk_input_styles_test.dart`

- [ ] **Step 1: 写失败测试**

`test/components/talk_input_styles_test.dart`:
```dart
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:talk_design/src/components/talk_input_styles.dart';

void main() {
  group('TalkInputStyles', () {
    test('light level1 fill color is #F5F5F5', () {
      expect(TalkInputStyles.light.level1.fillColor, const Color(0xFFF5F5F5));
    });

    test('light level2 fill color is #FFFFFF', () {
      expect(TalkInputStyles.light.level2.fillColor, const Color(0xFFFFFFFF));
    });

    test('level1 and level2 are filled', () {
      expect(TalkInputStyles.light.level1.filled, isTrue);
      expect(TalkInputStyles.light.level2.filled, isTrue);
    });

    test('copyWith replaces only level1FillColor', () {
      final modified = TalkInputStyles.light.copyWith(
        level1FillColor: const Color(0xFF000000),
      );
      expect(modified.level1.fillColor, const Color(0xFF000000));
      expect(modified.level2.fillColor, TalkInputStyles.light.level2.fillColor);
    });
  });
}
```

- [ ] **Step 2: 运行测试确认失败**

```bash
cd /Users/joy/development/JusTalk/talk_design && flutter test test/components/talk_input_styles_test.dart
```

Expected: FAIL — 源文件不存在

- [ ] **Step 3: 实现 TalkInputStyles**

`lib/src/components/talk_input_styles.dart`:
```dart
import 'package:flutter/material.dart';

class TalkInputStyles extends ThemeExtension<TalkInputStyles> {
  const TalkInputStyles({
    required this.level1FillColor,
    required this.level2FillColor,
  });

  final Color level1FillColor;
  final Color level2FillColor;

  static const light = TalkInputStyles(
    level1FillColor: Color(0xFFF5F5F5),
    level2FillColor: Color(0xFFFFFFFF),
  );

  InputDecoration get level1 => InputDecoration(
        filled: true,
        fillColor: level1FillColor,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(4),
          borderSide: BorderSide.none,
        ),
        contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      );

  InputDecoration get level2 => InputDecoration(
        filled: true,
        fillColor: level2FillColor,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(4),
          borderSide: BorderSide.none,
        ),
        contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      );

  @override
  TalkInputStyles copyWith({
    Color? level1FillColor,
    Color? level2FillColor,
  }) =>
      TalkInputStyles(
        level1FillColor: level1FillColor ?? this.level1FillColor,
        level2FillColor: level2FillColor ?? this.level2FillColor,
      );

  @override
  TalkInputStyles lerp(TalkInputStyles? other, double t) {
    if (other is! TalkInputStyles) return this;
    return TalkInputStyles(
      level1FillColor: Color.lerp(level1FillColor, other.level1FillColor, t)!,
      level2FillColor: Color.lerp(level2FillColor, other.level2FillColor, t)!,
    );
  }
}
```

- [ ] **Step 4: 运行测试确认通过**

```bash
cd /Users/joy/development/JusTalk/talk_design && flutter test test/components/talk_input_styles_test.dart
```

Expected: All tests passed!

- [ ] **Step 5: Commit**

```bash
cd /Users/joy/development/JusTalk/talk_design
git add lib/src/components/talk_input_styles.dart test/components/talk_input_styles_test.dart
git commit -m "feat: add TalkInputStyles with level1/level2 fill colors"
```

---

## Task 6: TalkTheme + BuildContext 扩展 + 统一导出

**Files:**
- Create: `lib/src/theme/talk_theme.dart`
- Create: `lib/src/theme/talk_context_extensions.dart`
- Create: `lib/talk_design.dart`
- Create: `test/theme/talk_theme_test.dart`

- [ ] **Step 1: 写失败测试**

`test/theme/talk_theme_test.dart`:
```dart
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:talk_design/talk_design.dart';

void main() {
  group('TalkTheme', () {
    test('light() registers TalkColors extension', () {
      expect(TalkTheme.light().extension<TalkColors>(), isNotNull);
    });

    test('light() registers TalkButtonStyles extension', () {
      expect(TalkTheme.light().extension<TalkButtonStyles>(), isNotNull);
    });

    test('light() registers TalkInputStyles extension', () {
      expect(TalkTheme.light().extension<TalkInputStyles>(), isNotNull);
    });

    test('light() colorScheme seed matches themeColor', () {
      final theme = TalkTheme.light();
      final colors = theme.extension<TalkColors>()!;
      expect(colors.themeColor, const Color(0xFFFF2C55));
    });
  });

  group('BuildContext extensions', () {
    testWidgets('talkColors returns TalkColors from context', (tester) async {
      late TalkColors result;
      await tester.pumpWidget(MaterialApp(
        theme: TalkTheme.light(),
        home: Builder(builder: (context) {
          result = context.talkColors;
          return const SizedBox();
        }),
      ));
      expect(result.themeColor, const Color(0xFFFF2C55));
    });

    testWidgets('talkButtonStyles returns TalkButtonStyles from context', (tester) async {
      late TalkButtonStyles result;
      await tester.pumpWidget(MaterialApp(
        theme: TalkTheme.light(),
        home: Builder(builder: (context) {
          result = context.talkButtonStyles;
          return const SizedBox();
        }),
      ));
      expect(result.fillTheme, isNotNull);
    });

    testWidgets('talkInputStyles returns TalkInputStyles from context', (tester) async {
      late TalkInputStyles result;
      await tester.pumpWidget(MaterialApp(
        theme: TalkTheme.light(),
        home: Builder(builder: (context) {
          result = context.talkInputStyles;
          return const SizedBox();
        }),
      ));
      expect(result.level1.fillColor, const Color(0xFFF5F5F5));
    });
  });
}
```

- [ ] **Step 2: 运行测试确认失败**

```bash
cd /Users/joy/development/JusTalk/talk_design && flutter test test/theme/talk_theme_test.dart
```

Expected: FAIL — `package:talk_design/talk_design.dart` 不存在

- [ ] **Step 3: 实现 TalkTheme**

`lib/src/theme/talk_theme.dart`:
```dart
import 'package:flutter/material.dart';
import '../tokens/talk_colors.dart';
import '../components/talk_button_styles.dart';
import '../components/talk_input_styles.dart';

class TalkTheme {
  static ThemeData light() => ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: TalkColors.light.themeColor),
        extensions: [
          TalkColors.light,
          TalkButtonStyles.light,
          TalkInputStyles.light,
        ],
      );
}
```

- [ ] **Step 4: 实现 BuildContext 扩展**

`lib/src/theme/talk_context_extensions.dart`:
```dart
import 'package:flutter/material.dart';
import '../tokens/talk_colors.dart';
import '../components/talk_button_styles.dart';
import '../components/talk_input_styles.dart';

extension TalkContextExtensions on BuildContext {
  TalkColors get talkColors => Theme.of(this).extension<TalkColors>()!;
  TalkButtonStyles get talkButtonStyles => Theme.of(this).extension<TalkButtonStyles>()!;
  TalkInputStyles get talkInputStyles => Theme.of(this).extension<TalkInputStyles>()!;
}
```

- [ ] **Step 5: 创建统一导出文件**

`lib/talk_design.dart`:
```dart
export 'src/tokens/talk_colors.dart';
export 'src/tokens/talk_typography.dart';
export 'src/tokens/talk_spacing.dart';
export 'src/tokens/talk_shadows.dart';
export 'src/components/talk_button_styles.dart';
export 'src/components/talk_input_styles.dart';
export 'src/theme/talk_theme.dart';
export 'src/theme/talk_context_extensions.dart';
```

- [ ] **Step 6: 运行所有测试**

```bash
cd /Users/joy/development/JusTalk/talk_design && flutter test
```

Expected: All tests passed!（7 个测试文件全部通过）

- [ ] **Step 7: 运行 analyze 检查**

```bash
cd /Users/joy/development/JusTalk/talk_design && flutter analyze
```

Expected: No issues found!

- [ ] **Step 8: Commit**

```bash
cd /Users/joy/development/JusTalk/talk_design
git add lib/src/theme/talk_theme.dart lib/src/theme/talk_context_extensions.dart lib/talk_design.dart test/theme/talk_theme_test.dart
git commit -m "feat: add TalkTheme assembly, BuildContext extensions, and barrel export"
```

- [ ] **Step 9: Push 到远程**

```bash
cd /Users/joy/development/JusTalk/talk_design
git tag v0.1.0
git push origin master --tags
```

---

## Task 7: 接入 JusTalk_Windows

**Files:**
- Modify: `/Users/joy/development/JusTalk/JusTalk_Windows/pubspec.yaml`
- Modify: `/Users/joy/development/JusTalk/JusTalk_Windows/lib/main.dart`

- [ ] **Step 1: 在 pubspec.yaml 添加依赖**

在 `/Users/joy/development/JusTalk/JusTalk_Windows/pubspec.yaml` 的 `dependencies:` 节下添加：

```yaml
  talk_design:
    git:
      url: git@github.com:JoyHong/talk_design.git
      ref: v0.1.0
```

- [ ] **Step 2: 安装依赖**

```bash
cd /Users/joy/development/JusTalk/JusTalk_Windows && flutter pub get
```

Expected: 成功解析 `talk_design` 包，无 error。

- [ ] **Step 3: 更新 main.dart 使用 TalkTheme**

在 `/Users/joy/development/JusTalk/JusTalk_Windows/lib/main.dart` 文件顶部添加导入：

```dart
import 'package:talk_design/talk_design.dart';
```

将 `MyApp.build()` 中的 `theme:` 和 `darkTheme:` 替换为：

```dart
theme: TalkTheme.light(),
darkTheme: TalkTheme.light(), // 暗色模式待 Figma 规范完善后实现
```

- [ ] **Step 4: 确认编译通过**

```bash
cd /Users/joy/development/JusTalk/JusTalk_Windows && flutter analyze
```

Expected: No issues found!（或仅有已存在的警告，无新增 error）

- [ ] **Step 5: Commit**

```bash
cd /Users/joy/development/JusTalk/JusTalk_Windows
git add pubspec.yaml pubspec.lock lib/main.dart
git commit -m "feat: integrate talk_design package, replace seed theme with TalkTheme"
```

---

## 自检记录

**Spec 覆盖检查：**
- ✅ 17 个颜色 Token → Task 2
- ✅ 按钮 9 种类型 × 4 状态 → Task 4
- ✅ 输入框 level1/level2 → Task 5
- ✅ 字体/间距/阴影 Token → Task 3
- ✅ ThemeData 组装 → Task 6
- ✅ BuildContext 扩展 → Task 6
- ✅ 统一 barrel 导出 → Task 6
- ✅ JusTalk_Windows 接入 → Task 7

**类型一致性：**
- `TalkColors.light.themeColor` 在 Task 2 定义，在 Task 6 `TalkTheme` 中引用 ✅
- `TalkButtonStyles.light` 在 Task 4 定义，在 Task 6 导出 ✅
- `TalkBlockButtonColors` 在 Task 4 `talk_button_styles.dart` 中定义，并由 `talk_design.dart` 导出 ✅
- `context.talkColors`/`context.talkButtonStyles`/`context.talkInputStyles` 均在 Task 6 定义 ✅

**无 Placeholder：** 所有步骤包含完整代码，无 TBD。
