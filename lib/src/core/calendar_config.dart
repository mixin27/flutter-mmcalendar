/// Configuration class for the Myanmar Calendar
class CalendarConfig {
  /// Sasana year type
  ///
  /// 0 = year depends only on the sun, do not take account moon phase for Sasana year
  ///
  /// 1 = Sasana year starts on the first day of Tagu
  ///
  /// 2 = Sasana year starts on Kason full moon day
  final int sasanaYearType;

  /// Calendar type for Julian/Gregorian calculations
  ///
  /// 0 = British (default), 1 = Gregorian, 2 = Julian
  final int calendarType;

  /// Beginning of Gregorian calendar in JDN [default=2361222]
  final int gregorianStart;

  /// Default timezone offset in hours (e.g., 6.5 for Myanmar Time)
  final double timezoneOffset;

  /// Default language for translations
  final String defaultLanguage;

  const CalendarConfig({
    this.sasanaYearType = 0,
    this.calendarType = 0,
    this.gregorianStart = 2361222,
    this.timezoneOffset = 6.5, // Myanmar Time UTC+6:30
    this.defaultLanguage = 'en',
  });

  CalendarConfig copyWith({
    int? sasanaYearType,
    int? calendarType,
    int? gregorianStart,
    double? timezoneOffset,
    String? defaultLanguage,
  }) {
    return CalendarConfig(
      sasanaYearType: sasanaYearType ?? this.sasanaYearType,
      calendarType: calendarType ?? this.calendarType,
      gregorianStart: gregorianStart ?? this.gregorianStart,
      timezoneOffset: timezoneOffset ?? this.timezoneOffset,
      defaultLanguage: defaultLanguage ?? this.defaultLanguage,
    );
  }
}
