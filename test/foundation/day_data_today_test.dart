import 'package:flutter/material.dart';
import 'package:flutter_mmcalendar/flutter_mmcalendar.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  final client = MyanmarCalendarClient();
  CompleteDate day(int m, int d) =>
      client.getCompleteDateFor(2026, m, d, language: Language.english);

  group('MyanmarDayData.resolve', () {
    test('works out the cell state', () {
      final data = MyanmarDayData.resolve(
        date: day(10, 26),
        today: DateTime(2026, 10, 18, 21),
        visibleMonth: DateTime(2026, 10),
        selection: RangeSelection(
          start: DateTime(2026, 10, 25),
          end: DateTime(2026, 10, 27),
        ),
        events: const ['Lights at Shwedagon'],
      );
      expect(data.day, DateTime(2026, 10, 26));
      expect(data.isToday, isFalse);
      expect(data.isSelected, isTrue);
      expect(data.rangePosition, RangePosition.middle);
      expect(data.isOutside, isFalse);
      expect(data.isWeekend, isFalse);
      expect(data.events, ['Lights at Shwedagon']);
      // Thadingyut full moon: End of Buddhist Lent and a Sabbath.
      expect(data.moonPhase, MoonPhase.fullMoon);
      expect(data.isMoonDay, isTrue);
      expect(data.sabbath, SabbathType.sabbath);
      expect(
        data.holidays.map((h) => h.id),
        contains(HolidayId.endOfBuddhistLent),
      );
    });

    test('flags today, outside days, weekends and disabled days', () {
      final today = MyanmarDayData.resolve(
        date: day(10, 18),
        today: DateTime(2026, 10, 18),
        visibleMonth: DateTime(2026, 10),
      );
      expect(today.isToday, isTrue);
      expect(today.isWeekend, isTrue);

      final outside = MyanmarDayData.resolve(
        date: day(9, 30),
        today: DateTime(2026, 10, 18),
        visibleMonth: DateTime(2026, 10),
        isSelectable: (d) => d.month == 10,
      );
      expect(outside.isOutside, isTrue);
      expect(outside.isDisabled, isTrue);
    });

    test('the day after a public holiday is one too at Thadingyut', () {
      final data = MyanmarDayData.resolve(
        date: day(10, 27),
        today: DateTime(2026, 10, 18),
      );
      expect(data.isPublicHoliday, isTrue);
    });
  });

  group('TodayBuilder', () {
    testWidgets('rebuilds with the new day after midnight', (tester) async {
      var now = DateTime(2026, 10, 18, 23, 59, 30);
      final days = <DateTime>[];
      await tester.pumpWidget(
        TodayBuilder(
          clock: () => now,
          builder: (context, today) {
            days.add(today);
            return const SizedBox();
          },
        ),
      );
      expect(days.last, DateTime(2026, 10, 18));

      now = DateTime(2026, 10, 19, 0, 0, 1);
      await tester.pump(const Duration(seconds: 31));
      expect(days.last, DateTime(2026, 10, 19));
    });

    testWidgets('re-reads the date when the app resumes', (tester) async {
      var now = DateTime(2026, 10, 18, 9);
      final days = <DateTime>[];
      await tester.pumpWidget(
        TodayBuilder(
          clock: () => now,
          builder: (context, today) {
            days.add(today);
            return const SizedBox();
          },
        ),
      );
      now = DateTime(2026, 10, 20, 9);
      tester.binding.handleAppLifecycleStateChanged(AppLifecycleState.paused);
      tester.binding.handleAppLifecycleStateChanged(AppLifecycleState.resumed);
      await tester.pump();
      expect(days.last, DateTime(2026, 10, 20));
    });
  });
}
