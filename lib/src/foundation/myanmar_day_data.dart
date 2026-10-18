import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart' show DateUtils;
import 'package:myanmar_calendar_dart/myanmar_calendar_dart.dart';

import 'calendar_selection.dart';

/// Everything a day cell or builder needs about one day: its dates, holidays
/// and astrology, plus how it sits in the calendar right now.
@immutable
class MyanmarDayData {
  /// Creates day data. Calendars build these with [MyanmarDayData.resolve].
  const MyanmarDayData({
    required this.date,
    required this.day,
    this.isToday = false,
    this.isSelected = false,
    this.rangePosition = RangePosition.none,
    this.isOutside = false,
    this.isDisabled = false,
    this.isWeekend = false,
    this.events = const [],
  });

  /// Works out a day's state for a calendar showing [visibleMonth].
  factory MyanmarDayData.resolve({
    required CompleteDate date,
    required DateTime today,
    CalendarSelection? selection,
    DateTime? visibleMonth,
    bool Function(DateTime day)? isSelectable,
    Set<int> weekendDays = const {DateTime.saturday, DateTime.sunday},
    List<Object?> events = const [],
  }) {
    final day = DateTime(
      date.western.year,
      date.western.month,
      date.western.day,
    );
    return MyanmarDayData(
      date: date,
      day: day,
      isToday: DateUtils.isSameDay(day, today),
      isSelected: selection?.contains(day) ?? false,
      rangePosition: selection?.rangePositionOf(day) ?? RangePosition.none,
      isOutside:
          visibleMonth != null && !DateUtils.isSameMonth(day, visibleMonth),
      isDisabled: !(isSelectable?.call(day) ?? true),
      isWeekend: weekendDays.contains(day.weekday),
      events: events,
    );
  }

  /// The day's Western, Myanmar and Shan dates, holidays and astrology.
  final CompleteDate date;

  /// The Western day, date-only, in local time.
  final DateTime day;

  /// Whether this is today.
  final bool isToday;

  /// Whether the selection includes this day.
  final bool isSelected;

  /// Where this day sits in a range selection.
  final RangePosition rangePosition;

  /// Whether the day belongs to the month before or after the one shown.
  final bool isOutside;

  /// Whether the day is outside the allowed dates or ruled out.
  final bool isDisabled;

  /// Whether the day falls on a weekend.
  final bool isWeekend;

  /// The app's events on this day, from a calendar's `eventLoader`.
  final List<Object?> events;

  /// The day's Myanmar date.
  MyanmarDate get myanmar => date.myanmar;

  /// The day's holidays and anniversaries.
  List<Holiday> get holidays => date.holidays.entries;

  /// Whether the day has a public holiday.
  bool get isPublicHoliday => holidays.any((h) => h.type == HolidayType.public);

  /// The day's moon phase.
  MoonPhase get moonPhase => date.myanmar.phase;

  /// Whether the day is a full or new moon.
  bool get isMoonDay =>
      moonPhase == MoonPhase.fullMoon || moonPhase == MoonPhase.newMoon;

  /// The day's Sabbath kind.
  SabbathType get sabbath => date.astro.sabbathType;

  @override
  bool operator ==(Object other) =>
      other is MyanmarDayData &&
      other.day == day &&
      identical(other.date, date) &&
      other.isToday == isToday &&
      other.isSelected == isSelected &&
      other.rangePosition == rangePosition &&
      other.isOutside == isOutside &&
      other.isDisabled == isDisabled &&
      other.isWeekend == isWeekend &&
      listEquals(other.events, events);

  @override
  int get hashCode => Object.hash(
    day,
    isToday,
    isSelected,
    rangePosition,
    isOutside,
    isDisabled,
    isWeekend,
    Object.hashAll(events),
  );
}
