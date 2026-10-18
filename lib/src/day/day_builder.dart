import 'package:flutter/material.dart';
import 'package:myanmar_calendar_dart/myanmar_calendar_dart.dart';

import '../foundation/myanmar_calendar_scope.dart';
import '../foundation/today_builder.dart';

/// Builds with everything about [date], or about today (kept current at
/// midnight) when [date] is null.
class DayBuilder extends StatelessWidget {
  /// Creates a day builder.
  const DayBuilder({required this.builder, super.key, this.date, this.clock});

  /// The day; today when null.
  final DateTime? date;

  /// The current time, for tests.
  final DateTime Function()? clock;

  /// Builds with the day's complete date and today's date.
  final Widget Function(BuildContext context, CompleteDate day, DateTime today)
  builder;

  @override
  Widget build(BuildContext context) {
    final scope = MyanmarCalendarScope.of(context);
    return TodayBuilder(
      clock: clock,
      builder: (context, today) =>
          builder(context, scope.day(date ?? today), today),
    );
  }
}

/// The Western day of [date], date-only.
DateTime westernDay(CompleteDate date) =>
    DateTime(date.western.year, date.western.month, date.western.day);
