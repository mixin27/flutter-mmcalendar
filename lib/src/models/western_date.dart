/// Represents a Western (Gregorian/Julian) calendar date
class WesternDate {
  /// Year
  final int year;

  /// Month
  final int month;

  /// Day
  final int day;

  /// Hour
  final int hour;

  /// Minute
  final int minute;

  /// Second
  final int second;

  /// Millisecond
  final int millisecond;

  /// Weekday [0=Saturday, 1=Sunday, ..., 6=Friday]
  final int weekday;

  /// Julian Day Number
  final double julianDayNumber;

  /// Create a new western date
  const WesternDate({
    required this.year,
    required this.month,
    required this.day,
    this.hour = 12,
    this.minute = 0,
    this.second = 0,
    this.millisecond = 0,
    required this.weekday,
    required this.julianDayNumber,
  });

  /// Convert to Dart DateTime
  DateTime toDateTime() {
    return DateTime(year, month, day, hour, minute, second, millisecond);
  }

  /// Create from Dart DateTime
  static WesternDate fromDateTime(DateTime dateTime, {double? jdn}) {
    final jd = jdn ?? _calculateJulianDayNumber(dateTime);
    final weekday = (jd.round() + 2) % 7;

    return WesternDate(
      year: dateTime.year,
      month: dateTime.month,
      day: dateTime.day,
      hour: dateTime.hour,
      minute: dateTime.minute,
      second: dateTime.second,
      millisecond: dateTime.millisecond,
      weekday: weekday,
      julianDayNumber: jd,
    );
  }

  static double _calculateJulianDayNumber(DateTime dateTime) {
    // Julian Day Number calculation
    final a = ((14 - dateTime.month) / 12).floor();
    final y = dateTime.year + 4800 - a;
    final m = dateTime.month + (12 * a) - 3;

    final jdn =
        dateTime.day +
        ((153 * m + 2) / 5).floor() +
        (365 * y) +
        (y / 4).floor() -
        (y / 100).floor() +
        (y / 400).floor() -
        32045;

    // Add time fraction
    final timeOfDay =
        (dateTime.hour - 12) / 24.0 +
        dateTime.minute / 1440.0 +
        dateTime.second / 86400.0 +
        dateTime.millisecond / 86400000.0;

    return jdn + timeOfDay;
  }

  @override
  String toString() {
    return 'WesternDate($year-$month-$day $hour:$minute:$second)';
  }
}
