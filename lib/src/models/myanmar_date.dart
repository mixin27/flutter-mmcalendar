/// Represents a Myanmar calendar date with all relevant properties
class MyanmarDate {
  /// Myanmar year
  final int year;

  /// Myanmar month (1-14)
  /// [Tagu=1, Kason=2, Nayon=3, FirstWaso=0, Waso=4, Wagaung=5,
  ///  Tawthalin=6, Thadingyut=7, Tazaungmon=8, Nadaw=9, Pyatho=10,
  ///  Tabodwe=11, Tabaung=12, LateTagu=13, LateKason=14]
  final int month;

  /// Day of the month (1-30)
  final int day;

  /// Year type [0=common, 1=little watat, 2=big watat]
  final int yearType;

  /// Moon phase [0=waxing, 1=full moon, 2=waning, 3=new moon]
  final int moonPhase;

  /// Fortnight day [1-15]
  final int fortnightDay;

  /// Weekday [0=Saturday, 1=Sunday, ..., 6=Friday]
  final int weekday;

  /// Julian Day Number
  final double julianDayNumber;

  /// Sasana year based on configuration
  final int sasanaYear;

  /// Length of the month (29 or 30 days)
  final int monthLength;

  const MyanmarDate({
    required this.year,
    required this.month,
    required this.day,
    required this.yearType,
    required this.moonPhase,
    required this.fortnightDay,
    required this.weekday,
    required this.julianDayNumber,
    required this.sasanaYear,
    required this.monthLength,
  });

  /// Creates a copy with modified values
  MyanmarDate copyWith({
    int? year,
    int? month,
    int? day,
    int? yearType,
    int? moonPhase,
    int? fortnightDay,
    int? weekday,
    double? julianDayNumber,
    int? sasanaYear,
    int? monthLength,
  }) {
    return MyanmarDate(
      year: year ?? this.year,
      month: month ?? this.month,
      day: day ?? this.day,
      yearType: yearType ?? this.yearType,
      moonPhase: moonPhase ?? this.moonPhase,
      fortnightDay: fortnightDay ?? this.fortnightDay,
      weekday: weekday ?? this.weekday,
      julianDayNumber: julianDayNumber ?? this.julianDayNumber,
      sasanaYear: sasanaYear ?? this.sasanaYear,
      monthLength: monthLength ?? this.monthLength,
    );
  }

  @override
  String toString() {
    return 'MyanmarDate(year: $year, month: $month, day: $day, yearType: $yearType, moonPhase: $moonPhase, fortnightDay: $fortnightDay, weekday: $weekday, julianDayNumber: $julianDayNumber, sasanaYear: $sasanaYear, monthLength: $monthLength)';
  }

  @override
  bool operator ==(covariant MyanmarDate other) {
    if (identical(this, other)) return true;

    return other.year == year &&
        other.month == month &&
        other.day == day &&
        other.yearType == yearType &&
        other.moonPhase == moonPhase &&
        other.fortnightDay == fortnightDay &&
        other.weekday == weekday &&
        other.julianDayNumber == julianDayNumber &&
        other.sasanaYear == sasanaYear &&
        other.monthLength == monthLength;
  }

  @override
  int get hashCode {
    return year.hashCode ^
        month.hashCode ^
        day.hashCode ^
        yearType.hashCode ^
        moonPhase.hashCode ^
        fortnightDay.hashCode ^
        weekday.hashCode ^
        julianDayNumber.hashCode ^
        sasanaYear.hashCode ^
        monthLength.hashCode;
  }
}
