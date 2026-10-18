import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_mmcalendar/flutter_mmcalendar.dart';
import 'package:flutter_test/flutter_test.dart';

DateTime _clock() => DateTime(2026, 10, 18, 9);

Widget _host(
  Widget child, {
  Language language = Language.english,
  MmVisualStyle style = MmVisualStyle.material,
}) => MyanmarCalendarScope(
  language: language,
  style: style,
  child: MaterialApp(
    home: Scaffold(body: SingleChildScrollView(child: child)),
  ),
);

void main() {
  group('MyanmarDateText', () {
    testWidgets('formats with Myanmar and Western patterns', (tester) async {
      await tester.pumpWidget(
        _host(
          Column(
            children: [
              MyanmarDateText(DateTime(2026, 10, 18), pattern: '&y &M &P &ff'),
              MyanmarDateText(
                DateTime(2026, 10, 18),
                pattern: '&M &P &ff',
                westernPattern: '%d %MMM %yyyy',
              ),
            ],
          ),
        ),
      );
      expect(find.text('1388 Thadingyut Waxing 07'), findsOneWidget);
      expect(find.text('Thadingyut Waxing 07 · 18 OCT 2026'), findsOneWidget);
    });

    testWidgets('.today turns over at midnight', (tester) async {
      var now = DateTime(2026, 10, 18, 23, 59, 50);
      await tester.pumpWidget(
        _host(MyanmarDateText.today(pattern: '&P &ff', clock: () => now)),
      );
      expect(find.text('Waxing 07'), findsOneWidget);
      now = DateTime(2026, 10, 19, 0, 0, 2);
      await tester.pump(const Duration(seconds: 12));
      expect(find.text('Waxing 08'), findsOneWidget);
    });
  });

  group('MyanmarTodayCard', () {
    testWidgets('shows the day, years, moon and badges', (tester) async {
      CompleteDate? tapped;
      await tester.pumpWidget(
        _host(MyanmarTodayCard(clock: _clock, onTap: (d) => tapped = d)),
      );
      expect(find.text('18'), findsOneWidget);
      expect(find.text('Thadingyut Waxing 7'), findsOneWidget);
      expect(find.text('Myanmar Year 1388 · Sasana Year 2570'), findsOneWidget);
      expect(find.text('Sabbath Eve'), findsOneWidget);
      expect(find.text('Pyathada'), findsOneWidget);
      expect(find.byType(MoonGlyph), findsOneWidget);
      await tester.tap(find.byType(MyanmarTodayCard));
      expect(tapped!.western.day, 18);
    });

    testWidgets('a holiday shows its badge', (tester) async {
      await tester.pumpWidget(
        _host(MyanmarTodayCard(date: DateTime(2026, 10, 26), clock: _clock)),
      );
      expect(find.text('End of Buddhist Lent'), findsOneWidget);
      expect(find.text('Sabbath'), findsOneWidget);
    });

    testWidgets('compact is a square', (tester) async {
      await tester.pumpWidget(
        _host(Center(child: MyanmarTodayCard.compact(clock: _clock))),
      );
      final size = tester.getSize(find.byType(MyanmarTodayCard));
      expect(size.width, size.height);
    });

    testWidgets('reads in Myanmar', (tester) async {
      await tester.pumpWidget(
        _host(MyanmarTodayCard(clock: _clock), language: Language.myanmar),
      );
      expect(find.text('၁၈'), findsOneWidget);
    });
  });

  group('MyanmarDayDetails', () {
    testWidgets('lists the sections and copies a date', (tester) async {
      final copied = <String>[];
      String? clipboard;
      tester.binding.defaultBinaryMessenger.setMockMethodCallHandler(
        SystemChannels.platform,
        (call) async {
          if (call.method == 'Clipboard.setData') {
            clipboard = (call.arguments as Map)['text'] as String;
          }
          return null;
        },
      );
      await tester.pumpWidget(
        _host(
          MyanmarDayDetails(
            date: DateTime(2026, 10, 26),
            clock: _clock,
            onCopied: copied.add,
          ),
        ),
      );
      expect(find.text('Monday, 26 October 2026'), findsOneWidget);
      expect(find.text('1388 Thadingyut Full Moon'), findsOneWidget);
      expect(find.text('2570'), findsOneWidget);
      expect(find.text('End of Buddhist Lent'), findsWidgets);
      expect(find.text('Mahabote'), findsOneWidget);

      await tester.tap(find.byTooltip('Copy').first);
      await tester.pump();
      expect(clipboard, 'Monday, 26 October 2026');
      expect(copied, ['Monday, 26 October 2026']);
    });

    testWidgets('shows only the chosen sections', (tester) async {
      await tester.pumpWidget(
        _host(
          MyanmarDayDetails(
            date: DateTime(2026, 10, 21),
            clock: _clock,
            sections: const [DaySection.holidays],
          ),
        ),
      );
      expect(find.text('No holidays'), findsOneWidget);
      expect(find.text('Dates'), findsNothing);
    });
  });

  group('HolidayList', () {
    testWidgets('lists what is coming with a countdown', (tester) async {
      await tester.pumpWidget(
        _host(HolidayList.upcoming(clock: _clock, days: 40)),
      );
      expect(find.text('Upcoming holidays'), findsOneWidget);
      expect(find.text('in 7 days'), findsOneWidget); // 25 October
      expect(find.text('in 8 days'), findsOneWidget); // End of Lent
      expect(find.text('End of Buddhist Lent'), findsOneWidget);
      expect(find.text('Halloween'), findsNothing); // an anniversary
    });

    test('find honours types, limits and custom holidays', () {
      final family = CustomHoliday.westernDate(
        id: 'family',
        name: 'Family day',
        type: HolidayType.otherAnniversary,
        month: 10,
        day: 20,
      );
      final scope = MyanmarCalendarScopeData(
        client: MyanmarCalendarClient(
          config: CalendarConfig(customHolidays: [family]),
        ),
        language: Language.english,
      );
      final found = HolidayList.find(
        scope,
        from: DateTime(2026, 10, 18),
        days: 30,
        types: const {HolidayType.public},
      );
      expect(found.first.holiday.name, 'Family day');
      expect(found.first.date, DateTime(2026, 10, 20));
      expect(
        found.where((o) => o.holiday.type == HolidayType.public).length,
        2,
      );
      expect(
        HolidayList.find(
          scope,
          from: DateTime(2026, 10, 18),
          days: 30,
          types: const {HolidayType.public},
          limit: 1,
        ),
        hasLength(1),
      );
    });
  });

  group('astrology', () {
    testWidgets('the card names the day in the calendar language', (
      tester,
    ) async {
      await tester.pumpWidget(_host(AstrologyCard(clock: _clock)));
      expect(find.text('Atun'), findsOneWidget);
      expect(find.text('Human'), findsOneWidget);
      expect(find.text('Bhadrapaha'), findsOneWidget);
      expect(find.text('East'), findsOneWidget);
      expect(find.text('Sabbath Eve'), findsOneWidget);

      await tester.pumpWidget(
        _host(AstrologyCard(clock: _clock), language: Language.myanmar),
      );
      expect(
        find.text(TranslationService.translateTo('Atun', Language.myanmar)),
        findsOneWidget,
      );
    });

    testWidgets('the compass points where the dragon faces', (tester) async {
      expect(NagahleCompass.angleOf('North'), 0);
      expect(NagahleCompass.angleOf('South'), closeTo(3.1416, 1e-3));
      final semantics = tester.ensureSemantics();
      await tester.pumpWidget(_host(NagahleCompass(clock: _clock)));
      expect(find.bySemanticsLabel('Naga Head: East'), findsOneWidget);
      semantics.dispose();
    });
  });

  group('moon', () {
    testWidgets('the strip shows a month\'s quarter days', (tester) async {
      await tester.pumpWidget(
        _host(const MoonPhaseStrip(year: 1388, month: 7)),
      );
      expect(find.text('Waxing 8'), findsOneWidget);
      expect(find.text('Full Moon'), findsOneWidget);
      expect(find.text('Waning 8'), findsOneWidget);
      expect(find.text('New Moon'), findsOneWidget);
      expect(find.text('19 Oct'), findsOneWidget);
      expect(find.text('26 Oct'), findsOneWidget);
      expect(find.text('3 Nov'), findsOneWidget);
      expect(find.text('9 Nov'), findsOneWidget);
    });

    testWidgets('the countdown counts from today', (tester) async {
      await tester.pumpWidget(_host(NextMoonCountdown(clock: _clock)));
      expect(find.text('in 8 days'), findsOneWidget); // full moon, 26 Oct
      expect(find.text('in 22 days'), findsOneWidget); // new moon, 9 Nov
      expect(find.text('Tomorrow'), findsOneWidget); // Sabbath, 19 Oct
    });
  });
}
