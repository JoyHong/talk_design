import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:talk_design/talk_design.dart';

Widget _wrap(Widget child) => MaterialApp(
      theme: TalkTheme.light(),
      home: Scaffold(body: child),
    );

TextStyle _styleOf(WidgetTester tester) =>
    tester.widget<RichText>(find.byType(RichText).first).text.style!;

void main() {
  group('talk_text_widgets', () {
  // ── Display ─────────────────────────────────────────────────────────────

  testWidgets('DisplayLarge: 57/64/bold/textMain by default', (tester) async {
    await tester.pumpWidget(_wrap(const DisplayLarge('x')));
    final style = _styleOf(tester);
    expect(style.fontSize, 57);
    expect(style.height, closeTo(64 / 57, 0.001));
    expect(style.fontWeight, FontWeight.bold);
    expect(style.color, TalkColors.light.textMain);
  });

  testWidgets('DisplayLarge: custom color overrides textMain', (tester) async {
    await tester.pumpWidget(_wrap(const DisplayLarge('x', color: Colors.red)));
    expect(_styleOf(tester).color, Colors.red);
  });

  testWidgets('DisplayMedium: 45/52/bold', (tester) async {
    await tester.pumpWidget(_wrap(const DisplayMedium('x')));
    final style = _styleOf(tester);
    expect(style.fontSize, 45);
    expect(style.height, closeTo(52 / 45, 0.001));
    expect(style.fontWeight, FontWeight.bold);
  });

  testWidgets('DisplaySmall: 36/44/bold', (tester) async {
    await tester.pumpWidget(_wrap(const DisplaySmall('x')));
    final style = _styleOf(tester);
    expect(style.fontSize, 36);
    expect(style.height, closeTo(44 / 36, 0.001));
  });

  // ── Headline ────────────────────────────────────────────────────────────

  testWidgets('HeadlineLarge: 32/40/bold', (tester) async {
    await tester.pumpWidget(_wrap(const HeadlineLarge('x')));
    final style = _styleOf(tester);
    expect(style.fontSize, 32);
    expect(style.height, closeTo(40 / 32, 0.001));
    expect(style.fontWeight, FontWeight.bold);
  });

  testWidgets('HeadlineMedium: 28/36/bold', (tester) async {
    await tester.pumpWidget(_wrap(const HeadlineMedium('x')));
    final style = _styleOf(tester);
    expect(style.fontSize, 28);
    expect(style.height, closeTo(36 / 28, 0.001));
  });

  testWidgets('HeadlineMedium2: 26/34/bold', (tester) async {
    await tester.pumpWidget(_wrap(const HeadlineMedium2('x')));
    final style = _styleOf(tester);
    expect(style.fontSize, 26);
    expect(style.height, closeTo(34 / 26, 0.001));
  });

  testWidgets('HeadlineSmall: 24/32/bold', (tester) async {
    await tester.pumpWidget(_wrap(const HeadlineSmall('x')));
    expect(_styleOf(tester).fontSize, 24);
  });

  testWidgets('HeadlineSmall2: 20/28/bold', (tester) async {
    await tester.pumpWidget(_wrap(const HeadlineSmall2('x')));
    expect(_styleOf(tester).fontSize, 20);
  });

  testWidgets('HeadlineSmall3: 18/26/bold', (tester) async {
    await tester.pumpWidget(_wrap(const HeadlineSmall3('x')));
    expect(_styleOf(tester).fontSize, 18);
  });

  // ── Title ────────────────────────────────────────────────────────────────

  testWidgets('TitleLarge: 22/28/bold', (tester) async {
    await tester.pumpWidget(_wrap(const TitleLarge('x')));
    final style = _styleOf(tester);
    expect(style.fontSize, 22);
    expect(style.height, closeTo(28 / 22, 0.001));
    expect(style.fontWeight, FontWeight.bold);
  });

  testWidgets('TitleMedium: 16/24/bold', (tester) async {
    await tester.pumpWidget(_wrap(const TitleMedium('x')));
    expect(_styleOf(tester).fontSize, 16);
  });

  testWidgets('TitleSmall: 14/20/bold', (tester) async {
    await tester.pumpWidget(_wrap(const TitleSmall('x')));
    expect(_styleOf(tester).fontSize, 14);
  });

  // ── Label ────────────────────────────────────────────────────────────────

  testWidgets('LabelLarge: 14/20/bold', (tester) async {
    await tester.pumpWidget(_wrap(const LabelLarge('x')));
    final style = _styleOf(tester);
    expect(style.fontSize, 14);
    expect(style.fontWeight, FontWeight.bold);
  });

  testWidgets('LabelMedium: 12/16/bold', (tester) async {
    await tester.pumpWidget(_wrap(const LabelMedium('x')));
    expect(_styleOf(tester).fontSize, 12);
  });

  testWidgets('LabelSmall: 11/16/bold', (tester) async {
    await tester.pumpWidget(_wrap(const LabelSmall('x')));
    expect(_styleOf(tester).fontSize, 11);
  });

  // ── Body ─────────────────────────────────────────────────────────────────

  testWidgets('BodyLarge2: 18/26/w500', (tester) async {
    await tester.pumpWidget(_wrap(const BodyLarge2('x')));
    final style = _styleOf(tester);
    expect(style.fontSize, 18);
    expect(style.height, closeTo(26 / 18, 0.001));
    expect(style.fontWeight, FontWeight.w500);
  });

  testWidgets('BodyLarge: 16/24/w500', (tester) async {
    await tester.pumpWidget(_wrap(const BodyLarge('x')));
    final style = _styleOf(tester);
    expect(style.fontSize, 16);
    expect(style.fontWeight, FontWeight.w500);
  });

  testWidgets('BodyMedium: 14/20/w500', (tester) async {
    await tester.pumpWidget(_wrap(const BodyMedium('x')));
    expect(_styleOf(tester).fontSize, 14);
  });

  testWidgets('BodySmall: 12/16/w500', (tester) async {
    await tester.pumpWidget(_wrap(const BodySmall('x')));
    final style = _styleOf(tester);
    expect(style.fontSize, 12);
    expect(style.fontWeight, FontWeight.w500);
  });
  });
}
