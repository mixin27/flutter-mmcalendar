import 'package:flutter_mmcalendar/flutter_mmcalendar.dart';

class AstroConverter {
  /// Myanmar Date to Astro
  static Astro convert(MyanmarDate myanmarDate) {
    return AstroKernel.astro(myanmarDate.mmonth, myanmarDate.monthLength,
        myanmarDate.monthDay, myanmarDate.weekDay, myanmarDate.myear);
  }
}
