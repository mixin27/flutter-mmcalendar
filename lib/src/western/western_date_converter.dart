import 'package:flutter_mmcalendar/flutter_mmcalendar.dart';
import 'package:flutter_mmcalendar/src/western/western_date.dart';
import 'package:flutter_mmcalendar/src/western/western_date_kernel.dart';

class WesternDateConverter {
  /// Myanmar Date to Western Date
  static WesternDate convert(MyanmarDate myanmarDate) {
    return convertByJulianDay(myanmarDate.jd);
  }

  /// Julian date to Western date
  static WesternDate convertByJulianDay(double jd) {
    return WesternDateKernel.j2wByJulianDateAndCalendarType(
        jd, Config.instance.calendarType);
  }

  /// Julian date to Western date Credit4 Gregorian date:
  /// http://pmyers.pcug.org.au/General/JulianDates.htm
  /// Credit4 Julian Calendar: http://quasar.as.utexas.edu/BillInfo/JulianDatesG.html
  static WesternDate convertByJulianDayAndCalendarType(
      double jd, CalendarType calendarType) {
    return WesternDateKernel.j2w(jd, calendarType.number, 0);
  }
}
