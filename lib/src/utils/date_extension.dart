import '../../flutter_mmcalendar.dart';

/// Extension of [CompleteDate]
extension CompleteDateX on CompleteDate {
  /// Gets formatted western date.
  String formatWestern() => MyanmarCalendar.formatWestern(western);

  /// Gets formatted myanmar date.
  String formatMyanmar() => MyanmarCalendar.formatMyanmar(myanmar);
}

/// Extension of [MyanmarDate]
extension MyanmarDateX on MyanmarDate {
  /// Gets formatted myanmar date.
  String format() => MyanmarCalendar.formatMyanmar(this);
}

/// Extension of [MyanmarDate]
extension WesternDateX on WesternDate {
  /// Gets formatted myanmar date.
  String format() => MyanmarCalendar.formatWestern(this);
}
