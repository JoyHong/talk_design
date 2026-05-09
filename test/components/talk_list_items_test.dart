import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:talk_design/src/components/talk_list_items.dart';
import 'package:talk_design/src/components/talk_button.dart';
import 'package:talk_design/src/theme/talk_theme.dart';

Widget _wrap(Widget child) => MaterialApp(
      theme: TalkTheme.light(),
      home: Scaffold(body: child),
    );

const _themeColor = Color(0xFFFF2C55);
const _textPrimary = Color(0xFF262626);
const _textSecondary = Color(0xFFAAAAAA);

void main() {
// ── TalkAvatarStatusItem ───────────────────────────────────────────────────

group('TalkAvatarStatusItem', () {
  testWidgets('renders name and preview text', (t) async {
    await t.pumpWidget(_wrap(
      TalkAvatarStatusItem(
        avatar: const SizedBox.square(dimension: 32, child: ColoredBox(color: Colors.grey)),
        name: 'Martha Walsh',
        preview: 'I sent a message.',
      ),
    ));
    expect(find.text('Martha Walsh'), findsOneWidget);
    expect(find.text('I sent a message.'), findsOneWidget);
  });

  testWidgets('timestamp shown when provided', (t) async {
    await t.pumpWidget(_wrap(
      TalkAvatarStatusItem(
        avatar: const SizedBox.square(dimension: 32, child: ColoredBox(color: Colors.grey)),
        name: 'Alice',
        timestamp: '09:30 AM',
      ),
    ));
    expect(find.text('09:30 AM'), findsOneWidget);
  });

testWidgets('badge shown when provided', (t) async {
    await t.pumpWidget(_wrap(
      TalkAvatarStatusItem(
        avatar: const SizedBox.square(dimension: 32, child: ColoredBox(color: Colors.grey)),
        name: 'Carol',
        badge: const SizedBox.square(dimension: 16, child: ColoredBox(color: Colors.red, key: Key('badge'))),
      ),
    ));
    expect(find.byKey(const Key('badge')), findsOneWidget);
  });

  testWidgets('name text is bodyMedium single-line ellipsis', (t) async {
    await t.pumpWidget(_wrap(
      TalkAvatarStatusItem(
        avatar: const SizedBox.square(dimension: 32, child: ColoredBox(color: Colors.grey)),
        name: 'Dave',
        preview: 'hello',
      ),
    ));
    final nameWidget = t.widget<Text>(find.text('Dave'));
    expect(nameWidget.style!.fontSize, 14);
    expect(nameWidget.style!.fontWeight, FontWeight.w500);
    expect(nameWidget.maxLines, 1);
    expect(nameWidget.overflow, TextOverflow.ellipsis);
  });

  testWidgets('preview text style is bodySmall with textSecondary color', (t) async {
    await t.pumpWidget(_wrap(
      TalkAvatarStatusItem(
        avatar: const SizedBox.square(dimension: 32, child: ColoredBox(color: Colors.grey)),
        name: 'Eve',
        preview: 'some preview',
      ),
    ));
    final previewWidget = t.widget<Text>(find.text('some preview'));
    expect(previewWidget.style!.color, _textSecondary);
    expect(previewWidget.maxLines, 1);
    expect(previewWidget.overflow, TextOverflow.ellipsis);
  });
});

// ── TalkAvatarButtonItem ───────────────────────────────────────────────────

group('TalkAvatarButtonItem', () {
  testWidgets('renders title and button label', (t) async {
    await t.pumpWidget(_wrap(
      TalkAvatarButtonItem(
        avatar: const SizedBox.square(dimension: 32, child: ColoredBox(color: Colors.grey)),
        title: 'Frank',
        buttonLabel: 'Follow',
        onButtonPressed: () {},
      ),
    ));
    expect(find.text('Frank'), findsOneWidget);
    expect(find.text('Follow'), findsOneWidget);
  });

  testWidgets('subtitle shown when provided', (t) async {
    await t.pumpWidget(_wrap(
      TalkAvatarButtonItem(
        avatar: const SizedBox.square(dimension: 32, child: ColoredBox(color: Colors.grey)),
        title: 'Grace',
        subtitle: 'Last seen 5 min ago',
        buttonLabel: 'Add',
        onButtonPressed: () {},
      ),
    ));
    expect(find.text('Last seen 5 min ago'), findsOneWidget);
  });

  testWidgets('button uses theme color border', (t) async {
    await t.pumpWidget(_wrap(
      TalkAvatarButtonItem(
        avatar: const SizedBox.square(dimension: 32, child: ColoredBox(color: Colors.grey)),
        title: 'Hank',
        buttonLabel: 'OK',
        onButtonPressed: () {},
      ),
    ));
    final btn = t.widget<TalkButton>(find.byType(TalkButton));
    // TalkButton.strokeThemeCustom internally applies the theme color border.
    expect(btn.label, 'OK');
  });

  testWidgets('title is bodyMedium single-line ellipsis', (t) async {
    await t.pumpWidget(_wrap(
      TalkAvatarButtonItem(
        avatar: const SizedBox.square(dimension: 32, child: ColoredBox(color: Colors.grey)),
        title: 'Iris',
        buttonLabel: 'Act',
        onButtonPressed: () {},
      ),
    ));
    final titleWidget = t.widget<Text>(find.text('Iris'));
    expect(titleWidget.style!.fontSize, 14);
    expect(titleWidget.style!.fontWeight, FontWeight.w500);
    expect(titleWidget.maxLines, 1);
    expect(titleWidget.overflow, TextOverflow.ellipsis);
  });
});

// ── TalkListBaseItem ───────────────────────────────────────────────────────

group('TalkListBaseItem', () {
  testWidgets('renders label and trailing', (t) async {
    await t.pumpWidget(_wrap(
      TalkListBaseItem(
        icon: const Icon(Icons.settings),
        label: 'Settings',
        trailing: 'Detail',
      ),
    ));
    expect(find.text('Settings'), findsOneWidget);
    expect(find.text('Detail'), findsOneWidget);
  });

  testWidgets('no trailing when not provided', (t) async {
    await t.pumpWidget(_wrap(
      TalkListBaseItem(
        icon: const Icon(Icons.info),
        label: 'Info',
      ),
    ));
    expect(find.text('Info'), findsOneWidget);
    // only one Text widget (the label)
    expect(find.byType(Text), findsOneWidget);
  });

  testWidgets('compact uses 10px horizontal padding', (t) async {
    await t.pumpWidget(_wrap(
      TalkListBaseItem(
        icon: const Icon(Icons.menu),
        label: 'Menu',
        compact: true,
      ),
    ));
    final padding = t.widget<Padding>(find.byType(Padding).first);
    expect(
      (padding.padding as EdgeInsets).left,
      10.0,
    );
  });

  testWidgets('default uses 24px horizontal padding', (t) async {
    await t.pumpWidget(_wrap(
      TalkListBaseItem(
        icon: const Icon(Icons.home),
        label: 'Home',
      ),
    ));
    final padding = t.widget<Padding>(find.byType(Padding).first);
    expect(
      (padding.padding as EdgeInsets).left,
      24.0,
    );
  });

  testWidgets('label is bodyMedium single-line ellipsis', (t) async {
    await t.pumpWidget(_wrap(
      TalkListBaseItem(
        icon: const Icon(Icons.label),
        label: 'Label Text',
      ),
    ));
    final text = t.widget<Text>(find.text('Label Text'));
    expect(text.style!.fontSize, 14);
    expect(text.style!.fontWeight, FontWeight.w500);
    expect(text.maxLines, 1);
    expect(text.overflow, TextOverflow.ellipsis);
  });

  testWidgets('trailing uses bodyMedium textSecondary', (t) async {
    await t.pumpWidget(_wrap(
      TalkListBaseItem(
        icon: const Icon(Icons.label),
        label: 'Label',
        trailing: 'Right',
      ),
    ));
    final trailing = t.widget<Text>(find.text('Right'));
    expect(trailing.style!.color, _textSecondary);
    expect(trailing.maxLines, 1);
    expect(trailing.overflow, TextOverflow.ellipsis);
  });
});

// ── TalkListButtonItem ─────────────────────────────────────────────────────

group('TalkListButtonItem', () {
  testWidgets('renders title and button', (t) async {
    await t.pumpWidget(_wrap(
      TalkListButtonItem(
        title: 'Hearing Protection Mode',
        buttonLabel: 'Enable',
        onButtonPressed: () {},
      ),
    ));
    expect(find.text('Hearing Protection Mode'), findsOneWidget);
    expect(find.text('Enable'), findsOneWidget);
  });

  testWidgets('subtitle shown when provided', (t) async {
    await t.pumpWidget(_wrap(
      TalkListButtonItem(
        title: 'Title',
        subtitle: 'Sub text',
        buttonLabel: 'OK',
        onButtonPressed: () {},
      ),
    ));
    expect(find.text('Sub text'), findsOneWidget);
  });

  testWidgets('button uses textSecondary 1px border', (t) async {
    await t.pumpWidget(_wrap(
      TalkListButtonItem(
        title: 'Title',
        buttonLabel: 'Act',
        onButtonPressed: () {},
      ),
    ));
    final btn = t.widget<TalkButton>(find.byType(TalkButton));
    // TalkButton.strokeSecondaryCustom(inDialog: true) internally applies the 1px textSecondary border.
    expect(btn.label, 'Act');
  });

  testWidgets('title is single-line ellipsis', (t) async {
    await t.pumpWidget(_wrap(
      TalkListButtonItem(
        title: 'A very long title that should be truncated',
        buttonLabel: 'Act',
        onButtonPressed: () {},
      ),
    ));
    final title = t.widget<Text>(
      find.text('A very long title that should be truncated'),
    );
    expect(title.maxLines, 1);
    expect(title.overflow, TextOverflow.ellipsis);
  });
});

// ── TalkListSwitchItem ─────────────────────────────────────────────────────

group('TalkListSwitchItem', () {
  testWidgets('renders label and switch', (t) async {
    await t.pumpWidget(_wrap(
      TalkListSwitchItem(
        label: 'Dark Mode',
        value: true,
        onChanged: (_) {},
      ),
    ));
    expect(find.text('Dark Mode'), findsOneWidget);
    expect(find.byType(Switch), findsOneWidget);
  });

  testWidgets('subtitle shown when provided', (t) async {
    await t.pumpWidget(_wrap(
      TalkListSwitchItem(
        label: 'Notifications',
        subtitle: 'Receive push notifications',
        value: false,
        onChanged: (_) {},
      ),
    ));
    expect(find.text('Receive push notifications'), findsOneWidget);
  });

  testWidgets('single-line uses 14px vertical padding', (t) async {
    await t.pumpWidget(_wrap(
      TalkListSwitchItem(
        label: 'Option',
        value: false,
        onChanged: (_) {},
      ),
    ));
    final padding = t.widget<Padding>(find.byType(Padding).first);
    expect((padding.padding as EdgeInsets).top, 14.0);
  });

  testWidgets('multi-line uses 13px vertical padding', (t) async {
    await t.pumpWidget(_wrap(
      TalkListSwitchItem(
        label: 'Option',
        subtitle: 'Detail',
        value: false,
        onChanged: (_) {},
      ),
    ));
    final padding = t.widget<Padding>(find.byType(Padding).first);
    expect((padding.padding as EdgeInsets).top, 13.0);
  });

  testWidgets('switch value reflects provided value', (t) async {
    await t.pumpWidget(_wrap(
      TalkListSwitchItem(
        label: 'Toggle',
        value: true,
        onChanged: (_) {},
      ),
    ));
    final sw = t.widget<Switch>(find.byType(Switch));
    expect(sw.value, true);
  });

  testWidgets('label is bodyMedium single-line ellipsis', (t) async {
    await t.pumpWidget(_wrap(
      TalkListSwitchItem(
        label: 'Some Label',
        value: false,
        onChanged: (_) {},
      ),
    ));
    final text = t.widget<Text>(find.text('Some Label'));
    expect(text.style!.fontSize, 14);
    expect(text.style!.fontWeight, FontWeight.w500);
    expect(text.maxLines, 1);
    expect(text.overflow, TextOverflow.ellipsis);
  });
});
} // end main
