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
      expect(result.level1FillColor, const Color(0xFFF5F5F5));
    });
  });
}
