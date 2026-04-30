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

    // textTheme 完整状态
    test('textTheme: hovered fg is #FF4569', () {
      final fg = TalkButtonStyles.light.textTheme.foregroundColor!;
      expect(fg.resolve({WidgetState.hovered}), const Color(0xFFFF4569));
    });

    test('textTheme: pressed fg is #E5284D', () {
      final fg = TalkButtonStyles.light.textTheme.foregroundColor!;
      expect(fg.resolve({WidgetState.pressed}), const Color(0xFFE5284D));
    });

    test('textTheme: disabled fg is #3C3C43@20%', () {
      final fg = TalkButtonStyles.light.textTheme.foregroundColor!;
      expect(fg.resolve({WidgetState.disabled}), const Color(0x333C3C43));
    });

    // textSecondary
    test('textSecondary: normal fg is #AAAAAA', () {
      final fg = TalkButtonStyles.light.textSecondary.foregroundColor!;
      expect(fg.resolve({}), const Color(0xFFAAAAAA));
    });

    test('textSecondary: hovered fg is #888888', () {
      final fg = TalkButtonStyles.light.textSecondary.foregroundColor!;
      expect(fg.resolve({WidgetState.hovered}), const Color(0xFF888888));
    });

    test('textSecondary: pressed fg is #777777', () {
      final fg = TalkButtonStyles.light.textSecondary.foregroundColor!;
      expect(fg.resolve({WidgetState.pressed}), const Color(0xFF777777));
    });

    test('textSecondary: disabled fg is #D1D1D1', () {
      final fg = TalkButtonStyles.light.textSecondary.foregroundColor!;
      expect(fg.resolve({WidgetState.disabled}), const Color(0xFFD1D1D1));
    });

    // fillTheme normal fg (white)
    test('fillTheme: normal fg is white', () {
      final fg = TalkButtonStyles.light.fillTheme.foregroundColor!;
      expect(fg.resolve({}), const Color(0xFFFFFFFF));
    });

    // strokeSecondary complete states
    test('strokeSecondary: pressed bg is #AAAAAA@25%', () {
      final bg = TalkButtonStyles.light.strokeSecondary.backgroundColor!;
      expect(bg.resolve({WidgetState.pressed}), const Color(0x40AAAAAA));
    });

    test('strokeSecondary: disabled border is #000@12%', () {
      final side = TalkButtonStyles.light.strokeSecondary.side!;
      expect(side.resolve({WidgetState.disabled})?.color, const Color(0x1F000000));
    });

    // themeIcon complete states
    test('themeIcon: pressed bg is #999@20%', () {
      final bg = TalkButtonStyles.light.themeIcon.backgroundColor!;
      expect(bg.resolve({WidgetState.pressed}), const Color(0x33999999));
    });

    test('themeIcon: disabled bg is #999@20%', () {
      final bg = TalkButtonStyles.light.themeIcon.backgroundColor!;
      expect(bg.resolve({WidgetState.disabled}), const Color(0x33999999));
    });

    // textSecondaryRipple
    test('textSecondaryRipple: normal bg is transparent', () {
      final bg = TalkButtonStyles.light.textSecondaryRipple.backgroundColor!;
      expect(bg.resolve({}), Colors.transparent);
    });

    test('textSecondaryRipple: hovered bg is #999@10%', () {
      final bg = TalkButtonStyles.light.textSecondaryRipple.backgroundColor!;
      expect(bg.resolve({WidgetState.hovered}), const Color(0x1A999999));
    });

    test('textSecondaryRipple: pressed bg is #999@20%', () {
      final bg = TalkButtonStyles.light.textSecondaryRipple.backgroundColor!;
      expect(bg.resolve({WidgetState.pressed}), const Color(0x33999999));
    });

    test('textSecondaryRipple: disabled fg is #D1D1D1', () {
      final fg = TalkButtonStyles.light.textSecondaryRipple.foregroundColor!;
      expect(fg.resolve({WidgetState.disabled}), const Color(0xFFD1D1D1));
    });

    // block complete
    test('block: pressedBackground is #999@20%', () {
      expect(TalkButtonStyles.light.block.pressedBackground, const Color(0x33999999));
    });

    test('block: normalBackground is transparent', () {
      expect(TalkButtonStyles.light.block.normalBackground, Colors.transparent);
    });

    // copyWith
    test('copyWith replaces only specified field', () {
      final modified = TalkButtonStyles.light.copyWith(
        textTheme: TalkButtonStyles.light.fillTheme,
      );
      expect(modified.textTheme, TalkButtonStyles.light.fillTheme);
      expect(modified.strokeSecondary, TalkButtonStyles.light.strokeSecondary);
      expect(modified.block, TalkButtonStyles.light.block);
    });
  });
}
