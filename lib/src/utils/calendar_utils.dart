import 'dart:math' as math;

import 'package:flutter_mmcalendar/src/localization/translation_service.dart';
import 'package:flutter_mmcalendar/src/models/complete_date.dart';
import 'package:flutter_mmcalendar/src/models/myanmar_date.dart';
import 'package:flutter_mmcalendar/src/models/validation_result.dart';
import 'package:flutter_mmcalendar/src/services/myanmar_calendar_service.dart';
import 'package:flutter_mmcalendar/src/utils/package_constants.dart';

/// Utility class providing helper functions for Myanmar Calendar operations
///
/// This class contains static utility methods that provide common functionality
/// for working with Myanmar calendar dates, conversions, calculations, and
/// various helper operations that don't fit into the main service classes.
///
/// All methods in this class are static and can be called without creating
/// an instance of the class.
class CalendarUtils {
  CalendarUtils._(); // Private constructor to prevent instantiation

  // ============================================================================
  // DATE RANGE AND GENERATION UTILITIES
  // ============================================================================

  /// Generates a range of Myanmar dates between two dates
  ///
  /// Creates a list of Myanmar dates starting from [startDate] and ending
  /// at [endDate] (inclusive). The dates are generated in chronological order.
  ///
  /// Example:
  /// ```dart
  /// final start = MyanmarDate(year: 1380, month: 1, day: 1);
  /// final end = MyanmarDate(year: 1380, month: 1, day: 10);
  /// final dateRange = CalendarUtils.generateMyanmarDateRange(start, end);
  /// print('Generated ${dateRange.length} dates');
  /// ```
  static List<MyanmarDate> generateMyanmarDateRange(
    MyanmarDate startDate,
    MyanmarDate endDate,
  ) {
    if (startDate.julianDayNumber > endDate.julianDayNumber) {
      throw ArgumentError('Start date must be before or equal to end date');
    }

    final dates = <MyanmarDate>[];
    final service = MyanmarCalendarService();

    var currentJdn = startDate.julianDayNumber;
    final endJdn = endDate.julianDayNumber;

    while (currentJdn <= endJdn) {
      dates.add(service.julianToMyanmar(currentJdn));
      currentJdn += 1.0;
    }

    return dates;
  }

  /// Generates a range of Western dates between two dates
  ///
  /// Creates a list of Western dates starting from [startDate] and ending
  /// at [endDate] (inclusive). The dates are generated in chronological order.
  static List<DateTime> generateWesternDateRange(
    DateTime startDate,
    DateTime endDate,
  ) {
    if (startDate.isAfter(endDate)) {
      throw ArgumentError('Start date must be before or equal to end date');
    }

    final dates = <DateTime>[];
    var currentDate = DateTime(startDate.year, startDate.month, startDate.day);
    final endDateOnly = DateTime(endDate.year, endDate.month, endDate.day);

    while (!currentDate.isAfter(endDateOnly)) {
      dates.add(currentDate);
      currentDate = currentDate.add(const Duration(days: 1));
    }

    return dates;
  }

  /// Generates dates for a specific Myanmar month
  ///
  /// Returns all dates within the specified Myanmar month and year.
  static List<MyanmarDate> generateMyanmarMonth(int year, int month) {
    final service = MyanmarCalendarService();
    return service.getMyanmarMonth(year, month);
  }

  /// Generates dates for a specific Western month
  ///
  /// Returns all dates within the specified Western month and year.
  static List<DateTime> generateWesternMonth(int year, int month) {
    final dates = <DateTime>[];
    final daysInMonth = getDaysInWesternMonth(year, month);

    for (int day = 1; day <= daysInMonth; day++) {
      dates.add(DateTime(year, month, day));
    }

    return dates;
  }

  // ============================================================================
  // DATE CALCULATION UTILITIES
  // ============================================================================

  /// Calculates the number of days between two Myanmar dates
  ///
  /// Returns the absolute difference in days between two Myanmar dates.
  /// The result is always positive regardless of date order.
  static int daysBetweenMyanmarDates(MyanmarDate date1, MyanmarDate date2) {
    return (date1.julianDayNumber - date2.julianDayNumber).abs().round();
  }

  /// Calculates the number of days between two Western dates
  ///
  /// Returns the absolute difference in days between two Western dates.
  static int daysBetweenWesternDates(DateTime date1, DateTime date2) {
    final difference = date1.difference(date2);
    return difference.inDays.abs();
  }

  /// Adds days to a Myanmar date
  ///
  /// Returns a new Myanmar date that is [days] days after the input date.
  /// Use negative values to subtract days.
  static MyanmarDate addDaysToMyanmarDate(MyanmarDate date, int days) {
    final service = MyanmarCalendarService();
    final newJdn = date.julianDayNumber + days;
    return service.julianToMyanmar(newJdn);
  }

  /// Adds months to a Myanmar date (approximate)
  ///
  /// This method adds approximately [months] months to the date.
  /// Since Myanmar months vary in length, this is an approximation.
  static MyanmarDate addMonthsToMyanmarDate(MyanmarDate date, int months) {
    final service = MyanmarCalendarService();
    var newYear = date.year;
    var newMonth = date.month + months;

    // Handle month overflow/underflow
    while (newMonth > 14) {
      newMonth -= 12; // Assuming 12 regular months per year
      newYear++;
    }
    while (newMonth < 1) {
      newMonth += 12;
      newYear--;
    }

    // Adjust day if it exceeds the new month's length
    final monthLength = getMonthLength(newMonth, service.getYearType(newYear));
    final newDay = math.min(date.day, monthLength);

    final newJdn = service.myanmarToJulian(newYear, newMonth, newDay, 12, 0, 0);
    return service.julianToMyanmar(newJdn);
  }

  /// Gets the number of days in a Myanmar month
  ///
  /// Returns the length of the specified Myanmar month considering the year type.
  static int getMonthLength(int month, int yearType) {
    var length = 30 - month % 2; // Basic alternating pattern
    if (month == 3) {
      // Nayon
      length += (yearType ~/ 2); // Add extra day in big watat year
    }
    return length;
  }

  /// Gets the number of days in a Western month
  ///
  /// Returns the number of days in the specified Western month and year,
  /// accounting for leap years.
  static int getDaysInWesternMonth(int year, int month) {
    switch (month) {
      case 1:
      case 3:
      case 5:
      case 7:
      case 8:
      case 10:
      case 12:
        return 31;
      case 4:
      case 6:
      case 9:
      case 11:
        return 30;
      case 2:
        return isWesternLeapYear(year) ? 29 : 28;
      default:
        throw ArgumentError('Invalid month: $month');
    }
  }

  /// Checks if a Western year is a leap year
  ///
  /// Returns true if the specified year is a leap year in the Gregorian calendar.
  static bool isWesternLeapYear(int year) {
    return (year % 4 == 0 && year % 100 != 0) || (year % 400 == 0);
  }

  // ============================================================================
  // DATE FINDING UTILITIES
  // ============================================================================

  /// Finds the next occurrence of a specific moon phase
  ///
  /// Returns the next Myanmar date that has the specified moon phase,
  /// starting from the given date (exclusive).
  static MyanmarDate findNextMoonPhase(MyanmarDate startDate, int moonPhase) {
    final service = MyanmarCalendarService();
    var currentJdn = startDate.julianDayNumber + 1;

    // Limit search to avoid infinite loops
    const maxDays = 45; // More than a lunar month

    for (int i = 0; i < maxDays; i++) {
      final currentDate = service.julianToMyanmar(currentJdn);
      if (currentDate.moonPhase == moonPhase) {
        return currentDate;
      }
      currentJdn += 1;
    }

    throw StateError('Could not find next occurrence of moon phase $moonPhase');
  }

  /// Finds the previous occurrence of a specific moon phase
  ///
  /// Returns the previous Myanmar date that has the specified moon phase,
  /// starting from the given date (exclusive).
  static MyanmarDate findPreviousMoonPhase(
    MyanmarDate startDate,
    int moonPhase,
  ) {
    final service = MyanmarCalendarService();
    var currentJdn = startDate.julianDayNumber - 1;

    // Limit search to avoid infinite loops
    const maxDays = 45; // More than a lunar month

    for (int i = 0; i < maxDays; i++) {
      final currentDate = service.julianToMyanmar(currentJdn);
      if (currentDate.moonPhase == moonPhase) {
        return currentDate;
      }
      currentJdn -= 1;
    }

    throw StateError(
      'Could not find previous occurrence of moon phase $moonPhase',
    );
  }

  /// Finds all dates with specific moon phase in a year
  ///
  /// Returns all Myanmar dates in the specified year that have the given moon phase.
  static List<MyanmarDate> findMoonPhaseDatesInYear(int year, int moonPhase) {
    final service = MyanmarCalendarService();
    final dates = <MyanmarDate>[];

    // Start from the beginning of the year
    final startJdn = service.myanmarToJulian(year, 1, 1, 12, 0, 0);
    final endJdn = service.myanmarToJulian(year + 1, 1, 1, 12, 0, 0);

    var currentJdn = startJdn;
    while (currentJdn < endJdn) {
      final currentDate = service.julianToMyanmar(currentJdn);
      if (currentDate.moonPhase == moonPhase && currentDate.year == year) {
        dates.add(currentDate);
      }
      currentJdn += 1;
    }

    return dates;
  }

  /// Finds all sabbath days in a Myanmar month
  ///
  /// Returns all dates in the specified month that are sabbath days.
  static List<MyanmarDate> findSabbathDaysInMonth(int year, int month) {
    final monthDates = generateMyanmarMonth(year, month);
    final service = MyanmarCalendarService();

    return monthDates.where((date) {
      final astro = service.getAstroInfo(date);
      return astro.sabbath == 'Sabbath';
    }).toList();
  }

  // ============================================================================
  // DATE COMPARISON UTILITIES
  // ============================================================================

  /// Compares two Myanmar dates
  ///
  /// Returns -1 if [date1] is before [date2], 0 if they're equal, 1 if after.
  static int compareMyanmarDates(MyanmarDate date1, MyanmarDate date2) {
    return date1.julianDayNumber.compareTo(date2.julianDayNumber);
  }

  /// Checks if a Myanmar date is within a range
  ///
  /// Returns true if [date] is between [startDate] and [endDate] (inclusive).
  static bool isMyanmarDateInRange(
    MyanmarDate date,
    MyanmarDate startDate,
    MyanmarDate endDate,
  ) {
    return date.julianDayNumber >= startDate.julianDayNumber &&
        date.julianDayNumber <= endDate.julianDayNumber;
  }

  /// Finds the minimum Myanmar date from a list
  ///
  /// Returns the earliest date from the provided list.
  static MyanmarDate findMinMyanmarDate(List<MyanmarDate> dates) {
    if (dates.isEmpty) {
      throw ArgumentError('Cannot find minimum of empty list');
    }

    return dates.reduce(
      (current, next) =>
          current.julianDayNumber <= next.julianDayNumber ? current : next,
    );
  }

  /// Finds the maximum Myanmar date from a list
  ///
  /// Returns the latest date from the provided list.
  static MyanmarDate findMaxMyanmarDate(List<MyanmarDate> dates) {
    if (dates.isEmpty) {
      throw ArgumentError('Cannot find maximum of empty list');
    }

    return dates.reduce(
      (current, next) =>
          current.julianDayNumber >= next.julianDayNumber ? current : next,
    );
  }

  // ============================================================================
  // DATE PARSING AND FORMATTING UTILITIES
  // ============================================================================

  /// Parses a Myanmar date string in various formats
  ///
  /// Attempts to parse common Myanmar date string formats.
  /// Supported formats: "year/month/day", "year-month-day", "day.month.year"
  static MyanmarDate? parseMyanmarDateString(String dateString) {
    // Remove whitespace and normalize separators
    final normalized = dateString.trim().replaceAll(RegExp(r'[^\d/\-\.]'), '');

    final patterns = [
      RegExp(r'^(\d{1,4})[/\-\.](\d{1,2})[/\-\.](\d{1,2})'), // year/month/day
      RegExp(r'^(\d{1,2})[/\-\.](\d{1,2})[/\-\.](\d{1,4})'), // day/month/year
    ];

    for (final pattern in patterns) {
      final match = pattern.firstMatch(normalized);
      if (match != null) {
        try {
          final first = int.parse(match.group(1)!);
          final second = int.parse(match.group(2)!);
          final third = int.parse(match.group(3)!);

          // Determine which format based on magnitude
          if (first > 31 || third <= 31) {
            // Likely year/month/day format
            return _createMyanmarDateSafe(first, second, third);
          } else {
            // Likely day/month/year format
            return _createMyanmarDateSafe(third, second, first);
          }
        } catch (e) {
          continue; // Try next pattern
        }
      }
    }

    return null; // Could not parse
  }

  /// Helper method to safely create Myanmar date
  static MyanmarDate? _createMyanmarDateSafe(int year, int month, int day) {
    final service = MyanmarCalendarService();
    final validation = service.validateMyanmarDate(year, month, day);

    if (validation.isValid) {
      final jdn = service.myanmarToJulian(year, month, day, 12, 0, 0);
      return service.julianToMyanmar(jdn);
    }

    return null;
  }

  /// Formats a Myanmar date as a simple string
  ///
  /// Returns the date in "year/month/day" format.
  static String formatMyanmarDateSimple(MyanmarDate date) {
    return '${date.year}/${date.month}/${date.day}';
  }

  /// Formats a Western date as a simple string
  ///
  /// Returns the date in "year-month-day" format.
  static String formatWesternDateSimple(DateTime date) {
    return '${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}';
  }

  // ============================================================================
  // BATCH PROCESSING UTILITIES
  // ============================================================================

  /// Converts multiple Western dates to Myanmar dates
  ///
  /// Efficiently converts a list of Western dates to Myanmar dates.
  /// Processing is done in batches to optimize performance.
  static List<MyanmarDate> convertWesternDatesToMyanmar(
    List<DateTime> westernDates,
  ) {
    final service = MyanmarCalendarService();
    final results = <MyanmarDate>[];

    // Process in batches to avoid memory issues with large lists
    const batchSize = PackageConstants.maxBatchSize;

    for (int i = 0; i < westernDates.length; i += batchSize) {
      final end = math.min(i + batchSize, westernDates.length);
      final batch = westernDates.sublist(i, end);

      for (final westernDate in batch) {
        results.add(service.westernToMyanmar(westernDate));
      }
    }

    return results;
  }

  /// Converts multiple Myanmar dates to Western dates
  ///
  /// Efficiently converts a list of Myanmar dates to Western dates.
  static List<DateTime> convertMyanmarDatesToWestern(
    List<MyanmarDate> myanmarDates,
  ) {
    final service = MyanmarCalendarService();
    final results = <DateTime>[];

    const batchSize = PackageConstants.maxBatchSize;

    for (int i = 0; i < myanmarDates.length; i += batchSize) {
      final end = math.min(i + batchSize, myanmarDates.length);
      final batch = myanmarDates.sublist(i, end);

      for (final myanmarDate in batch) {
        results.add(
          service.myanmarToWestern(
            myanmarDate.year,
            myanmarDate.month,
            myanmarDate.day,
          ),
        );
      }
    }

    return results;
  }

  /// Gets complete date information for multiple dates
  ///
  /// Efficiently processes multiple dates to get complete information.
  static List<CompleteDate> getCompleteDatesForWesternDates(
    List<DateTime> dates,
  ) {
    final service = MyanmarCalendarService();
    final results = <CompleteDate>[];

    const batchSize = PackageConstants.maxBatchSize;

    for (int i = 0; i < dates.length; i += batchSize) {
      final end = math.min(i + batchSize, dates.length);
      final batch = dates.sublist(i, end);

      for (final date in batch) {
        results.add(service.getCompleteDate(date));
      }
    }

    return results;
  }

  // ============================================================================
  // STATISTICAL UTILITIES
  // ============================================================================

  /// Calculates statistics for a list of Myanmar dates
  ///
  /// Returns various statistics about the date range including span, average, etc.
  static Map<String, dynamic> calculateMyanmarDateStatistics(
    List<MyanmarDate> dates,
  ) {
    if (dates.isEmpty) {
      return {'count': 0};
    }

    final jdns = dates.map((d) => d.julianDayNumber).toList();
    jdns.sort();

    final min = jdns.first;
    final max = jdns.last;
    final span = (max - min).round();
    final average = jdns.reduce((a, b) => a + b) / jdns.length;

    // Calculate median
    final middle = jdns.length ~/ 2;
    final median = jdns.length % 2 == 0
        ? (jdns[middle - 1] + jdns[middle]) / 2
        : jdns[middle];

    final service = MyanmarCalendarService();

    return {
      'count': dates.length,
      'span_days': span,
      'earliest': service.julianToMyanmar(min),
      'latest': service.julianToMyanmar(max),
      'average_jdn': average,
      'median_jdn': median,
      'average_date': service.julianToMyanmar(average),
      'median_date': service.julianToMyanmar(median),
    };
  }

  /// Groups dates by year
  ///
  /// Returns a map where keys are years and values are lists of dates.
  static Map<int, List<MyanmarDate>> groupMyanmarDatesByYear(
    List<MyanmarDate> dates,
  ) {
    final grouped = <int, List<MyanmarDate>>{};

    for (final date in dates) {
      grouped.putIfAbsent(date.year, () => <MyanmarDate>[]).add(date);
    }

    return grouped;
  }

  /// Groups dates by month
  ///
  /// Returns a map where keys are months and values are lists of dates.
  static Map<int, List<MyanmarDate>> groupMyanmarDatesByMonth(
    List<MyanmarDate> dates,
  ) {
    final grouped = <int, List<MyanmarDate>>{};

    for (final date in dates) {
      grouped.putIfAbsent(date.month, () => <MyanmarDate>[]).add(date);
    }

    return grouped;
  }

  /// Groups dates by weekday
  ///
  /// Returns a map where keys are weekdays and values are lists of dates.
  static Map<int, List<MyanmarDate>> groupMyanmarDatesByWeekday(
    List<MyanmarDate> dates,
  ) {
    final grouped = <int, List<MyanmarDate>>{};

    for (final date in dates) {
      grouped.putIfAbsent(date.weekday, () => <MyanmarDate>[]).add(date);
    }

    return grouped;
  }

  // ============================================================================
  // VALIDATION UTILITIES
  // ============================================================================

  /// Validates a list of Myanmar dates
  ///
  /// Returns validation results for each date in the list.
  static List<ValidationResult> validateMyanmarDates(
    List<Map<String, int>> dateMaps,
  ) {
    final service = MyanmarCalendarService();
    final results = <ValidationResult>[];

    for (final dateMap in dateMaps) {
      final year = dateMap['year'] ?? 0;
      final month = dateMap['month'] ?? 0;
      final day = dateMap['day'] ?? 0;

      results.add(service.validateMyanmarDate(year, month, day));
    }

    return results;
  }

  /// Checks if all dates in a list are valid
  ///
  /// Returns true only if all dates pass validation.
  static bool areAllMyanmarDatesValid(List<Map<String, int>> dateMaps) {
    final results = validateMyanmarDates(dateMaps);
    return results.every((result) => result.isValid);
  }

  // ============================================================================
  // HELPER UTILITIES
  // ============================================================================

  /// Rounds a Julian Day Number to the nearest day
  ///
  /// Useful for converting continuous JDN values to discrete day values.
  static double roundJulianDayNumber(double jdn) {
    return jdn.roundToDouble();
  }

  /// Clamps a value between minimum and maximum bounds
  ///
  /// Ensures a value stays within specified bounds.
  static T clamp<T extends num>(T value, T min, T max) {
    if (value < min) return min;
    if (value > max) return max;
    return value;
  }

  /// Gets a safe integer from a dynamic value
  ///
  /// Attempts to convert a dynamic value to an integer with bounds checking.
  static int? getSafeInteger(dynamic value, {int? min, int? max}) {
    int? result;

    if (value is int) {
      result = value;
    } else if (value is double) {
      result = value.round();
    } else if (value is String) {
      result = int.tryParse(value);
    }

    if (result == null) return null;

    if (min != null && result < min) return null;
    if (max != null && result > max) return null;

    return result;
  }

  /// Creates a deep copy of a date list
  ///
  /// Returns a new list with copies of all Myanmar dates.
  static List<MyanmarDate> copyMyanmarDateList(List<MyanmarDate> dates) {
    return dates.map((date) => date.copyWith()).toList();
  }

  /// Sorts Myanmar dates chronologically
  ///
  /// Returns a new list with dates sorted by Julian Day Number.
  static List<MyanmarDate> sortMyanmarDatesChronologically(
    List<MyanmarDate> dates,
  ) {
    final sorted = copyMyanmarDateList(dates);
    sorted.sort((a, b) => a.julianDayNumber.compareTo(b.julianDayNumber));
    return sorted;
  }

  /// Removes duplicate dates from a list
  ///
  /// Returns a new list with duplicate Myanmar dates removed.
  static List<MyanmarDate> removeDuplicateMyanmarDates(
    List<MyanmarDate> dates,
  ) {
    final seen = <double>{};
    return dates.where((date) => seen.add(date.julianDayNumber)).toList();
  }

  /// Convert a number to a string according to the current global language setting.
  ///
  /// `number` - Number to convert
  /// Returns translated number as string.
  static String convertNumberToLanguage(double number) {
    int r = 0;
    String s = "", g = "";

    if (number < 0) {
      g = "-";
      number = number.abs();
    }

    number = number.floorToDouble();

    do {
      r = (number % 10).toInt();
      number = (number / 10).floorToDouble();
      s = TranslationService.translate(r.toString()) + s;
    } while (number > 0);

    return g + s;
  }
}
