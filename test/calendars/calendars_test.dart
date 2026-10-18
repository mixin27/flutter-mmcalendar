import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_mmcalendar/flutter_mmcalendar.dart';
import 'package:flutter_test/flutter_test.dart';

DateTime _clock() => DateTime(2026, 10, 18, 9);

Widget _host(
  Widget child, {
  Language language = Language.english,
  int firstDayOfWeek = DateTime.sunday,
  double textScale = 1,
  Size size = const Size(400, 800),
}) => MyanmarCalendarScope(
  language: language,
  style: MmVisualStyle.material,
  firstDayOfWeek: firstDayOfWeek,
  child: MaterialApp(
    home: MediaQuery(
      data: MediaQueryData(
        size: size,
        textScaler: TextScaler.linear(textScale),
      ),
      child: Scaffold(body: child),
    ),
  ),
);

Finder _day(int day, {String month = 'October'}) => find.byWidgetPredicate(
  (w) =>
      w is MyanmarDayCell &&
      w.data.day.day == day &&
      DateUtils.isSameMonth(
        w.data.day,
        DateTime(2026, month == 'October' ? 10 : 11),
      ),
);

void main() {
  group('MyanmarMonthCalendar', () {
    testWidgets('shows both calendars in the header and selects a day', (
      tester,
    ) async {
      CompleteDate? tapped;
      CalendarSelection? changed;
      final controller = MyanmarCalendarController(
        initialMonth: DateTime(2026, 10),
      );
      await tester.pumpWidget(
        _host(
          MyanmarMonthCalendar(
            controller: controller,
            clock: _clock,
            onDayTapped: (d) => tapped = d,
            onSelectionChanged: (s) => changed = s,
          ),
        ),
      );
      expect(find.text('October 2026'), findsOneWidget);
      expect(find.text('Tawthalin – Thadingyut 1388'), findsOneWidget);

      await tester.tap(_day(26));
      await tester.pump();
      expect(tapped!.myanmar.phase, MoonPhase.fullMoon);
      expect(changed, SingleSelection(DateTime(2026, 10, 26)));
      expect(tester.widget<MyanmarDayCell>(_day(26)).data.isSelected, isTrue);
    });

    testWidgets('selects a range and several days', (tester) async {
      final range = MyanmarCalendarController(
        initialMonth: DateTime(2026, 10),
        selection: RangeSelection(),
      );
      await tester.pumpWidget(
        _host(MyanmarMonthCalendar(controller: range, clock: _clock)),
      );
      await tester.tap(_day(25));
      await tester.tap(_day(27));
      await tester.pump();
      expect(
        range.selection,
        RangeSelection(
          start: DateTime(2026, 10, 25),
          end: DateTime(2026, 10, 27),
        ),
      );
      expect(
        tester.widget<MyanmarDayCell>(_day(26)).data.rangePosition,
        RangePosition.middle,
      );

      final multi = MyanmarCalendarController(
        initialMonth: DateTime(2026, 10),
        selection: MultiSelection(),
      );
      await tester.pumpWidget(
        _host(MyanmarMonthCalendar(controller: multi, clock: _clock)),
      );
      await tester.tap(_day(19));
      await tester.tap(_day(26));
      await tester.tap(_day(19));
      await tester.pump();
      expect(multi.selection.days, [DateTime(2026, 10, 26)]);
    });

    testWidgets('starts the week on the chosen day', (tester) async {
      await tester.pumpWidget(
        _host(
          MyanmarMonthCalendar(
            controller: MyanmarCalendarController(
              initialMonth: DateTime(2026, 10),
            ),
            clock: _clock,
          ),
          firstDayOfWeek: DateTime.monday,
        ),
      );
      final cells = tester.widgetList<MyanmarDayCell>(
        find.byType(MyanmarDayCell),
      );
      // 1 October 2026 is a Thursday: the Monday row starts on 28 September.
      expect(cells.first.data.day, DateTime(2026, 9, 28));
      final labels = tester.widgetList<Text>(
        find.descendant(
          of: find.byType(MyanmarMonthCalendar),
          matching: find.text('Mon'),
        ),
      );
      expect(labels, isNotEmpty);
    });

    testWidgets('swipes and the controller move between months', (
      tester,
    ) async {
      final months = <DateTime>[];
      final controller = MyanmarCalendarController(
        initialMonth: DateTime(2026, 10),
      );
      await tester.pumpWidget(
        _host(
          MyanmarMonthCalendar(
            controller: controller,
            clock: _clock,
            onMonthChanged: months.add,
          ),
        ),
      );
      await tester.fling(find.byType(PageView), const Offset(-300, 0), 1000);
      await tester.pumpAndSettle();
      expect(controller.visibleMonth, DateTime(2026, 11));
      expect(find.text('November 2026'), findsOneWidget);

      controller.previousMonth();
      await tester.pumpAndSettle();
      expect(find.text('October 2026'), findsOneWidget);
      expect(months, [DateTime(2026, 11), DateTime(2026, 10)]);

      await tester.tap(find.byTooltip('Next month'));
      await tester.pumpAndSettle();
      expect(controller.visibleMonth, DateTime(2026, 11));
    });

    testWidgets('arrow keys move focus and Enter selects', (tester) async {
      final controller = MyanmarCalendarController(
        initialMonth: DateTime(2026, 10),
        selection: SingleSelection(DateTime(2026, 10, 18)),
      );
      await tester.pumpWidget(
        _host(MyanmarMonthCalendar(controller: controller, clock: _clock)),
      );
      final focus = Focus.of(tester.element(find.byType(PageView)));
      focus.requestFocus();
      await tester.pump();
      await tester.sendKeyEvent(LogicalKeyboardKey.arrowRight);
      await tester.sendKeyEvent(LogicalKeyboardKey.arrowDown);
      await tester.pump();
      expect(tester.widget<MyanmarDayCell>(_day(26)).focused, isTrue);
      await tester.sendKeyEvent(LogicalKeyboardKey.enter);
      await tester.pump();
      expect(controller.selection, SingleSelection(DateTime(2026, 10, 26)));

      // Moving past the month's end brings the next month into view.
      for (var i = 0; i < 2; i++) {
        await tester.sendKeyEvent(LogicalKeyboardKey.arrowDown);
      }
      await tester.pumpAndSettle();
      expect(controller.visibleMonth, DateTime(2026, 11));
    });

    testWidgets('days outside the bounds cannot be selected', (tester) async {
      final controller = MyanmarCalendarController(
        initialMonth: DateTime(2026, 10),
        firstDate: DateTime(2026, 10, 10),
        lastDate: DateTime(2026, 10, 31),
      );
      await tester.pumpWidget(
        _host(MyanmarMonthCalendar(controller: controller, clock: _clock)),
      );
      expect(tester.widget<MyanmarDayCell>(_day(5)).data.isDisabled, isTrue);
      await tester.tap(_day(5));
      expect(controller.selection.isEmpty, isTrue);
      expect(controller.canGoNext, isFalse);
    });

    testWidgets('reads each day in the calendar language', (tester) async {
      final semantics = tester.ensureSemantics();
      await tester.pumpWidget(
        _host(
          MyanmarMonthCalendar(
            controller: MyanmarCalendarController(
              initialMonth: DateTime(2026, 10),
            ),
            clock: _clock,
          ),
        ),
      );
      expect(
        tester.getSemantics(_day(26)).label,
        allOf(
          contains('Monday, 26 October 2026'),
          contains('Thadingyut Full Moon'),
          contains('End of Buddhist Lent'),
          contains('Sabbath'),
        ),
      );
      expect(tester.getSemantics(_day(18)).label, contains('Today'));

      await tester.pumpWidget(
        _host(
          MyanmarMonthCalendar(
            controller: MyanmarCalendarController(
              initialMonth: DateTime(2026, 10),
            ),
            clock: _clock,
          ),
          language: Language.myanmar,
        ),
      );
      await tester.pump();
      expect(
        tester.getSemantics(_day(26)).label,
        allOf(
          contains(TranslationService.getMoonPhaseName(1, Language.myanmar)),
          contains(TranslationService.translateTo('Sabbath', Language.myanmar)),
          contains('၂၆'),
          contains('ယနေ့').not,
        ),
      );
      semantics.dispose();
    });

    for (final cellStyle in MyanmarDayCellStyle.values) {
      testWidgets('large text fits: ${cellStyle.name}', (tester) async {
        tester.view
          ..physicalSize = const Size(360, 700)
          ..devicePixelRatio = 1;
        addTearDown(tester.view.reset);
        await tester.pumpWidget(
          _host(
            MyanmarMonthCalendar(
              controller: MyanmarCalendarController(
                initialMonth: DateTime(2026, 10),
              ),
              cellStyle: cellStyle,
              clock: _clock,
            ),
            textScale: 2,
            size: const Size(360, 700),
          ),
        );
        expect(tester.takeException(), isNull);
      });
    }

    testWidgets('events add a dot and are read out', (tester) async {
      final semantics = tester.ensureSemantics();
      await tester.pumpWidget(
        _host(
          MyanmarMonthCalendar(
            controller: MyanmarCalendarController(
              initialMonth: DateTime(2026, 10),
            ),
            clock: _clock,
            eventLoader: (d) =>
                d == DateTime(2026, 10, 20) ? ['Pagoda visit'] : const [],
          ),
        ),
      );
      expect(tester.getSemantics(_day(20)).label, contains('1 event'));
      semantics.dispose();
    });
  });

  group('MyanmarWeekStrip', () {
    testWidgets('shows the selected week and follows the controller', (
      tester,
    ) async {
      final controller = MyanmarCalendarController(
        selection: SingleSelection(DateTime(2026, 10, 18)),
      );
      await tester.pumpWidget(
        _host(MyanmarWeekStrip(controller: controller, clock: _clock)),
      );
      expect(find.text('18'), findsOneWidget);
      expect(find.text('24'), findsOneWidget);

      controller.selection = SingleSelection(DateTime(2026, 11, 2));
      await tester.pumpAndSettle();
      expect(find.text('2'), findsWidgets);
      expect(find.text('7'), findsWidgets);

      await tester.tap(find.text('4').first);
      expect(controller.selection, SingleSelection(DateTime(2026, 11, 4)));
    });

    testWidgets('fits large text', (tester) async {
      await tester.pumpWidget(
        _host(MyanmarWeekStrip(clock: _clock), textScale: 2),
      );
      expect(tester.takeException(), isNull);
    });
  });

  group('MyanmarYearCalendar and MyanmarMiniMonth', () {
    testWidgets('twelve months; tapping a title opens it', (tester) async {
      DateTime? opened;
      await tester.pumpWidget(
        _host(
          SingleChildScrollView(
            child: MyanmarYearCalendar(
              year: 2026,
              clock: _clock,
              onMonthTapped: (m) => opened = m,
            ),
          ),
        ),
      );
      expect(find.byType(MyanmarMiniMonth), findsNWidgets(12));
      expect(find.text('2026'), findsOneWidget);
      await tester.tap(find.text('April'));
      expect(opened, DateTime(2026, 4));
      await tester.tap(find.byTooltip('Next year'));
      await tester.pump();
      expect(find.text('2027'), findsOneWidget);
    });
  });

  group('MyanmarLunarMonthCalendar', () {
    test('orders a year\'s months and skips the ones it lacks', () {
      final client = MyanmarCalendarClient();
      final months = MyanmarLunarMonthCalendar.monthsOf(client, 1388);
      expect(months.indexOf(0), lessThan(months.indexOf(4))); // First Waso
      expect(months.indexOf(3), lessThan(months.indexOf(0)));
      // New Year falls inside Tagu: 1388 ends with Late Tagu and 1389
      // starts with the rest of Tagu.
      expect(months.last, 13);
      expect(MyanmarLunarMonthCalendar.monthsOf(client, 1389).first, 1);
      expect(MyanmarLunarMonthCalendar.monthsOf(client, 1387), contains(13));
    });

    test('Western dates come from the Julian day number', () {
      final client = MyanmarCalendarClient();
      final first = client.getMyanmarMonth(1388, 7).first;
      expect(
        MyanmarLunarMonthCalendar.westernOf(first),
        DateTime(2026, 10, 12),
      );
    });

    testWidgets('lays out Thadingyut 1388 by fortnight', (tester) async {
      final controller = MyanmarCalendarController();
      await tester.pumpWidget(
        _host(
          SingleChildScrollView(
            child: MyanmarLunarMonthCalendar(
              year: 1388,
              month: 7,
              controller: controller,
              clock: _clock,
            ),
          ),
        ),
      );
      expect(find.text('Thadingyut 1388'), findsOneWidget);
      expect(find.textContaining('Big Watat'), findsOneWidget);
      expect(find.byType(MoonGlyph), findsNWidgets(2)); // full and new moon

      // Waxing 7 is 18 October.
      await tester.tap(find.text('7').first);
      expect(controller.selection, SingleSelection(DateTime(2026, 10, 18)));

      await tester.tap(find.byTooltip('Next month'));
      await tester.pump();
      expect(find.text('Tazaungmon 1388'), findsOneWidget);
    });
  });

  group('MyanmarAgenda', () {
    testWidgets('lists the days with something on them', (tester) async {
      await tester.pumpWidget(
        _host(
          MyanmarAgenda(
            from: DateTime(2026, 10, 18),
            days: 10,
            clock: _clock,
            eventLoader: (d) =>
                d == DateTime(2026, 10, 20) ? ['Pagoda visit'] : const [],
          ),
        ),
      );
      expect(find.text('End of Buddhist Lent'), findsOneWidget);
      expect(find.text('Holiday'), findsNWidgets(2)); // 25 and 27 October
      expect(find.text('United Nations'), findsOneWidget);
      expect(find.text('Pagoda visit'), findsOneWidget);
      expect(find.text('Full Moon'), findsOneWidget);
    });

    testWidgets('leaves out what it is told to', (tester) async {
      await tester.pumpWidget(
        _host(
          MyanmarAgenda(
            from: DateTime(2026, 10, 18),
            days: 10,
            clock: _clock,
            include: const {MyanmarAgendaItem.holidays},
          ),
        ),
      );
      expect(find.text('United Nations'), findsNothing);
      expect(find.text('End of Buddhist Lent'), findsOneWidget);
    });

    testWidgets('says so when nothing is on', (tester) async {
      await tester.pumpWidget(
        _host(
          MyanmarAgenda(
            from: DateTime(2026, 10, 20),
            days: 2,
            clock: _clock,
            include: const {MyanmarAgendaItem.holidays},
          ),
        ),
      );
      expect(find.text('Nothing on these days'), findsOneWidget);
    });
  });
}

extension on Matcher {
  Matcher get not => isNot(this);
}
