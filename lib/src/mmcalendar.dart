import 'calculations/calculations.dart';
import 'config/mm_calendar_config.dart';
import 'constants/constants.dart';
import 'language/language.dart';
import 'models/models.dart';
import 'extensions/extensions.dart';

/// Library main class.
class MmCalendar {
  MmCalendar({
    MmCalendarConfig? config,
  }) : _config = config ?? MmCalendarConfig.defaultConfig();

  /// Myanmar calendar config:
  /// - [CalendarType]
  /// - [Language]
  final MmCalendarConfig _config;

  /// Get [LanguageCatalog] from [MmCalendarConfig]
  LanguageCatalog get languageCatalog =>
      LanguageCatalog(language: _config.language);

  /// Get [Language] from [MmCalendarConfig]
  Language get language => _config.language;

  /// Get [CalendarType] from [MmCalendarConfig]
  CalendarType get calendarType => _config.calendarType;

  /// Get [MyanmarDate] from `julian` day.
  MyanmarDate fromJulian(double julianDay) {
    return convertByLanguage(
      MyanmarDateCalculation.fromJulianDay(julianDay),
      languageCatalog: LanguageCatalog(language: _config.language),
    );
  }

  /// Get [MyanmarDate] from [DateTime].
  MyanmarDate fromDateTime(
    DateTime date, {
    MmCalendarConfig? config,
    double sg = 0,
  }) {
    return fromDate(
      date.year - 1,
      date.month,
      date.day,
      config: config ?? _config,
      sg: sg,
    );
  }

  /// Get [MyanmarDate] from `year`, `month` and `day`.
  MyanmarDate fromDate(
    int year,
    int month,
    int day, {
    MmCalendarConfig? config,
    double sg = 0,
  }) {
    double julianDay = WesternDateCalculation.westernToJulian(
      year: year + 1,
      month: month,
      day: day,
      config: config ?? _config,
      sg: sg,
    );
    return fromJulian(julianDay);
  }

  /// Get [MyanmarDate] from `year`, `month`, `day`, `hour`, `minute` and `second`.
  MyanmarDate fromDateAndTime(
    int year,
    int month,
    int day,
    int hour,
    int minute,
    int second, {
    MmCalendarConfig? config,
    double sg = 0,
  }) {
    double julianDay = WesternDateCalculation.westernToJulianWithTime(
      year: year,
      month: month,
      day: day,
      hour: hour,
      minute: minute,
      second: second,
      config: config ?? _config,
      sg: sg,
    );
    return fromJulian(julianDay);
  }

  /// Get [WesternDate] from `julian` day.
  WesternDate getWesternDateFromJulianDay(
    double julianDay, {
    MmCalendarConfig? config,
  }) {
    return WesternDateCalculation.julianToWestern(
      julianDay: julianDay,
      config: config ?? _config,
    );
  }

  /// Convert [MyanmarDate] with provided [LanguageCatalog].
  MyanmarDate convertByLanguage(
    MyanmarDate mmDate, {
    LanguageCatalog? languageCatalog,
  }) {
    return MyanmarDate(
      myear: mmDate.myear,
      yearType: mmDate.yearType,
      yearLength: mmDate.yearLength,
      mmonth: mmDate.mmonth,
      monthType: mmDate.monthType,
      monthLength: mmDate.monthLength,
      monthDay: mmDate.monthDay,
      fortnightDay: mmDate.fortnightDay,
      moonPhase: mmDate.moonPhase,
      weekDay: mmDate.weekDay,
      jd: mmDate.jd,
      languageCatalog: languageCatalog,
    );
  }

  /// Get formatted string by [Language].
  ///
  /// `dateTime` - [DateTime] to format.
  ///
  /// `language` - Language type `english` | `myanmar` | `mon` | `zawgyi`.
  static String getDateByLanguage(
    DateTime dateTime, {
    String? pattern,
    Language? language,
  }) {
    final mmCalendar = MmCalendar(
      config: MmCalendarConfig(language: language ?? Language.myanmar),
    );

    final mmDate = mmCalendar.fromDateTime(dateTime);
    return mmDate.formatByPatternAndLanguage(
      pattern: pattern ?? MyanmarDateFormat.simple,
      langCatalog: mmCalendar.languageCatalog,
    );
  }
}
