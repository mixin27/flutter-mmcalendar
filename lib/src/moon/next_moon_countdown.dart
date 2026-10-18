import 'package:flutter/material.dart';
import 'package:myanmar_calendar_dart/myanmar_calendar_dart.dart';

import '../adaptive/mm_surface.dart';
import '../calendars/calendar_layout.dart';
import '../foundation/mm_strings.dart';
import '../foundation/mm_visual_style.dart';
import '../foundation/myanmar_calendar_scope.dart';
import '../foundation/today_builder.dart';
import 'moon_glyph.dart';

/// What a [NextMoonCountdown] counts down to.
enum MoonCountdown {
  /// The next full moon.
  fullMoon,

  /// The next new moon.
  newMoon,

  /// The next Sabbath (any quarter day).
  sabbath,
}

/// Days until the next full moon, new moon and Sabbath, counted from [from]
/// or from today. A bar fills as the full moon nears.
class NextMoonCountdown extends StatelessWidget {
  /// Creates a countdown.
  const NextMoonCountdown({
    super.key,
    this.from,
    this.kinds = const {
      MoonCountdown.fullMoon,
      MoonCountdown.newMoon,
      MoonCountdown.sabbath,
    },
    this.surface = true,
    this.style,
    this.clock,
  });

  /// The day to count from; today when null.
  final DateTime? from;

  /// What to count down to, in display order.
  final Set<MoonCountdown> kinds;

  /// Whether to draw on an [MmSurface].
  final bool surface;

  /// Overrides the scope's visual style.
  final MmVisualStyle? style;

  /// The current time, for tests.
  final DateTime Function()? clock;

  /// The first day after [from] that is a [kind] day, within 40 days.
  static CompleteDate? next(
    MyanmarCalendarScopeData scope,
    DateTime from,
    MoonCountdown kind,
  ) {
    var d = DateUtils.dateOnly(from);
    for (var i = 0; i < 40; i++) {
      d = CalendarLayout.addDays(d, 1);
      final day = scope.day(d);
      final hit = switch (kind) {
        MoonCountdown.fullMoon => day.myanmar.phase == MoonPhase.fullMoon,
        MoonCountdown.newMoon => day.myanmar.phase == MoonPhase.newMoon,
        MoonCountdown.sabbath => day.astro.sabbathType == SabbathType.sabbath,
      };
      if (hit) return day;
    }
    return null;
  }

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

    return TodayBuilder(
      clock: clock,
      builder: (context, today) {
        final start = from ?? today;
        int daysTo(CompleteDate d) => DateTime.utc(
          d.western.year,
          d.western.month,
          d.western.day,
        ).difference(DateTime.utc(start.year, start.month, start.day)).inDays;

        final rows = <Widget>[];
        int? toFull;
        for (final kind in kinds) {
          final day = next(scope, start, kind);
          if (day == null) continue;
          final n = daysTo(day);
          if (kind == MoonCountdown.fullMoon) toFull = n;
          final name = switch (kind) {
            MoonCountdown.fullMoon => strings.moonPhase(MoonPhase.fullMoon),
            MoonCountdown.newMoon => strings.moonPhase(MoonPhase.newMoon),
            MoonCountdown.sabbath => strings.term('Sabbath'),
          };
          final western = DateTime(
            day.western.year,
            day.western.month,
            day.western.day,
          );
          rows.add(
            MergeSemantics(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 5),
                child: Row(
                  children: [
                    MoonGlyph(date: day.myanmar, size: 28),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(name, style: ts(15, theme.ink, FontWeight.w600)),
                          Text(
                            '${strings.westernShort(western)} · '
                            '${strings.myanmarDate(day.myanmar)}',
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: ts(12, theme.muted),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      strings.daysUntil(n),
                      style: ts(14, theme.ink, FontWeight.w600),
                    ),
                  ],
                ),
              ),
            ),
          );
        }

        final body = Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisSize: MainAxisSize.min,
          children: [
            ...rows,
            if (toFull != null) ...[
              const SizedBox(height: 8),
              ExcludeSemantics(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(4),
                  child: LinearProgressIndicator(
                    value: (1 - toFull / 15).clamp(0.0, 1.0),
                    minHeight: 6,
                    color: theme.moon,
                    backgroundColor: theme.surfaceVariant,
                  ),
                ),
              ),
            ],
          ],
        );
        final padded = Padding(
          padding: const EdgeInsets.fromLTRB(16, 10, 16, 14),
          child: body,
        );
        return surface ? MmSurface(style: style, child: padded) : padded;
      },
    );
  }
}
