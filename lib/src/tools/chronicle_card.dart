import 'package:flutter/material.dart';
import 'package:myanmar_calendar_dart/myanmar_calendar_dart.dart';

import '../adaptive/mm_list.dart';
import '../day/day_builder.dart';
import '../foundation/language_locale.dart';
import '../foundation/mm_strings.dart';
import '../foundation/mm_visual_style.dart';
import '../foundation/myanmar_calendar_scope.dart';

/// A dated record from the core library's chronicles.
@immutable
class ChronicleRecord {
  /// Creates a record.
  const ChronicleRecord({required this.entry, required this.westernYear});

  /// The chronicle entry.
  final ChronicleEntryData entry;

  /// The Western year it is dated to.
  final int westernYear;
}

/// The era a date falls in, from the core library's dynasties, and the
/// dated records nearest to it.
///
/// Kingdoms that ran side by side (Ava and Hanthawaddy, Taungoo and
/// Mrauk-U) are all listed. Records are dated events, so they are matched
/// by their date; [windowYears] sets how far either side to look.
class ChronicleCard extends StatelessWidget {
  /// Creates a card for [date] (default: today).
  const ChronicleCard({
    super.key,
    this.date,
    this.maxRecords = 3,
    this.windowYears = 25,
    this.style,
    this.clock,
  });

  /// The day; today when null.
  final DateTime? date;

  /// The most records to list.
  final int maxRecords;

  /// How many years either side of the date to look for records.
  final int windowYears;

  /// Overrides the scope's visual style.
  final MmVisualStyle? style;

  /// The current time, for tests.
  final DateTime Function()? clock;

  /// Every dynasty or era whose span includes [julianDay], earliest first.
  static List<DynastyData> erasAt(
    MyanmarCalendarClient client,
    double julianDay,
  ) => [
    for (final d in client.listDynasties())
      if (julianDay >= d.startJdn && julianDay <= d.endJdn) d,
  ];

  /// The records dated within [windowYears] of [julianDay], nearest first.
  ///
  /// Every entry in the core's chronicles is a single dated event, so this
  /// matches on the entry's date rather than treating a missing end as
  /// "still ongoing".
  static List<ChronicleRecord> recordsNear(
    MyanmarCalendarClient client,
    double julianDay, {
    int windowYears = 25,
    int? limit,
  }) {
    final window = windowYears * 365.25;
    final near =
        client
            .getChroniclesBetweenJdn(julianDay - window, julianDay + window)
            .where((e) => (e.startJdn - julianDay).abs() <= window)
            .toList()
          ..sort(
            (a, b) => (a.startJdn - julianDay).abs().compareTo(
              (b.startJdn - julianDay).abs(),
            ),
          );
    return [
      for (final e in limit == null ? near : near.take(limit))
        ChronicleRecord(
          entry: e,
          westernYear: client.fromJulianDay(e.startJdn).westernDate.year,
        ),
    ];
  }

  /// [names] in [language], falling back to English, then to any.
  static String localized(Map<String, String> names, Language language) =>
      names[language.code] ?? names['en'] ?? names.values.firstOrNull ?? '';

  @override
  Widget build(BuildContext context) {
    final scope = MyanmarCalendarScope.of(context);
    final theme = MyanmarCalendarScope.themeOf(context);
    final strings = MmStrings.of(scope.language);
    final language = scope.language;
    final client = scope.client;

    return DayBuilder(
      date: date,
      clock: clock,
      builder: (context, day, _) {
        final jdn = day.myanmar.julianDayNumber;
        final eras = erasAt(client, jdn);
        final records = recordsNear(
          client,
          jdn,
          windowYears: windowYears,
          limit: maxRecords,
        );
        int year(double j) => client.fromJulianDay(j).westernDate.year;
        String years(DynastyData d) =>
            '${language.digits(year(d.startJdn))} – '
            '${language.digits(year(d.endJdn))}';

        return DefaultTextStyle.merge(
          style: theme.textStyle(const TextStyle(), language),
          child: MmListGroup(
            header: strings.history,
            style: style,
            children: [
              if (eras.isEmpty && records.isEmpty)
                MmListRow(
                  title: Text(
                    strings.noRecords,
                    style: TextStyle(color: theme.muted),
                  ),
                  style: style,
                ),
              for (final era in eras)
                MmListRow(
                  leading: Icon(
                    Icons.account_balance_outlined,
                    color: theme.accent,
                  ),
                  title: Text(localized(era.name, language)),
                  subtitle: Text(years(era)),
                  style: style,
                ),
              for (final r in records)
                MmListRow(
                  leading: SizedBox(
                    width: 44,
                    child: Text(
                      language.digits(r.westernYear),
                      style: TextStyle(
                        color: theme.muted,
                        fontWeight: FontWeight.w600,
                        fontFeatures: const [FontFeature.tabularFigures()],
                      ),
                    ),
                  ),
                  title: Text(
                    localized(r.entry.title, language),
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                  ),
                  style: style,
                ),
            ],
          ),
        );
      },
    );
  }
}
