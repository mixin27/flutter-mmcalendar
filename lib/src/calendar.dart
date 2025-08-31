import 'package:flutter_mmcalendar/src/config/calendar_config.dart';
import 'package:flutter_mmcalendar/src/core/calculations.dart';
import 'package:flutter_mmcalendar/src/core/constants.dart';
import 'package:flutter_mmcalendar/src/extensions/myanmar_date_extension.dart';
import 'package:flutter_mmcalendar/src/language/language_catalog.dart';
import 'package:flutter_mmcalendar/src/language/language_extension.dart';
import 'package:flutter_mmcalendar/src/models/astro.dart';
import 'package:flutter_mmcalendar/src/models/date.dart';
import 'package:flutter_mmcalendar/src/models/enums.dart';
import 'package:flutter_mmcalendar/src/models/thingyan.dart';

/// Core API for Myanmar Calendar.
class MmCalendar {
  /// Initialize with optional [MmCalendarConfig].
  MmCalendar({MmCalendarConfig? config})
    : _config = config ?? GlobalCalendarConfig().config {
    GlobalCalendarConfig().setCalendarType(_config.calendarType);
    GlobalCalendarConfig().setLanguage(_config.language);
  }

  /// Calendar configuration (language, calendar type, etc.)
  final MmCalendarConfig _config;

  /// Current language
  Language get language => _config.language;

  /// Current calendar type
  CalendarType get calendarType => _config.calendarType;

  /// Convert Julian Day Number to [MyanmarDate]
  MyanmarDate fromJulian(double julianDay) {
    return MyanmarDateCalculation.fromJulianDay(julianDay);
  }

  /// Convert [DateTime] to [MyanmarDate]
  MyanmarDate fromDateTime(
    DateTime date, {
    MmCalendarConfig? config,
    double? sg,
  }) {
    return fromDate(date.year, date.month, date.day, config: config, sg: sg);
  }

  /// Convert Western date to [MyanmarDate]
  MyanmarDate fromDate(
    int year,
    int month,
    int day, {
    MmCalendarConfig? config,
    double? sg,
  }) {
    double julianDay = WesternDateCalculation.westernToJulian(
      year: year,
      month: month,
      day: day,
      config: config ?? _config,
      sg: sg,
    );
    return fromJulian(julianDay);
  }

  /// Convert full date & time to [MyanmarDate]
  MyanmarDate fromDateAndTime(
    int year,
    int month,
    int day,
    int hour,
    int minute,
    int second, {
    MmCalendarConfig? config,
    double? sg,
  }) {
    double julianDay = WesternDateCalculation.westernToJulianWithTime(
      year: year,
      month: month,
      day: day,
      hour: hour,
      minute: minute,
      second: second,
      config: config ?? _config,
      sg: sg,
    );
    return fromJulian(julianDay);
  }

  /// Get [WesternDate] from Julian Day Number
  WesternDate getWesternDateFromJulianDay(
    double julianDay, {
    MmCalendarConfig? config,
    double? sg,
  }) {
    return WesternDateCalculation.julianToWestern(
      julianDay: julianDay,
      config: config ?? _config,
      sg: sg,
    );
  }

  /// Convenience: Get formatted Myanmar date string
  String formatDateTime(
    DateTime dateTime, {
    String? pattern,
    LanguageCode? langCode,
  }) {
    final mmDate = fromDateTime(dateTime);
    return mmDate.formatByPattern(
      pattern ?? MyanmarDateFormat.simple,
      langCode: langCode ?? _config.language.toLanguageCode(),
    );
  }

  /// Convert Julian Day Number to formatted Myanmar date string
  String formatJulian(
    double julianDay, {
    String? pattern,
    LanguageCode? langCode,
  }) {
    final mmDate = fromJulian(julianDay);
    return mmDate.formatByPattern(
      pattern ?? MyanmarDateFormat.simple,
      langCode: langCode,
    );
  }

  /// Get [Astro] information for a specific [DateTime]
  Astro getAstro(DateTime date) {
    final mmDate = fromDateTime(date);
    return mmDate.astro;
  }

  /// Get all holidays for a specific [DateTime]
  List<String> getHolidays(DateTime date) {
    final mmDate = fromDateTime(date);
    return HolidaysCalculation.getHolidays(mmDate);
  }

  /// Get all anniversaries for a specific [DateTime]
  List<String> getAnniversaries(DateTime date) {
    final mmDate = fromDateTime(date);
    return HolidaysCalculation.getAnniversaries(mmDate);
  }

  /// Get all myanmar thingyan holidays for a specific [DateTime]
  List<MyanmarThingyan> getThingyanDays(DateTime date) {
    final mmDate = fromDateTime(date);
    return mmDate.getMyanmarThingyanDays();
  }
}
