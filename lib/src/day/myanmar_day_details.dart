import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:myanmar_calendar_dart/myanmar_calendar_dart.dart';

import '../adaptive/mm_buttons.dart';
import '../adaptive/mm_list.dart';
import '../foundation/language_locale.dart';
import '../foundation/mm_strings.dart';
import '../foundation/mm_visual_style.dart';
import '../foundation/myanmar_calendar_scope.dart';
import '../moon/moon_glyph.dart';
import 'day_badges.dart';
import 'day_builder.dart';

/// A section of [MyanmarDayDetails].
enum DaySection {
  /// Western, Myanmar, Sasana and Shan dates.
  dates,

  /// The moon phase and day of the fortnight.
  moon,

  /// Holidays and anniversaries.
  holidays,

  /// Sabbath, Yatyaza, Pyathada, the named days, mahabote, nakhat, nagahle
  /// and the year name.
  astrology,
}

/// Everything about one day, in grouped sections you can reorder or leave
/// out. Each date row has a copy button.
class MyanmarDayDetails extends StatelessWidget {
  /// Creates details for [date], or today.
  const MyanmarDayDetails({
    super.key,
    this.date,
    this.sections = DaySection.values,
    this.onCopied,
    this.style,
    this.clock,
  });

  /// The day; today when null.
  final DateTime? date;

  /// Which sections to show, in order.
  final List<DaySection> sections;

  /// Called with the text a copy button put on the clipboard, e.g. to show
  /// a confirmation.
  final ValueChanged<String>? onCopied;

  /// Overrides the scope's visual style.
  final MmVisualStyle? style;

  /// The current time, for tests.
  final DateTime Function()? clock;

  @override
  Widget build(BuildContext context) {
    final scope = MyanmarCalendarScope.of(context);
    final theme = MyanmarCalendarScope.themeOf(context);
    final strings = MmStrings.of(scope.language);
    final language = scope.language;

    return DayBuilder(
      date: date,
      clock: clock,
      builder: (context, day, _) {
        final western = westernDay(day);
        final m = day.myanmar;

        Widget? copyButton(String text) => MmIconButton(
          icon: Icons.copy_rounded,
          tooltip: strings.copy,
          style: style,
          onPressed: () async {
            await Clipboard.setData(ClipboardData(text: text));
            onCopied?.call(text);
          },
        );

        MmListRow row(String label, String value, {bool copy = true}) =>
            MmListRow(
              title: Text(value),
              subtitle: Text(label),
              trailing: copy ? copyButton(value) : null,
              style: style,
            );

        Widget section(DaySection s) {
          switch (s) {
            case DaySection.dates:
              return MmListGroup(
                header: strings.dates,
                style: style,
                children: [
                  row(
                    strings.western,
                    '${strings.weekdayName(western.weekday)}, '
                    '${strings.westernDate(western)}',
                  ),
                  row(
                    strings.myanmar,
                    '${language.digits(m.year)} ${strings.myanmarDate(m)}',
                  ),
                  row(strings.sasanaYear, language.digits(m.sasanaYear)),
                  // The Shan month name is in Shan script; show it only in Shan.
                  row(
                    strings.shanYear,
                    language == Language.shan
                        ? '${language.digits(day.shan.year)} ${day.shan.monthName}'
                        : language.digits(day.shan.year),
                  ),
                ],
              );
            case DaySection.moon:
              return MmListGroup(
                header: strings.moon,
                style: style,
                children: [
                  MmListRow(
                    leading: MoonGlyph(
                      date: m,
                      size: 28,
                      tilt: MoonTilt.myanmar,
                    ),
                    title: Text(strings.fortnightDay(m)),
                    subtitle: Text(
                      strings.percentLit(
                        (MoonGlyph.illumination(m) * 100).round(),
                      ),
                    ),
                    style: style,
                  ),
                ],
              );
            case DaySection.holidays:
              return MmListGroup(
                header: strings.holidays,
                style: style,
                children: [
                  if (day.holidays.entries.isEmpty)
                    MmListRow(
                      title: Text(
                        strings.noHolidays,
                        style: TextStyle(color: theme.muted),
                      ),
                      style: style,
                    )
                  else
                    for (final h in day.holidays.entries)
                      MmListRow(
                        leading: DecoratedBox(
                          decoration: BoxDecoration(
                            color: h.isCustom
                                ? theme.accent
                                : theme.holidayColor(h.type),
                            shape: BoxShape.circle,
                          ),
                          child: const SizedBox.square(dimension: 10),
                        ),
                        title: Text(h.name),
                        subtitle: Text(
                          h.isCustom
                              ? strings.customHoliday
                              : strings.holidayType(h.type),
                        ),
                        style: style,
                      ),
                ],
              );
            case DaySection.astrology:
              final astro = day.astro;
              return MmListGroup(
                header: strings.astrology,
                style: style,
                children: [
                  if (AstroBadges.hasAny(day))
                    MmListRow(
                      title: AstroBadges(date: day, style: style),
                      style: style,
                    ),
                  row(
                    strings.term('Mahabote'),
                    strings.term(astro.mahabote),
                    copy: false,
                  ),
                  row(
                    strings.term('Nakhat'),
                    strings.term(astro.nakhat),
                    copy: false,
                  ),
                  row(
                    strings.term('Naga Head'),
                    strings.term(astro.nagahle),
                    copy: false,
                  ),
                  row(
                    strings.term('Year Name'),
                    strings.term(astro.yearName),
                    copy: false,
                  ),
                ],
              );
          }
        }

        return DefaultTextStyle.merge(
          style: theme.textStyle(const TextStyle(), language),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisSize: MainAxisSize.min,
            children: [
              for (var i = 0; i < sections.length; i++) ...[
                if (i > 0) const SizedBox(height: 12),
                section(sections[i]),
              ],
            ],
          ),
        );
      },
    );
  }
}
