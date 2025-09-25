import 'package:flutter_mmcalendar/src/core/calendar_config.dart';
import 'package:flutter_mmcalendar/src/localization/language.dart';

/// Package-wide constants for Myanmar Calendar
///
/// This file contains all the constants used throughout the Myanmar Calendar package
/// including package metadata, configuration defaults, validation rules, format patterns,
/// error messages, and other shared constants.
class PackageConstants {
  PackageConstants._(); // Private constructor to prevent instantiation

  // ============================================================================
  // PACKAGE METADATA
  // ============================================================================

  /// Package name
  static const String packageName = 'flutter_mmcalendar';

  /// Package version
  static const String version = '3.0.0';

  /// Package description
  static const String description =
      'A comprehensive Flutter package for Myanmar calendar with date conversions, '
      'astrological calculations, and multi-language support';

  /// Author information - Myanmar Calendar Package Contributors
  static const String author =
      'Kyaw Zayar Tun <kyawzayartun.contact@gmail.com>';

  /// Repository URL
  static const String repository =
      'https://github.com/mixin27/flutter-mmcalendar';

  /// Documentation URL
  static const String documentation =
      'https://pub.dev/packages/flutter_mmcalendar';

  /// Issue tracker URL
  static const String issueTracker =
      'https://github.com/mixin27/flutter-mmcalendar/issues';

  /// Homepage URL
  static const String homepage =
      'https://github.com/mixin27/flutter-mmcalendar';

  // ============================================================================
  // DEFAULT CONFIGURATION
  // ============================================================================

  /// Default calendar configuration
  static const CalendarConfig defaultConfig = CalendarConfig();

  /// Default timezone offset (Myanmar Time UTC+6:30)
  static const double defaultTimezoneOffset = 6.5;

  /// Default language code
  static const String defaultLanguage = 'en';

  /// Default Sasana year type
  static const int defaultSasanaYearType = 0;

  /// Default calendar type (British)
  static const int defaultCalendarType = 0;

  /// Default Gregorian start date (1752/Sep/14)
  static const int defaultGregorianStart = 2361222;

  // ============================================================================
  // SUPPORTED LANGUAGES
  // ============================================================================

  /// Supported languages
  static const List<Language> supportedLanguages = Language.values;

  /// Map of language codes to language names
  static const Map<String, String> languageNames = {
    'en': 'English',
    'my': 'Myanmar (Unicode)',
    'zawgyi': 'Myanmar (Zawgyi)',
    'mon': 'Mon',
    'shan': 'Shan',
    'karen': 'Karen',
  };

  /// Map of language codes to native names
  static const Map<String, String> languageNativeNames = {
    'en': 'English',
    'my': 'မြန်မာ',
    'zawgyi': 'ျမန္မာ',
    'mon': 'ဘာသာမန်',
    'shan': 'လိၵ်ႈတႆး',
    'karen': 'ကညီကျိာ်',
  };

  // ============================================================================
  // DATE FORMAT PATTERNS
  // ============================================================================

  /// Default Myanmar date format
  static const String defaultMyanmarPattern = '&y &M &P &ff';

  /// Default Western date format
  static const String defaultWesternPattern = '%Www %y-%mm-%dd';

  /// Default complete date format
  static const String defaultCompletePattern = '&y &M &d (%Www %y-%mm-%dd)';

  /// Predefined Myanmar date format patterns
  static const Map<String, String> myanmarPatterns = {
    'short': '&y/&m/&d',
    'medium': '&y &M &d',
    'long': '&y &M &P &ff',
    'full': '&y &M &P &ff (&W)',
    'withSasana': '&YYYY &y &M &P &ff',
    'monthYear': '&M &y',
    'yearOnly': '&y',
    'dayMonth': '&d &M',
    'moonPhase': '&P &ff',
    'weekday': '&W &d &M',
    'compact': '&y&mm&dd',
    'verbose': '&N &y &YT &M &P &ff &Nay',
  };

  /// Predefined Western date format patterns
  static const Map<String, String> westernPatterns = {
    'short': '%d/%m/%y',
    'medium': '%d %Mmm %y',
    'long': '%d %M %yyyy',
    'full': '%W, %d %M %yyyy',
    'iso': '%yyyy-%mm-%dd',
    'time': '%HH:%nn:%ss',
    'dateTime': '%yyyy-%mm-%dd %HH:%nn:%ss',
    'time12': '%h:%nn %aa',
    'dateTime12': '%yyyy-%mm-%dd %h:%nn:%ss %aa',
    'monthYear': '%M %yyyy',
    'yearOnly': '%yyyy',
    'dayMonth': '%d %M',
    'weekday': '%W %d %M',
    'compact': '%yyyy%mm%dd',
    'rfc3339': '%yyyy-%mm-%ddT%HH:%nn:%ss.%lllZ',
    'http': '%Www, %dd %MMM %yyyy %HH:%nn:%ss GMT',
  };

  /// Myanmar format pattern placeholders documentation
  static const Map<String, String> myanmarFormatHelp = {
    '&yyyy': 'Myanmar year [0000-9999, e.g. 1380]',
    '&y': 'Myanmar year [0-9999, e.g. 1380]',
    '&YYYY': 'Sasana year [0000-9999, e.g. 2562]',
    '&mm': 'Month with zero padding [01-14]',
    '&M': 'Month name [e.g. Tagu]',
    '&m': 'Month [1-14]',
    '&P': 'Moon phase [e.g. Waxing, Full Moon]',
    '&dd': 'Day with zero padding [01-31]',
    '&d': 'Day [1-31]',
    '&ff': 'Fortnight day with zero padding [01-15]',
    '&f': 'Fortnight day [1-15]',
    '&W': 'Weekday name [e.g. Monday]',
    '&w': 'Weekday number [0-6]',
    '&YT': 'Year type [e.g. Common Year, Little Watat]',
    '&N': 'Year name [e.g. Hpusha, Magha]',
  };

  /// Western format pattern placeholders documentation
  static const Map<String, String> westernFormatHelp = {
    '%yyyy': 'Year [0000-9999, e.g. 2018]',
    '%yy': 'Year [00-99 e.g. 18]',
    '%y': 'Year [0-9999, e.g. 2018]',
    '%MMM': 'Month [e.g. JAN]',
    '%Mmm': 'Month [e.g. Jan]',
    '%mm': 'Month with zero padding [01-12]',
    '%M': 'Month [e.g. January]',
    '%m': 'Month [1-12]',
    '%dd': 'Day with zero padding [01-31]',
    '%d': 'Day [1-31]',
    '%HH': 'Hour [00-23]',
    '%hh': 'Hour [01-12]',
    '%H': 'Hour [0-23]',
    '%h': 'Hour [1-12]',
    '%AA': 'AM or PM',
    '%aa': 'am or pm',
    '%nn': 'Minute with zero padding [00-59]',
    '%n': 'Minute [0-59]',
    '%ss': 'Second [00-59]',
    '%s': 'Second [0-59]',
    '%WWW': 'Weekday [e.g. SAT]',
    '%Www': 'Weekday [e.g. Sat]',
    '%W': 'Weekday [e.g. Saturday]',
    '%w': 'Weekday number [0=sat, 1=sun, ..., 6=fri]',
    '%zz': 'Time zone (e.g. +08, +06:30)',
  };

  // ============================================================================
  // VALIDATION CONSTANTS
  // ============================================================================

  /// Minimum Myanmar year
  static const int minMyanmarYear = 1;

  /// Maximum Myanmar year
  static const int maxMyanmarYear = 9999;

  /// Minimum Myanmar month (First Waso)
  static const int minMyanmarMonth = 0;

  /// Maximum Myanmar month (Late Kason)
  static const int maxMyanmarMonth = 14;

  /// Minimum Myanmar day
  static const int minMyanmarDay = 1;

  /// Maximum Myanmar day
  static const int maxMyanmarDay = 30;

  /// Minimum fortnight day
  static const int minFortnightDay = 1;

  /// Maximum fortnight day
  static const int maxFortnightDay = 15;

  /// Minimum moon phase index
  static const int minMoonPhase = 0;

  /// Maximum moon phase index
  static const int maxMoonPhase = 3;

  /// Minimum weekday index (Saturday)
  static const int minWeekday = 0;

  /// Maximum weekday index (Friday)
  static const int maxWeekday = 6;

  /// Minimum year type (Common)
  static const int minYearType = 0;

  /// Maximum year type (Big Watat)
  static const int maxYearType = 2;

  /// Calendar limits and boundaries
  static const double minJulianDay = 1000000.0; // Roughly year -2700 CE
  static const double maxJulianDay = 5000000.0; // Roughly year 11000 CE

  /// Regular expressions for validation
  static final RegExp myanmarDatePattern = RegExp(
    r'^\d{1,4}[/\-\.]\d{1,2}[/\-\.]\d{1,2}$',
  );
  static final RegExp westernDatePattern = RegExp(
    r'^\d{4}[/\-\.]\d{1,2}[/\-\.]\d{1,2}$',
  );
  static final RegExp timePattern = RegExp(
    r'^([01]?[0-9]|2[0-3]):[0-5][0-9](:[0-5][0-9])?$',
  );
  static final RegExp dateTimePattern = RegExp(
    r'^\d{4}[/\-\.]\d{1,2}[/\-\.]\d{1,2}[\sT]\d{1,2}:\d{2}(:\d{2})?$',
  );

  // ============================================================================
  // ERROR MESSAGES
  // ============================================================================

  /// Error message constants
  static const Map<String, String> errorMessages = {
    'invalidYear': 'Year must be between $minMyanmarYear and $maxMyanmarYear',
    'invalidMonth':
        'Month must be between $minMyanmarMonth and $maxMyanmarMonth',
    'invalidDay': 'Day must be between $minMyanmarDay and $maxMyanmarDay',
    'invalidFortnightDay':
        'Fortnight day must be between $minFortnightDay and $maxFortnightDay',
    'invalidMoonPhase':
        'Moon phase must be between $minMoonPhase and $maxMoonPhase',
    'invalidWeekday': 'Weekday must be between $minWeekday and $maxWeekday',
    'invalidYearType':
        'Year type must be between $minYearType and $maxYearType',
    'invalidDate': 'The specified Myanmar date does not exist',
    'invalidWesternDate': 'The specified Western date is invalid',
    'invalidFormat': 'Invalid date format provided',
    'invalidJulianDay': 'Julian Day Number is out of valid range',
    'calculationError': 'Error occurred during date calculation',
    'conversionError': 'Error occurred during date conversion',
    'configurationError': 'Invalid configuration provided',
    'languageNotSupported': 'The specified language is not supported',
    'formatPatternError': 'Invalid format pattern provided',
    'translationError': 'Translation service error',
    'astroCalculationError': 'Astrological calculation error',
    'holidayCalculationError': 'Holiday calculation error',
    'parseError': 'Failed to parse the provided date string',
    'nullValueError': 'Null value provided where non-null expected',
    'rangeError': 'Value is out of valid range',
    'typeError': 'Invalid type provided',
    'notInitialized': 'Service or component not properly initialized',
  };

  // ============================================================================
  // TIMEZONE AND LOCATION CONSTANTS
  // ============================================================================

  /// Myanmar timezone offset in hours
  static const double myanmarTimezoneOffset = 6.5; // UTC+6:30

  /// Myanmar timezone code
  static const String myanmarTimezoneCode = 'MMT';

  /// Myanmar timezone name
  static const String myanmarTimezoneName = 'Myanmar Time';

  /// Common timezone offsets
  static const Map<String, double> commonTimezones = {
    'UTC': 0.0,
    'GMT': 0.0,
    'MMT': 6.5, // Myanmar Time
    'ICT': 7.0, // Indochina Time
    'JST': 9.0, // Japan Standard Time
    'CST': 8.0, // China Standard Time
    'IST': 5.5, // India Standard Time
    'EST': -5.0, // Eastern Standard Time
    'PST': -8.0, // Pacific Standard Time
  };

  // ============================================================================
  // CULTURAL AND HISTORICAL CONSTANTS
  // ============================================================================

  /// Buddhist Era start year (BCE)
  static const int buddhistEraStart = 544;

  /// Myanmar Era start year (CE)
  static const int myanmarEraStart = 638;

  /// Independence year (CE)
  static const int independenceYear = 1948;

  /// Traditional Buddhist Era offset
  static const int buddhistEraOffset = 1182;

  /// Common era transitions
  static const Map<String, int> eraTransitions = {
    'buddhist_era': 544,
    'myanmar_era': 638,
    'independence': 1948,
    'british_colonial': 1824,
    'konbaung_dynasty': 1752,
    'toungoo_dynasty': 1510,
  };

  // ============================================================================
  // ASTRONOMICAL CONSTANTS
  // ============================================================================

  /// Average lunar month in days
  static const double lunarMonthDays = 29.530588;

  /// Average solar year in days
  static const double solarYearDays = 365.25;

  /// 19-year Metonic cycle in days
  static const int metonicCycleDays = 6940;

  /// Lunar year in days
  static const int lunarYearDays = 354;

  /// Days in a fortnight
  static const int fortnightDays = 15;

  /// Moon phases per month
  static const int moonPhasesPerMonth = 4;

  /// Years in the 12-year animal cycle
  static const int animalCycleYears = 12;

  // ============================================================================
  // PERFORMANCE AND CACHING CONSTANTS
  // ============================================================================

  /// Maximum cache size for date calculations
  static const int maxCacheSize = 1000;

  /// Cache expiry duration
  static const Duration cacheExpiry = Duration(hours: 24);

  /// Maximum batch size for bulk operations
  static const int maxBatchSize = 100;

  /// Default page size for paginated results
  static const int defaultPageSize = 20;

  /// Performance thresholds
  static const Map<String, int> performanceThresholds = {
    'fast_calculation_ms': 10,
    'normal_calculation_ms': 100,
    'slow_calculation_ms': 1000,
    'max_calculation_ms': 5000,
  };

  // ============================================================================
  // FEATURE FLAGS
  // ============================================================================

  /// Feature availability flags
  static const Map<String, bool> features = {
    'enableCaching': true,
    'enableValidation': true,
    'enableTranslations': true,
    'enableAstrology': true,
    'enableHolidays': true,
    'enableFormatting': true,
    'enableUtilities': true,
    'enableWidgets': true,
    'enableAnimations': true,
    'enableThemes': true,
    'enableAccessibility': true,
    'enableDebugMode': false,
    'enablePerformanceLogging': false,
    'enableDetailedErrors': true,
    'enableAutoCorrection': false,
    'enableFuzzyMatching': false,
  };

  // ============================================================================
  // UI AND THEMING CONSTANTS
  // ============================================================================

  /// Color schemes for different themes
  static const Map<String, Map<String, int>> colorSchemes = {
    'traditional': {
      'primary': 0xFFB71C1C, // Deep red
      'secondary': 0xFFFFC107, // Gold
      'accent': 0xFF2E7D32, // Green
      'background': 0xFFFFFDE7, // Cream
      'surface': 0xFFFFFFFF, // White
      'error': 0xFFD32F2F, // Red
      'onPrimary': 0xFFFFFFFF, // White
      'onSecondary': 0xFF000000, // Black
      'onBackground': 0xFF000000, // Black
      'onSurface': 0xFF000000, // Black
      'onError': 0xFFFFFFFF, // White
    },
    'modern': {
      'primary': 0xFF1976D2, // Blue
      'secondary': 0xFF424242, // Grey
      'accent': 0xFFFF5722, // Orange
      'background': 0xFFFAFAFA, // Light grey
      'surface': 0xFFFFFFFF, // White
      'error': 0xFFE53935, // Red
      'onPrimary': 0xFFFFFFFF, // White
      'onSecondary': 0xFFFFFFFF, // White
      'onBackground': 0xFF000000, // Black
      'onSurface': 0xFF000000, // Black
      'onError': 0xFFFFFFFF, // White
    },
    'dark': {
      'primary': 0xFF90CAF9, // Light blue
      'secondary': 0xFF81C784, // Light green
      'accent': 0xFFFFAB40, // Amber
      'background': 0xFF121212, // Dark grey
      'surface': 0xFF1E1E1E, // Darker grey
      'error': 0xFFCF6679, // Light red
      'onPrimary': 0xFF000000, // Black
      'onSecondary': 0xFF000000, // Black
      'onBackground': 0xFFFFFFFF, // White
      'onSurface': 0xFFFFFFFF, // White
      'onError': 0xFF000000, // Black
    },
  };

  /// Default widget dimensions
  static const Map<String, double> dimensions = {
    'calendarCellSize': 40.0,
    'calendarHeight': 300.0,
    'datePickerHeight': 400.0,
    'headerHeight': 65.0,
    'footerHeight': 48.0,
    'spacingTiny': 4.0,
    'spacingSmall': 8.0,
    'spacingMedium': 16.0,
    'spacingLarge': 24.0,
    'spacingExtraLarge': 32.0,
    'paddingTiny': 4.0,
    'paddingSmall': 8.0,
    'paddingMedium': 16.0,
    'paddingLarge': 24.0,
    'borderRadius': 8.0,
    'borderRadiusSmall': 4.0,
    'borderRadiusLarge': 12.0,
    'iconSize': 24.0,
    'iconSizeSmall': 16.0,
    'iconSizeLarge': 32.0,
    'elevationLow': 2.0,
    'elevationMedium': 4.0,
    'elevationHigh': 8.0,
  };

  // ============================================================================
  // ANIMATION CONSTANTS
  // ============================================================================

  /// Animation durations in milliseconds
  static const Map<String, int> animationDurations = {
    'instant': 0,
    'fast': 150,
    'normal': 300,
    'slow': 500,
    'verySlow': 1000,
    'pageTransition': 250,
    'modalTransition': 200,
    'fadeTransition': 300,
    'slideTransition': 250,
    'scaleTransition': 200,
  };

  /// Animation curves
  static const Map<String, String> animationCurves = {
    'linear': 'linear',
    'ease': 'ease',
    'easeIn': 'easeIn',
    'easeOut': 'easeOut',
    'easeInOut': 'easeInOut',
    'bounceIn': 'bounceIn',
    'bounceOut': 'bounceOut',
    'elasticIn': 'elasticIn',
    'elasticOut': 'elasticOut',
  };

  // ============================================================================
  // ACCESSIBILITY CONSTANTS
  // ============================================================================

  /// Accessibility labels and hints
  static const Map<String, String> accessibilityLabels = {
    'calendar': 'Myanmar Calendar',
    'dateInput': 'Date input field',
    'datePicker': 'Date picker',
    'nextMonth': 'Go to next month',
    'previousMonth': 'Go to previous month',
    'selectDate': 'Select date',
    'selectedDate': 'Selected date',
    'todayButton': 'Go to today',
    'clearButton': 'Clear selection',
    'confirmButton': 'Confirm selection',
    'cancelButton': 'Cancel selection',
    'yearSelector': 'Year selector',
    'monthSelector': 'Month selector',
    'languageSelector': 'Language selector',
  };

  // ============================================================================
  // DEBUGGING AND LOGGING CONSTANTS
  // ============================================================================

  /// Log levels
  static const Map<String, int> logLevels = {
    'verbose': 0,
    'debug': 1,
    'info': 2,
    'warning': 3,
    'error': 4,
    'fatal': 5,
  };

  /// Debug categories
  static const List<String> debugCategories = [
    'conversion',
    'calculation',
    'formatting',
    'translation',
    'validation',
    'astrology',
    'holidays',
    'ui',
    'performance',
  ];

  // ============================================================================
  // EXPORT AND IMPORT FORMATS
  // ============================================================================

  /// Supported export formats
  static const List<String> exportFormats = [
    'json',
    'csv',
    'xml',
    'yaml',
    'txt',
  ];

  /// Supported import formats
  static const List<String> importFormats = [
    'json',
    'csv',
    'xml',
    'yaml',
    'txt',
    'ics', // iCalendar format
  ];

  // ============================================================================
  // API AND NETWORK CONSTANTS
  // ============================================================================

  /// API version
  static const String apiVersion = 'v1';

  /// Request timeout duration
  static const Duration requestTimeout = Duration(seconds: 30);

  /// Retry attempts for failed requests
  static const int maxRetryAttempts = 3;

  /// User agent string
  static const String userAgent = 'MyanmarCalendar/$version Dart';

  // ============================================================================
  // UTILITY METHODS
  // ============================================================================

  /// Check if a feature is enabled
  static bool isFeatureEnabled(String feature) {
    return features[feature] ?? false;
  }

  /// Get color value from scheme
  static int? getColor(String scheme, String colorName) {
    return colorSchemes[scheme]?[colorName];
  }

  /// Get dimension value
  static double getDimension(String name) {
    return dimensions[name] ?? 0.0;
  }

  /// Get animation duration
  static int getAnimationDuration(String name) {
    return animationDurations[name] ?? animationDurations['normal']!;
  }

  /// Get log level value
  static int getLogLevel(String level) {
    return logLevels[level] ?? logLevels['info']!;
  }

  /// Check if export format is supported
  static bool isExportFormatSupported(String format) {
    return exportFormats.contains(format.toLowerCase());
  }

  /// Check if import format is supported
  static bool isImportFormatSupported(String format) {
    return importFormats.contains(format.toLowerCase());
  }

  /// Get error message by key
  static String getErrorMessage(String key) {
    return errorMessages[key] ?? 'Unknown error occurred';
  }

  /// Get accessibility label by key
  static String getAccessibilityLabel(String key) {
    return accessibilityLabels[key] ?? key;
  }

  /// Get format pattern by name
  static String? getMyanmarPattern(String name) {
    return myanmarPatterns[name];
  }

  /// Get western format pattern by name
  static String? getWesternPattern(String name) {
    return westernPatterns[name];
  }

  /// Get timezone offset by code
  static double? getTimezoneOffset(String code) {
    return commonTimezones[code];
  }

  /// Check if language is supported
  static bool isLanguageSupported(String languageCode) {
    return languageNames.containsKey(languageCode);
  }

  /// Get all available pattern names for Myanmar dates
  static List<String> get availableMyanmarPatterns =>
      myanmarPatterns.keys.toList();

  /// Get all available pattern names for Western dates
  static List<String> get availableWesternPatterns =>
      westernPatterns.keys.toList();

  /// Get all available color scheme names
  static List<String> get availableColorSchemes => colorSchemes.keys.toList();

  /// Get package information as a map
  static Map<String, dynamic> get packageInfo => {
    'name': packageName,
    'version': version,
    'description': description,
    'author': author,
    'repository': repository,
    'documentation': documentation,
    'homepage': homepage,
  };

  /// Get validation limits as a map
  static Map<String, int> get validationLimits => {
    'minMyanmarYear': minMyanmarYear,
    'maxMyanmarYear': maxMyanmarYear,
    'minMyanmarMonth': minMyanmarMonth,
    'maxMyanmarMonth': maxMyanmarMonth,
    'minMyanmarDay': minMyanmarDay,
    'maxMyanmarDay': maxMyanmarDay,
    'minFortnightDay': minFortnightDay,
    'maxFortnightDay': maxFortnightDay,
    'minMoonPhase': minMoonPhase,
    'maxMoonPhase': maxMoonPhase,
    'minWeekday': minWeekday,
    'maxWeekday': maxWeekday,
    'minYearType': minYearType,
    'maxYearType': maxYearType,
  };
}
