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
  ///
  /// This is used only for display purposes. Internal calculations
  /// are done in UTC to maintain consistency.
  ///
  /// Common Myanmar timezone offsets:
  /// - Yangon/Myanmar Time (MMT): UTC+6:30 (6.5)
  /// - Ancient Myanmar Time: UTC+6:24:47 (6.41306)
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

  /// Create config with Myanmar Time (UTC+6:30)
  factory CalendarConfig.myanmarTime() {
    return const CalendarConfig(timezoneOffset: 6.5, defaultLanguage: 'my');
  }

  /// Create config with Ancient Myanmar Time (UTC+6:24:47)
  factory CalendarConfig.ancientMyanmarTime() {
    return const CalendarConfig(timezoneOffset: 6.41306, defaultLanguage: 'my');
  }

  /// Get the current timezone offset in days
  double get timezoneOffsetInDays => timezoneOffset / 24.0;

  /// Convert local time to UTC Julian Day Number
  double localToUtc(double localJdn) => localJdn - timezoneOffsetInDays;

  /// Convert UTC Julian Day Number to local time
  double utcToLocal(double utcJdn) => utcJdn + timezoneOffsetInDays;

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
