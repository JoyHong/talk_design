import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:talk_design/src/components/talk_button.dart';

// 从已渲染的 TextButton 中提取 ButtonStyle（来自 widget 实例，非 effective style）。
ButtonStyle _styleOf(WidgetTester tester) =>
    tester.widget<TextButton>(find.byType(TextButton)).style!;

Widget _wrap(Widget child) => MaterialApp(home: Scaffold(body: child));

void main() {
  // ── fillTheme ──────────────────────────────────────────────────────────────
  group('TalkButton.fillTheme', () {
    testWidgets('normal bg is #FF2C55', (t) async {
      await t.pumpWidget(_wrap(
        TalkButton.fillTheme(label: 'Test', onPressed: () {}),
      ));
      final bg = _styleOf(t).backgroundColor!;
      expect(bg.resolve({}), const Color(0xFFFF2C55));
    });

    testWidgets('hovered bg is #FF4569', (t) async {
      await t.pumpWidget(_wrap(
        TalkButton.fillTheme(label: 'Test', onPressed: () {}),
      ));
      final bg = _styleOf(t).backgroundColor!;
      expect(bg.resolve({WidgetState.hovered}), const Color(0xFFFF4569));
    });

    testWidgets('pressed bg is #E5284D', (t) async {
      await t.pumpWidget(_wrap(
        TalkButton.fillTheme(label: 'Test', onPressed: () {}),
      ));
      final bg = _styleOf(t).backgroundColor!;
      expect(bg.resolve({WidgetState.pressed}), const Color(0xFFE5284D));
    });

    testWidgets('disabled bg is #4F4F4F@26%', (t) async {
      await t.pumpWidget(_wrap(
        const TalkButton.fillTheme(label: 'Test'),
      ));
      final bg = _styleOf(t).backgroundColor!;
      expect(bg.resolve({WidgetState.disabled}), const Color(0x424F4F4F));
    });

    testWidgets('disabled fg is #000@38%', (t) async {
      await t.pumpWidget(_wrap(
        const TalkButton.fillTheme(label: 'Test'),
      ));
      final fg = _styleOf(t).foregroundColor!;
      expect(fg.resolve({WidgetState.disabled}), const Color(0x61000000));
    });

    testWidgets('normal fg is white', (t) async {
      await t.pumpWidget(_wrap(
        TalkButton.fillTheme(label: 'Test', onPressed: () {}),
      ));
      final fg = _styleOf(t).foregroundColor!;
      expect(fg.resolve({}), Colors.white);
    });
  });

  // ── textTheme ──────────────────────────────────────────────────────────────
  group('TalkButton.textTheme', () {
    testWidgets('normal fg is #FF2C55', (t) async {
      await t.pumpWidget(_wrap(
        TalkButton.textTheme(label: 'Test', onPressed: () {}),
      ));
      final fg = _styleOf(t).foregroundColor!;
      expect(fg.resolve({}), const Color(0xFFFF2C55));
    });

    testWidgets('hovered fg is #FF4569', (t) async {
      await t.pumpWidget(_wrap(
        TalkButton.textTheme(label: 'Test', onPressed: () {}),
      ));
      final fg = _styleOf(t).foregroundColor!;
      expect(fg.resolve({WidgetState.hovered}), const Color(0xFFFF4569));
    });

    testWidgets('pressed fg is #E5284D', (t) async {
      await t.pumpWidget(_wrap(
        TalkButton.textTheme(label: 'Test', onPressed: () {}),
      ));
      final fg = _styleOf(t).foregroundColor!;
      expect(fg.resolve({WidgetState.pressed}), const Color(0xFFE5284D));
    });

    testWidgets('disabled fg is #3C3C43@20%', (t) async {
      await t.pumpWidget(_wrap(
        const TalkButton.textTheme(label: 'Test'),
      ));
      final fg = _styleOf(t).foregroundColor!;
      expect(fg.resolve({WidgetState.disabled}), const Color(0x333C3C43));
    });
  });

  // ── textSecondary ──────────────────────────────────────────────────────────
  group('TalkButton.textSecondary', () {
    testWidgets('normal fg is #AAAAAA', (t) async {
      await t.pumpWidget(_wrap(
        TalkButton.textSecondary(label: 'Test', onPressed: () {}),
      ));
      final fg = _styleOf(t).foregroundColor!;
      expect(fg.resolve({}), const Color(0xFFAAAAAA));
    });

    testWidgets('hovered fg is #888888', (t) async {
      await t.pumpWidget(_wrap(
        TalkButton.textSecondary(label: 'Test', onPressed: () {}),
      ));
      final fg = _styleOf(t).foregroundColor!;
      expect(fg.resolve({WidgetState.hovered}), const Color(0xFF888888));
    });

    testWidgets('pressed fg is #777777', (t) async {
      await t.pumpWidget(_wrap(
        TalkButton.textSecondary(label: 'Test', onPressed: () {}),
      ));
      final fg = _styleOf(t).foregroundColor!;
      expect(fg.resolve({WidgetState.pressed}), const Color(0xFF777777));
    });

    testWidgets('disabled fg is #D1D1D1', (t) async {
      await t.pumpWidget(_wrap(
        const TalkButton.textSecondary(label: 'Test'),
      ));
      final fg = _styleOf(t).foregroundColor!;
      expect(fg.resolve({WidgetState.disabled}), const Color(0xFFD1D1D1));
    });
  });

  // ── strokeSecondary ────────────────────────────────────────────────────────
  group('TalkButton.strokeSecondary', () {
    testWidgets('normal border is #AAAAAA 2px', (t) async {
      await t.pumpWidget(_wrap(
        TalkButton.strokeSecondary(label: 'Test', onPressed: () {}),
      ));
      final side = _styleOf(t).side!;
      expect(side.resolve({})?.color, const Color(0xFFAAAAAA));
      expect(side.resolve({})?.width, 2);
    });

    testWidgets('hovered bg is #AAAAAA@12%', (t) async {
      await t.pumpWidget(_wrap(
        TalkButton.strokeSecondary(label: 'Test', onPressed: () {}),
      ));
      final bg = _styleOf(t).backgroundColor!;
      expect(bg.resolve({WidgetState.hovered}), const Color(0x1FAAAAAA));
    });

    testWidgets('pressed bg is #AAAAAA@25%', (t) async {
      await t.pumpWidget(_wrap(
        TalkButton.strokeSecondary(label: 'Test', onPressed: () {}),
      ));
      final bg = _styleOf(t).backgroundColor!;
      expect(bg.resolve({WidgetState.pressed}), const Color(0x40AAAAAA));
    });

    testWidgets('disabled border is #000@12%', (t) async {
      await t.pumpWidget(_wrap(
        const TalkButton.strokeSecondary(label: 'Test'),
      ));
      final side = _styleOf(t).side!;
      expect(side.resolve({WidgetState.disabled})?.color, const Color(0x1F000000));
    });
  });

  // ── themeIcon ──────────────────────────────────────────────────────────────
  group('TalkButton.themeIcon', () {
    testWidgets('normal bg is transparent', (t) async {
      await t.pumpWidget(_wrap(
        TalkButton.themeIcon(icon: const Icon(Icons.add), onPressed: () {}),
      ));
      final bg = _styleOf(t).backgroundColor!;
      expect(bg.resolve({}), Colors.transparent);
    });

    testWidgets('hovered bg is #999@10%', (t) async {
      await t.pumpWidget(_wrap(
        TalkButton.themeIcon(icon: const Icon(Icons.add), onPressed: () {}),
      ));
      final bg = _styleOf(t).backgroundColor!;
      expect(bg.resolve({WidgetState.hovered}), const Color(0x1A999999));
    });

    testWidgets('pressed bg is #999@20%', (t) async {
      await t.pumpWidget(_wrap(
        TalkButton.themeIcon(icon: const Icon(Icons.add), onPressed: () {}),
      ));
      final bg = _styleOf(t).backgroundColor!;
      expect(bg.resolve({WidgetState.pressed}), const Color(0x33999999));
    });

    testWidgets('foreground is #FF2C55', (t) async {
      await t.pumpWidget(_wrap(
        TalkButton.themeIcon(icon: const Icon(Icons.add), onPressed: () {}),
      ));
      final fg = _styleOf(t).foregroundColor!;
      expect(fg.resolve({}), const Color(0xFFFF2C55));
    });
  });

  // ── textSecondaryRipple ────────────────────────────────────────────────────
  group('TalkButton.textSecondaryRipple', () {
    testWidgets('normal bg is transparent', (t) async {
      await t.pumpWidget(_wrap(
        TalkButton.textSecondaryRipple(label: 'Test', onPressed: () {}),
      ));
      final bg = _styleOf(t).backgroundColor!;
      expect(bg.resolve({}), Colors.transparent);
    });

    testWidgets('hovered bg is #999@10%', (t) async {
      await t.pumpWidget(_wrap(
        TalkButton.textSecondaryRipple(label: 'Test', onPressed: () {}),
      ));
      final bg = _styleOf(t).backgroundColor!;
      expect(bg.resolve({WidgetState.hovered}), const Color(0x1A999999));
    });

    testWidgets('pressed bg is #999@20%', (t) async {
      await t.pumpWidget(_wrap(
        TalkButton.textSecondaryRipple(label: 'Test', onPressed: () {}),
      ));
      final bg = _styleOf(t).backgroundColor!;
      expect(bg.resolve({WidgetState.pressed}), const Color(0x33999999));
    });

    testWidgets('disabled fg is #D1D1D1', (t) async {
      await t.pumpWidget(_wrap(
        const TalkButton.textSecondaryRipple(label: 'Test'),
      ));
      final fg = _styleOf(t).foregroundColor!;
      expect(fg.resolve({WidgetState.disabled}), const Color(0xFFD1D1D1));
    });
  });

  // ── TalkButton.block ───────────────────────────────────────────────────────
  group('TalkButton.block', () {
    testWidgets('renders icon and label', (t) async {
      await t.pumpWidget(_wrap(
        TalkButton.block(
          icon: const Icon(Icons.videocam),
          label: '视频',
          onPressed: () {},
        ),
      ));
      expect(find.byIcon(Icons.videocam), findsOneWidget);
      expect(find.text('视频'), findsOneWidget);
    });

    testWidgets('normal bg is transparent', (t) async {
      await t.pumpWidget(_wrap(
        TalkButton.block(
          icon: const Icon(Icons.mic),
          label: '语音',
          onPressed: () {},
        ),
      ));
      final bg = _styleOf(t).backgroundColor!;
      expect(bg.resolve({}), Colors.transparent);
    });

    testWidgets('hovered bg is #999@10%', (t) async {
      await t.pumpWidget(_wrap(
        TalkButton.block(
          icon: const Icon(Icons.mic),
          label: '语音',
          onPressed: () {},
        ),
      ));
      final bg = _styleOf(t).backgroundColor!;
      expect(bg.resolve({WidgetState.hovered}), const Color(0x1A999999));
    });

    testWidgets('pressed bg is #999@20%', (t) async {
      await t.pumpWidget(_wrap(
        TalkButton.block(
          icon: const Icon(Icons.mic),
          label: '语音',
          onPressed: () {},
        ),
      ));
      final bg = _styleOf(t).backgroundColor!;
      expect(bg.resolve({WidgetState.pressed}), const Color(0x33999999));
    });

    testWidgets('foreground is #FF2C55', (t) async {
      await t.pumpWidget(_wrap(
        TalkButton.block(
          icon: const Icon(Icons.mic),
          label: '语音',
          onPressed: () {},
        ),
      ));
      final fg = _styleOf(t).foregroundColor!;
      expect(fg.resolve({}), const Color(0xFFFF2C55));
    });
  });

  // ── fillThemeIcon ──────────────────────────────────────────────────────────
  group('TalkButton.fillThemeIcon', () {
    testWidgets('renders icon and label in row', (t) async {
      await t.pumpWidget(_wrap(
        TalkButton.fillThemeIcon(
          label: 'With Icon',
          icon: const Icon(Icons.add),
          onPressed: () {},
        ),
      ));
      expect(find.byIcon(Icons.add), findsOneWidget);
      expect(find.text('With Icon'), findsOneWidget);
    });

    testWidgets('normal bg is #FF2C55', (t) async {
      await t.pumpWidget(_wrap(
        TalkButton.fillThemeIcon(
          label: 'Test',
          icon: const Icon(Icons.add),
          onPressed: () {},
        ),
      ));
      final bg = _styleOf(t).backgroundColor!;
      expect(bg.resolve({}), const Color(0xFFFF2C55));
    });
  });
}
