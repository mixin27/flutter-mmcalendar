import 'package:flutter_mmcalendar/src/core/calendar_config.dart';
import 'package:flutter_mmcalendar/src/localization/language.dart';
import 'package:flutter_mmcalendar/src/localization/translation_service.dart';
import 'package:flutter_mmcalendar/src/models/astro_info.dart';
import 'package:flutter_mmcalendar/src/models/complete_date.dart';
import 'package:flutter_mmcalendar/src/models/holiday_info.dart';
import 'package:flutter_mmcalendar/src/models/myanmar_date.dart';
import 'package:flutter_mmcalendar/src/models/shan_date.dart';
import 'package:flutter_mmcalendar/src/models/validation_result.dart';
import 'package:flutter_mmcalendar/src/models/western_date.dart';
import 'package:flutter_mmcalendar/src/services/astro_calculator.dart';
import 'package:flutter_mmcalendar/src/services/date_converter.dart';
import 'package:flutter_mmcalendar/src/services/format_service.dart';
import 'package:flutter_mmcalendar/src/services/holiday_calculator.dart';

import '../core/calendar_cache.dart';

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
  final CalendarCache _cache;
  late final DateConverter _dateConverter;
  late final AstroCalculator _astroCalculator;
  late final HolidayCalculator _holidayCalculator;
  final FormatService _formatService;

  /// Create service that uses the global shared cache
  /// This is the default and recommended for most use cases
  MyanmarCalendarService.withGlobalCache({
    CalendarConfig? config,
    Language? defaultLanguage,
  }) : _config = config ?? const CalendarConfig(),
       _cache = CalendarCache.global(), // Use global cache
       _formatService = FormatService() {
    _initializeServices();
    _setLanguage(defaultLanguage);
  }

  /// Create service with independent cache
  /// Use this for testing or when isolation is needed
  MyanmarCalendarService.withIndependentCache({
    CalendarConfig? config,
    CacheConfig? cacheConfig,
    Language? defaultLanguage,
  }) : _config = config ?? const CalendarConfig(),
       _cache = CalendarCache.independent(
         config: cacheConfig ?? const CacheConfig(),
       ),
       _formatService = FormatService() {
    _initializeServices();
    _setLanguage(defaultLanguage);
  }

  /// Legacy constructor - uses global cache by default
  factory MyanmarCalendarService({
    CalendarConfig? config,
    Language? defaultLanguage,
  }) {
    return MyanmarCalendarService.withGlobalCache(
      config: config,
      defaultLanguage: defaultLanguage,
    );
  }

  void _initializeServices() {
    _dateConverter = DateConverter(_config, cache: _cache);
    _astroCalculator = AstroCalculator(cache: _cache);
    _holidayCalculator = HolidayCalculator(cache: _cache);
  }

  void _setLanguage(Language? defaultLanguage) {
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

  /// Get [AstroCalculator] instance.
  AstroCalculator get astroCalculator => _astroCalculator;

  /// Get [HolidayCalculator] instance.
  HolidayCalculator get holidayCalculator => _holidayCalculator;

  /// Get [FormatService] instance.
  FormatService get formatService => _formatService;

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
    // Try to get from cache
    final cached = _cache.getCompleteDate(dateTime);
    if (cached != null) {
      return cached;
    }

    // Calculate if not in cache
    final westernDate = WesternDate.fromDateTime(dateTime);
    final myanmarDate = _dateConverter.julianToMyanmar(
      westernDate.julianDayNumber,
    );
    final shanDate = ShanDate.fromMyanmarDate(myanmarDate);
    final astroInfo = _astroCalculator.calculate(myanmarDate);
    final holidayInfo = _holidayCalculator.getHolidays(myanmarDate);

    final completeDate = CompleteDate(
      western: westernDate,
      myanmar: myanmarDate,
      shan: shanDate,
      astro: astroInfo,
      holidays: holidayInfo,
    );

    // Store in cache
    _cache.putCompleteDate(dateTime, completeDate);

    return completeDate;
  }

  /// Find auspicious days for a given Myanmar month and year
  List<CompleteDate> findAuspiciousDays(int year, int month) {
    final myanmarMonth = getMyanmarMonth(year, month);
    return myanmarMonth
        .map(
          (md) => getCompleteDate(myanmarToWestern(md.year, md.month, md.day)),
        )
        .where((cd) => cd.astro.isAuspicious)
        .toList();
  }

  /// Get Myanmar dates for a month
  List<MyanmarDate> getMyanmarMonth(int year, int month) {
    final dates = <MyanmarDate>[];

    // get first day of myanmar month
    final yearInfo = _dateConverter.getYearInfo(year);
    final yearType = yearInfo['yearType'];

    // We don't use Late Kason, Just Kason
    if (month == 14 && yearType == 0) {
      return dates;
    }

    // No Tagu in special year, only Late Tagu
    if (month == 1 && yearType == 0) {
      return dates;
    }

    // Get first day of the month
    var jdn = _dateConverter.myanmarToJulian(year, month, 1);
    var currentDate = _dateConverter.julianToMyanmar(jdn);

    // Add all days in the month
    while (currentDate.year == year && currentDate.month == month) {
      dates.add(currentDate);
      jdn += 1;
      currentDate = _dateConverter.julianToMyanmar(jdn);
    }

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
    final firstDayOfYear = _dateConverter.myanmarToJulian(year, 1, 1);
    final myanmarDate = _dateConverter.julianToMyanmar(firstDayOfYear);
    return myanmarDate.yearType > 0;
  }

  /// Get year type for a Myanmar year
  int getYearType(int year) {
    final firstDayOfYear = _dateConverter.myanmarToJulian(year, 1, 1);
    final myanmarDate = _dateConverter.julianToMyanmar(firstDayOfYear);
    return myanmarDate.yearType;
  }

  /// Set language for the service
  void setLanguage(Language language) {
    TranslationService.setLanguage(language);
  }

  /// Get current language
  Language get currentLanguage => TranslationService.currentLanguage;

  /// Get cache statistics
  Map<String, dynamic> getCacheStatistics() => _cache.getStatistics();

  /// Clear cache
  void clearCache() => _cache.clearAll();

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
      final jdn = _dateConverter.myanmarToJulian(year, month, day);
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
