import 'package:flutter/material.dart';
import 'package:myanmar_calendar_dart/myanmar_calendar_dart.dart';

import '../adaptive/mm_surface.dart';
import '../foundation/language_locale.dart';
import '../foundation/mm_strings.dart';
import '../foundation/mm_visual_style.dart';
import '../foundation/myanmar_calendar_scope.dart';
import '../foundation/today_builder.dart';
import 'calendar_layout.dart';
import 'myanmar_calendar_header.dart';
import 'myanmar_mini_month.dart';

/// A Western year as twelve [MyanmarMiniMonth]s, with public holidays and
/// full moons marked. Tapping a month calls [onMonthTapped].
class MyanmarYearCalendar extends StatefulWidget {
  /// Creates a year view starting on [year].
  const MyanmarYearCalendar({
    required this.year,
    super.key,
    this.onMonthTapped,
    this.onDayTapped,
    this.onYearChanged,
    this.showHeader = true,
    this.surface = true,
    this.minMonthWidth = 150,
    this.style,
    this.clock,
  });

  /// The Western year to show first.
  final int year;

  /// Called with the first day of the tapped month.
  final ValueChanged<DateTime>? onMonthTapped;

  /// Called with a tapped day.
  final ValueChanged<CompleteDate>? onDayTapped;

  /// Called when the header buttons change the year.
  final ValueChanged<int>? onYearChanged;

  /// Whether to show the title with previous and next buttons.
  final bool showHeader;

  /// Whether to draw on an [MmSurface].
  final bool surface;

  /// The narrowest a month may get before the grid drops a column.
  final double minMonthWidth;

  /// Overrides the scope's visual style.
  final MmVisualStyle? style;

  /// The current time, for tests.
  final DateTime Function()? clock;

  @override
  State<MyanmarYearCalendar> createState() => _MyanmarYearCalendarState();
}

class _MyanmarYearCalendarState extends State<MyanmarYearCalendar> {
  late int _year = widget.year;

  @override
  void didUpdateWidget(MyanmarYearCalendar oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.year != oldWidget.year) _year = widget.year;
  }

  void _go(int delta) {
    setState(() => _year += delta);
    widget.onYearChanged?.call(_year);
  }

  @override
  Widget build(BuildContext context) {
    final scope = MyanmarCalendarScope.of(context);
    final strings = MmStrings.of(scope.language);
    final body = TodayBuilder(
      clock: widget.clock,
      builder: (context, today) => Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.min,
        children: [
          if (widget.showHeader)
            MyanmarCalendarHeader(
              title: scope.language.digits(_year),
              subtitle: CalendarLayout.myanmarSpan(
                scope,
                DateTime(_year),
                DateTime(_year, 12, 31),
              ),
              onPrevious: () => _go(-1),
              onNext: () => _go(1),
              previousTooltip: strings.previousYear,
              nextTooltip: strings.nextYear,
              style: widget.style,
            ),
          const SizedBox(height: 8),
          LayoutBuilder(
            builder: (context, box) {
              final columns = (box.maxWidth / widget.minMonthWidth)
                  .floor()
                  .clamp(1, 4);
              final rows = (12 / columns).ceil();
              return Column(
                children: [
                  for (var r = 0; r < rows; r++)
                    Padding(
                      padding: const EdgeInsets.only(bottom: 14),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          for (var c = 0; c < columns; c++) ...[
                            if (c > 0) const SizedBox(width: 14),
                            Expanded(child: _month(r * columns + c + 1, today)),
                          ],
                        ],
                      ),
                    ),
                ],
              );
            },
          ),
        ],
      ),
    );
    final padded = Padding(padding: const EdgeInsets.all(14), child: body);
    return widget.surface
        ? MmSurface(style: widget.style, child: padded)
        : padded;
  }

  Widget _month(int month, DateTime today) {
    if (month > 12) return const SizedBox.shrink();
    final first = DateTime(_year, month);
    return MyanmarMiniMonth(
      month: first,
      clock: widget.clock,
      highlightTitle: DateUtils.isSameMonth(first, today),
      onTitleTapped: widget.onMonthTapped == null
          ? null
          : () => widget.onMonthTapped!(first),
      onDayTapped: widget.onDayTapped,
    );
  }
}
