import '../models/models.dart';

/// Calendar configs.
class MmCalendarConfig {
  const MmCalendarConfig({
    this.calendarType = CalendarType.english,
    this.language = Language.myanmar,
  });

  /// Default calendar config with
  /// - [CalendarType.english]
  /// - [Language.myanmar]
  factory MmCalendarConfig.defaultConfig() => const MmCalendarConfig();

  /// Calendar config with
  /// - [CalendarType.english]
  /// - [Language.myanmar]
  factory MmCalendarConfig.myanmarLanguage() =>
      const MmCalendarConfig(language: Language.myanmar);

  /// Calendar config with
  /// - [CalendarType.english]
  /// - [Language.zawgyi]
  factory MmCalendarConfig.zawgyiLanguage() =>
      const MmCalendarConfig(language: Language.zawgyi);

  /// Calendar config with
  /// - [CalendarType.english]
  /// - [Language.english]
  factory MmCalendarConfig.englishLanguage() =>
      const MmCalendarConfig(language: Language.english);

  /// Calendar config with
  /// - [CalendarType.english]
  /// - [Language.mon]
  factory MmCalendarConfig.monLanguage() =>
      const MmCalendarConfig(language: Language.mon);

  /// Calendar config with
  /// - [CalendarType.english]
  /// - [Language.karen]
  factory MmCalendarConfig.karenLanguage() =>
      const MmCalendarConfig(language: Language.karen);

  /// Calendar config with
  /// - [CalendarType.english]
  /// - [Language.tai]
  factory MmCalendarConfig.taiLanguage() =>
      const MmCalendarConfig(language: Language.tai);

  /// Calendar type
  /// `English` | `Gregorian` | `Julian`
  final CalendarType calendarType;

  /// Calendar language
  /// `English` | `Myanmar Unicode` | Myanmar Zawgyi` | `Mon` | `Karen` | `Tai`
  final Language language;
}
