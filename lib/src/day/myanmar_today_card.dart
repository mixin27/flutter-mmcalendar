import 'package:flutter/material.dart';
import 'package:myanmar_calendar_dart/myanmar_calendar_dart.dart';

import '../adaptive/mm_surface.dart';
import '../calendars/myanmar_day_cell.dart';
import '../foundation/language_locale.dart';
import '../foundation/mm_strings.dart';
import '../foundation/mm_visual_style.dart';
import '../foundation/myanmar_calendar_scope.dart';
import '../foundation/myanmar_day_data.dart';
import '../moon/moon_glyph.dart';
import 'day_badges.dart';
import 'day_builder.dart';

/// A day at a glance: the Western day large, the Myanmar date, the Myanmar
/// and Sasana years, the moon, and the day's holidays and Sabbath, Yatyaza
/// and Pyathada badges.
///
/// Without a [date] it shows today and turns over at midnight.
/// [MyanmarTodayCard.compact] fits a square slot like a home-screen widget.
class MyanmarTodayCard extends StatelessWidget {
  /// Creates a card for [date], or today.
  const MyanmarTodayCard({
    super.key,
    this.date,
    this.onTap,
    this.style,
    this.clock,
  }) : compact = false;

  /// A square card: weekday, day, Myanmar date and moon.
  const MyanmarTodayCard.compact({
    super.key,
    this.date,
    this.onTap,
    this.style,
    this.clock,
  }) : compact = true;

  /// The day; today when null.
  final DateTime? date;

  /// Called when the card is tapped.
  final ValueChanged<CompleteDate>? onTap;

  /// Whether this is the square variant.
  final bool compact;

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
    TextStyle ts(double size, Color c, [FontWeight? w]) => theme.textStyle(
      TextStyle(fontSize: size, color: c, fontWeight: w),
      language,
    );

    return DayBuilder(
      date: date,
      clock: clock,
      builder: (context, day, today) {
        final western = westernDay(day);
        final label = MyanmarDayCell.semanticLabel(
          MyanmarDayData(date: day, day: western, isToday: western == today),
          language,
        );
        final number = Text(
          language.digits(western.day),
          style: ts(
            compact ? 40 : 46,
            theme.ink,
            FontWeight.w600,
          ).copyWith(height: 1, letterSpacing: -1),
        );
        final weekday =
            '${strings.weekdayName(western.weekday)} · '
            '${strings.westernShort(western)}';

        final Widget content;
        if (compact) {
          content = SizedBox.square(
            dimension: 164,
            child: Padding(
              padding: const EdgeInsets.all(14),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    strings.weekdayName(western.weekday),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: ts(12, theme.muted).copyWith(height: 1.2),
                  ),
                  // The number gives way first, so long Myanmar month names
                  // and large text still fit the square.
                  Expanded(
                    child: Align(
                      alignment: AlignmentDirectional.centerStart,
                      child: FittedBox(fit: BoxFit.scaleDown, child: number),
                    ),
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Expanded(
                        child: Text(
                          strings.myanmarDate(day.myanmar),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: ts(
                            13,
                            theme.ink,
                            FontWeight.w600,
                          ).copyWith(height: 1.25),
                        ),
                      ),
                      MoonGlyph(
                        date: day.myanmar,
                        size: 22,
                        tilt: MoonTilt.myanmar,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        } else {
          final years =
              '${strings.myanmarYear} ${language.digits(day.myanmar.year)} · '
              '${strings.sasanaYear} ${language.digits(day.myanmar.sasanaYear)}';
          content = Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  children: [
                    number,
                    const SizedBox(width: 14),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(weekday, style: ts(12.5, theme.muted)),
                          Text(
                            strings.myanmarDate(day.myanmar),
                            style: ts(17, theme.ink, FontWeight.w600),
                          ),
                          Text(years, style: ts(12, theme.muted)),
                        ],
                      ),
                    ),
                    const SizedBox(width: 8),
                    MoonGlyph(
                      date: day.myanmar,
                      size: 40,
                      tilt: MoonTilt.myanmar,
                      earthshine: true,
                    ),
                  ],
                ),
                if (AstroBadges.hasAny(
                  day,
                  includeHolidays: true,
                  includeAstrologicalDays: false,
                )) ...[
                  const SizedBox(height: 12),
                  AstroBadges(
                    date: day,
                    includeHolidays: true,
                    includeAstrologicalDays: false,
                    style: style,
                  ),
                ],
              ],
            ),
          );
        }

        return Semantics(
          container: true,
          button: onTap != null,
          label: label,
          excludeSemantics: true,
          onTap: onTap == null ? null : () => onTap!(day),
          child: GestureDetector(
            onTap: onTap == null ? null : () => onTap!(day),
            child: MmSurface(style: style, child: content),
          ),
        );
      },
    );
  }
}
