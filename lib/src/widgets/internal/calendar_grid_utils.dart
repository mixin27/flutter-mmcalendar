// ignore_for_file: public_member_api_docs

/// Date-grid helpers shared by calendar and picker widgets.
class CalendarGridUtils {
  /// Normalizes a value to date-only precision.
  static DateTime normalize(DateTime value) {
    return DateTime(value.year, value.month, value.day);
  }

  /// Returns true when [a] and [b] represent the same day.
  static bool isSameDate(DateTime a, DateTime b) {
    return a.year == b.year && a.month == b.month && a.day == b.day;
  }

  /// Builds a fixed-size month grid suitable for calendar UIs.
  ///
  /// The result always has `rows * 7` items and includes leading/trailing days
  /// from adjacent months.
  static List<DateTime> buildMonthGrid(
    DateTime visibleMonth, {
    int firstDayOfWeek = 1,
    int rows = 6,
  }) {
    final month = DateTime(visibleMonth.year, visibleMonth.month);
    final firstOfMonth = DateTime(month.year, month.month, 1);

    // Dart: 1=Mon..7=Sun; Myanmar weekday model used by package: 0=Sat..6=Fri.
    final firstMyanmarWeekday = (firstOfMonth.weekday + 1) % 7;
    final back = (firstMyanmarWeekday - firstDayOfWeek + 7) % 7;
    final start = firstOfMonth.subtract(Duration(days: back));

    final count = rows * 7;
    return List<DateTime>.generate(
      count,
      (index) => start.add(Duration(days: index)),
      growable: false,
    );
  }
}
