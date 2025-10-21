import '../../flutter_mmcalendar.dart';

/// Extension of [CompleteDate]
extension CompleteDateX on CompleteDate {
  /// Gets formatted western date.
  String formatWestern({String? pattern, Language? language}) =>
      MyanmarCalendar.formatWestern(
        western,
        pattern: pattern,
        language: language,
      );

  /// Gets formatted myanmar date.
  String formatMyanmar({String? pattern, Language? language}) =>
      MyanmarCalendar.formatMyanmar(
        myanmar,
        pattern: pattern,
        language: language,
      );
}

/// Extension of [MyanmarDate]
extension MyanmarDateX on MyanmarDate {
  /// Gets formatted myanmar date.
  String format({String? pattern, Language? language}) =>
      MyanmarCalendar.formatMyanmar(this, pattern: pattern, language: language);
}

/// Extension of [MyanmarDate]
extension WesternDateX on WesternDate {
  /// Gets formatted myanmar date.
  String format({String? pattern, Language? language}) =>
      MyanmarCalendar.formatWestern(this, pattern: pattern, language: language);
}
