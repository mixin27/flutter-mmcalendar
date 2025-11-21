import '../utils/shan_calendar_constants.dart';
import 'myanmar_date.dart';

/// Represents a date in the Shan calendar system
///
/// The Shan calendar follows the Myanmar calendar structure but uses
/// a different year calculation: Shan Year = Myanmar Year + 733
///
/// Example:
/// ```dart
/// final myanmarDate = MyanmarDate(year: 1387, month: 10, day: 15, ...);
/// final shanDate = ShanDate.fromMyanmarDate(myanmarDate);
/// print('Shan Year: ${shanDate.year}'); // 2120
/// print('Formatted: ${shanDate.format()}'); // ပီ 2120 လိူၼ်ပူၼ် ဝၼ်း 15
/// ```
class ShanDate {
  /// Shan calendar year (e.g., 2120)
  final int year;

  /// Month index (0-14, same structure as Myanmar calendar)
  final int month;

  /// Day of month (1-30)
  final int day;

  /// Corresponding Myanmar year (e.g., 1387)
  final int myanmarYear;

  /// Weekday (0-6, where 0=Saturday in Myanmar system)
  final int weekday;

  /// Month type (0=normal, 1=intercalary)
  final int monthType;

  /// Moon phase (0=waxing, 1=full moon, 2=waning, 3=new moon)
  final int moonPhase;

  /// Fortnight day (1-15)
  final int fortnightDay;

  /// Creates a Shan date
  const ShanDate({
    required this.year,
    required this.month,
    required this.day,
    required this.myanmarYear,
    required this.weekday,
    required this.monthType,
    required this.moonPhase,
    required this.fortnightDay,
  });

  /// Create Shan date from Myanmar date
  ///
  /// Converts a Myanmar calendar date to Shan calendar by adding
  /// the offset of 733 years to the Myanmar year.
  ///
  /// Example:
  /// ```dart
  /// final myanmarDate = MyanmarDate(year: 1387, month: 10, day: 15, ...);
  /// final shanDate = ShanDate.fromMyanmarDate(myanmarDate);
  /// print(shanDate.year); // 2120
  /// ```
  factory ShanDate.fromMyanmarDate(MyanmarDate myanmarDate) {
    return ShanDate(
      year: ShanCalendarConstants.getShanYear(myanmarDate.year),
      month: myanmarDate.month,
      day: myanmarDate.day,
      myanmarYear: myanmarDate.year,
      weekday: myanmarDate.weekday,
      monthType: myanmarDate.monthType,
      moonPhase: myanmarDate.moonPhase,
      fortnightDay: myanmarDate.fortnightDay,
    );
  }

  /// Get Shan month name in Shan language
  String get monthName => ShanCalendarConstants.getMonthName(month);

  /// Get Shan weekday name
  String getWeekdayName({bool short = false}) {
    return ShanCalendarConstants.getWeekdayName(weekday, short: short);
  }

  /// Format Shan date with pattern
  ///
  /// Pattern tokens:
  /// - `&sy` : Shan year (e.g., 2120)
  /// - `&sm` : Shan month name (e.g., လိူၼ်ပူၼ်)
  /// - `&mi` : Month index (0-14)
  /// - `&d`  : Day (e.g., 15)
  /// - `&dd` : Day with zero padding (e.g., 05)
  /// - `&w`  : Weekday name
  /// - `&ws` : Weekday short name
  /// - `&p`  : Moon phase name
  /// - `&f`  : Fortnight day
  ///
  /// Example:
  /// ```dart
  /// final formatted = shanDate.format('ပီ &sy &sm ဝၼ်း &d');
  /// // Output: "ပီ 2120 လိူၼ်ပူၼ် ဝၼ်း 15"
  /// ```
  String format({String pattern = 'ပီ &sy &sm ဝၼ်း &d'}) {
    var result = pattern;

    // Shan year
    result = result.replaceAll('&sy', year.toString());

    // Shan month name
    result = result.replaceAll('&sm', monthName);

    // Month index
    result = result.replaceAll('&mi', month.toString());

    // Day with zero padding
    result = result.replaceAll('&dd', day.toString().padLeft(2, '0'));

    // Day
    result = result.replaceAll('&d', day.toString());

    // Weekday short name
    result = result.replaceAll('&ws', getWeekdayName(short: true));

    // Weekday name
    result = result.replaceAll('&w', getWeekdayName());

    // Moon phase
    if (result.contains('&p')) {
      final phaseName = _getMoonPhaseName();
      result = result.replaceAll('&p', phaseName);
    }

    // Fortnight day
    result = result.replaceAll('&f', fortnightDay.toString());

    return result;
  }

  /// Get moon phase name in Shan
  String _getMoonPhaseName() {
    const phases = [
      'လိူၼ်မႂ်ႇ', // Waxing
      'လိူၼ်မူၼ်း', // Full Moon
      'လိူၼ်လွင်ႈ', // Waning
      'လိူၼ်လပ်း', // New Moon
    ];
    return moonPhase >= 0 && moonPhase < phases.length ? phases[moonPhase] : '';
  }

  /// Short format: "2120/10/15"
  String formatShort() => '$year/$month/$day';

  /// Long format with weekday: "ဝၼ်းပူၼ်, ပီ 2120 လိူၼ်ပူၼ် ဝၼ်း 15"
  String formatLong() => format(pattern: '&w, ပီ &sy &sm ဝၼ်း &d');

  /// Compact format: "2120/10/15"
  String formatCompact() => '$year/$month/$day';

  @override
  String toString() {
    return 'ShanDate(year: $year, month: $month, day: $day, myanmarYear: $myanmarYear)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is ShanDate &&
        other.year == year &&
        other.month == month &&
        other.day == day;
  }

  @override
  int get hashCode => Object.hash(year, month, day);

  /// Convert to Map for serialization
  Map<String, dynamic> toMap() {
    return {
      'year': year,
      'month': month,
      'day': day,
      'myanmarYear': myanmarYear,
      'weekday': weekday,
      'monthType': monthType,
      'moonPhase': moonPhase,
      'fortnightDay': fortnightDay,
      'monthName': monthName,
    };
  }

  /// Create from Map (deserialization)
  factory ShanDate.fromMap(Map<String, dynamic> map) {
    return ShanDate(
      year: map['year'] as int,
      month: map['month'] as int,
      day: map['day'] as int,
      myanmarYear: map['myanmarYear'] as int,
      weekday: map['weekday'] as int,
      monthType: map['monthType'] as int,
      moonPhase: map['moonPhase'] as int,
      fortnightDay: map['fortnightDay'] as int,
    );
  }

  /// Create a copy with modified values
  ShanDate copyWith({
    int? year,
    int? month,
    int? day,
    int? myanmarYear,
    int? weekday,
    int? monthType,
    int? moonPhase,
    int? fortnightDay,
  }) {
    return ShanDate(
      year: year ?? this.year,
      month: month ?? this.month,
      day: day ?? this.day,
      myanmarYear: myanmarYear ?? this.myanmarYear,
      weekday: weekday ?? this.weekday,
      monthType: monthType ?? this.monthType,
      moonPhase: moonPhase ?? this.moonPhase,
      fortnightDay: fortnightDay ?? this.fortnightDay,
    );
  }
}
