/// Western date
class WesternDate {
  const WesternDate({
    required this.year,
    required this.month,
    required this.day,
    required this.hour,
    required this.minute,
    required this.second,
  });

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

  WesternDate copyWith({
    int? year,
    int? month,
    int? day,
    int? hour,
    int? minute,
    int? second,
  }) {
    return WesternDate(
      year: year ?? this.year,
      month: month ?? this.month,
      day: day ?? this.day,
      hour: hour ?? this.hour,
      minute: minute ?? this.minute,
      second: second ?? this.second,
    );
  }

  @override
  bool operator ==(covariant WesternDate other) {
    if (identical(this, other)) return true;

    return other.year == year &&
        other.month == month &&
        other.day == day &&
        other.hour == hour &&
        other.minute == minute &&
        other.second == second;
  }

  @override
  int get hashCode {
    return year.hashCode ^
        month.hashCode ^
        day.hashCode ^
        hour.hashCode ^
        minute.hashCode ^
        second.hashCode;
  }

  @override
  String toString() {
    return 'WesternDate(year: $year, month: $month, day: $day, hour: $hour, minute: $minute, second: $second)';
  }
}
