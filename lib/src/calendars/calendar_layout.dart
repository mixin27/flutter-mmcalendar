import 'package:flutter/material.dart';
import 'package:myanmar_calendar_dart/myanmar_calendar_dart.dart';

import '../foundation/language_locale.dart';
import '../foundation/mm_strings.dart';
import '../foundation/myanmar_calendar_scope.dart';

/// Date arithmetic shared by the calendars. Days are local, date-only.
abstract final class CalendarLayout {
  /// [day] moved by [days] calendar days, safe across daylight saving.
  static DateTime addDays(DateTime day, int days) =>
      DateTime(day.year, day.month, day.day + days);

  /// The first day of the week containing [day].
  static DateTime weekStart(DateTime day, int firstDayOfWeek) {
    final offset = (day.weekday - firstDayOfWeek + 7) % 7;
    return addDays(DateUtils.dateOnly(day), -offset);
  }

  /// The weeks covering [month], each seven days long, including the
  /// neighbouring months' days that fill the first and last week.
  static List<List<DateTime>> weeksOf(DateTime month, int firstDayOfWeek) {
    final first = DateTime(month.year, month.month);
    final last = DateTime(month.year, month.month + 1, 0);
    var start = weekStart(first, firstDayOfWeek);
    final weeks = <List<DateTime>>[];
    while (!start.isAfter(last)) {
      weeks.add([for (var i = 0; i < 7; i++) addDays(start, i)]);
      start = addDays(start, 7);
    }
    return weeks;
  }

  /// The weekdays in display order, as `DateTime` weekdays.
  static List<int> weekdayOrder(int firstDayOfWeek) => [
    for (var i = 0; i < 7; i++) (firstDayOfWeek - 1 + i) % 7 + 1,
  ];

  /// The Myanmar months [month] spans, e.g. "Tawthalin – Thadingyut 1388",
  /// or "Tabaung 1387 – Late Tagu 1388" across a Myanmar new year.
  static String myanmarSpan(
    MyanmarCalendarScopeData scope,
    DateTime first,
    DateTime last,
  ) {
    final strings = MmStrings.of(scope.language);
    final a = scope.day(first).myanmar;
    final b = scope.day(last).myanmar;
    String digits(int n) => scope.language.digits(n);
    String name(MyanmarDate d) => strings.myanmarMonth(d.month, d.yearType);
    if (a.year != b.year) {
      return '${name(a)} ${digits(a.year)} – ${name(b)} ${digits(b.year)}';
    }
    if (a.month == b.month) return '${name(a)} ${digits(a.year)}';
    return '${name(a)} – ${name(b)} ${digits(b.year)}';
  }

  /// The Myanmar months a Western [month] spans.
  static String myanmarSpanOfMonth(
    MyanmarCalendarScopeData scope,
    DateTime month,
  ) => myanmarSpan(
    scope,
    DateTime(month.year, month.month),
    DateTime(month.year, month.month + 1, 0),
  );
}
