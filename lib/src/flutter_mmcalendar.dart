import 'package:flutter_mmcalendar/flutter_mmcalendar.dart';

class FlutterMmcalendar {
  /// Get [MyanmarDate] object by `year`, `month` and `day.
  ///
  /// `year` - Year
  ///
  /// `month` - Month
  ///
  /// `day` - Day
  static MyanmarDate getMyanmarDate({
    required int year,
    required int month,
    required int day,
  }) {
    return MyanmarDateConverter.convertByYMD(year, month, day);
  }

  /// Get formatted string by [Language].
  ///
  /// `dateTime` - [DateTime] to format.
  ///
  /// `language` - Language type `englisht` | `myanmar` | `mon` | `zawgyi`.
  static String getDateByLanguage(
    DateTime dateTime, {
    Language language = Language.english,
  }) {
    final mmDate = MyanmarDateConverter.convertByDateTime(dateTime);
    return mmDate.formatByPatternAndLanguage(
      'S s k, B y k, M p f r En',
      LanguageCatalog(language: language),
    );
  }
}
