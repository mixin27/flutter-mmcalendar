/// Contains holiday information for a given date
class HolidayInfo {
  /// Public holidays
  final List<String> publicHolidays;

  /// Religious holidays
  final List<String> religiousHolidays;

  /// Cultural holidays
  final List<String> culturalHolidays;

  /// Create a new holiday info
  const HolidayInfo({
    required this.publicHolidays,
    required this.religiousHolidays,
    required this.culturalHolidays,
  });

  /// Get all holidays combined
  List<String> get allHolidays => [
    ...publicHolidays,
    ...religiousHolidays,
    ...culturalHolidays,
  ];

  /// Check if there are any holidays on this date
  bool get hasHolidays => allHolidays.isNotEmpty;

  @override
  String toString() {
    return 'HolidayInfo(public: $publicHolidays, religious: $religiousHolidays, '
        'cultural: $culturalHolidays)';
  }
}
