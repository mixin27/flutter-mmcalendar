import 'package:flutter_mmcalendar/flutter_mmcalendar.dart';

/// Western Date Converter
class WesternDateConverter {
  /// Myanmar Date to Western Date
  static WesternDate fromMyanmarDate(
    MyanmarDate myanmarDate, {
    CalendarType? calendarType,
  }) {
    return fromJulianDate(myanmarDate.jd, calendarType: calendarType);
  }

  /// Julian date to Western date
  static WesternDate fromJulianDate(
    double julianDate, {
    CalendarType? calendarType,
  }) {
    return WesternDateLogic.julianToWestern(
      julianDay: julianDate,
      calendarType: calendarType,
    );
  }
}
