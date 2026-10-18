import 'package:flutter/material.dart';
import 'package:myanmar_calendar_dart/myanmar_calendar_dart.dart';

import '../foundation/calendar_selection.dart';
import '../foundation/language_locale.dart';
import '../foundation/mm_strings.dart';
import '../foundation/myanmar_calendar_scope.dart';
import '../foundation/myanmar_day_data.dart';
import '../foundation/today_builder.dart';
import 'calendar_layout.dart';
import 'myanmar_day_cell.dart';

/// A compact month for side panels, the year view and the desktop sidebar:
/// today filled, full moons tinted, public holidays coloured.
class MyanmarMiniMonth extends StatelessWidget {
  /// Creates a mini month for [month].
  const MyanmarMiniMonth({
    required this.month,
    super.key,
    this.selection,
    this.firstDayOfWeek,
    this.showTitle = true,
    this.highlightTitle = false,
    this.onDayTapped,
    this.onTitleTapped,
    this.clock,
  });

  /// Any day in the month to show.
  final DateTime month;

  /// Days to ring as selected.
  final CalendarSelection? selection;

  /// The first column's weekday; `null` uses the scope's.
  final int? firstDayOfWeek;

  /// Whether to show the month name and its Myanmar months.
  final bool showTitle;

  /// Whether to draw the title in the accent colour (the current month in a
  /// year view).
  final bool highlightTitle;

  /// Called with the day the user taps.
  final ValueChanged<CompleteDate>? onDayTapped;

  /// Called when the user taps the title.
  final VoidCallback? onTitleTapped;

  /// The current time, for tests.
  final DateTime Function()? clock;

  @override
  Widget build(BuildContext context) {
    final scope = MyanmarCalendarScope.of(context);
    final theme = MyanmarCalendarScope.themeOf(context);
    final strings = MmStrings.of(scope.language);
    final firstDay = firstDayOfWeek ?? scope.firstDayOfWeek;
    final shown = DateTime(month.year, month.month);
    final language = scope.language;
    TextStyle ts(double size, Color c, [FontWeight? w]) => theme
        .textStyle(TextStyle(fontSize: size, color: c, fontWeight: w), language)
        .copyWith(height: 1.1);

    return TodayBuilder(
      clock: clock,
      builder: (context, today) {
        final weeks = CalendarLayout.weeksOf(shown, firstDay);
        Widget title = Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              strings.westernMonth(shown.month),
              maxLines: 1,
              style: ts(
                13,
                highlightTitle ? theme.accent : theme.ink,
                FontWeight.w600,
              ),
            ),
            Text(
              CalendarLayout.myanmarSpanOfMonth(scope, shown),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: ts(10.5, theme.muted),
            ),
          ],
        );
        if (onTitleTapped != null) {
          title = Semantics(
            button: true,
            child: GestureDetector(onTap: onTitleTapped, child: title),
          );
        }

        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisSize: MainAxisSize.min,
          children: [
            if (showTitle) ...[title, const SizedBox(height: 4)],
            ExcludeSemantics(
              child: Row(
                children: [
                  for (final w in CalendarLayout.weekdayOrder(firstDay))
                    Expanded(
                      child: Text(
                        strings.weekdayNarrow(w),
                        textAlign: TextAlign.center,
                        maxLines: 1,
                        overflow: TextOverflow.clip,
                        style: ts(9.5, theme.muted, FontWeight.w600),
                      ),
                    ),
                ],
              ),
            ),
            for (final week in weeks)
              Row(
                children: [
                  for (final d in week)
                    Expanded(
                      child: AspectRatio(
                        aspectRatio: 1,
                        child: DateUtils.isSameMonth(d, shown)
                            ? _MiniDay(
                                data: MyanmarDayData.resolve(
                                  date: scope.day(d),
                                  today: today,
                                  selection: selection,
                                ),
                                language: language,
                                onTap: onDayTapped,
                              )
                            : const SizedBox.shrink(),
                      ),
                    ),
                ],
              ),
          ],
        );
      },
    );
  }
}

class _MiniDay extends StatelessWidget {
  const _MiniDay({required this.data, required this.language, this.onTap});

  final MyanmarDayData data;
  final Language language;
  final ValueChanged<CompleteDate>? onTap;

  @override
  Widget build(BuildContext context) {
    final theme = MyanmarCalendarScope.themeOf(context);
    final full = data.moonPhase == MoonPhase.fullMoon;
    final Color fg;
    final Color? bg;
    if (data.isToday) {
      fg = theme.onAccent;
      bg = theme.accent;
    } else if (full) {
      fg = theme.ink;
      bg = theme.moon.withValues(alpha: 0.32);
    } else {
      fg = data.isPublicHoliday ? theme.publicHoliday : theme.muted;
      bg = null;
    }
    final day = DecoratedBox(
      decoration: BoxDecoration(
        color: bg,
        shape: BoxShape.circle,
        border: data.isSelected && !data.isToday
            ? Border.all(color: theme.accent, width: 1.5)
            : null,
      ),
      child: Center(
        child: FittedBox(
          fit: BoxFit.scaleDown,
          child: Padding(
            padding: const EdgeInsets.all(1),
            child: Text(
              language.digits(data.day.day),
              style: theme
                  .textStyle(
                    TextStyle(
                      fontSize: 10,
                      color: fg,
                      fontWeight: data.isPublicHoliday || data.isToday
                          ? FontWeight.w700
                          : FontWeight.w500,
                    ),
                    language,
                  )
                  .copyWith(height: 1),
            ),
          ),
        ),
      ),
    );
    return Semantics(
      button: onTap != null,
      selected: data.isSelected,
      label: MyanmarDayCell.semanticLabel(data, language),
      excludeSemantics: true,
      onTap: onTap == null ? null : () => onTap!(data.date),
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: onTap == null ? null : () => onTap!(data.date),
        child: day,
      ),
    );
  }
}
