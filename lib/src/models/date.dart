import 'package:equatable/equatable.dart';

/// Represents a Myanmar date and time.
class MyanmarDate extends Equatable {
  final int myear;
  final int yearType;
  final int yearLength;
  final int mmonth;
  final int monthType;
  final int monthLength;
  final int monthDay;
  final int fortnightDay;
  final int moonPhase;
  final int weekDay;
  final double jd;

  const MyanmarDate({
    required this.myear,
    required this.yearType,
    required this.yearLength,
    required this.mmonth,
    required this.monthType,
    required this.monthLength,
    required this.monthDay,
    required this.fortnightDay,
    required this.moonPhase,
    required this.weekDay,
    required this.jd,
  });

  @override
  List<Object?> get props => [
    myear,
    yearType,
    yearLength,
    mmonth,
    monthType,
    monthLength,
    monthDay,
    fortnightDay,
    moonPhase,
    weekDay,
    jd,
  ];

  MyanmarDate copyWith({
    int? myear,
    int? yearType,
    int? yearLength,
    int? mmonth,
    int? monthType,
    int? monthLength,
    int? monthDay,
    int? fortnightDay,
    int? moonPhase,
    int? weekDay,
    double? jd,
  }) {
    return MyanmarDate(
      myear: myear ?? this.myear,
      yearType: yearType ?? this.yearType,
      yearLength: yearLength ?? this.yearLength,
      mmonth: mmonth ?? this.mmonth,
      monthType: monthType ?? this.monthType,
      monthLength: monthLength ?? this.monthLength,
      monthDay: monthDay ?? this.monthDay,
      fortnightDay: fortnightDay ?? this.fortnightDay,
      moonPhase: moonPhase ?? this.moonPhase,
      weekDay: weekDay ?? this.weekDay,
      jd: jd ?? this.jd,
    );
  }

  @override
  String toString() => '$monthDay/$mmonth/$myear';
}

/// Represents a Western (Gregorian) date and time.
class WesternDate extends Equatable {
  /// Year of the date.
  final int year;

  /// Month of the date (1–12).
  final int month;

  /// Day of the month (1–31).
  final int day;

  /// Hour of the day (0–23).
  final int hour;

  /// Minute of the hour (0–59).
  final int minute;

  /// Second of the minute (0–59).
  final int second;

  const WesternDate({
    required this.year,
    required this.month,
    required this.day,
    required this.hour,
    required this.minute,
    required this.second,
  });

  @override
  List<Object?> get props => [year, month, day, hour, minute, second];

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
  String toString() => 'WesternDate($year-$month-$day $hour:$minute:$second)';
}
