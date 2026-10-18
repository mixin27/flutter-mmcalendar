import 'package:flutter/material.dart';
import 'package:myanmar_calendar_dart/myanmar_calendar_dart.dart';

import '../adaptive/mm_buttons.dart';
import '../adaptive/mm_segmented.dart';
import '../adaptive/mm_surface.dart';
import '../calendars/calendar_layout.dart';
import '../foundation/language_locale.dart';
import '../foundation/mm_strings.dart';
import '../foundation/mm_visual_style.dart';
import '../foundation/myanmar_calendar_scope.dart';
import 'pickable_date_row.dart';

/// What [DateDifferenceCard] adds to a date.
enum DateStep {
  /// Calendar days.
  days,

  /// Myanmar months, keeping the day of the month (or the month's last day
  /// when it is shorter).
  myanmarMonths,
}

/// Date arithmetic: the days between two dates, and a date plus a number of
/// days or Myanmar months.
class DateDifferenceCard extends StatefulWidget {
  /// Creates the card for [from] and [to] (both default to today).
  const DateDifferenceCard({
    super.key,
    this.from,
    this.to,
    this.initialAmount = 1,
    this.initialStep = DateStep.myanmarMonths,
    this.style,
  });

  /// The first date.
  final DateTime? from;

  /// The second date.
  final DateTime? to;

  /// How much to add at first.
  final int initialAmount;

  /// What to add at first.
  final DateStep initialStep;

  /// Overrides the scope's visual style.
  final MmVisualStyle? style;

  /// [from] plus [amount] of [step], computed with [client].
  static DateTime add(
    MyanmarCalendarClient client,
    DateTime from,
    int amount,
    DateStep step,
  ) {
    if (step == DateStep.days) return CalendarLayout.addDays(from, amount);
    final start = client.fromWestern(from.year, from.month, from.day);
    final w = client.addMonths(start, amount).westernDate;
    return DateTime(w.year, w.month, w.day);
  }

  /// Calendar days from [a] to [b]; negative when [b] is earlier.
  static int daysBetween(DateTime a, DateTime b) => DateTime.utc(
    b.year,
    b.month,
    b.day,
  ).difference(DateTime.utc(a.year, a.month, a.day)).inDays;

  @override
  State<DateDifferenceCard> createState() => _DateDifferenceCardState();
}

class _DateDifferenceCardState extends State<DateDifferenceCard> {
  late DateTime _from = DateUtils.dateOnly(widget.from ?? DateTime.now());
  late DateTime _to = DateUtils.dateOnly(widget.to ?? DateTime.now());
  late int _amount = widget.initialAmount;
  late DateStep _step = widget.initialStep;

  DateTime _dayOf(CompleteDate d) =>
      DateTime(d.western.year, d.western.month, d.western.day);

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

    final between = DateDifferenceCard.daysBetween(_from, _to);
    final result = DateDifferenceCard.add(scope.client, _from, _amount, _step);
    final resultDay = scope.day(result);

    return MmSurface(
      style: widget.style,
      padding: const EdgeInsets.all(14),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(strings.daysBetween, style: ts(16, theme.ink, FontWeight.w700)),
          const SizedBox(height: 10),
          PickableDateRow(
            label: strings.from,
            main: strings.westernDate(_from),
            detail: strings.myanmarDate(scope.day(_from).myanmar),
            date: _from,
            style: widget.style,
            onPicked: (d) => setState(() => _from = _dayOf(d)),
          ),
          const SizedBox(height: 8),
          PickableDateRow(
            label: strings.to,
            main: strings.westernDate(_to),
            detail: strings.myanmarDate(scope.day(_to).myanmar),
            date: _to,
            style: widget.style,
            onPicked: (d) => setState(() => _to = _dayOf(d)),
          ),
          const SizedBox(height: 10),
          Semantics(
            liveRegion: true,
            child: Text(
              strings.dayCount(between.abs()),
              textAlign: TextAlign.center,
              style: ts(24, theme.accent, FontWeight.w700),
            ),
          ),
          const SizedBox(height: 14),
          Divider(height: 1, color: theme.outline),
          const SizedBox(height: 14),
          Row(
            children: [
              Text(strings.add, style: ts(15, theme.ink, FontWeight.w600)),
              const Spacer(),
              MmIconButton(
                icon: Icons.remove,
                tooltip: '−1',
                style: widget.style,
                onPressed: () => setState(() => _amount--),
              ),
              SizedBox(
                width: 44,
                child: Text(
                  language.digits(_amount),
                  textAlign: TextAlign.center,
                  style: ts(18, theme.ink, FontWeight.w700),
                ),
              ),
              MmIconButton(
                icon: Icons.add,
                tooltip: '+1',
                style: widget.style,
                onPressed: () => setState(() => _amount++),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Center(
            child: MmSegmented<DateStep>(
              segments: {
                DateStep.days: strings.day,
                DateStep.myanmarMonths: strings.myanmarMonths,
              },
              selected: _step,
              style: widget.style,
              onChanged: (s) => setState(() => _step = s),
            ),
          ),
          const SizedBox(height: 10),
          Semantics(
            liveRegion: true,
            child: Column(
              children: [
                Text(
                  strings.myanmarDate(resultDay.myanmar),
                  textAlign: TextAlign.center,
                  style: ts(17, theme.ink, FontWeight.w600),
                ),
                Text(
                  '${strings.weekdayName(result.weekday)}, '
                  '${strings.westernDate(result)}',
                  textAlign: TextAlign.center,
                  style: ts(13, theme.muted),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
