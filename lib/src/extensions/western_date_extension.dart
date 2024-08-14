import '../calculations/calculations.dart';
import '../config/mm_calendar_config.dart';
import '../models/models.dart';

/// Utility extension of [WesternDate]
extension WesternDateExtension on WesternDate {
  /// Get `julian` day from [WesternDate].
  double toJulianDay({
    MmCalendarConfig? config,
    double sg = 0,
  }) {
    return WesternDateCalculation.westernToJulian(
      year: year,
      month: month,
      day: day,
      config: config,
      sg: sg,
    );
  }

  /// Get [MyanmarDate] from [WesternDate].
  MyanmarDate toMyanmarDate() {
    return MyanmarDateCalculation.fromJulianDay(toJulianDay());
  }
}
