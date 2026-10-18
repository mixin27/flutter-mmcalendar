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
  Size size = const Size(420, 760),
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
              SingleChildScrollView(
                padding: const EdgeInsets.all(16),
                child: child,
              ),
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

void main() {
  setUpAll(loadTestFonts);

  for (final (style, b) in [
    (MmVisualStyle.material, Brightness.light),
    (MmVisualStyle.cupertino, Brightness.light),
    (MmVisualStyle.glass, Brightness.dark),
  ]) {
    testWidgets('today cards ${style.name}', (tester) async {
      await _golden(
        tester,
        'today_${style.name}_${b.name}',
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            MyanmarTodayCard(clock: _clock),
            const SizedBox(height: 12),
            MyanmarTodayCard(date: DateTime(2026, 10, 26), clock: _clock),
            const SizedBox(height: 12),
            Row(
              children: [
                MyanmarTodayCard.compact(clock: _clock),
                const SizedBox(width: 12),
                MyanmarTodayCard.compact(
                  date: DateTime(2026, 10, 26),
                  clock: _clock,
                ),
              ],
            ),
          ],
        ),
        style: style,
        brightness: b,
      );
    });
  }

  for (final (style, b) in [
    (MmVisualStyle.material, Brightness.light),
    (MmVisualStyle.glass, Brightness.dark),
  ]) {
    testWidgets('day details ${style.name}', (tester) async {
      await _golden(
        tester,
        'day_details_${style.name}_${b.name}',
        MyanmarDayDetails(date: DateTime(2026, 10, 26), clock: _clock),
        style: style,
        brightness: b,
        size: const Size(420, 1000),
      );
    });
  }

  testWidgets('holiday list cupertino', (tester) async {
    await _golden(
      tester,
      'holiday_list_cupertino_light',
      HolidayList.upcoming(clock: _clock, days: 80),
      style: MmVisualStyle.cupertino,
    );
  });

  testWidgets('astrology glass', (tester) async {
    await _golden(
      tester,
      'astrology_glass_light',
      Column(
        children: [
          AstrologyCard(clock: _clock),
          const SizedBox(height: 16),
          NagahleCompass(clock: _clock, surface: true),
        ],
      ),
      style: MmVisualStyle.glass,
      size: const Size(420, 900),
    );
  });

  testWidgets('moon material dark', (tester) async {
    await _golden(
      tester,
      'moon_material_dark',
      Column(
        children: [
          const MoonPhaseStrip(year: 1388, month: 7),
          const SizedBox(height: 16),
          NextMoonCountdown(clock: _clock),
          const SizedBox(height: 16),
          Wrap(
            spacing: 10,
            runSpacing: 10,
            children: [
              for (var d = 12; d <= 31; d += 2)
                Builder(
                  builder: (context) => MoonGlyph(
                    date: MyanmarCalendarScope.of(
                      context,
                    ).day(DateTime(2026, 10, d)).myanmar,
                    size: 34,
                    tilt: MoonTilt.myanmar,
                    earthshine: true,
                    animate: false,
                  ),
                ),
            ],
          ),
        ],
      ),
      brightness: Brightness.dark,
    );
  });
}
