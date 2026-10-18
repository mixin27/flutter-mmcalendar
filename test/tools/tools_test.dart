import 'package:flutter/material.dart';
import 'package:flutter_mmcalendar/flutter_mmcalendar.dart';
import 'package:flutter_test/flutter_test.dart';

DateTime _clock() => DateTime(2026, 10, 18, 9);

Future<void> _pump(WidgetTester tester, Widget child) async {
  tester.view
    ..physicalSize = const Size(420, 900)
    ..devicePixelRatio = 1;
  addTearDown(tester.view.reset);
  await tester.pumpWidget(
    MyanmarCalendarScope(
      style: MmVisualStyle.material,
      child: MaterialApp(
        home: Scaffold(
          body: SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: child,
          ),
        ),
      ),
    ),
  );
}

void main() {
  final client = MyanmarCalendarClient();
  double jdnOf(int y, int m, int d) =>
      client.getCompleteDateFor(y, m, d).myanmar.julianDayNumber;

  group('MyanmarDateConverter', () {
    testWidgets('shows both calendars, swaps and picks', (tester) async {
      CompleteDate? changed;
      await _pump(
        tester,
        MyanmarDateConverter(
          initialDate: DateTime(2026, 10, 18),
          onChanged: (d) => changed = d,
        ),
      );
      expect(find.text('18 October 2026'), findsOneWidget);
      expect(find.text('1388 Thadingyut Waxing 7'), findsOneWidget);
      expect(find.text('Sasana Year 2570 · Shan year 2120'), findsOneWidget);
      double top(String text) => tester.getTopLeft(find.text(text)).dy;
      expect(top('18 October 2026'), lessThan(top('1388 Thadingyut Waxing 7')));

      await tester.tap(find.byTooltip('Swap'));
      await tester.pumpAndSettle();
      expect(top('1388 Thadingyut Waxing 7'), lessThan(top('18 October 2026')));

      await tester.tap(find.text('18 October 2026'));
      await tester.pumpAndSettle();
      await tester.tap(
        find.byWidgetPredicate(
          (w) => w is MyanmarDayCell && w.data.day == DateTime(2026, 10, 26),
        ),
      );
      await tester.pump();
      await tester.tap(find.text('OK'));
      await tester.pumpAndSettle();
      expect(changed!.western.day, 26);
      expect(find.text('1388 Thadingyut Full Moon'), findsOneWidget);
    });
  });

  group('DateDifferenceCard', () {
    test('adds days and Myanmar months', () {
      expect(
        DateDifferenceCard.add(
          client,
          DateTime(2026, 10, 18),
          1,
          DateStep.myanmarMonths,
        ),
        DateTime(2026, 11, 16), // Tazaungmon Waxing 7
      );
      expect(
        DateDifferenceCard.add(
          client,
          DateTime(2026, 10, 18),
          -18,
          DateStep.days,
        ),
        DateTime(2026, 9, 30),
      );
      expect(
        DateDifferenceCard.daysBetween(
          DateTime(2026, 3, 1),
          DateTime(2026, 4, 1),
        ),
        31,
      );
      expect(
        DateDifferenceCard.daysBetween(
          DateTime(2026, 10, 26),
          DateTime(2026, 10, 18),
        ),
        -8,
      );
    });

    testWidgets('shows the gap and the result', (tester) async {
      await _pump(
        tester,
        DateDifferenceCard(
          from: DateTime(2026, 10, 18),
          to: DateTime(2026, 10, 26),
        ),
      );
      expect(find.text('8 days'), findsOneWidget);
      expect(find.text('Tazaungmon Waxing 7'), findsOneWidget);
      expect(find.text('Monday, 16 November 2026'), findsOneWidget);

      await tester.tap(find.text('Day'));
      await tester.pumpAndSettle();
      expect(find.text('Monday, 19 October 2026'), findsOneWidget);
      await tester.tap(find.byTooltip('+1'));
      await tester.pump();
      expect(find.text('Tuesday, 20 October 2026'), findsOneWidget);
    });
  });

  group('AIPromptAction', () {
    testWidgets('hands over the prompt for the chosen kind', (tester) async {
      AIPromptType? type;
      String? text;
      await _pump(
        tester,
        AIPromptAction(
          clock: _clock,
          onPrompt: (t, p) {
            type = t;
            text = p;
          },
        ),
      );
      expect(find.textContaining('horoscope reading'), findsOneWidget);
      await tester.tap(find.text('Fortune'));
      await tester.pumpAndSettle();
      await tester.tap(find.text('Copy prompt'));
      expect(type, AIPromptType.fortuneTelling);
      expect(text, contains('fortune-telling reading'));
      expect(text, contains('Thadingyut'));
    });
  });

  group('ChronicleCard', () {
    test('finds every era running on a date', () {
      final eras = ChronicleCard.erasAt(client, jdnOf(1850, 1, 1));
      expect(eras.map((e) => e.id), ['konbaung']);
      // In 1500 several kingdoms ran side by side.
      final in1500 = ChronicleCard.erasAt(client, jdnOf(1500, 1, 1));
      expect(in1500.map((e) => e.id), containsAll(['ava', 'hanthawaddy']));
      expect(in1500.length, greaterThan(2));
    });

    test('records are matched by their own date, nearest first', () {
      final jdn = jdnOf(1400, 1, 1);
      final near = ChronicleCard.recordsNear(client, jdn, windowYears: 10);
      expect(near, isNotEmpty);
      for (final r in near) {
        expect((r.entry.startJdn - jdn).abs(), lessThanOrEqualTo(3653));
        expect(r.westernYear, inInclusiveRange(1389, 1411));
      }
      for (var i = 1; i < near.length; i++) {
        expect(
          (near[i].entry.startJdn - jdn).abs(),
          greaterThanOrEqualTo((near[i - 1].entry.startJdn - jdn).abs()),
        );
      }
      // Each record is a one-day event: the core finds it on its own day.
      final first = near.first.entry;
      expect(client.getChronicleForJdn(first.startJdn), contains(first));
      expect(
        client.getChronicleForJdn(first.startJdn + 1),
        isNot(contains(first)),
      );
    });

    testWidgets('shows the era and nearby records', (tester) async {
      await _pump(tester, ChronicleCard(date: DateTime(1850), clock: _clock));
      expect(find.text('History'), findsOneWidget);
      expect(find.text('Konbaung'), findsOneWidget);
    });

    testWidgets('says so when there is nothing', (tester) async {
      await _pump(tester, ChronicleCard(clock: _clock));
      expect(find.text('No records for this date'), findsOneWidget);
    });
  });
}
