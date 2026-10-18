import 'package:flutter/material.dart';
import 'package:flutter_mmcalendar/flutter_mmcalendar.dart';
import 'package:flutter_test/flutter_test.dart';

/// Records the scope data and resolved style it sees on each build.
class _Probe extends StatelessWidget {
  const _Probe(this.seen);

  final List<(MyanmarCalendarScopeData, MmVisualStyle, MmCalendarThemeData)>
  seen;

  @override
  Widget build(BuildContext context) {
    seen.add((
      MyanmarCalendarScope.of(context),
      MyanmarCalendarScope.styleOf(context),
      MyanmarCalendarScope.themeOf(context),
    ));
    return const SizedBox();
  }
}

void main() {
  final seen =
      <(MyanmarCalendarScopeData, MmVisualStyle, MmCalendarThemeData)>[];
  setUp(seen.clear);

  testWidgets('without a scope: English, default client, scheme theme', (
    tester,
  ) async {
    await tester.pumpWidget(MaterialApp(home: _Probe(seen)));
    final (data, _, theme) = seen.last;
    expect(data.language, Language.english);
    expect(data.firstDayOfWeek, DateTime.sunday);
    expect(data.client.config.timezoneOffset, 6.5);
    expect(
      theme.accent,
      Theme.of(tester.element(find.byType(_Probe))).colorScheme.primary,
    );
  });

  testWidgets('a scope above MaterialApp follows the app locale', (
    tester,
  ) async {
    await tester.pumpWidget(
      MyanmarCalendarScope(
        // Localizations directly: MaterialApp would warn that its own
        // delegates don't support Burmese.
        child: Localizations(
          locale: const Locale('my'),
          delegates: const [DefaultWidgetsLocalizations.delegate],
          child: _Probe(seen),
        ),
      ),
    );
    expect(seen.last.$1.language, Language.myanmar);
    expect(seen.last.$1.digits(18), '၁၈');
  });

  testWidgets('the scope language wins over the locale', (tester) async {
    await tester.pumpWidget(
      MyanmarCalendarScope(
        language: Language.shan,
        child: MaterialApp(home: _Probe(seen)),
      ),
    );
    expect(seen.last.$1.language, Language.shan);
  });

  testWidgets('style resolves for the theme platform', (tester) async {
    await tester.pumpWidget(
      MyanmarCalendarScope(
        child: MaterialApp(
          theme: ThemeData(platform: TargetPlatform.android),
          home: _Probe(seen),
        ),
      ),
    );
    expect(seen.last.$2, MmVisualStyle.material);

    await tester.pumpWidget(
      MyanmarCalendarScope(
        style: MmVisualStyle.glass,
        child: MaterialApp(
          theme: ThemeData(platform: TargetPlatform.android),
          home: _Probe(seen),
        ),
      ),
    );
    expect(seen.last.$2, MmVisualStyle.glass);
  });

  testWidgets('theme: scope, then app extension, then scheme', (tester) async {
    final ext = MmCalendarThemeData.fromSeed(Colors.green);
    final scoped = MmCalendarThemeData.fromSeed(Colors.red);
    Widget app({MmCalendarThemeData? theme}) => MyanmarCalendarScope(
      theme: theme,
      child: MaterialApp(
        theme: ThemeData(extensions: [ext]),
        home: _Probe(seen),
      ),
    );
    await tester.pumpWidget(app());
    expect(seen.last.$3, ext);
    await tester.pumpWidget(app(theme: scoped));
    expect(seen.last.$3, scoped);
  });

  testWidgets('a new config builds a new client with its holidays', (
    tester,
  ) async {
    final family = CustomHoliday.westernDate(
      id: 'family',
      name: 'Family day',
      type: HolidayType.other,
      month: 10,
      day: 18,
    );
    Widget app(CalendarConfig config) => MyanmarCalendarScope(
      config: config,
      child: MaterialApp(home: _Probe(seen)),
    );
    await tester.pumpWidget(app(const CalendarConfig()));
    final first = seen.last.$1;
    expect(
      first.day(DateTime(2026, 10, 18)).holidays.hasCustom('family'),
      isFalse,
    );

    await tester.pumpWidget(app(CalendarConfig(customHolidays: [family])));
    final second = seen.last.$1;
    expect(identical(first.client, second.client), isFalse);
    expect(
      second.day(DateTime(2026, 10, 18)).holidays.hasCustom('family'),
      isTrue,
    );
  });

  testWidgets('dependents rebuild only when the scope changes', (tester) async {
    // The same probe instance each time, so only the scope can rebuild it.
    final probe = _Probe(seen);
    Widget app(Language language) => MyanmarCalendarScope(
      language: language,
      child: MaterialApp(home: probe),
    );
    await tester.pumpWidget(app(Language.english));
    final builds = seen.length;
    await tester.pumpWidget(app(Language.english));
    expect(seen.length, builds);
    await tester.pumpWidget(app(Language.myanmar));
    expect(seen.length, builds + 1);
  });
}
