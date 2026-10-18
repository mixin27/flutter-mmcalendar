@Tags(['golden'])
library;

import 'package:flutter/material.dart';
import 'package:flutter_mmcalendar/flutter_mmcalendar.dart';
import 'package:flutter_test/flutter_test.dart';

import '../helpers/fonts.dart';
import '../helpers/wallpaper.dart';

DateTime _clock() => DateTime(2026, 10, 18, 9);

Future<void> _golden(
  WidgetTester tester,
  String name,
  Widget child, {
  MmVisualStyle style = MmVisualStyle.material,
  Brightness brightness = Brightness.light,
  Size size = const Size(400, 520),
}) async {
  tester.view
    ..physicalSize = size
    ..devicePixelRatio = 1;
  addTearDown(tester.view.reset);
  final dark = brightness == Brightness.dark;
  await tester.pumpWidget(
    MyanmarCalendarScope(
      style: style,
      language: Language.english,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          fontFamily: 'Roboto',
          colorSchemeSeed: Colors.indigo,
          brightness: brightness,
        ),
        home: Scaffold(
          body: Stack(
            fit: StackFit.expand,
            children: [
              if (style == MmVisualStyle.glass)
                GoldenWallpaper(dark: dark)
              else
                ColoredBox(
                  color: dark
                      ? const Color(0xFF0E1016)
                      : const Color(0xFFF2F2F7),
                ),
              Padding(padding: const EdgeInsets.all(12), child: child),
            ],
          ),
        ),
      ),
    ),
  );
  await tester.pumpAndSettle();
  await expectLater(
    find.byType(Scaffold),
    matchesGoldenFile('goldens/$name.png'),
  );
}

MyanmarCalendarController _october([CalendarSelection? selection]) =>
    MyanmarCalendarController(
      initialMonth: DateTime(2026, 10),
      selection: selection ?? SingleSelection(DateTime(2026, 10, 18)),
    );

void main() {
  setUpAll(loadTestFonts);

  for (final style in [
    MmVisualStyle.material,
    MmVisualStyle.cupertino,
    MmVisualStyle.glass,
  ]) {
    for (final b in Brightness.values) {
      testWidgets('month ${style.name} ${b.name}', (tester) async {
        await _golden(
          tester,
          'month_${style.name}_${b.name}',
          MyanmarMonthCalendar(
            controller: _october(),
            clock: _clock,
            eventLoader: (d) =>
                d == DateTime(2026, 10, 20) ? ['Pagoda visit'] : const [],
          ),
          style: style,
          brightness: b,
        );
      });
    }
  }

  for (final cellStyle in MyanmarDayCellStyle.values) {
    testWidgets('cell style ${cellStyle.name}', (tester) async {
      await _golden(
        tester,
        'cells_${cellStyle.name}',
        MyanmarMonthCalendar(
          controller: _october(),
          cellStyle: cellStyle,
          clock: _clock,
        ),
      );
    });
  }

  testWidgets('range selection', (tester) async {
    await _golden(
      tester,
      'month_range',
      MyanmarMonthCalendar(
        controller: _october(
          RangeSelection(
            start: DateTime(2026, 10, 25),
            end: DateTime(2026, 10, 27),
          ),
        ),
        cellStyle: MyanmarDayCellStyle.westernFirst,
        clock: _clock,
      ),
      style: MmVisualStyle.cupertino,
    );
  });

  final others = <String, Widget Function()>{
    'week_strip': () => Align(
      alignment: Alignment.topCenter,
      child: MyanmarWeekStrip(
        controller: MyanmarCalendarController(
          selection: SingleSelection(DateTime(2026, 10, 18)),
        ),
        clock: _clock,
      ),
    ),
    'mini_month': () => Align(
      alignment: Alignment.topLeft,
      child: SizedBox(
        width: 220,
        child: MyanmarMiniMonth(month: DateTime(2026, 10), clock: _clock),
      ),
    ),
    'lunar_month': () => SingleChildScrollView(
      child: MyanmarLunarMonthCalendar(year: 1388, month: 7, clock: _clock),
    ),
    'agenda': () => MyanmarAgenda(
      from: DateTime(2026, 10, 18),
      days: 40,
      clock: _clock,
      eventLoader: (d) => d == DateTime(2026, 10, 20)
          ? ['Pagoda visit with Grandma']
          : const [],
    ),
  };
  for (final entry in others.entries) {
    for (final (style, b) in [
      (MmVisualStyle.glass, Brightness.light),
      (MmVisualStyle.material, Brightness.dark),
    ]) {
      testWidgets('${entry.key} ${style.name} ${b.name}', (tester) async {
        await _golden(
          tester,
          '${entry.key}_${style.name}_${b.name}',
          entry.value(),
          style: style,
          brightness: b,
        );
      });
    }
  }

  testWidgets('year', (tester) async {
    await _golden(
      tester,
      'year_cupertino_light',
      SingleChildScrollView(
        child: MyanmarYearCalendar(year: 2026, clock: _clock),
      ),
      style: MmVisualStyle.cupertino,
      size: const Size(760, 900),
    );
  });
}
