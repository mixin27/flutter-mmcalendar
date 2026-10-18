import 'package:flutter/material.dart';

import '../adaptive/mm_pressable.dart';
import '../calendars/calendar_layout.dart';
import '../calendars/myanmar_calendar_header.dart';
import '../foundation/language_locale.dart';
import '../foundation/mm_strings.dart';
import '../foundation/mm_visual_style.dart';
import '../foundation/myanmar_calendar_scope.dart';

/// Jumps to a month: a year with previous and next buttons over a grid of
/// its twelve months. The header shows the Myanmar years the Western year
/// spans.
class MyanmarMonthYearPicker extends StatefulWidget {
  /// Creates a month-year picker with [selectedMonth] highlighted.
  const MyanmarMonthYearPicker({
    required this.selectedMonth,
    required this.onChanged,
    super.key,
    this.firstDate,
    this.lastDate,
    this.style,
  });

  /// Any day in the highlighted month.
  final DateTime selectedMonth;

  /// Called with the first day of the month the user picks.
  final ValueChanged<DateTime> onChanged;

  /// Months before this one are disabled.
  final DateTime? firstDate;

  /// Months after this one are disabled.
  final DateTime? lastDate;

  /// Overrides the scope's visual style.
  final MmVisualStyle? style;

  @override
  State<MyanmarMonthYearPicker> createState() => _MyanmarMonthYearPickerState();
}

class _MyanmarMonthYearPickerState extends State<MyanmarMonthYearPicker> {
  late int _year = widget.selectedMonth.year;

  bool _allowed(DateTime month) {
    final first = widget.firstDate;
    final last = widget.lastDate;
    if (first != null && month.isBefore(DateTime(first.year, first.month))) {
      return false;
    }
    if (last != null && month.isAfter(DateTime(last.year, last.month))) {
      return false;
    }
    return true;
  }

  @override
  Widget build(BuildContext context) {
    final scope = MyanmarCalendarScope.of(context);
    final theme = MyanmarCalendarScope.themeOf(context);
    final style = MyanmarCalendarScope.styleOf(context, widget.style);
    final strings = MmStrings.of(scope.language);
    final language = scope.language;
    final firstYear = widget.firstDate?.year;
    final lastYear = widget.lastDate?.year;

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        MyanmarCalendarHeader(
          title: language.digits(_year),
          subtitle: CalendarLayout.myanmarSpan(
            scope,
            DateTime(_year),
            DateTime(_year, 12, 31),
          ),
          onPrevious: firstYear == null || _year > firstYear
              ? () => setState(() => _year--)
              : null,
          onNext: lastYear == null || _year < lastYear
              ? () => setState(() => _year++)
              : null,
          previousTooltip: strings.previousYear,
          nextTooltip: strings.nextYear,
          style: widget.style,
        ),
        const SizedBox(height: 8),
        GridView.count(
          crossAxisCount: 3,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          mainAxisSpacing: 8,
          crossAxisSpacing: 8,
          childAspectRatio: 2.4,
          children: [
            for (var m = 1; m <= 12; m++)
              () {
                final month = DateTime(_year, m);
                final selected = DateUtils.isSameMonth(
                  month,
                  widget.selectedMonth,
                );
                final radius = BorderRadius.circular(
                  style == MmVisualStyle.cupertino ? 10 : 999,
                );
                return MmPressable(
                  onPressed: _allowed(month)
                      ? () => widget.onChanged(month)
                      : null,
                  selected: selected,
                  borderRadius: radius,
                  focusColor: theme.accent,
                  minSize: 36,
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      color: selected
                          ? theme.accent
                          : theme.accent.withValues(alpha: 0.08),
                      borderRadius: radius,
                    ),
                    child: Center(
                      child: FittedBox(
                        fit: BoxFit.scaleDown,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 6),
                          child: Text(
                            strings.westernMonth(m),
                            maxLines: 1,
                            style: theme.textStyle(
                              TextStyle(
                                color: selected ? theme.onAccent : theme.ink,
                                fontWeight: selected
                                    ? FontWeight.w600
                                    : FontWeight.w500,
                              ),
                              language,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              }(),
          ],
        ),
      ],
    );
  }
}
