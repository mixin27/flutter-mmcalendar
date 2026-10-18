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
  Size size = const Size(420, 1100),
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

Widget _tools() => Column(
  crossAxisAlignment: CrossAxisAlignment.stretch,
  children: [
    MyanmarDateConverter(initialDate: DateTime(2026, 10, 18)),
    const SizedBox(height: 14),
    DateDifferenceCard(
      from: DateTime(2026, 10, 18),
      to: DateTime(2026, 10, 26),
    ),
    const SizedBox(height: 14),
    AIPromptAction(clock: _clock, onPrompt: (_, _) {}),
  ],
);

void main() {
  setUpAll(loadTestFonts);

  testWidgets('tools glass light', (tester) async {
    await _golden(
      tester,
      'tools_glass_light',
      _tools(),
      style: MmVisualStyle.glass,
    );
  });

  testWidgets('tools material dark', (tester) async {
    await _golden(
      tester,
      'tools_material_dark',
      _tools(),
      brightness: Brightness.dark,
    );
  });

  testWidgets('chronicle cupertino', (tester) async {
    await _golden(
      tester,
      'chronicle_cupertino_light',
      ChronicleCard(date: DateTime(1500, 6, 1), clock: _clock),
      style: MmVisualStyle.cupertino,
      size: const Size(420, 760),
    );
  });
}
