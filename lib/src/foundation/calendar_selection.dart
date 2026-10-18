import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart' show DateUtils;

/// Where a day sits in a range selection.
enum RangePosition {
  /// Not in the range.
  none,

  /// The range's first day, with more to follow.
  start,

  /// Between the first and last day.
  middle,

  /// The range's last day.
  end,

  /// The only day: a range whose start and end are the same, or whose end
  /// isn't chosen yet.
  single,
}

/// What is selected in a calendar. Days are always date-only.
@immutable
sealed class CalendarSelection {
  const CalendarSelection();

  /// Whether [day] is selected.
  bool contains(DateTime day);

  /// The selection after the user taps [day].
  CalendarSelection select(DateTime day);

  /// The same kind of selection with nothing selected.
  CalendarSelection cleared();

  /// The selected days, earliest first. A range lists only its ends.
  List<DateTime> get days;

  /// Where [day] sits in a range; [RangePosition.none] for other selections.
  RangePosition rangePositionOf(DateTime day) => RangePosition.none;

  /// Whether nothing is selected.
  bool get isEmpty => days.isEmpty;
}

/// One day, or none.
final class SingleSelection extends CalendarSelection {
  /// Selects [date], or nothing.
  SingleSelection([DateTime? date])
    : date = date == null ? null : DateUtils.dateOnly(date);

  /// The selected day.
  final DateTime? date;

  @override
  bool contains(DateTime day) => DateUtils.isSameDay(date, day);

  @override
  SingleSelection select(DateTime day) => SingleSelection(day);

  @override
  SingleSelection cleared() => SingleSelection();

  @override
  List<DateTime> get days => [?date];

  @override
  bool operator ==(Object other) =>
      other is SingleSelection && other.date == date;

  @override
  int get hashCode => date.hashCode;

  @override
  String toString() => 'SingleSelection($date)';
}

/// A run of days from [start] to [end], inclusive.
final class RangeSelection extends CalendarSelection {
  /// Selects [start] to [end]. A start without an end is a range in progress.
  RangeSelection({DateTime? start, DateTime? end})
    : assert(start != null || end == null, 'A range with an end needs a start'),
      start = start == null ? null : DateUtils.dateOnly(start),
      end = end == null ? null : DateUtils.dateOnly(end) {
    assert(
      this.end == null || !this.end!.isBefore(this.start!),
      'end must not be before start',
    );
  }

  /// The first day.
  final DateTime? start;

  /// The last day; `null` while the range is being chosen.
  final DateTime? end;

  /// Whether both ends are chosen.
  bool get isComplete => start != null && end != null;

  /// The number of days in the range, both ends included.
  int get length => !isComplete
      ? (start == null ? 0 : 1)
      : _utc(end!).difference(_utc(start!)).inDays + 1;

  // Counting in UTC keeps daylight-saving days from being 23 or 25 hours.
  static DateTime _utc(DateTime d) => DateTime.utc(d.year, d.month, d.day);

  @override
  bool contains(DateTime day) => rangePositionOf(day) != RangePosition.none;

  @override
  RangePosition rangePositionOf(DateTime day) {
    final s = start;
    if (s == null) return RangePosition.none;
    final d = DateUtils.dateOnly(day);
    final e = end ?? s;
    if (d.isBefore(s) || d.isAfter(e)) return RangePosition.none;
    if (s == e) return RangePosition.single;
    if (d == s) return RangePosition.start;
    if (d == e) return RangePosition.end;
    return RangePosition.middle;
  }

  /// Tapping starts a new range when this one is empty or complete; tapping
  /// before the start moves the start; otherwise it sets the end.
  @override
  RangeSelection select(DateTime day) {
    final d = DateUtils.dateOnly(day);
    final s = start;
    if (s == null || isComplete || d.isBefore(s)) {
      return RangeSelection(start: d);
    }
    return RangeSelection(start: s, end: d);
  }

  @override
  RangeSelection cleared() => RangeSelection();

  @override
  List<DateTime> get days => [?start, if (end != start) ?end];

  @override
  bool operator ==(Object other) =>
      other is RangeSelection && other.start == start && other.end == end;

  @override
  int get hashCode => Object.hash(start, end);

  @override
  String toString() => 'RangeSelection($start, $end)';
}

/// Any number of separate days.
final class MultiSelection extends CalendarSelection {
  /// Selects [dates].
  MultiSelection([Iterable<DateTime> dates = const []])
    : dates = Set.unmodifiable(dates.map(DateUtils.dateOnly));

  /// The selected days.
  final Set<DateTime> dates;

  @override
  bool contains(DateTime day) => dates.contains(DateUtils.dateOnly(day));

  /// Tapping toggles [day].
  @override
  MultiSelection select(DateTime day) {
    final d = DateUtils.dateOnly(day);
    return MultiSelection(
      dates.contains(d) ? dates.where((x) => x != d) : [...dates, d],
    );
  }

  @override
  MultiSelection cleared() => MultiSelection();

  @override
  List<DateTime> get days => dates.toList()..sort();

  @override
  bool operator ==(Object other) =>
      other is MultiSelection && setEquals(other.dates, dates);

  @override
  int get hashCode => Object.hashAllUnordered(dates);

  @override
  String toString() => 'MultiSelection(${days.join(', ')})';
}
