import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:talk_design/talk_design.dart';

void main() {
  group('TalkTheme', () {
    test('light() registers TalkColors extension', () {
      expect(TalkTheme.light().extension<TalkColors>(), isNotNull);
    });

    test('light() registers TalkInputStyles extension', () {
      expect(TalkTheme.light().extension<TalkInputStyles>(), isNotNull);
    });

    test('light() colorScheme seed matches main', () {
      final theme = TalkTheme.light();
      final colors = theme.extension<TalkColors>()!;
      expect(colors.main, const Color(0xFFFF2C55));
    });

    test('light() labelLarge letterSpacing is 0', () {
      expect(TalkTheme.light().textTheme.labelLarge!.letterSpacing, 0);
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
      expect(result.main, const Color(0xFFFF2C55));
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
