/// Myanmar Calendar Package
///
/// A comprehensive Flutter package for Myanmar calendar with date conversions,
/// astrological calculations, holiday information, and multi-language support.
///
/// Author: Kyaw Zayar Tun
/// Website: https://www.kyawzayartun.com
/// GitHub:  https://github.com/mixin27/flutter-mmcalendar
/// License: MIT
///
/// ## Features
///
/// - **Date Conversions**: Bidirectional conversion between Myanmar and Western calendars
/// - **Astrological Information**: Complete astrological calculations including watat years, moon phases
/// - **Holiday Calculations**: Myanmar holidays, religious days, cultural celebrations
/// - **Multi-language Support**: Myanmar (Unicode), Myanmar (Zawgyi), Mon, Shan, Karen, English
/// - **Formatting Services**: Flexible date formatting with localization
/// - **UI Widgets**: Ready-to-use calendar widgets and date pickers
/// - **Validation**: Comprehensive date validation with detailed error messages
/// - **Utilities**: Helper functions for date calculations and manipulations
///
/// ## Quick Start
///
/// ```dart
/// import 'package:flutter_mmcalendar/flutter_mmcalendar.dart';
///
/// // Get today's Myanmar date
/// final today = MyanmarCalendar.today();
/// print('Today: ${today.formatMyanmar()}');
///
/// // Convert dates
/// final myanmarDate = MyanmarCalendar.fromWestern(2024, 1, 1);
/// final westernDate = MyanmarCalendar.fromMyanmar(1385, 10, 1);
///
/// // Get complete date information
/// final completeDate = MyanmarCalendar.getCompleteDate(DateTime.now());
/// print('Holidays: ${completeDate.allHolidays}');
/// print('Astrological days: ${completeDate.astrologicalDays}');
/// ```
///
/// ## Widgets
///
/// ```dart
/// // Myanmar Calendar Widget
/// MyanmarCalendarWidget(
///   onDateSelected: (date) => print('Selected: $date'),
///   initialDate: DateTime.now(),
///   language: Language.myanmar,
/// )
///
/// // Myanmar Date Picker
/// final date = await showMyanmarDatePicker(
///   context: context,
///   initialDate: DateTime.now(),
///   language: Language.english,
/// );
/// ```
///
/// For detailed documentation and examples, visit: https://pub.dev/packages/flutter_mmcalendar
library;

import 'src/core/calendar_cache.dart';
import 'src/core/calendar_config.dart';
import 'src/core/myanmar_date_time.dart';
import 'src/localization/language.dart';
import 'src/localization/translation_service.dart';
import 'src/models/astro_info.dart';
import 'src/models/chronicle_models.dart';
import 'src/models/complete_date.dart';
import 'src/models/holiday_info.dart';
import 'src/models/myanmar_date.dart';
import 'src/models/validation_result.dart';
import 'src/models/western_date.dart';
import 'src/services/chronicle_service.dart';
import 'src/services/myanmar_calendar_service.dart';
import 'src/utils/calendar_utils.dart';
import 'src/utils/package_constants.dart';

// ============================================================================
// CORE EXPORTS
// ============================================================================

// Configuration
export 'src/core/calendar_cache.dart';
export 'src/core/calendar_config.dart';
export 'src/core/myanmar_calendar_theme.dart';
export 'src/core/myanmar_date_time.dart';

// Localization
export 'src/localization/language.dart';
export 'src/localization/translation_service.dart';
// Models
export 'src/models/astro_info.dart';
export 'src/models/chronicle_models.dart';
export 'src/models/complete_date.dart';
export 'src/models/holiday_info.dart';
export 'src/models/myanmar_date.dart';
export 'src/models/validation_result.dart';
export 'src/models/western_date.dart';
// Services
export 'src/services/astro_calculator.dart';
export 'src/services/date_converter.dart';
export 'src/services/format_service.dart';
export 'src/services/holiday_calculator.dart';
export 'src/services/myanmar_calendar_service.dart';
export 'src/utils/calendar_constants.dart';
// Utils
export 'src/utils/calendar_utils.dart';
export 'src/utils/chronicle_dynasties.dart';
export 'src/utils/chronicle_dynasty_meta.dart';
export 'src/utils/chronicle_entries.dart';
export 'src/utils/date_extension.dart';
export 'src/utils/package_constants.dart';
export 'src/widgets/moon/moon_phase_indicator.dart';
// Widgets
export 'src/widgets/myanmar_calendar_widget.dart';
export 'src/widgets/myanmar_date_picker_widget.dart';

// ============================================================================
// MAIN MYANMAR CALENDAR CLASS
// ============================================================================

/// Main Myanmar Calendar class providing static access to all package functionality
///
/// This class serves as the primary entry point for the Myanmar Calendar package,
/// offering convenient static methods for common operations while maintaining
/// backward compatibility and ease of use.
///
/// ## Usage Examples
///
/// ```dart
/// // Basic date operations
/// final today = MyanmarCalendar.today();
/// final myanmarDate = MyanmarCalendar.fromWestern(2024, 1, 1);
/// final westernDate = MyanmarCalendar.fromMyanmar(1385, 10, 1);
///
/// // Get complete information
/// final completeDate = MyanmarCalendar.getCompleteDate(DateTime.now());
///
/// // Formatting
/// final formatted = MyanmarCalendar.format(today, language: Language.myanmar);
///
/// // Configuration
/// MyanmarCalendar.configure(
///   language: Language.myanmar,
///   timezoneOffset: 6.5,
///   sasanaYearType: 0,
/// );
/// ```
class MyanmarCalendar {
  // Private static instances
  static MyanmarCalendarService? _service;
  static CalendarConfig _config = const CalendarConfig();

  static ChronicleService? _chronicles;
  static ChronicleService _chronicleInstance() {
    _chronicles ??= ChronicleService(config: config, language: currentLanguage);
    return _chronicles!;
  }

  static CalendarCache? _cache;

  // Private constructor to prevent instantiation
  MyanmarCalendar._();

  // ============================================================================
  // CONFIGURATION
  // ============================================================================

  /// Configure the Myanmar Calendar with custom settings
  ///
  /// [language] - Default language for translations
  /// [timezoneOffset] - Timezone offset in hours (default: 6.5 for Myanmar Time)
  /// [sasanaYearType] - Sasana year calculation method (0, 1, or 2)
  /// [calendarType] - Calendar system (0=British, 1=Gregorian, 2=Julian)
  /// [gregorianStart] - Julian Day Number of Gregorian calendar start
  static void configure({
    Language? language,
    double? timezoneOffset,
    int? sasanaYearType,
    int? calendarType,
    int? gregorianStart,
  }) {
    // Update configuration
    _config = _config.copyWith(
      defaultLanguage: language?.code,
      timezoneOffset: timezoneOffset,
      sasanaYearType: sasanaYearType,
      calendarType: calendarType,
      gregorianStart: gregorianStart,
    );

    // Reset service to pick up new configuration
    _service = null;

    // Update translation service language
    if (language != null) {
      TranslationService.setLanguage(language);
    }
  }

  /// Get current configuration
  static CalendarConfig get config => _config;

  /// Get the service instance (lazy initialization)
  static MyanmarCalendarService get _serviceInstance {
    _service ??= MyanmarCalendarService(config: _config);
    return _service!;
  }

  /// Configure cache
  static void configureCache(CacheConfig cacheConfig) {
    _cache = CalendarCache(config: cacheConfig);
  }

  /// Get cache instance
  static CalendarCache get cache {
    _cache ??= CalendarCache();
    return _cache!;
  }

  /// Clear all caches
  static void clearCache() {
    cache.clearAll();
  }

  /// Get cache statistics
  static Map<String, dynamic> getCacheStatistics() {
    return cache.getStatistics();
  }

  /// Warm up cache with date range
  static void warmUpCache({DateTime? startDate, DateTime? endDate}) {
    cache.warmUp(
      startDate: startDate,
      endDate: endDate,
      service: _serviceInstance,
    );
  }

  /// Reset cache statistics
  static void resetCacheStatistics() {
    cache.resetStatistics();
  }

  // ============================================================================
  // FACTORY METHODS
  // ============================================================================

  /// Get today's Myanmar date
  ///
  /// Returns a [MyanmarDateTime] representing the current date and time
  /// in the configured timezone.
  static MyanmarDateTime today() {
    return MyanmarDateTime.now(config: _config);
  }

  /// Get current Myanmar date and time
  ///
  /// Alias for [today] method for clarity in usage.
  static MyanmarDateTime now() {
    return today();
  }

  /// Create Myanmar date from Western date
  ///
  /// Converts Western calendar date to Myanmar calendar date.
  ///
  /// Example:
  /// ```dart
  /// final myanmarDate = MyanmarCalendar.fromWestern(2024, 1, 1);
  /// print('Myanmar: ${myanmarDate.formatMyanmar()}');
  /// ```
  static MyanmarDateTime fromWestern(
    int year,
    int month,
    int day, {
    int hour = 12,
    int minute = 0,
    int second = 0,
  }) {
    return MyanmarDateTime.fromWestern(
      year,
      month,
      day,
      hour: hour,
      minute: minute,
      second: second,
      config: _config,
    );
  }

  /// Create Myanmar date from Myanmar calendar components
  ///
  /// Creates a Myanmar date from Myanmar calendar year, month, and day.
  ///
  /// Example:
  /// ```dart
  /// final date = MyanmarCalendar.fromMyanmar(1385, 10, 1);
  /// print('Western: ${date.formatWestern()}');
  /// ```
  static MyanmarDateTime fromMyanmar(
    int year,
    int month,
    int day, {
    int hour = 12,
    int minute = 0,
    int second = 0,
  }) {
    return MyanmarDateTime.fromMyanmar(
      year,
      month,
      day,
      hour: hour,
      minute: minute,
      second: second,
      config: _config,
    );
  }

  /// Create Myanmar date from DateTime object
  ///
  /// Converts a Dart [DateTime] object to Myanmar calendar date.
  ///
  /// Example:
  /// ```dart
  /// final dartDate = DateTime(2024, 1, 1);
  /// final myanmarDate = MyanmarCalendar.fromDateTime(dartDate);
  /// ```
  static MyanmarDateTime fromDateTime(DateTime dateTime) {
    return MyanmarDateTime.fromDateTime(dateTime, config: _config);
  }

  /// Create Myanmar date from Julian Day Number
  ///
  /// Creates a Myanmar date from a Julian Day Number.
  /// Useful for astronomical calculations or when working with
  /// external calendar systems.
  static MyanmarDateTime fromJulianDay(double julianDayNumber) {
    return MyanmarDateTime.fromJulianDay(julianDayNumber, config: _config);
  }

  /// Create Myanmar date from milliseconds since epoch
  ///
  /// Converts Unix timestamp (milliseconds since epoch) to Myanmar date.
  static MyanmarDateTime fromMillisecondsSinceEpoch(
    int milliseconds, {
    bool isUtc = false,
  }) {
    return MyanmarDateTime.fromMillisecondsSinceEpoch(
      milliseconds,
      isUtc: isUtc,
      config: _config,
    );
  }

  /// Create Myanmar date from timestamp (seconds since epoch)
  ///
  /// Converts Unix timestamp (seconds since epoch) to Myanmar date.
  static MyanmarDateTime fromTimestamp(int timestamp) {
    return MyanmarDateTime.fromTimestamp(timestamp, config: _config);
  }

  // ============================================================================
  // PARSING METHODS
  // ============================================================================

  /// Parse Myanmar date string
  ///
  /// Attempts to parse various Myanmar date string formats.
  /// Returns null if parsing fails.
  ///
  /// Supported formats:
  /// - "1385/10/1"
  /// - "1385-10-1"
  /// - "1.10.1385"
  ///
  /// Example:
  /// ```dart
  /// final date = MyanmarCalendar.parseMyanmar('1385/10/1');
  /// if (date != null) {
  ///   print('Parsed: ${date.formatMyanmar()}');
  /// }
  /// ```
  static MyanmarDateTime? parseMyanmar(String dateString) {
    return MyanmarDateTime.parseMyanmar(dateString, config: _config);
  }

  /// Parse Western date string
  ///
  /// Attempts to parse Western date string using Dart's DateTime.parse.
  /// Returns null if parsing fails.
  ///
  /// Example:
  /// ```dart
  /// final date = MyanmarCalendar.parseWestern('2024-01-01');
  /// if (date != null) {
  ///   print('Parsed: ${date.formatWestern()}');
  /// }
  /// ```
  static MyanmarDateTime? parseWestern(String dateString) {
    return MyanmarDateTime.parseWestern(dateString, config: _config);
  }

  // ============================================================================
  // INFORMATION METHODS
  // ============================================================================

  /// Get complete date information
  ///
  /// Returns a [CompleteDate] object containing Myanmar date, Western date,
  /// astrological information, and holiday information for the given date.
  ///
  /// Example:
  /// ```dart
  /// final complete = MyanmarCalendar.getCompleteDate(DateTime.now());
  /// print('Holidays: ${complete.allHolidays}');
  /// print('Moon phase: ${complete.moonPhase}');
  /// print('Astrological days: ${complete.astrologicalDays}');
  /// ```
  static CompleteDate getCompleteDate(DateTime dateTime) {
    return _serviceInstance.getCompleteDate(dateTime);
  }

  /// Get astrological information for a date
  ///
  /// Returns [AstroInfo] containing astrological calculations
  /// such as sabbath days, yatyaza, pyathada, mahabote, etc.
  static AstroInfo getAstroInfo(MyanmarDate date) {
    return _serviceInstance.getAstroInfo(date);
  }

  /// Get holiday information for a date
  ///
  /// Returns [HolidayInfo] containing public, religious, and cultural
  /// holidays for the given Myanmar date.
  static HolidayInfo getHolidayInfo(MyanmarDate date) {
    return _serviceInstance.getHolidayInfo(date);
  }

  /// Check if a Myanmar year is a watat year
  ///
  /// Returns true if the year has an intercalary month.
  ///
  /// Example:
  /// ```dart
  /// final isWatat = MyanmarCalendar.isWatatYear(1385);
  /// print('1385 is watat year: $isWatat');
  /// ```
  static bool isWatatYear(int myanmarYear) {
    return _serviceInstance.isWatatYear(myanmarYear);
  }

  /// Get year type for a Myanmar year
  ///
  /// Returns:
  /// - 0: Common year
  /// - 1: Little watat year
  /// - 2: Big watat year
  static int getYearType(int myanmarYear) {
    return _serviceInstance.getYearType(myanmarYear);
  }

  /// Get all dates in a Myanmar month
  ///
  /// Returns a list of [MyanmarDate] objects representing all days
  /// in the specified Myanmar month and year.
  static List<MyanmarDate> getMyanmarMonth(int year, int month) {
    return _serviceInstance.getMyanmarMonth(year, month);
  }

  /// Get Western dates for a Myanmar month
  ///
  /// Returns a list of [DateTime] objects representing the Western
  /// calendar equivalents for all days in the Myanmar month.
  static List<DateTime> getWesternDatesForMyanmarMonth(int year, int month) {
    return _serviceInstance.getWesternDatesForMyanmarMonth(year, month);
  }

  // ============================================================================
  // FORMATTING METHODS
  // ============================================================================

  /// Format Myanmar date
  ///
  /// Formats a Myanmar date using the specified pattern and language.
  ///
  /// Example:
  /// ```dart
  /// final date = MyanmarCalendar.today();
  /// final formatted = MyanmarCalendar.formatMyanmar(
  ///   date.myanmarDate,
  ///   pattern: '&y &M &P &ff',
  ///   language: Language.myanmar,
  /// );
  /// ```
  static String formatMyanmar(
    MyanmarDate date, {
    String? pattern,
    Language? language,
  }) {
    return _serviceInstance.formatMyanmarDate(
      date,
      pattern: pattern,
      language: language,
    );
  }

  /// Format Western date
  ///
  /// Formats a Western date using the specified pattern and language.
  static String formatWestern(
    WesternDate date, {
    String? pattern,
    Language? language,
  }) {
    return _serviceInstance.formatWesternDate(
      date,
      pattern: pattern,
      language: language,
    );
  }

  /// Format date with default patterns
  ///
  /// Convenience method to format a [MyanmarDateTime] with default patterns.
  ///
  /// Example:
  /// ```dart
  /// final date = MyanmarCalendar.today();
  /// final formatted = MyanmarCalendar.format(date, language: Language.myanmar);
  /// ```
  static String format(
    MyanmarDateTime dateTime, {
    String? myanmarPattern,
    String? westernPattern,
    Language? language,
  }) {
    return dateTime.formatComplete(
      myanmarPattern: myanmarPattern,
      westernPattern: westernPattern,
      language: language,
    );
  }

  // ============================================================================
  // VALIDATION METHODS
  // ============================================================================

  /// Validate Myanmar date
  ///
  /// Validates Myanmar date components and returns a [ValidationResult].
  ///
  /// Example:
  /// ```dart
  /// final result = MyanmarCalendar.validateMyanmar(1385, 15, 1);
  /// if (!result.isValid) {
  ///   print('Error: ${result.error}');
  /// }
  /// ```
  static ValidationResult validateMyanmar(int year, int month, int day) {
    return _serviceInstance.validateMyanmarDate(year, month, day);
  }

  /// Check if Myanmar date is valid
  ///
  /// Returns true if the Myanmar date is valid, false otherwise.
  ///
  /// Example:
  /// ```dart
  /// final isValid = MyanmarCalendar.isValidMyanmar(1385, 10, 1);
  /// print('Date is valid: $isValid');
  /// ```
  static bool isValidMyanmar(int year, int month, int day) {
    return validateMyanmar(year, month, day).isValid;
  }

  // ============================================================================
  // UTILITY METHODS
  // ============================================================================

  /// Calculate days between two dates
  ///
  /// Returns the number of days between two [MyanmarDateTime] objects.
  static int daysBetween(MyanmarDateTime date1, MyanmarDateTime date2) {
    return date1.differenceInDays(date2).abs();
  }

  /// Add days to a Myanmar date
  ///
  /// Returns a new [MyanmarDateTime] with the specified number of days added.
  static MyanmarDateTime addDays(MyanmarDateTime date, int days) {
    return date.addDays(days);
  }

  /// Add months to a Myanmar date (approximate)
  ///
  /// Returns a new [MyanmarDateTime] with approximately the specified
  /// number of months added. This is an approximation due to varying
  /// month lengths in the Myanmar calendar.
  static MyanmarDateTime addMonths(MyanmarDateTime date, int months) {
    final myanmarDate = CalendarUtils.addMonthsToMyanmarDate(
      date.myanmarDate,
      months,
    );
    return MyanmarDateTime.fromMyanmarDate(myanmarDate, config: _config);
  }

  /// Find next occurrence of a moon phase
  ///
  /// Returns the next [MyanmarDateTime] that has the specified moon phase.
  ///
  /// Moon phases:
  /// - 0: Waxing
  /// - 1: Full moon
  /// - 2: Waning
  /// - 3: New moon
  static MyanmarDateTime findNextMoonPhase(
    MyanmarDateTime startDate,
    int moonPhase,
  ) {
    final nextDate = CalendarUtils.findNextMoonPhase(
      startDate.myanmarDate,
      moonPhase,
    );
    return MyanmarDateTime.fromMyanmarDate(nextDate, config: _config);
  }

  /// Find all sabbath days in a month
  ///
  /// Returns a list of [MyanmarDateTime] objects representing all sabbath
  /// days in the specified Myanmar month and year.
  static List<MyanmarDateTime> findSabbathDays(int year, int month) {
    final sabbathDates = CalendarUtils.findSabbathDaysInMonth(year, month);
    return sabbathDates
        .map((date) => MyanmarDateTime.fromMyanmarDate(date, config: _config))
        .toList();
  }

  // ============================================================================
  // LANGUAGE AND LOCALIZATION
  // ============================================================================

  /// Set the current language
  ///
  /// Changes the language used for formatting and translations.
  ///
  /// Example:
  /// ```dart
  /// MyanmarCalendar.setLanguage(Language.myanmar);
  /// ```
  static void setLanguage(Language language) {
    _serviceInstance.setLanguage(language);
  }

  /// Get the current language
  static Language get currentLanguage => _serviceInstance.currentLanguage;

  /// Get all supported languages
  static List<Language> get supportedLanguages => Language.values;

  /// Check if a language is supported
  static bool isLanguageSupported(String languageCode) {
    return PackageConstants.isLanguageSupported(languageCode);
  }

  // ============================================================================
  // PACKAGE INFORMATION
  // ============================================================================

  /// Get package version
  static String get version => PackageConstants.version;

  /// Get package name
  static String get packageName => PackageConstants.packageName;

  /// Get package information
  static Map<String, dynamic> get packageInfo => PackageConstants.packageInfo;

  /// Get validation limits
  static Map<String, int> get validationLimits =>
      PackageConstants.validationLimits;

  /// Get available format patterns for Myanmar dates
  static List<String> get availableMyanmarPatterns =>
      PackageConstants.availableMyanmarPatterns;

  /// Get available format patterns for Western dates
  static List<String> get availableWesternPatterns =>
      PackageConstants.availableWesternPatterns;

  // ============================================================================
  // BATCH OPERATIONS
  // ============================================================================

  /// Convert multiple Western dates to Myanmar dates
  ///
  /// Efficiently converts a list of Western dates to Myanmar dates.
  /// Useful for batch processing of date data.
  static List<MyanmarDateTime> convertWesternDates(
    List<DateTime> westernDates,
  ) {
    return westernDates
        .map((date) => MyanmarDateTime.fromDateTime(date, config: _config))
        .toList();
  }

  /// Convert multiple Myanmar date maps to MyanmarDateTime objects
  ///
  /// Converts a list of maps containing Myanmar date components
  /// to [MyanmarDateTime] objects.
  ///
  /// Example:
  /// ```dart
  /// final dateMaps = [
  ///   {'year': 1385, 'month': 10, 'day': 1},
  ///   {'year': 1385, 'month': 10, 'day': 15},
  /// ];
  /// final dates = MyanmarCalendar.convertMyanmarDates(dateMaps);
  /// ```
  static List<MyanmarDateTime> convertMyanmarDates(
    List<Map<String, int>> dateMaps,
  ) {
    return dateMaps
        .map(
          (dateMap) => MyanmarDateTime.fromMyanmar(
            dateMap['year']!,
            dateMap['month']!,
            dateMap['day']!,
            config: _config,
          ),
        )
        .toList();
  }

  /// Get complete date information for multiple dates
  ///
  /// Returns a list of [CompleteDate] objects for the given dates.
  /// Efficient for bulk processing of date information.
  static List<CompleteDate> getCompleteDates(List<DateTime> dates) {
    return CalendarUtils.getCompleteDatesForWesternDates(dates);
  }

  // ============================================================================
  // DEBUGGING AND DIAGNOSTICS
  // ============================================================================

  /// Get diagnostic information about the current configuration
  ///
  /// Returns a map containing diagnostic information useful for
  /// debugging and troubleshooting.
  static Map<String, dynamic> getDiagnostics() {
    return {
      'packageInfo': packageInfo,
      'configuration': {
        'sasanaYearType': _config.sasanaYearType,
        'calendarType': _config.calendarType,
        'gregorianStart': _config.gregorianStart,
        'timezoneOffset': _config.timezoneOffset,
        'defaultLanguage': _config.defaultLanguage,
      },
      'currentLanguage': currentLanguage.code,
      'supportedLanguages': supportedLanguages
          .map((lang) => lang.code)
          .toList(),
      'validationLimits': validationLimits,
      'availablePatterns': {
        'myanmar': availableMyanmarPatterns,
        'western': availableWesternPatterns,
      },
      'features': PackageConstants.features,
    };
  }

  /// Reset to default configuration
  ///
  /// Resets all configuration to package defaults.
  /// Useful for testing or clearing custom configurations.
  static void reset() {
    _config = const CalendarConfig();
    _service = null;
    TranslationService.setLanguage(Language.english);
  }

  /// Get chronicles for [DateTime]
  static List<ChronicleEntryData> getChronicleFor(DateTime dt) {
    final jdn = WesternDate.fromDateTime(dt).julianDayNumber;
    return _chronicleInstance().byJdn(jdn);
  }

  /// Get dynasty data for [DateTime]
  static DynastyData? getDynastyFor(DateTime dt) {
    final jdn = WesternDate.fromDateTime(dt).julianDayNumber;
    return _chronicleInstance().dynastyForJdn(jdn);
  }

  /// Get chronicles for a Julian Day Number
  static List<ChronicleEntryData> getChronicleForJdn(double jdn) {
    return _chronicleInstance().byJdn(jdn);
  }

  /// Get dynasty for a Julian Day Number
  static DynastyData? getDynastyForJdn(double jdn) {
    return _chronicleInstance().dynastyForJdn(jdn);
  }

  /// Get chronicles for a MyanmarDate (uses its JDN)
  static List<ChronicleEntryData> getChronicleForMyanmar(MyanmarDate date) {
    return _chronicleInstance().byJdn(date.julianDayNumber);
  }

  /// Get dynasty for a MyanmarDate (uses its JDN)
  static DynastyData? getDynastyForMyanmar(MyanmarDate date) {
    return _chronicleInstance().dynastyForJdn(date.julianDayNumber);
  }

  /// Get entries for a given dynasty ID
  static List<ChronicleEntryData> getEntriesForDynasty(String dynastyId) {
    return _chronicleInstance().entriesForDynasty(dynastyId);
  }

  /// Get chronicle entries intersecting [start, end] (DateTime) range
  static List<ChronicleEntryData> getChroniclesBetween(
    DateTime start,
    DateTime end,
  ) {
    final a = WesternDate.fromDateTime(start).julianDayNumber;
    final b = WesternDate.fromDateTime(end).julianDayNumber;
    return _chronicleInstance().betweenJdn(a, b);
  }

  /// Get chronicle entries intersecting [startJdn, endJdn]
  static List<ChronicleEntryData> getChroniclesBetweenJdn(
    double startJdn,
    double endJdn,
  ) {
    return _chronicleInstance().betweenJdn(startJdn, endJdn);
  }

  /// List all dynasties
  static List<DynastyData> listDynasties() {
    return _chronicleInstance().allDynasties();
  }

  /// Lookup a dynasty by ID
  static DynastyData? getDynastyById(String dynastyId) {
    return _chronicleInstance().dynastyById(dynastyId);
  }
}
