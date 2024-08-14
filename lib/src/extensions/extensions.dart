import '../calculations/calculations.dart';
import '../config/mm_calendar_config.dart';
import '../models/models.dart';

export 'myanmar_date_extension.dart';
export 'western_date_extension.dart';
export 'astro_extension.dart';

extension DateTimeX on DateTime {
  /// Get [MyanmarDate] from [DateTime].
  MyanmarDate get myanmarDate {
    double julianDay = WesternDateCalculation.westernToJulian(
      year: year,
      month: month,
      day: day,
      config: MmCalendarConfig.defaultConfig(),
    );

    return MyanmarDateCalculation.fromJulianDay(julianDay);
  }
}
