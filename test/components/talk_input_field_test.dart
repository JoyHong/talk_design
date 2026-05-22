import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:talk_design/talk_design.dart';

Widget _wrap(Widget child) => MaterialApp(
      theme: TalkTheme.light(),
      home: Scaffold(body: Padding(padding: const EdgeInsets.all(16), child: child)),
    );

void main() {
  // ── TalkTextField ──────────────────────────────────────────────────────────

  group('TalkTextField', () {
    testWidgets('no clear icon when unfocused and empty', (tester) async {
      await tester.pumpWidget(_wrap(const TalkTextField(hintText: 'hint')));
      expect(find.byIcon(Icons.cancel), findsNothing);
    });

    testWidgets('no clear icon when focused but empty', (tester) async {
      await tester.pumpWidget(_wrap(const TalkTextField(hintText: 'hint')));
      await tester.tap(find.byType(TextField));
      await tester.pump();
      expect(find.byIcon(Icons.cancel), findsNothing);
    });

    testWidgets('no clear icon when has content but unfocused', (tester) async {
      final controller = TextEditingController(text: 'hello');
      await tester.pumpWidget(_wrap(TalkTextField(controller: controller)));
      expect(find.byIcon(Icons.cancel), findsNothing);
    });

    testWidgets('shows clear icon when focused and has content', (tester) async {
      await tester.pumpWidget(_wrap(const TalkTextField(hintText: 'hint')));
      await tester.tap(find.byType(TextField));
      await tester.enterText(find.byType(TextField), 'hello');
      await tester.pump();
      expect(find.byIcon(Icons.cancel), findsOneWidget);
    });

    testWidgets('tapping clear icon empties the field', (tester) async {
      await tester.pumpWidget(_wrap(const TalkTextField(hintText: 'hint')));
      await tester.tap(find.byType(TextField));
      await tester.enterText(find.byType(TextField), 'hello');
      await tester.pump();
      await tester.tap(find.byIcon(Icons.cancel));
      await tester.pump();
      expect(find.text('hello'), findsNothing);
      expect(find.byIcon(Icons.cancel), findsNothing);
    });

    testWidgets('uses external controller', (tester) async {
      final ctrl = TextEditingController();
      await tester.pumpWidget(_wrap(TalkTextField(controller: ctrl)));
      await tester.tap(find.byType(TextField));
      await tester.enterText(find.byType(TextField), 'abc');
      await tester.pump();
      expect(ctrl.text, 'abc');
    });

    testWidgets('onChanged fires', (tester) async {
      String? last;
      await tester.pumpWidget(_wrap(TalkTextField(onChanged: (v) => last = v)));
      await tester.enterText(find.byType(TextField), 'x');
      expect(last, 'x');
    });

    testWidgets('isLoading shows loading indicator', (tester) async {
      await tester.pumpWidget(_wrap(const TalkTextField(isLoading: true)));
      expect(find.byType(CircularProgressIndicator), findsOneWidget);
    });

    testWidgets('isLoading hides clear icon when focused and has content', (tester) async {
      await tester.pumpWidget(_wrap(const TalkTextField(isLoading: true, hintText: 'hint')));
      await tester.tap(find.byType(TextField));
      await tester.enterText(find.byType(TextField), 'hello');
      await tester.pump();
      expect(find.byType(CircularProgressIndicator), findsOneWidget);
      expect(find.byIcon(Icons.cancel), findsNothing);
    });

    testWidgets('loading indicator not shown when isLoading is false', (tester) async {
      await tester.pumpWidget(_wrap(const TalkTextField(isLoading: false)));
      expect(find.byType(CircularProgressIndicator), findsNothing);
    });
  });

  // ── TalkPasswordField ──────────────────────────────────────────────────────

  group('TalkPasswordField', () {
    testWidgets('no toggle icon when unfocused and no hover', (tester) async {
      await tester.pumpWidget(_wrap(const TalkPasswordField(hintText: 'pw')));
      expect(find.byIcon(Icons.visibility), findsNothing);
      expect(find.byIcon(Icons.visibility_off), findsNothing);
    });

    testWidgets('shows visibility icon when focused', (tester) async {
      await tester.pumpWidget(_wrap(const TalkPasswordField(hintText: 'pw')));
      await tester.tap(find.byType(TextField));
      await tester.pump();
      expect(find.byIcon(Icons.visibility), findsOneWidget);
    });

    testWidgets('toggling visibility icon switches obscureText', (tester) async {
      await tester.pumpWidget(_wrap(const TalkPasswordField(hintText: 'pw')));
      await tester.tap(find.byType(TextField));
      await tester.pump();
      // initially obscured → visibility icon shown
      expect(find.byIcon(Icons.visibility), findsOneWidget);
      await tester.tap(find.byIcon(Icons.visibility));
      await tester.pump();
      // now visible → visibility_off icon shown
      expect(find.byIcon(Icons.visibility_off), findsOneWidget);
      await tester.tap(find.byIcon(Icons.visibility_off));
      await tester.pump();
      expect(find.byIcon(Icons.visibility), findsOneWidget);
    });

    testWidgets('TextField is obscure by default', (tester) async {
      await tester.pumpWidget(_wrap(const TalkPasswordField()));
      final tf = tester.widget<TextField>(find.byType(TextField));
      expect(tf.obscureText, isTrue);
    });
  });

  // ── TalkIconTextField ──────────────────────────────────────────────────────

  group('TalkIconTextField', () {
    testWidgets('icon is always visible', (tester) async {
      await tester.pumpWidget(_wrap(
        TalkIconTextField(icon: const Icon(Icons.calendar_today)),
      ));
      expect(find.byIcon(Icons.calendar_today), findsOneWidget);
    });

    testWidgets('icon is still visible when focused', (tester) async {
      await tester.pumpWidget(_wrap(
        TalkIconTextField(icon: const Icon(Icons.calendar_today)),
      ));
      await tester.tap(find.byType(TextField));
      await tester.pump();
      expect(find.byIcon(Icons.calendar_today), findsOneWidget);
    });

    testWidgets('onIconTap fires when icon is tapped', (tester) async {
      var tapped = false;
      await tester.pumpWidget(_wrap(
        TalkIconTextField(
          icon: const Icon(Icons.calendar_today),
          onIconTap: () => tapped = true,
        ),
      ));
      await tester.tap(find.byIcon(Icons.calendar_today));
      await tester.pump();
      expect(tapped, isTrue);
    });

    testWidgets('icon is wrapped in 20×20 SizedBox', (tester) async {
      await tester.pumpWidget(_wrap(
        TalkIconTextField(icon: const Icon(Icons.calendar_today, key: Key('ic'))),
      ));
      final box = tester.getSize(find.ancestor(
        of: find.byKey(const Key('ic')),
        matching: find.byType(SizedBox),
      ).first);
      expect(box.width, 20);
      expect(box.height, 20);
    });
  });

  // ── TalkSearchField ────────────────────────────────────────────────────────

  group('TalkSearchField', () {
    testWidgets('search icon always visible', (tester) async {
      await tester.pumpWidget(_wrap(const TalkSearchField()));
      expect(find.byIcon(Icons.search), findsOneWidget);
    });

    testWidgets('no clear icon when unfocused and empty', (tester) async {
      await tester.pumpWidget(_wrap(const TalkSearchField()));
      expect(find.byIcon(Icons.cancel), findsNothing);
    });

    testWidgets('no clear icon when focused but empty', (tester) async {
      await tester.pumpWidget(_wrap(const TalkSearchField()));
      await tester.tap(find.byType(TextField));
      await tester.pump();
      expect(find.byIcon(Icons.cancel), findsNothing);
    });

    testWidgets('shows clear icon when focused and has content', (tester) async {
      await tester.pumpWidget(_wrap(const TalkSearchField()));
      await tester.tap(find.byType(TextField));
      await tester.enterText(find.byType(TextField), 'flutter');
      await tester.pump();
      expect(find.byIcon(Icons.cancel), findsOneWidget);
    });

    testWidgets('tapping clear icon empties the field', (tester) async {
      await tester.pumpWidget(_wrap(const TalkSearchField()));
      await tester.tap(find.byType(TextField));
      await tester.enterText(find.byType(TextField), 'flutter');
      await tester.pump();
      await tester.tap(find.byIcon(Icons.cancel));
      await tester.pump();
      expect(find.text('flutter'), findsNothing);
      expect(find.byIcon(Icons.cancel), findsNothing);
    });

    testWidgets('search icon still visible after typing', (tester) async {
      await tester.pumpWidget(_wrap(const TalkSearchField()));
      await tester.tap(find.byType(TextField));
      await tester.enterText(find.byType(TextField), 'query');
      await tester.pump();
      expect(find.byIcon(Icons.search), findsOneWidget);
    });

    testWidgets('onSubmitted fires with search action', (tester) async {
      String? submitted;
      await tester.pumpWidget(_wrap(TalkSearchField(onSubmitted: (v) => submitted = v)));
      await tester.enterText(find.byType(TextField), 'hello');
      await tester.testTextInput.receiveAction(TextInputAction.search);
      await tester.pump();
      expect(submitted, 'hello');
    });
  });
}
