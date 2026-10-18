import 'package:flutter/material.dart';

import 'calendar_selection.dart';

/// Holds the month a calendar shows and what is selected in it.
///
/// Calendars and pickers listen to it, so the app can move or select from
/// anywhere:
///
/// ```dart
/// final controller = MyanmarCalendarController(
///   initialMonth: DateTime(2026, 10),
///   selection: RangeSelection(),
/// );
/// controller.nextMonth();
/// ```
class MyanmarCalendarController extends ChangeNotifier {
  /// Creates a controller showing [initialMonth] (default: this month).
  ///
  /// [firstDate] and [lastDate] bound both navigation and selection;
  /// [selectableDayPredicate] can rule out other days.
  MyanmarCalendarController({
    DateTime? initialMonth,
    CalendarSelection? selection,
    DateTime? firstDate,
    DateTime? lastDate,
    this.selectableDayPredicate,
  }) : firstDate = firstDate == null ? null : DateUtils.dateOnly(firstDate),
       lastDate = lastDate == null ? null : DateUtils.dateOnly(lastDate),
       _selection = selection ?? SingleSelection() {
    assert(
      this.firstDate == null ||
          this.lastDate == null ||
          !this.lastDate!.isBefore(this.firstDate!),
      'lastDate must not be before firstDate',
    );
    _visibleMonth = _clampMonth(
      _monthOf(initialMonth ?? _selection.days.firstOrNull ?? DateTime.now()),
    );
  }

  /// The earliest day that can be shown and selected.
  final DateTime? firstDate;

  /// The latest day that can be shown and selected.
  final DateTime? lastDate;

  /// Rules out days within [firstDate] to [lastDate], e.g. weekends.
  final SelectableDayPredicate? selectableDayPredicate;

  late DateTime _visibleMonth;
  CalendarSelection _selection;

  /// The first day of the month on screen.
  DateTime get visibleMonth => _visibleMonth;

  /// What is selected.
  CalendarSelection get selection => _selection;

  set selection(CalendarSelection value) {
    if (value == _selection) return;
    _selection = value;
    notifyListeners();
  }

  /// Whether [day] is within the bounds and allowed by the predicate.
  bool isSelectable(DateTime day) {
    final d = DateUtils.dateOnly(day);
    if (firstDate != null && d.isBefore(firstDate!)) return false;
    if (lastDate != null && d.isAfter(lastDate!)) return false;
    return selectableDayPredicate?.call(d) ?? true;
  }

  /// Applies a tap on [day] to the selection. Returns `false`, changing
  /// nothing, when the day can't be selected.
  bool select(DateTime day) {
    if (!isSelectable(day)) return false;
    selection = _selection.select(day);
    return true;
  }

  /// Selects nothing, keeping the kind of selection.
  void clearSelection() => selection = _selection.cleared();

  /// Shows the month containing [date], kept within the bounds.
  void jumpTo(DateTime date) {
    final month = _clampMonth(_monthOf(date));
    if (month == _visibleMonth) return;
    _visibleMonth = month;
    notifyListeners();
  }

  /// Whether there is a month after the visible one within the bounds.
  bool get canGoNext =>
      lastDate == null || _visibleMonth.isBefore(_monthOf(lastDate!));

  /// Whether there is a month before the visible one within the bounds.
  bool get canGoPrevious =>
      firstDate == null || _visibleMonth.isAfter(_monthOf(firstDate!));

  /// Shows the next month, if there is one.
  void nextMonth() {
    if (canGoNext) jumpTo(_addMonths(_visibleMonth, 1));
  }

  /// Shows the previous month, if there is one.
  void previousMonth() {
    if (canGoPrevious) jumpTo(_addMonths(_visibleMonth, -1));
  }

  /// The number of months from [firstDate]'s month to [lastDate]'s, or
  /// `null` when either is open.
  int? get monthCount => firstDate == null || lastDate == null
      ? null
      : DateUtils.monthDelta(firstDate!, lastDate!) + 1;

  static DateTime _monthOf(DateTime d) => DateTime(d.year, d.month);

  static DateTime _addMonths(DateTime month, int delta) =>
      DateTime(month.year, month.month + delta);

  DateTime _clampMonth(DateTime month) {
    if (firstDate != null && month.isBefore(_monthOf(firstDate!))) {
      return _monthOf(firstDate!);
    }
    if (lastDate != null && month.isAfter(_monthOf(lastDate!))) {
      return _monthOf(lastDate!);
    }
    return month;
  }
}
