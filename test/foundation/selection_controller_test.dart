import 'package:flutter_mmcalendar/flutter_mmcalendar.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  final oct18 = DateTime(2026, 10, 18);

  group('SingleSelection', () {
    test('keeps the date only, and replaces it on tap', () {
      final s = SingleSelection(DateTime(2026, 10, 18, 15, 30));
      expect(s.date, oct18);
      expect(s.contains(DateTime(2026, 10, 18, 9)), isTrue);
      expect(s.select(DateTime(2026, 10, 19)).days, [DateTime(2026, 10, 19)]);
      expect(s.cleared().isEmpty, isTrue);
      expect(s, SingleSelection(oct18));
    });
  });

  group('RangeSelection', () {
    test('tap, tap after, tap again restarts', () {
      var r = RangeSelection();
      r = r.select(DateTime(2026, 10, 25));
      expect(r.isComplete, isFalse);
      expect(r.rangePositionOf(DateTime(2026, 10, 25)), RangePosition.single);
      r = r.select(DateTime(2026, 10, 27));
      expect(
        [r.start, r.end],
        [DateTime(2026, 10, 25), DateTime(2026, 10, 27)],
      );
      expect(r.length, 3);
      expect(r.rangePositionOf(DateTime(2026, 10, 25)), RangePosition.start);
      expect(r.rangePositionOf(DateTime(2026, 10, 26)), RangePosition.middle);
      expect(r.rangePositionOf(DateTime(2026, 10, 27)), RangePosition.end);
      expect(r.rangePositionOf(DateTime(2026, 10, 28)), RangePosition.none);
      r = r.select(DateTime(2026, 11, 1));
      expect([r.start, r.end], [DateTime(2026, 11, 1), null]);
    });

    test('tapping before the start moves the start', () {
      final r = RangeSelection(
        start: DateTime(2026, 10, 25),
      ).select(DateTime(2026, 10, 20));
      expect([r.start, r.end], [DateTime(2026, 10, 20), null]);
    });

    test('length counts calendar days across a daylight-saving change', () {
      final r = RangeSelection(
        start: DateTime(2026, 3, 1),
        end: DateTime(2026, 4, 30),
      );
      expect(r.length, 61);
    });
  });

  group('MultiSelection', () {
    test('tapping toggles a day', () {
      var m = MultiSelection([DateTime(2026, 10, 26)]);
      m = m.select(DateTime(2026, 10, 19));
      expect(m.days, [DateTime(2026, 10, 19), DateTime(2026, 10, 26)]);
      m = m.select(DateTime(2026, 10, 26, 8));
      expect(m.days, [DateTime(2026, 10, 19)]);
      expect(m, MultiSelection([DateTime(2026, 10, 19)]));
    });
  });

  group('MyanmarCalendarController', () {
    test('starts on the initial month, else the selection, else today', () {
      expect(
        MyanmarCalendarController(initialMonth: oct18).visibleMonth,
        DateTime(2026, 10),
      );
      expect(
        MyanmarCalendarController(
          selection: SingleSelection(DateTime(2026, 4, 14)),
        ).visibleMonth,
        DateTime(2026, 4),
      );
      final now = DateTime.now();
      expect(
        MyanmarCalendarController().visibleMonth,
        DateTime(now.year, now.month),
      );
    });

    test('moves between months within the bounds', () {
      final c = MyanmarCalendarController(
        initialMonth: oct18,
        firstDate: DateTime(2026, 9, 15),
        lastDate: DateTime(2026, 11, 5),
      );
      var notified = 0;
      c.addListener(() => notified++);
      expect(c.monthCount, 3);
      c.nextMonth();
      expect(c.visibleMonth, DateTime(2026, 11));
      expect(c.canGoNext, isFalse);
      c.nextMonth();
      expect(c.visibleMonth, DateTime(2026, 11));
      c
        ..previousMonth()
        ..previousMonth();
      expect(c.visibleMonth, DateTime(2026, 9));
      expect(c.canGoPrevious, isFalse);
      expect(notified, 3);
      c.jumpTo(DateTime(2030));
      expect(c.visibleMonth, DateTime(2026, 11));
    });

    test('a month in December rolls into the next year', () {
      final c = MyanmarCalendarController(initialMonth: DateTime(2026, 12));
      c.nextMonth();
      expect(c.visibleMonth, DateTime(2027));
    });

    test('selects only selectable days', () {
      final c = MyanmarCalendarController(
        initialMonth: oct18,
        firstDate: DateTime(2026, 10),
        selection: MultiSelection(),
        selectableDayPredicate: (d) => d.weekday != DateTime.sunday,
      );
      expect(c.select(DateTime(2026, 9, 30)), isFalse);
      expect(c.select(oct18), isFalse); // a Sunday
      expect(c.select(DateTime(2026, 10, 19)), isTrue);
      expect(c.selection.days, [DateTime(2026, 10, 19)]);
      c.clearSelection();
      expect(c.selection, MultiSelection());
    });
  });
}
