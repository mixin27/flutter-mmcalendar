import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

import '../models/enums.dart';

/// Global reactive configuration singleton
///
/// Example:
/// ```dart
/// ValueListenableBuilder<MmCalendarConfig>(
///   valueListenable: GlobalCalendarConfig().configNotifier,
///   builder: (context, config, _) {
///     return Text(LanguageCatalog.tr("Yatyaza"));
///   },
/// );
/// ```
class GlobalCalendarConfig {
  GlobalCalendarConfig._internal();

  static final GlobalCalendarConfig _instance =
      GlobalCalendarConfig._internal();
  factory GlobalCalendarConfig() => _instance;

  /// Reactive config
  final ValueNotifier<MmCalendarConfig> configNotifier = ValueNotifier(
    MmCalendarConfig.defaultConfig(),
  );

  /// Current config
  MmCalendarConfig get config => configNotifier.value;

  /// Update the config
  void update(MmCalendarConfig newConfig) {
    configNotifier.value = newConfig;
  }

  /// Convenience setters
  void setLanguage(Language language) =>
      update(config.copyWith(language: language));

  void setCalendarType(CalendarType type) =>
      update(config.copyWith(calendarType: type));
}

/// Configuration for Myanmar Calendar.
class MmCalendarConfig extends Equatable {
  /// Creates a custom calendar configuration.
  const MmCalendarConfig({
    this.calendarType = CalendarType.english,
    this.language = Language.myanmar,
  });

  /// Default configuration:
  /// - [CalendarType.english]
  /// - [Language.myanmar]
  factory MmCalendarConfig.defaultConfig() => const MmCalendarConfig();

  /// Myanmar language configuration.
  factory MmCalendarConfig.myanmarLanguage() =>
      const MmCalendarConfig(language: Language.myanmar);

  /// Zawgyi language configuration.
  factory MmCalendarConfig.zawgyiLanguage() =>
      const MmCalendarConfig(language: Language.zawgyi);

  /// English language configuration.
  factory MmCalendarConfig.englishLanguage() =>
      const MmCalendarConfig(language: Language.english);

  /// Mon language configuration.
  factory MmCalendarConfig.monLanguage() =>
      const MmCalendarConfig(language: Language.mon);

  /// Karen language configuration.
  factory MmCalendarConfig.karenLanguage() =>
      const MmCalendarConfig(language: Language.karen);

  /// Tai language configuration.
  factory MmCalendarConfig.taiLanguage() =>
      const MmCalendarConfig(language: Language.tai);

  /// Calendar type: `English` | `Gregorian` | `Julian`
  final CalendarType calendarType;

  /// Calendar language: `English` | `Myanmar Unicode` | `Zawgyi` | `Mon` | `Karen` | `Tai`
  final Language language;

  /// Creates a copy with optional updated fields.
  MmCalendarConfig copyWith({CalendarType? calendarType, Language? language}) {
    return MmCalendarConfig(
      calendarType: calendarType ?? this.calendarType,
      language: language ?? this.language,
    );
  }

  @override
  List<Object?> get props => [calendarType, language];

  @override
  String toString() =>
      'MmCalendarConfig(calendarType: $calendarType, language: $language)';
}
