import 'package:flutter_mmcalendar/flutter_mmcalendar.dart';

/// Myanmar Date Converter
class MyanmarDateConverter {
  /// [DateTime] to Myanmar Date
  static MyanmarDate fromDateTime(
    DateTime dateTime, {
    CalendarType? calendarType,
    double sg = 0,
  }) {
    return fromDate(
      dateTime.year,
      dateTime.month + 1,
      dateTime.day,
      calendarType: calendarType,
      sg: sg,
    );
  }

  /// Date to Myanmar Date
  static MyanmarDate fromDate(
    int year,
    int month,
    int day, {
    CalendarType? calendarType,
    double sg = 0,
  }) {
    double julianDay = WesternDateLogic.westernToJulian(
      year: year,
      month: month,
      day: day,
      calendarType: calendarType,
      sg: sg,
    );
    return fromJulianDate(julianDay);
  }

  /// Date and time to Myanmar Date
  static MyanmarDate fromDateAndTime(
    int year,
    int month,
    int day,
    int hour,
    int minute,
    int second, {
    CalendarType? calendarType,
    double sg = 0,
  }) {
    double julianDay = WesternDateLogic.westernToJulianWithTime(
      year: year,
      month: month,
      day: day,
      hour: hour,
      minute: minute,
      second: second,
      calendarType: calendarType,
      sg: sg,
    );
    return fromJulianDate(julianDay);
  }

  /// Julian date to Myanmar Date
  static MyanmarDate fromJulianDate(double julianDate) {
    return MyanmarDateLogic.julianToMyanmarDate(julianDate);
  }
}
