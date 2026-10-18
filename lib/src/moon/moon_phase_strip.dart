import 'package:flutter/material.dart';
import 'package:myanmar_calendar_dart/myanmar_calendar_dart.dart';

import '../adaptive/mm_surface.dart';
import '../calendars/myanmar_lunar_month_calendar.dart';
import '../foundation/mm_strings.dart';
import '../foundation/mm_visual_style.dart';
import '../foundation/myanmar_calendar_scope.dart';
import 'moon_glyph.dart';

/// A Myanmar month's four Sabbath days, which are its quarter moons: waxing
/// 8, the full moon, waning 8 and the new moon, each with its Western date.
class MoonPhaseStrip extends StatelessWidget {
  /// Shows Myanmar [year] and [month].
  const MoonPhaseStrip({
    required this.year,
    required this.month,
    super.key,
    this.surface = true,
    this.onDayTapped,
    this.style,
  });

  /// The Myanmar year.
  final int year;

  /// The Myanmar month (0 is First Waso, 13 and 14 are the late months).
  final int month;

  /// Whether to draw on an [MmSurface].
  final bool surface;

  /// Called with a tapped day.
  final ValueChanged<CompleteDate>? onDayTapped;

  /// Overrides the scope's visual style.
  final MmVisualStyle? style;

  /// The quarter days of [days], one Myanmar month in order.
  static List<MyanmarDate> quarterDays(List<MyanmarDate> days) => [
    for (final d in days)
      if ((d.phase == MoonPhase.waxing || d.phase == MoonPhase.waning) &&
              d.fortnightDay == 8 ||
          d.phase == MoonPhase.fullMoon ||
          d.phase == MoonPhase.newMoon)
        d,
  ];

  @override
  Widget build(BuildContext context) {
    final scope = MyanmarCalendarScope.of(context);
    final theme = MyanmarCalendarScope.themeOf(context);
    final strings = MmStrings.of(scope.language);
    final days = quarterDays(scope.client.getMyanmarMonth(year, month));
    final language = scope.language;

    final row = Row(
      children: [
        for (final d in days)
          Expanded(
            child: () {
              final western = MyanmarLunarMonthCalendar.westernOf(d);
              final content = Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  MoonGlyph(date: d, size: 32),
                  const SizedBox(height: 6),
                  Text(
                    strings.fortnightDay(d),
                    textAlign: TextAlign.center,
                    maxLines: 2,
                    style: theme.textStyle(
                      TextStyle(
                        color: theme.ink,
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                      ),
                      language,
                    ),
                  ),
                  Text(
                    strings.westernShort(western),
                    style: theme.textStyle(
                      TextStyle(color: theme.muted, fontSize: 12),
                      language,
                    ),
                  ),
                ],
              );
              if (onDayTapped == null) {
                return MergeSemantics(child: content);
              }
              return Semantics(
                button: true,
                child: GestureDetector(
                  behavior: HitTestBehavior.opaque,
                  onTap: () => onDayTapped!(scope.day(western)),
                  child: MergeSemantics(child: content),
                ),
              );
            }(),
          ),
      ],
    );
    final padded = Padding(padding: const EdgeInsets.all(14), child: row);
    return surface ? MmSurface(style: style, child: padded) : padded;
  }
}
