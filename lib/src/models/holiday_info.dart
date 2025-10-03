/// Contains holiday information for a given date
class HolidayInfo {
  /// Public holidays
  final List<String> publicHolidays;

  /// Religious holidays
  final List<String> religiousHolidays;

  /// Cultural holidays
  final List<String> culturalHolidays;

  /// Other holidays
  final List<String> otherHolidays;

  /// Myanmar anniversary days - Others special days (not holidays)
  final List<String> myanmarAnniversaryDays;

  /// Myanmar anniversary days - Others special days (not holidays)
  final List<String> otherAnniversaryDays;

  /// Create a new holiday info
  const HolidayInfo({
    required this.publicHolidays,
    required this.religiousHolidays,
    required this.culturalHolidays,
    required this.otherHolidays,
    required this.myanmarAnniversaryDays,
    required this.otherAnniversaryDays,
  });

  /// Get all holidays combined
  List<String> get allHolidays => [
    ...publicHolidays,
    ...religiousHolidays,
    ...culturalHolidays,
    ...otherHolidays,
  ];

  /// Check if there are any holidays on this date
  bool get hasHolidays => allHolidays.isNotEmpty;

  /// Get all anniversary days combined
  List<String> get allAnniversaryDays => [
    ...myanmarAnniversaryDays,
    ...otherAnniversaryDays,
  ];

  /// Check if there are any anniversary days on this date
  bool get hasAnniversaryDays => allAnniversaryDays.isNotEmpty;

  @override
  String toString() {
    return 'HolidayInfo(public: $publicHolidays, religious: $religiousHolidays, '
        'cultural: $culturalHolidays), other: $otherHolidays), myanmarAnniversary: $myanmarAnniversaryDays), otherAnniversary: $otherAnniversaryDays)';
  }
}
