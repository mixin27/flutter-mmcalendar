@Tags(['golden'])
library;

import 'package:flutter/material.dart';
import 'package:flutter_mmcalendar/flutter_mmcalendar.dart';
import 'package:flutter_test/flutter_test.dart';

import '../helpers/fonts.dart';
import '../helpers/wallpaper.dart';

DateTime _clock() => DateTime(2026, 10, 18, 9);

Future<void> _scene(
  WidgetTester tester, {
  required MmVisualStyle style,
  required Brightness brightness,
  required Widget Function(BuildContext context) body,
  Future<void> Function(BuildContext context)? open,
}) async {
  tester.view
    ..physicalSize = const Size(420, 860)
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
              Builder(builder: body),
            ],
          ),
        ),
      ),
    ),
  );
  if (open != null) {
    await tester.tap(find.text('Open'));
    await tester.pumpAndSettle();
  }
}

Widget _opener(Future<void> Function(BuildContext) open) => Builder(
  builder: (context) => Align(
    alignment: Alignment.topCenter,
    child: TextButton(
      onPressed: () => open(context),
      child: const Text('Open'),
    ),
  ),
);

void main() {
  setUpAll(loadTestFonts);

  final pickers =
      <
        String,
        (MmVisualStyle, Brightness, Future<void> Function(BuildContext))
      >{
        'date_dialog_material_light': (
          MmVisualStyle.material,
          Brightness.light,
          (c) => showMyanmarDatePicker(
            context: c,
            initialDate: DateTime(2026, 10, 18),
            clock: _clock,
          ),
        ),
        'date_sheet_cupertino_light': (
          MmVisualStyle.cupertino,
          Brightness.light,
          (c) => showMyanmarDatePicker(
            context: c,
            initialDate: DateTime(2026, 10, 18),
            clock: _clock,
          ),
        ),
        'date_wheels_glass_dark': (
          MmVisualStyle.glass,
          Brightness.dark,
          (c) => showMyanmarDatePicker(
            context: c,
            initialDate: DateTime(2026, 10, 18),
            inputMode: MyanmarPickerInput.wheels,
            clock: _clock,
          ),
        ),
        'range_glass_light': (
          MmVisualStyle.glass,
          Brightness.light,
          (c) => showMyanmarDateRangePicker(
            context: c,
            initialStart: DateTime(2026, 10, 25),
            initialEnd: DateTime(2026, 10, 27),
            clock: _clock,
          ),
        ),
      };
  for (final entry in pickers.entries) {
    final (style, brightness, open) = entry.value;
    testWidgets(entry.key, (tester) async {
      await _scene(
        tester,
        style: style,
        brightness: brightness,
        body: (_) => _opener(open),
        open: open,
      );
      await expectLater(
        find.byType(MaterialApp),
        matchesGoldenFile('goldens/${entry.key}.png'),
      );
    });
  }

  testWidgets('month_year_material_dark', (tester) async {
    await _scene(
      tester,
      style: MmVisualStyle.material,
      brightness: Brightness.dark,
      body: (_) => Padding(
        padding: const EdgeInsets.all(20),
        child: MmSurface(
          padding: const EdgeInsets.all(16),
          child: MyanmarMonthYearPicker(
            selectedMonth: DateTime(2026, 10),
            onChanged: (_) {},
          ),
        ),
      ),
    );
    await expectLater(
      find.byType(MaterialApp),
      matchesGoldenFile('goldens/month_year_material_dark.png'),
    );
  });

  testWidgets('form_fields_light', (tester) async {
    final value = MyanmarCalendarClient().getCompleteDateFor(
      2026,
      10,
      18,
      language: Language.english,
    );
    await _scene(
      tester,
      style: MmVisualStyle.glass,
      brightness: Brightness.light,
      body: (_) => Padding(
        padding: const EdgeInsets.all(20),
        child: Material(
          type: MaterialType.transparency,
          child: Form(
            autovalidateMode: AutovalidateMode.always,
            child: Column(
              children: [
                for (final style in [
                  MmVisualStyle.material,
                  MmVisualStyle.cupertino,
                  MmVisualStyle.glass,
                ]) ...[
                  MyanmarDateFormField(
                    label: 'Ordination date (${style.name})',
                    initialValue: value,
                    style: style,
                  ),
                  const SizedBox(height: 14),
                  MyanmarDateFormField(
                    label: 'Reminder (${style.name})',
                    hint: 'Choose a day',
                    style: style,
                    validator: (d) => d == null ? 'Pick a date' : null,
                  ),
                  const SizedBox(height: 18),
                ],
              ],
            ),
          ),
        ),
      ),
    );
    // Material fades its error text in.
    await tester.pumpAndSettle();
    await expectLater(
      find.byType(MaterialApp),
      matchesGoldenFile('goldens/form_fields_light.png'),
    );
  });
}
