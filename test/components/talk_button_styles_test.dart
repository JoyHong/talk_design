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
