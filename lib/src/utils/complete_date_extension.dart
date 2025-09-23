import '../../flutter_mmcalendar.dart';

extension CompleteDateX on CompleteDate {
  /// Gets formatted western date.
  String formatWestern() => MyanmarCalendar.formatWestern(western);

  /// Gets formatted myanmar date.
  String formatMyanmar() => MyanmarCalendar.formatMyanmar(myanmar);
}
