import 'package:flutter_mmcalendar/flutter_mmcalendar.dart';

/// Astrological information Converter
class AstroConverter {
  /// Myanmar Date to Astro
  static Astro convert(MyanmarDate myanmarDate) {
    return AstroLogic.getAstro(
      mmonth: myanmarDate.mmonth,
      monthLength: myanmarDate.monthLength,
      monthDay: myanmarDate.monthDay,
      weekDay: myanmarDate.weekDay,
      myear: myanmarDate.myear,
    );
  }
}
