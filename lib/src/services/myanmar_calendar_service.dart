import 'package:flutter_mmcalendar/src/core/calendar_config.dart';
import 'package:flutter_mmcalendar/src/localization/language.dart';
import 'package:flutter_mmcalendar/src/localization/translation_service.dart';
import 'package:flutter_mmcalendar/src/models/astro_info.dart';
import 'package:flutter_mmcalendar/src/models/complete_date.dart';
import 'package:flutter_mmcalendar/src/models/holiday_info.dart';
import 'package:flutter_mmcalendar/src/models/myanmar_date.dart';
import 'package:flutter_mmcalendar/src/models/validation_result.dart';
import 'package:flutter_mmcalendar/src/models/western_date.dart';
import 'package:flutter_mmcalendar/src/services/astro_calculator.dart';
import 'package:flutter_mmcalendar/src/services/date_converter.dart';
import 'package:flutter_mmcalendar/src/services/format_service.dart';
import 'package:flutter_mmcalendar/src/services/holiday_calculator.dart';

/// Main service class for Myanmar Calendar operations
///
/// This service provides:
/// - Date conversions between Myanmar and Western calendars
/// - Formatting services with localization support
/// - Holiday calculations
/// - Astrological information
/// - Configuration management
class MyanmarCalendarService {
  final CalendarConfig _config;
  final DateConverter _dateConverter;
  final AstroCalculator _astroCalculator;
  final HolidayCalculator _holidayCalculator;
  final FormatService _formatService;

  /// Create a new Myanmar Calendar service with configuration
  MyanmarCalendarService({CalendarConfig? config, Language? defaultLanguage})
    : _config = config ?? const CalendarConfig(),
      _dateConverter = DateConverter(config ?? const CalendarConfig()),
      _astroCalculator = AstroCalculator(),
      _holidayCalculator = HolidayCalculator(),
      _formatService = FormatService() {
    // Set default language
    if (defaultLanguage != null) {
      TranslationService.setLanguage(defaultLanguage);
    } else {
      TranslationService.setLanguage(
        Language.fromCode(_config.defaultLanguage),
      );
    }
  }

  /// Get calendar configuration
  CalendarConfig get config => _config;

  /// Get [DateConverter] instance.
  DateConverter get dateConverter => _dateConverter;

  /// Convert Western date to Myanmar date
  MyanmarDate westernToMyanmar(DateTime dateTime) {
    final westernDate = WesternDate.fromDateTime(dateTime);
    return _dateConverter.julianToMyanmar(westernDate.julianDayNumber);
  }

  /// Convert julian day number to Western date.
  WesternDate julianToWestern(double julianDayNumber) {
    return _dateConverter.julianToWestern(julianDayNumber);
  }

  /// Convert Myanmar date to Western date
  DateTime myanmarToWestern(
    int year,
    int month,
    int day, [
    int hour = 12,
    int minute = 0,
    int second = 0,
  ]) {
    final jdn = _dateConverter.myanmarToJulian(
      year,
      month,
      day,
      hour,
      minute,
      second,
    );
    final westernDate = _dateConverter.julianToWestern(jdn);
    return westernDate.toDateTime();
  }

  /// Convert Myanmar date to WesternDate object
  WesternDate myanmarToWesternDate(
    int year,
    int month,
    int day, [
    int hour = 12,
    int minute = 0,
    int second = 0,
  ]) {
    final jdn = _dateConverter.myanmarToJulian(
      year,
      month,
      day,
      hour,
      minute,
      second,
    );
    return _dateConverter.julianToWestern(jdn);
  }

  /// Get today's Myanmar date
  MyanmarDate get today {
    return westernToMyanmar(DateTime.now());
  }

  /// Get Myanmar date for a specific Julian Day Number
  MyanmarDate julianToMyanmar(double julianDayNumber) {
    return _dateConverter.julianToMyanmar(julianDayNumber);
  }

  /// Get Julian Day Number for a Myanmar date
  double myanmarToJulian(
    int year,
    int month,
    int day, [
    int hour = 12,
    int minute = 0,
    int second = 0,
  ]) {
    return _dateConverter.myanmarToJulian(
      year,
      month,
      day,
      hour,
      minute,
      second,
    );
  }

  /// Get astronomical information for a Myanmar date
  AstroInfo getAstroInfo(MyanmarDate date) {
    return _astroCalculator.calculate(date);
  }

  /// Get holiday information for a Myanmar date
  HolidayInfo getHolidayInfo(MyanmarDate date) {
    return _holidayCalculator.getHolidays(date);
  }

  /// Format Myanmar date as string
  String formatMyanmarDate(
    MyanmarDate date, {
    String? pattern,
    Language? language,
  }) {
    return _formatService.formatMyanmarDate(
      date,
      pattern: pattern,
      language: language,
    );
  }

  /// Format Western date as string
  String formatWesternDate(
    WesternDate date, {
    String? pattern,
    Language? language,
  }) {
    return _formatService.formatWesternDate(
      date,
      pattern: pattern,
      language: language,
    );
  }

  /// Get complete information for a date (Myanmar + Western + Astro + Holidays)
  CompleteDate getCompleteDate(DateTime dateTime) {
    final westernDate = WesternDate.fromDateTime(dateTime);
    final myanmarDate = _dateConverter.julianToMyanmar(
      westernDate.julianDayNumber,
    );
    final astroInfo = _astroCalculator.calculate(myanmarDate);
    final holidayInfo = _holidayCalculator.getHolidays(myanmarDate);

    return CompleteDate(
      western: westernDate,
      myanmar: myanmarDate,
      astro: astroInfo,
      holidays: holidayInfo,
    );
  }

  /// Get Myanmar dates for a month
  List<MyanmarDate> getMyanmarMonth(int year, int month) {
    final dates = <MyanmarDate>[];

    // Get first day of the month
    var jdn = _dateConverter.myanmarToJulian(year, month, 1, 12, 0, 0);
    var currentDate = _dateConverter.julianToMyanmar(jdn);

    // Add all days in the month
    while (currentDate.year == year && currentDate.month == month) {
      dates.add(currentDate);
      jdn += 1;
      currentDate = _dateConverter.julianToMyanmar(jdn);
    }

    // log("Months: ${dates.join(',')}");
    return dates;
  }

  /// Get Western dates for a Myanmar month
  List<DateTime> getWesternDatesForMyanmarMonth(int year, int month) {
    return getMyanmarMonth(
      year,
      month,
    ).map((date) => myanmarToWestern(date.year, date.month, date.day)).toList();
  }

  /// Check if a Myanmar year is a watat year
  bool isWatatYear(int year) {
    final firstDayOfYear = _dateConverter.myanmarToJulian(year, 1, 1, 12, 0, 0);
    final myanmarDate = _dateConverter.julianToMyanmar(firstDayOfYear);
    return myanmarDate.yearType > 0;
  }

  /// Get year type for a Myanmar year
  int getYearType(int year) {
    final firstDayOfYear = _dateConverter.myanmarToJulian(year, 1, 1, 12, 0, 0);
    final myanmarDate = _dateConverter.julianToMyanmar(firstDayOfYear);
    return myanmarDate.yearType;
  }

  void setLanguage(Language language) {
    TranslationService.setLanguage(language);
  }

  /// Get current language
  Language get currentLanguage => TranslationService.currentLanguage;

  /// Validate Myanmar date
  ValidationResult validateMyanmarDate(int year, int month, int day) {
    // Basic range checks
    if (year < 1 || year > 9999) {
      return ValidationResult(
        isValid: false,
        error: 'Year must be between 1 and 9999',
      );
    }

    if (month < 0 || month > 14) {
      return ValidationResult(
        isValid: false,
        error: 'Month must be between 0 and 14',
      );
    }

    if (day < 1 || day > 30) {
      return ValidationResult(
        isValid: false,
        error: 'Day must be between 1 and 30',
      );
    }

    try {
      // Try to create the date
      final jdn = _dateConverter.myanmarToJulian(year, month, day, 12, 0, 0);
      final reconstructed = _dateConverter.julianToMyanmar(jdn);

      // Check if the reconstructed date matches input
      if (reconstructed.year != year ||
          reconstructed.month != month ||
          reconstructed.day != day) {
        return ValidationResult(
          isValid: false,
          error: 'Invalid date: does not exist in Myanmar calendar',
        );
      }

      return ValidationResult(isValid: true);
    } catch (e) {
      return ValidationResult(
        isValid: false,
        error: 'Invalid date: ${e.toString()}',
      );
    }
  }
}
