/// Contains holiday information for a given date
class HolidayInfo {
  final List<String> publicHolidays;
  final List<String> religiousHolidays;
  final List<String> culturalHolidays;

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
