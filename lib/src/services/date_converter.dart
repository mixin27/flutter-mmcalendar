/// ------------------------------------------------------------
/// Myanmar Calendar Calculation Core
///
/// Based on original algorithms by: [Dr Yan Naing Aye]
/// Source: https://github.com/yan9a/mmcal
/// Language: [Original Language, JavaScript, CPP]
/// License: [License type, MIT]
///
/// Dart/Flutter conversion and adaptations by: Kyaw Zayar Tun
/// Website: https://github.com/mixin27
///
/// Notes:
/// - The core algorithm originates from the above source.
/// - This implementation is a re-creation in Dart, with
///   modifications and optimizations for Flutter usage.
/// ------------------------------------------------------------
library;

import 'package:flutter_mmcalendar/src/core/calendar_config.dart';
import 'package:flutter_mmcalendar/src/models/myanmar_date.dart';
import 'package:flutter_mmcalendar/src/models/western_date.dart';
import 'package:flutter_mmcalendar/src/utils/calendar_constants.dart';
import 'package:flutter_mmcalendar/src/utils/package_constants.dart';

import '../core/calendar_cache.dart';
import '../utils/myanmar_year_constants.dart';

/// Date converter core
class DateConverter {
  final CalendarConfig _config;
  final CalendarCache _cache;

  /// Create a new date converter
  DateConverter(this._config, {required CalendarCache cache}) : _cache = cache;

  /// Get current calendar config.
  CalendarConfig get config => _config;

  /// Convert JDN to readable date for debugging
  static String jdnToGregorianDate(int jdn) {
    final a = jdn + 32044;
    final b = (4 * a + 3) ~/ 146097;
    final c = a - (146097 * b) ~/ 4;
    final d = (4 * c + 3) ~/ 1461;
    final e = c - (1461 * d) ~/ 4;
    final m = (5 * e + 2) ~/ 153;

    final day = e - (153 * m + 2) ~/ 5 + 1;
    final month = m + 3 - 12 * (m ~/ 10);
    final year = 100 * b + d - 4800 + (m ~/ 10);

    return '$year-${month.toString().padLeft(2, '0')}-${day.toString().padLeft(2, '0')}';
  }

  // ============================================================================
  // WESTERN DATE CONVERSIONS
  // ============================================================================

  /// Convert Western date to Julian Day Number
  double westernToJulian(
    int year,
    int month,
    int day, [
    int hour = 12,
    int minute = 0,
    int second = 0,
  ]) {
    _validateWesternDate(year, month, day, hour, minute, second);

    // Try to get from cache
    // final cached = _cache.g(julianDayNumber);
    // if (cached != null) {
    //   return cached;
    // }

    // Calculate if not in cache
    final jd = _calculateWesternToJulian(
      year,
      month,
      day,
      hour,
      minute,
      second,
    );

    // Store in cache
    // _cache.putWesternDate(julianDayNumber, westernDate);

    return jd;
  }

  double _calculateWesternToJulian(
    int year,
    int month,
    int day, [
    int hour = 12,
    int minute = 0,
    int second = 0,
  ]) {
    final calType = _config.calendarType;
    final gregorianStart = _config.gregorianStart.toDouble();

    final a = ((14 - month) / 12).floor();
    final adjustedYear = year + 4800 - a;
    final adjustedMonth = month + 12 * a - 3;

    double jd =
        (day +
                ((153 * adjustedMonth + 2) / 5).floor() +
                365 * adjustedYear +
                (adjustedYear / 4).floor())
            .toDouble();

    if (calType == CalendarConstants.calendarTypeGregorian) {
      jd =
          jd -
          (adjustedYear / 100).floor() +
          (adjustedYear / 400).floor() -
          32045;
    } else if (calType == CalendarConstants.calendarTypeJulian) {
      jd = jd - 32083;
    } else {
      // British calendar (default)
      jd =
          jd -
          (adjustedYear / 100).floor() +
          (adjustedYear / 400).floor() -
          32045;
      if (jd < gregorianStart) {
        jd =
            day +
            ((153 * adjustedMonth + 2) / 5).floor() +
            365 * adjustedYear +
            (adjustedYear / 4).floor() -
            32083;
        if (jd > gregorianStart) jd = gregorianStart;
      }
    }

    // Add time fraction
    final timeFraction = _timeToFraction(hour, minute, second);
    return jd + timeFraction;
  }

  /// Convert Julian Day Number to Western date
  WesternDate julianToWestern(double julianDayNumber) {
    // Try to get from cache
    final cached = _cache.getWesternDate(julianDayNumber);
    if (cached != null) {
      return cached;
    }

    // Calculate if not in cache
    final westernDate = _calculateJulianToWestern(julianDayNumber);

    // Store in cache
    _cache.putWesternDate(julianDayNumber, westernDate);

    return westernDate;
  }

  WesternDate _calculateJulianToWestern(double julianDayNumber) {
    final localJdn = julianDayNumber;
    final calType = _config.calendarType;
    final gregorianStart = _config.gregorianStart.toDouble();

    double j, jf, y, m, d;

    if (calType == CalendarConstants.calendarTypeJulian ||
        (calType == CalendarConstants.calendarTypeBritish &&
            localJdn < gregorianStart)) {
      // Julian Calendar
      final b = (localJdn + 0.5).floor() + 1524;
      final c = ((b - 122.1) / 365.25).floor();
      final f = (365.25 * c).floor();
      final e = ((b - f) / 30.6001).floor();

      m = e > 13 ? e - 13 : e - 1;
      d = b - f - (30.6001 * e).floorToDouble();
      y = m < 3 ? c - 4715 : c - 4716;

      j = localJdn + 0.5;
      jf = j - j.floor();
    } else {
      // Gregorian Calendar
      j = (localJdn + 0.5).floorToDouble();
      jf = localJdn + 0.5 - j;

      j -= 1721119;
      y = ((4 * j - 1) / 146097).floorToDouble();
      j = 4 * j - 1 - 146097 * y;
      d = (j / 4).floorToDouble();

      j = ((4 * d + 3) / 1461).floorToDouble();
      d = (4 * d + 3 - 1461 * j);
      d = ((d + 4) / 4).floorToDouble();

      m = ((5 * d - 3) / 153).floorToDouble();
      d = (5 * d - 3 - 153 * m);
      d = ((d + 5) / 5).floorToDouble();

      y = 100 * y + j;
      if (m < 10) {
        m += 3;
      } else {
        m -= 9;
        y += 1;
      }
    }

    // Extract time components
    jf *= 24;
    final h = jf.floor();
    jf = (jf - h) * 60;
    final n = jf.floor();
    final s = ((jf - n) * 60).round();

    final weekday = ((localJdn + 0.5).floor() + 2) % 7;

    return WesternDate(
      year: y.toInt(),
      month: m.toInt(),
      day: d.toInt(),
      hour: h,
      minute: n,
      second: s,
      weekday: weekday,
      julianDayNumber: localJdn,
    );
  }

  // ============================================================================
  // MYANMAR DATE CONVERSIONS
  // ============================================================================

  /// Convert Myanmar date to Julian Day Number
  double myanmarToJulian(
    int year,
    int month,
    int day, [
    int hour = 12,
    int minute = 0,
    int second = 0,
  ]) {
    _validateMyanmarDate(year, month, day);

    // Get Myanmar year info
    final yearInfo = _getMyanmarYearInfo(year);

    // Calculate month type (0=normal, 1=watat)
    final monthType = month ~/ 13;
    final normalizedMonth = month % 13 + monthType;

    // Year type adjustments
    final b = (yearInfo['myt']! / 2).floor(); // Big watat adjustment
    final c = (yearInfo['myt'] == 0) ? 1 : 0; // Common year adjustment

    // Calculate month length
    int monthLength = 30 - normalizedMonth % 2;
    if (normalizedMonth == 3) monthLength += b; // Nayon in big watat

    // Calculate moon phase for validation
    final moonPhase =
        ((day + 1) / 16).floor() +
        (day / 16).floor() +
        (day / monthLength).floor();
    final fortnightDay = day - 15 * (day ~/ 16);

    // Use the proven conversion formula
    final m1 = moonPhase % 2;
    final m2 = (moonPhase / 2).floor();

    final md =
        m1 * (15 + m2 * (monthLength - 15)) +
        (1 - m1) * (fortnightDay + 15 * m2);

    final adjustedMonth =
        normalizedMonth +
        4 -
        ((normalizedMonth + 15) / 16).floor() * 4 +
        ((normalizedMonth + 12) / 16).floor();

    double dd =
        (md +
                (29.544 * adjustedMonth - 29.26).floor() -
                c * ((adjustedMonth + 11) / 16).floor() * 30 +
                b * ((adjustedMonth + 12) / 16).floor())
            .toDouble();

    dd += monthType * (354 + (1 - c) * 30 + b);

    final jd = dd + yearInfo['tg1']! - 1;

    // Add time fraction
    final timeFraction = _timeToFraction(hour, minute, second);
    return jd + timeFraction;
  }

  /// Convert Julian Day Number to Myanmar date
  MyanmarDate julianToMyanmar(double julianDayNumber) {
    // Try to get from cache
    final cached = _cache.getMyanmarDate(julianDayNumber);
    if (cached != null) {
      return cached;
    }

    // Calculate if not in cache
    final myanmarDate = _calculateJulianToMyanmar(julianDayNumber);

    // Store in cache
    _cache.putMyanmarDate(julianDayNumber, myanmarDate);

    return myanmarDate;
  }

  MyanmarDate _calculateJulianToMyanmar(double julianDayNumber) {
    final jdn = julianDayNumber.round();

    // Calculate Myanmar year
    final myYear =
        ((jdn - 0.5 - CalendarConstants.myanmarEpoch) /
                CalendarConstants.solarYear)
            .floor();

    final yearInfo = _getMyanmarYearInfo(myYear);
    int dayCount = (jdn - yearInfo["tg1"]!).toInt() + 1;

    // Year adjustments
    final b = (yearInfo["myt"]! / 2).floor();
    final c = (1 / (yearInfo["myt"]! + 1)).floor();
    final yearLength = 354 + (1 - c) * 30 + b;

    final monthType = (dayCount - 1) ~/ yearLength;
    dayCount -= monthType * yearLength;

    final a = ((dayCount + 423) / 512).floor();

    // Month calculation
    int mmonth = ((dayCount - b * a + c * a * 30 + 29.26) / 29.544).floor();
    final e = ((mmonth + 12) / 16).floor();
    final f = ((mmonth + 11) / 16).floor();

    final monthDay =
        dayCount - (29.544 * mmonth - 29.26).floor() - b * e + c * f * 30;
    mmonth += f * 3 - e * 4;

    // Month length calculation
    int monthLength = 30 - mmonth % 2;
    if (mmonth == 3) monthLength += (yearInfo['myt']! / 2).toInt();

    // Moon phase calculation
    final moonPhase =
        ((monthDay + 1) / 16).floor() +
        (monthDay / 16).floor() +
        (monthDay / monthLength).floor();

    final fortnightDay = monthDay - 15 * (monthDay ~/ 16);
    final weekDay = (jdn + 2) % 7;

    // Calculate Sasana year
    final sasanaYear = _calculateSasanaYear(myYear, mmonth, monthDay);

    return MyanmarDate(
      year: myYear,
      month: mmonth + 12 * monthType, // Restore full month number
      day: monthDay,
      yearType: yearInfo["myt"]!.toInt(),
      moonPhase: moonPhase,
      fortnightDay: fortnightDay,
      weekday: weekDay.toInt(),
      julianDayNumber: julianDayNumber,
      sasanaYear: sasanaYear,
      monthLength: monthLength,
      monthType: monthType,
    );
  }

  // ============================================================================
  // MYANMAR YEAR CALCULATIONS
  // ============================================================================

  /// Get Myanmar year information
  Map<String, double> _getMyanmarYearInfo(int myear) {
    int offset = 0;
    Map<String, double> prevYearInfo;
    double nd = 0, werr = 0, fm = 0;

    final currentYear = _checkWatat(myear);
    double myt = currentYear["watat"]!;

    do {
      offset++;
      prevYearInfo = _checkWatat(myear - offset);
    } while (prevYearInfo["watat"] == 0 && offset < 3);

    if (myt > 0) {
      nd = (currentYear["fm"]! - prevYearInfo["fm"]!) % 354;
      myt = (nd / 31).floorToDouble() + 1;
      fm = currentYear["fm"]!;
      if (nd != 30 && nd != 31) werr = 1;
    } else {
      fm = prevYearInfo["fm"]! + 354 * offset;
    }

    final tg1 = prevYearInfo["fm"]! + 354 * offset - 102;

    return {"myt": myt, "tg1": tg1, "fm": fm, "werr": werr};
  }

  /// Check watat (intercalary month) using the exact proven algorithm
  Map<String, double> _checkWatat(int myear) {
    // Find the appropriate era for this year
    final Map<String, double> era = MyanmarYearConstants.getMyConst(myear);

    final double nm = era['NM']!;
    final double wo = era['WO']!;

    final ta =
        (CalendarConstants.solarYear / 12 - CalendarConstants.lunarMonth) *
        (12 - nm);
    double ed =
        (CalendarConstants.solarYear * (myear + 3739)) %
        CalendarConstants.lunarMonth;
    if (ed < ta) ed += CalendarConstants.lunarMonth;

    final fm =
        (CalendarConstants.solarYear * myear +
                CalendarConstants.myanmarEpoch -
                ed +
                4.5 * CalendarConstants.lunarMonth +
                wo)
            .round()
            .toDouble();
    int watat = 0;

    if (era['EI']! >= 2) {
      final tw =
          CalendarConstants.lunarMonth -
          (CalendarConstants.solarYear / 12 - CalendarConstants.lunarMonth) *
              nm;
      if (ed >= tw) watat = 1;
    } else {
      watat = (myear * 7 + 2) % 19;
      if (watat < 0) watat += 19;
      watat = (watat / 12).floor();
    }

    // Apply watat exceptions from era data
    watat ^= era['EW']!.toInt();

    return {"fm": fm, "watat": watat.toDouble()};
  }

  // ============================================================================
  // LUNAR CALCULATIONS
  // ============================================================================

  /// Calculate moon phase
  int _calculateMoonPhase(int day, int month, int yearType) {
    final monthLength = _getMonthLength(month, yearType);
    return ((day + 1) / 16).floor() +
        (day / 16).floor() +
        (day / monthLength).floor();
  }

  /// Calculate fortnight day
  int _calculateFortnightDay(int day) {
    return day - 15 * (day ~/ 16);
  }

  /// Get month length
  int _getMonthLength(int month, int yearType) {
    var length = 30 - month % 2;
    if (month == 3) length += (yearType ~/ 2); // Nayon in big watat
    return length;
  }

  /// Calculate Sasana year
  int _calculateSasanaYear(int myanmarYear, int month, int day) {
    var offset = CalendarConstants.buddhistEraOffset;

    switch (_config.sasanaYearType) {
      case 1:
        if (month >= 13) offset = CalendarConstants.buddhistEraOffset + 1;
        break;
      case 2:
        if (month == 1 || (month == 2 && day < 15)) {
          offset = CalendarConstants.buddhistEraOffset - 1;
        }
        break;
    }

    return myanmarYear + offset;
  }

  // ============================================================================
  // UTILITY METHODS
  // ============================================================================

  /// Convert time to fraction of day (noon-based)
  double _timeToFraction(int hour, int minute, int second) {
    return (hour - 12) / 24.0 + minute / 1440.0 + second / 86400.0;
  }

  /// Validate Western date
  void _validateWesternDate(
    int year,
    int month,
    int day,
    int hour,
    int minute,
    int second,
  ) {
    if (year < 1 || year > 9999) {
      throw ArgumentError('Invalid Western year: $year');
    }
    if (month < 1 || month > 12) {
      throw ArgumentError('Invalid Western month: $month');
    }
    if (day < 1 || day > 31) throw ArgumentError('Invalid Western day: $day');
    if (hour < 0 || hour > 23) throw ArgumentError('Invalid hour: $hour');
    if (minute < 0 || minute > 59) {
      throw ArgumentError('Invalid minute: $minute');
    }
    if (second < 0 || second > 59) {
      throw ArgumentError('Invalid second: $second');
    }
  }

  /// Validate Myanmar date
  void _validateMyanmarDate(int year, int month, int day) {
    if (year < PackageConstants.minMyanmarYear ||
        year > PackageConstants.maxMyanmarYear) {
      throw ArgumentError(
        'Myanmar year must be between ${PackageConstants.minMyanmarYear} and ${PackageConstants.maxMyanmarYear}',
      );
    }
    if (month < PackageConstants.minMyanmarMonth ||
        month > PackageConstants.maxMyanmarMonth) {
      throw ArgumentError(
        'Myanmar month must be between ${PackageConstants.minMyanmarMonth} and ${PackageConstants.maxMyanmarMonth}',
      );
    }
    if (day < PackageConstants.minMyanmarDay ||
        day > PackageConstants.maxMyanmarDay) {
      throw ArgumentError(
        'Myanmar day must be between ${PackageConstants.minMyanmarDay} and ${PackageConstants.maxMyanmarDay}',
      );
    }
  }

  // ============================================================================
  // PUBLIC HELPER METHODS
  // ============================================================================

  /// Calculate year type for a given Myanmar year
  int calculateYearType(int myanmarYear) {
    final yearInfo = _getMyanmarYearInfo(myanmarYear);
    return yearInfo['myt']!.toInt();
  }

  /// Check if a Myanmar year is a watat year
  bool isWatatYear(int myanmarYear) {
    return calculateYearType(myanmarYear) > 0;
  }

  /// Get month length for a specific month and year type
  int getMonthLength(int month, int yearType) {
    return _getMonthLength(month, yearType);
  }

  /// Calculate moon phase for any Myanmar date
  int calculateMoonPhase(int day, int month, int yearType) {
    return _calculateMoonPhase(day, month, yearType);
  }

  /// Calculate fortnight day for any Myanmar day
  int calculateFortnightDay(int day) {
    return _calculateFortnightDay(day);
  }

  /// Get the Julian Day Number for the first day of a Myanmar year
  double getYearStartJdn(int myanmarYear) {
    final yearInfo = _getMyanmarYearInfo(myanmarYear);
    return yearInfo['tg1']!;
  }

  /// Get complete year information
  Map<String, dynamic> getYearInfo(int myanmarYear) {
    final yearInfo = _getMyanmarYearInfo(myanmarYear);

    return {
      'year': myanmarYear,
      'yearType': yearInfo['myt']!.toInt(),
      'isWatat': yearInfo['myt']! > 0,
      'firstDayJdn': yearInfo['tg1']!.toInt(),
      'fullMoonJdn': yearInfo['fm']!.toInt(),
    };
  }
}
