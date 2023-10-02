import 'package:flutter_mmcalendar/flutter_mmcalendar.dart';
import 'package:flutter_mmcalendar/src/western/western_date_kernel.dart';

class MyanmarDateConverter {
  static MyanmarDate convertByDateTime(DateTime dateTime) {
    return convertByYMDTSG(dateTime.year, dateTime.month, dateTime.day,
        Config.instance.calendarType, 0);
  }

  /// Western day, month, year to Myanmar Date
  static MyanmarDate convertByYMD(int year, int month, int day) {
    return convertByYMDTSG(year, month, day, Config.instance.calendarType, 0);
  }

  ///
  static MyanmarDate convertByYMDTSG(
    int year,
    int month,
    int day,
    CalendarType calendarType,
    double sg,
  ) {
    double julianDayNumber =
        WesternDateKernel.w2jByYMDTSG(year, month, day, calendarType, sg);
    return convert(julianDayNumber);
  }

  /// Western day, month, year to Myanmar Date
  static MyanmarDate convertByYMDHMS(
    int year,
    int month,
    int day,
    int hour,
    int minute,
    int second,
  ) {
    return convertByYMDHMSTSG(year, month, day, hour, minute, second,
        Config.instance.calendarType, 0);
  }

  // Western day, month, year to Myanmar Date
  static MyanmarDate convertByYMDHMSTSG(
    int year,
    int month,
    int day,
    int hour,
    int minute,
    int second,
    CalendarType calendarType,
    double sg,
  ) {
    // double julianDayNumber = WesternDateKernel.w2j(year, month, day, hour, minute, second, calendarType, SG);
    double julianDayNumber = 0;
    return convert(julianDayNumber);
  }

  /// Julian date to Myanmar Date
  static MyanmarDate convert(double julianDayNumber) {
    return MyanmarDateKernel.j2m(julianDayNumber);
  }
}
