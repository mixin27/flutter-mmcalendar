@Tags(['golden'])
library;

import 'package:flutter/material.dart';
import 'package:flutter_mmcalendar/flutter_mmcalendar.dart';
import 'package:flutter_test/flutter_test.dart';

import '../helpers/fonts.dart';
import '../helpers/wallpaper.dart';

class _Gallery extends StatelessWidget {
  const _Gallery();

  @override
  Widget build(BuildContext context) {
    final theme = MyanmarCalendarScope.themeOf(context);
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          MmSurface(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                Text(
                  '18',
                  style: TextStyle(
                    fontSize: 40,
                    fontWeight: FontWeight.w600,
                    color: theme.ink,
                  ),
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Sunday, 18 October',
                        style: TextStyle(color: theme.muted, fontSize: 13),
                      ),
                      Text(
                        'Thadingyut Waxing 7',
                        style: TextStyle(
                          color: theme.ink,
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
                MmIconButton(
                  icon: Icons.chevron_right,
                  tooltip: 'Next month',
                  onPressed: () {},
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              MmButton(label: 'Today', onPressed: () {}),
              MmButton(
                label: 'Month',
                icon: Icons.calendar_month,
                variant: MmButtonVariant.tonal,
                onPressed: () {},
              ),
              MmButton(
                label: 'Cancel',
                variant: MmButtonVariant.text,
                onPressed: () {},
              ),
              const MmButton(label: 'Disabled', onPressed: null),
            ],
          ),
          const SizedBox(height: 16),
          Wrap(
            spacing: 6,
            runSpacing: 6,
            children: [
              MmChip(label: 'Holiday', color: theme.publicHoliday, dot: true),
              MmChip(
                label: 'End of Buddhist Lent',
                color: theme.religiousHoliday,
                dot: true,
              ),
              MmChip(label: 'Sabbath', color: theme.sabbath, dot: true),
              const MmChip(label: 'Pyathada'),
              MmChip(
                label: "Mum's birthday",
                color: theme.accent,
                outlined: true,
              ),
            ],
          ),
          const SizedBox(height: 16),
          Align(
            alignment: Alignment.centerLeft,
            child: MmSegmented<String>(
              segments: const {
                'month': 'Month',
                'week': 'Week',
                'year': 'Year',
              },
              selected: 'week',
              onChanged: (_) {},
            ),
          ),
          const SizedBox(height: 16),
          MmListGroup(
            header: 'Dates',
            children: [
              const MmListRow(
                title: Text('18 October 2026'),
                subtitle: Text('Western'),
              ),
              const MmListRow(
                title: Text('1388 Thadingyut Waxing 7'),
                subtitle: Text('Myanmar'),
              ),
              MmListRow(
                title: const Text('Sasana year'),
                trailing: Text('2570', style: TextStyle(color: theme.muted)),
                onTap: () {},
              ),
            ],
          ),
          const SizedBox(height: 16),
          SizedBox(
            height: 56,
            child: MmGlass(
              borderRadius: BorderRadius.circular(28),
              thickness: MmGlassThickness.clear,
              child: Center(
                child: Text(
                  'MmGlass · clear',
                  style: TextStyle(color: theme.ink, fontSize: 15),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

void main() {
  setUpAll(loadTestFonts);

  for (final style in [
    MmVisualStyle.material,
    MmVisualStyle.cupertino,
    MmVisualStyle.glass,
  ]) {
    for (final brightness in Brightness.values) {
      final name = '${style.name}_${brightness.name}';
      testWidgets('primitives: $name', (tester) async {
        tester.view
          ..physicalSize = const Size(420, 860)
          ..devicePixelRatio = 1;
        addTearDown(tester.view.reset);
        final dark = brightness == Brightness.dark;
        await tester.pumpWidget(
          MyanmarCalendarScope(
            style: style,
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
                    const SafeArea(child: _Gallery()),
                  ],
                ),
              ),
            ),
          ),
        );
        await expectLater(
          find.byType(Scaffold),
          matchesGoldenFile('goldens/primitives_$name.png'),
        );
      });
    }
  }
}
