import 'package:flutter_mmcalendar/src/enums/calendar_type.dart';
import 'package:flutter_mmcalendar/src/enums/language.dart';

/// Configuration for `Calendar`
final class Config {
  /// Beginning of `English` calendar.
  static const int by = 640;

  /// End of `English` calendar.
  static const int ey = 2140;

  /// Beginning of `Myanmar` calendar.
  static const int mby = 2;

  /// End of `Myanmar` calendar.
  static const int mey = 1500;

  /// Minimum accurate `English` year.
  static const int lt = 1700;

  /// Maximum accurate `English` year.
  static const int ut = 2018;

  /// Minumum accurate `Myanmar` year.
  static const int mlt = 1062;

  /// Maximum accurate `Myanmar` year.
  static const int mut = 1379;

  /// Gregorian start in `English` calendar (1752/Sep/14)
  static const double sg = 2361222;

  /// Simple date format `pattern` for `Myanmar` calendar.
  static const String simpleMyanmarDateFormatPattern =
      "S s k, B y k, M p f r En";

  CalendarType _calendarType = CalendarType.english;
  CalendarType get calendarType => _calendarType;

  Language _language = Language.myanmar;
  Language get language => _language;

  static Config? _instance;

  /// The current Calendar Config.
  ///
  /// If not set it will create a default config.
  static Config get instance {
    _instance ??= Config._private(MmCalendarBuilder());
    return _instance!;
  }

  /// Set the default `Calendar` config.
  static void initDefault(Config config) {
    _instance = config;
  }

  Config._private(MmCalendarBuilder builder) {
    _calendarType = builder.calendarType;
    _language = builder.language;
  }
}

class MmCalendarBuilder {
  CalendarType _calendarType = CalendarType.english;
  CalendarType get calendarType => _calendarType;

  Language _language = Language.myanmar;
  Language get language => _language;

  MmCalendarBuilder setCalendarType(CalendarType calendarType) {
    _calendarType = calendarType;
    return this;
  }

  MmCalendarBuilder setLanguage(Language language) {
    _language = language;
    return this;
  }

  Config build() {
    return Config._private(this);
  }
}
