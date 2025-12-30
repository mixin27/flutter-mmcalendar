import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_mmcalendar/flutter_mmcalendar.dart';

void main() {
  group('MyanmarCalendarWidget Selection Tests', () {
    testWidgets('Single selection mode works', (WidgetTester tester) async {
      DateTime? selectedDate;
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: MyanmarCalendarWidget(
              selectionMode: CalendarSelectionMode.single,
              onDateSelected: (date) {
                selectedDate = date.western.toDateTime();
              },
            ),
          ),
        ),
      );

      // Find a day (e.g., 15) and tap it
      // Note: We need to find the specific day cell.
      // Based on implementation, date cells have GestureDetector/InkWell
      final day15 = find.text('15').first;
      await tester.tap(day15);
      await tester.pump();

      expect(selectedDate, isNotNull);
      expect(selectedDate!.day, 15);
    });

    testWidgets('Range selection mode works', (WidgetTester tester) async {
      DateTime? rangeStart;
      DateTime? rangeEnd;
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: MyanmarCalendarWidget(
              selectionMode: CalendarSelectionMode.range,
              onRangeSelected: (start, end) {
                rangeStart = start;
                rangeEnd = end;
              },
            ),
          ),
        ),
      );

      // Tap day 10
      await tester.tap(find.text('10').first);
      await tester.pump();
      expect(rangeStart!.day, 10);
      expect(rangeEnd, isNull);

      // Tap day 20
      await tester.tap(find.text('20').first);
      await tester.pump();
      expect(rangeStart!.day, 10);
      expect(rangeEnd!.day, 20);
    });

    testWidgets('Multi selection mode works', (WidgetTester tester) async {
      List<DateTime> selectedDates = [];
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: MyanmarCalendarWidget(
              selectionMode: CalendarSelectionMode.multi,
              onMultiSelected: (dates) {
                selectedDates = dates;
              },
            ),
          ),
        ),
      );

      await tester.tap(find.text('5').first);
      await tester.pump();
      expect(selectedDates.length, 1);

      await tester.tap(find.text('10').first);
      await tester.pump();
      expect(selectedDates.length, 2);

      // Deselect 5
      await tester.tap(find.text('5').first);
      await tester.pump();
      expect(selectedDates.length, 1);
      expect(selectedDates.first.day, 10);
    });
  });
}
