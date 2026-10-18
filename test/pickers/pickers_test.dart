import 'package:flutter/material.dart';
import 'package:flutter_mmcalendar/flutter_mmcalendar.dart';
import 'package:flutter_test/flutter_test.dart';

DateTime _clock() => DateTime(2026, 10, 18, 9);

/// A page with a button that runs [open], sized like a phone.
Future<void> _pumpOpener(
  WidgetTester tester,
  Future<void> Function(BuildContext context) open, {
  MmVisualStyle style = MmVisualStyle.material,
}) async {
  tester.view
    ..physicalSize = const Size(420, 900)
    ..devicePixelRatio = 1;
  addTearDown(tester.view.reset);
  await tester.pumpWidget(
    MyanmarCalendarScope(
      style: style,
      child: MaterialApp(
        home: Scaffold(
          body: Builder(
            builder: (context) => Center(
              child: TextButton(
                onPressed: () => open(context),
                child: const Text('Open'),
              ),
            ),
          ),
        ),
      ),
    ),
  );
  await tester.tap(find.text('Open'));
  await tester.pumpAndSettle();
}

Finder _day(int day) => find.byWidgetPredicate(
  (w) => w is MyanmarDayCell && w.data.day.day == day && !w.data.isOutside,
);

Widget _host(Widget child, {MmVisualStyle style = MmVisualStyle.material}) =>
    MyanmarCalendarScope(
      style: style,
      child: MaterialApp(
        home: Scaffold(body: Center(child: child)),
      ),
    );

void main() {
  group('MyanmarDateWheelPicker', () {
    testWidgets('starts on the initial day and reports wheel changes', (
      tester,
    ) async {
      CompleteDate? changed;
      await tester.pumpWidget(
        _host(
          MyanmarDateWheelPicker(
            initialDate: DateTime(2026, 10, 18),
            onChanged: (d) => changed = d,
          ),
        ),
      );
      expect(find.text('1388'), findsOneWidget);
      expect(find.text('Thadingyut'), findsOneWidget);
      expect(find.text('Waxing 7'), findsOneWidget);

      // Two rows down the day wheel: Waxing 9, 20 October.
      await tester.drag(find.text('Waxing 7'), const Offset(0, -76));
      await tester.pumpAndSettle();
      expect(changed!.myanmar.fortnightDay, 9);
      expect(changed!.western.day, 20);
    });

    testWidgets('a year without First Waso moves it to Waso', (tester) async {
      final client = MyanmarCalendarClient();
      final firstWaso = MyanmarLunarMonthCalendar.westernOf(
        client.getMyanmarMonth(1388, 0).first,
      );
      CompleteDate? changed;
      await tester.pumpWidget(
        _host(
          MyanmarDateWheelPicker(
            initialDate: firstWaso,
            onChanged: (d) => changed = d,
          ),
        ),
      );
      expect(find.text('First Waso'), findsOneWidget);
      // Two years back: 1386 is a common year.
      await tester.drag(find.text('1388'), const Offset(0, 76));
      await tester.pumpAndSettle();
      expect(changed!.myanmar.year, 1386);
      expect(changed!.myanmar.month, 4);
    });

    test('every day the wheels can offer round-trips to itself', () {
      final client = MyanmarCalendarClient();
      for (var year = 1380; year <= 1392; year++) {
        for (final month in MyanmarLunarMonthCalendar.monthsOf(client, year)) {
          for (final d in client.getMyanmarMonth(year, month)) {
            final w = MyanmarLunarMonthCalendar.westernOf(d);
            final back = client
                .getCompleteDateFor(w.year, w.month, w.day)
                .myanmar;
            expect(
              [back.year, back.month, back.day],
              [d.year, d.month, d.day],
              reason: '$year/$month/${d.day}',
            );
          }
        }
      }
    });
  });

  testWidgets('the wheels select the day they show', (tester) async {
    CompleteDate? result;
    await _pumpOpener(tester, style: MmVisualStyle.glass, (context) async {
      result = await showMyanmarDatePicker(
        context: context,
        inputMode: MyanmarPickerInput.wheels,
        clock: _clock,
      );
    });
    expect(find.text('Sunday, 18 October 2026'), findsOneWidget);
    await tester.tap(find.text('Done'));
    await tester.pumpAndSettle();
    expect(result!.western.day, 18);
  });

  group('MyanmarMonthYearPicker', () {
    testWidgets('picks a month and respects the bounds', (tester) async {
      DateTime? picked;
      await tester.pumpWidget(
        _host(
          SizedBox(
            width: 360,
            child: MyanmarMonthYearPicker(
              selectedMonth: DateTime(2026, 10),
              lastDate: DateTime(2026, 11, 15),
              onChanged: (m) => picked = m,
            ),
          ),
        ),
      );
      expect(find.text('Pyatho 1387 – Nadaw 1388'), findsOneWidget);
      await tester.tap(find.text('March'));
      expect(picked, DateTime(2026, 3));
      await tester.tap(find.text('December'));
      expect(picked, DateTime(2026, 3));
      expect(
        tester
            .widget<MmIconButton>(
              find.widgetWithIcon(MmIconButton, Icons.chevron_right),
            )
            .onPressed,
        isNull,
      );
    });
  });

  group('showMyanmarDatePicker', () {
    testWidgets('material: a dialog that returns the tapped day', (
      tester,
    ) async {
      CompleteDate? result;
      await _pumpOpener(tester, (context) async {
        result = await showMyanmarDatePicker(
          context: context,
          initialDate: DateTime(2026, 10, 18),
          clock: _clock,
        );
      });
      expect(find.byType(Dialog), findsOneWidget);
      expect(find.text('Sunday, 18 October 2026'), findsOneWidget);
      await tester.tap(_day(26));
      await tester.pump();
      expect(find.text('1388 Thadingyut Full Moon'), findsOneWidget);
      await tester.tap(find.text('OK'));
      await tester.pumpAndSettle();
      expect(result!.western.day, 26);
    });

    testWidgets('cancel returns null', (tester) async {
      CompleteDate? result;
      var closed = false;
      await _pumpOpener(tester, (context) async {
        result = await showMyanmarDatePicker(
          context: context,
          initialDate: DateTime(2026, 10, 18),
          clock: _clock,
        );
        closed = true;
      });
      await tester.tap(find.text('Cancel'));
      await tester.pumpAndSettle();
      expect(closed, isTrue);
      expect(result, isNull);
    });

    testWidgets('cupertino: a sheet with a Myanmar input switch', (
      tester,
    ) async {
      CompleteDate? result;
      await _pumpOpener(tester, style: MmVisualStyle.cupertino, (
        context,
      ) async {
        result = await showMyanmarDatePicker(
          context: context,
          initialDate: DateTime(2026, 10, 18),
          clock: _clock,
        );
      });
      expect(find.byType(Dialog), findsNothing);
      await tester.tap(find.text('Myanmar'));
      await tester.pumpAndSettle();
      expect(find.byType(MyanmarDateWheelPicker), findsOneWidget);
      await tester.drag(find.text('Waxing 7'), const Offset(0, -38));
      await tester.pumpAndSettle();
      await tester.tap(find.text('Done'));
      await tester.pumpAndSettle();
      expect(result!.western.day, 19);
    });

    testWidgets('jumps months from the month-year grid', (tester) async {
      await _pumpOpener(tester, (context) async {
        await showMyanmarDatePicker(
          context: context,
          initialDate: DateTime(2026, 10, 18),
          clock: _clock,
        );
      });
      await tester.tap(find.text('October 2026'));
      await tester.pumpAndSettle();
      await tester.tap(find.text('April'));
      await tester.pumpAndSettle();
      expect(find.text('April 2026'), findsOneWidget);
    });
  });

  testWidgets('range picker: Done waits for both ends', (tester) async {
    MyanmarDateRange? result;
    await _pumpOpener(tester, style: MmVisualStyle.glass, (context) async {
      result = await showMyanmarDateRangePicker(
        context: context,
        initialMonth: DateTime(2026, 10),
        clock: _clock,
      );
    });
    await tester.tap(_day(25));
    await tester.pump();
    final done = find.widgetWithText(MmButton, 'Done');
    expect(tester.widget<MmButton>(done).onPressed, isNull);
    await tester.tap(_day(27));
    await tester.pump();
    expect(find.text('3 days'), findsOneWidget);
    await tester.tap(done);
    await tester.pumpAndSettle();
    expect(result!.dayCount, 3);
    expect(result!.start.western.day, 25);
  });

  testWidgets('multi picker returns the days in order', (tester) async {
    List<CompleteDate>? result;
    await _pumpOpener(tester, (context) async {
      result = await showMyanmarMultiDatePicker(
        context: context,
        initialDates: [DateTime(2026, 10, 26)],
        clock: _clock,
      );
    });
    await tester.tap(_day(19));
    await tester.pump();
    await tester.tap(find.text('OK'));
    await tester.pumpAndSettle();
    expect(result!.map((d) => d.western.day), [19, 26]);
  });

  group('MyanmarDateFormField', () {
    for (final style in [
      MmVisualStyle.material,
      MmVisualStyle.cupertino,
      MmVisualStyle.glass,
    ]) {
      testWidgets('validates and picks (${style.name})', (tester) async {
        tester.view
          ..physicalSize = const Size(420, 900)
          ..devicePixelRatio = 1;
        addTearDown(tester.view.reset);
        final form = GlobalKey<FormState>();
        CompleteDate? changed;
        await tester.pumpWidget(
          MyanmarCalendarScope(
            style: style,
            child: MaterialApp(
              home: Scaffold(
                body: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Form(
                    key: form,
                    child: MyanmarDateFormField(
                      label: 'Ordination date',
                      hint: 'Choose a day',
                      onChanged: (d) => changed = d,
                      validator: (d) => d == null ? 'Pick a date' : null,
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
        expect(find.text('Choose a day'), findsOneWidget);
        expect(form.currentState!.validate(), isFalse);
        await tester.pump();
        expect(find.text('Pick a date'), findsOneWidget);

        await tester.tap(find.text('Choose a day'));
        await tester.pumpAndSettle();
        // The picker opens on this month; pick the 10th.
        await tester.tap(_day(10));
        await tester.pump();
        await tester.tap(
          find.text(style == MmVisualStyle.material ? 'OK' : 'Done'),
        );
        await tester.pumpAndSettle();
        expect(changed!.western.day, 10);
        expect(form.currentState!.validate(), isTrue);
        await tester.pump();
        expect(find.text('Pick a date'), findsNothing);
      });
    }
  });
}
