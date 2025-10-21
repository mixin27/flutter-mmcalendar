/// ------------------------------------------------------------
/// Holiday Calculation Core
///
/// Based on original algorithms by: [Dr Yan Naing Aye]
/// Source: https://github.com/yan9a/mmcal
/// Language: [Original Language, e.g. CPP/JavaScript]
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

import 'package:flutter_mmcalendar/src/localization/translation_service.dart';
import 'package:flutter_mmcalendar/src/models/holiday_info.dart';
import 'package:flutter_mmcalendar/src/models/myanmar_date.dart';
import 'package:flutter_mmcalendar/src/utils/calendar_constants.dart';

import '../core/calendar_cache.dart';

/// Service for calculating holidays in the Myanmar calendar system
class HolidayCalculator {
  late final CalendarCache _cache;

  /// Create a new [HolidayCalculator] instance
  HolidayCalculator({required CalendarCache cache}) : _cache = cache;

  /// Get all holidays for a Myanmar date
  HolidayInfo getHolidays(MyanmarDate date) {
    // Try to get from cache
    final cached = _cache.getHolidayInfo(date);
    if (cached != null) {
      return cached;
    }

    // Calculate if not in cache
    final holidayInfo = _calculateHolidays(date);

    // Store in cache
    _cache.putHolidayInfo(date, holidayInfo);

    return holidayInfo;
  }

  HolidayInfo _calculateHolidays(MyanmarDate date) {
    final publicHolidays = <String>[];
    final religiousHolidays = <String>[];
    final culturalHolidays = <String>[];
    final otherHolidays = <String>[];
    final myanmarAnniversaryDays = <String>[];
    final otherAnniversaryDays = <String>[];

    // Convert to Western date for Gregorian-based holidays
    final westernJdn = date.julianDayNumber;
    final westernDate = _jdnToWestern(westernJdn);

    // Myanmar calendar based holidays
    _addMyanmarHolidays(
      date,
      publicHolidays,
      religiousHolidays,
      culturalHolidays,
    );

    // Western calendar based holidays
    _addWesternHolidays(
      westernDate,
      publicHolidays,
      religiousHolidays,
      culturalHolidays,
    );

    // Thingyan holidays (Myanmar New Year)
    _addThingyanHolidays(date, westernDate, publicHolidays, culturalHolidays);

    // Other holidays
    _addOtherHolidays(westernDate, otherHolidays);

    // Myanmar anniversary days
    _addMyanmarAnniversaryDays(date, myanmarAnniversaryDays);

    // Other anniversary days
    _addOtherAnniversaryDays(westernDate, otherAnniversaryDays);

    return HolidayInfo(
      publicHolidays: publicHolidays,
      religiousHolidays: religiousHolidays,
      culturalHolidays: culturalHolidays,
      otherHolidays: otherHolidays,
      myanmarAnniversaryDays: myanmarAnniversaryDays,
      otherAnniversaryDays: otherAnniversaryDays,
    );
  }

  /// Add Myanmar calendar based holidays
  void _addMyanmarHolidays(
    MyanmarDate date,
    List<String> publicHolidays,
    List<String> religiousHolidays,
    List<String> culturalHolidays,
  ) {
    // Vesak Day (Buddha Day) - Kason full moon
    if (date.month == CalendarConstants.monthKason &&
        date.moonPhase == CalendarConstants.moonPhaseFullMoon) {
      religiousHolidays.add(TranslationService.translate('Buddha'));
    }

    // Start of Buddhist Lent - Waso full moon
    if (date.month == CalendarConstants.monthWaso &&
        date.moonPhase == CalendarConstants.moonPhaseFullMoon) {
      religiousHolidays.add(
        TranslationService.translate('Start of Buddhist Lent'),
      );
    }

    // End of Buddhist Lent - Thadingyut full moon
    if (date.month == CalendarConstants.monthThadingyut &&
        date.moonPhase == CalendarConstants.moonPhaseFullMoon) {
      religiousHolidays.add(
        TranslationService.translate('End of Buddhist Lent'),
      );
      publicHolidays.add(TranslationService.translate('Holiday'));
    }

    if (date.year >= 1379 &&
        date.month == CalendarConstants.monthThadingyut &&
        (date.day == 14 || date.day == 16)) {
      publicHolidays.add(TranslationService.translate('Holiday'));
    }

    // Tazaungdaing Festival - Tazaungmon full moon
    if (date.month == CalendarConstants.monthTazaungmon &&
        date.moonPhase == CalendarConstants.moonPhaseFullMoon) {
      religiousHolidays.add(TranslationService.translate('Tazaungdaing'));
    }

    if (date.year >= 1379 &&
        date.month == CalendarConstants.monthTazaungmon &&
        date.day == 14) {
      culturalHolidays.add(TranslationService.translate('Holiday'));
    }

    // National Day - Tazaungmon waning 10
    if (date.year >= 1282 &&
        date.month == CalendarConstants.monthTazaungmon &&
        date.moonPhase == CalendarConstants.moonPhaseWaning &&
        date.fortnightDay == 10) {
      publicHolidays.add(TranslationService.translate('National Day'));
    }

    // Karen New Year - Pyatho 1
    if (date.month == CalendarConstants.monthPyatho && date.day == 1) {
      culturalHolidays.add(TranslationService.translate('Karen'));
      culturalHolidays.add(TranslationService.translate("New Year's"));
    }

    // Tabaung Pwe - Tabaung full moon
    if (date.month == CalendarConstants.monthTabaung &&
        date.moonPhase == CalendarConstants.moonPhaseFullMoon) {
      culturalHolidays.add(TranslationService.translate('Tabaung'));
      culturalHolidays.add(TranslationService.translate('Pwe'));
    }
  }

  /// Add Myanmar anniversary days
  void _addMyanmarAnniversaryDays(MyanmarDate date, List<String> items) {
    // Mahathamaya Day - Nayon full moon
    if (date.month == CalendarConstants.monthNayon &&
        date.moonPhase == CalendarConstants.moonPhaseFullMoon) {
      items.add(TranslationService.translate('Mahathamaya'));
    }

    // Garudhamma Day - Tawthalin full moon
    if (date.month == CalendarConstants.monthTawthalin &&
        date.moonPhase == CalendarConstants.moonPhaseFullMoon) {
      items.add(TranslationService.translate('Garudhamma'));
    }

    // Mothers' Day - Pyatho full moon (since 1998 CE / 1360 ME)
    if (date.year >= 1360 &&
        date.month == CalendarConstants.monthPyatho &&
        date.moonPhase == CalendarConstants.moonPhaseFullMoon) {
      items.add(TranslationService.translate('Mothers'));
    }

    // Fathers' Day - Tabaung full moon (since 2008 CE / 1370 ME)
    if (date.year >= 1370 &&
        date.month == CalendarConstants.monthTabaung &&
        date.moonPhase == CalendarConstants.moonPhaseFullMoon) {
      items.add(TranslationService.translate('Fathers'));
    }

    // Metta Day - Wagaung full moon
    if (date.month == CalendarConstants.monthWagaung &&
        date.moonPhase == CalendarConstants.moonPhaseFullMoon) {
      items.add(TranslationService.translate('Metta'));
    }

    // Taungpyone Pwe - Wagaung 10
    if (date.month == CalendarConstants.monthWagaung && date.day == 10) {
      items.add(TranslationService.translate('Taungpyone'));
      items.add(TranslationService.translate('Pwe'));
    }

    // Yadanagu Pwe - Wagaung 23
    if (date.month == CalendarConstants.monthWagaung && date.day == 23) {
      items.add(TranslationService.translate('Yadanagu'));
      items.add(TranslationService.translate('Pwe'));
    }

    // Mon National Day - Tabodwe 16 (since 1947 CE / 1309 ME)
    if (date.year >= 1309 &&
        date.month == CalendarConstants.monthTabodwe &&
        date.day == 16) {
      items.add(TranslationService.translate('Mon'));
      items.add(TranslationService.translate('National'));
    }

    // Shan New Year & Authors' Day - Nadaw 1
    if (date.month == CalendarConstants.monthNadaw && date.day == 1) {
      items.add(TranslationService.translate('Shan'));
      items.add(TranslationService.translate("New Year's"));

      if (date.year >= 1306) {
        items.add(TranslationService.translate('Authors'));
      }
    }
  }

  /// Add other anniversary days
  void _addOtherAnniversaryDays(
    Map<String, int> westernDate,
    List<String> items,
  ) {
    final year = westernDate['year']!;
    final month = westernDate['month']!;
    final day = westernDate['day']!;

    // General Aung San's Birthday (February 13, since 1915)
    if (year >= 1915 && month == 2 && day == 13) {
      items.add(TranslationService.translate('G. Aung San BD'));
    }

    // Valentines Day
    if ((year >= 1969) && (month == 2 && day == 14)) {
      items.add(TranslationService.translate('Valentines'));
    }

    // Earth Day
    if ((year >= 1970) && (month == 4 && day == 22)) {
      items.add(TranslationService.translate('Earth'));
    }

    // April Fools'
    if ((year >= 1392) && (month == 4 && day == 1)) {
      items.add(TranslationService.translate("April Fools'"));
    }

    // Red cross
    if ((year >= 1948) && (month == 5 && day == 8)) {
      items.add(TranslationService.translate('Red Cross'));
    }

    // World Teachers'
    if ((year >= 1994) && (month == 10 && day == 5)) {
      items.add(TranslationService.translate("World Teachers'"));
    }

    // UN Day
    if ((year >= 1947) && (month == 10 && day == 24)) {
      items.add(TranslationService.translate("United Nations"));
    }

    // Halloween
    if ((year >= 1753) && (month == 10 && day == 31)) {
      items.add(TranslationService.translate("Halloween"));
    }

    // Eid al-Fitr (approximate calculation)
    if (_isEidAlFitr(year, month, day)) {
      items.add(TranslationService.translate("Eid al-Fitr"));
    }

    // Eid al-Adha (approximate calculation)
    if (_isEidAlAdha(year, month, day)) {
      items.add(TranslationService.translate("Eid al-Adha"));
    }

    // Chinese New Year
    if (_isChineseNewYear(year, month, day)) {
      items.add(TranslationService.translate("Chinese New Year's"));
    }
  }

  /// Add Western calendar based holidays
  void _addWesternHolidays(
    Map<String, int> westernDate,
    List<String> publicHolidays,
    List<String> religiousHolidays,
    List<String> culturalHolidays,
  ) {
    final year = westernDate['year']!;
    final month = westernDate['month']!;
    final day = westernDate['day']!;

    // New Year's Day (since 2018)
    if (year >= 2018 && month == 1 && day == 1) {
      publicHolidays.add(TranslationService.translate("New Year's"));
    }

    // Pre New Year's
    if (year >= 2018 && month == 12 && day == 31) {
      publicHolidays.add(TranslationService.translate("Holiday"));
    }

    // Independence Day (January 4, since 1948)
    if (year >= 1948 && month == 1 && day == 4) {
      publicHolidays.add(TranslationService.translate('Independence'));
    }

    // Union Day (February 12, since 1947)
    if (year >= 1947 && month == 2 && day == 12) {
      publicHolidays.add(TranslationService.translate('Union'));
    }

    // Peasants' Day (March 2, since 1958)
    if (year >= 1958 && month == 3 && day == 2) {
      publicHolidays.add(TranslationService.translate('Peasants'));
    }

    // Resistance Day (March 27, since 1945)
    if (year >= 1945 && month == 3 && day == 27) {
      publicHolidays.add(TranslationService.translate('Resistance'));
    }

    // Labour Day (May 1, since 1923)
    if (year >= 1923 && month == 5 && day == 1) {
      publicHolidays.add(TranslationService.translate('Labour'));
    }

    // Martyrs' Day (July 19, since 1947)
    if (year >= 1947 && month == 7 && day == 19) {
      publicHolidays.add(TranslationService.translate("Martyrs'"));
    }

    // Christmas Day (since 1752)
    if (year >= 1752 && month == 12 && day == 25) {
      religiousHolidays.add(TranslationService.translate('Christmas'));
    }

    // Easter calculation
    final easterJdn = _calculateEaster(year);
    final currentJdn = _westernToJdn(year, month, day);

    if (currentJdn == easterJdn) {
      religiousHolidays.add(TranslationService.translate('Easter'));
    } else if (currentJdn == easterJdn - 2) {
      religiousHolidays.add(TranslationService.translate('Good Friday'));
    }
  }

  /// Add Thingyan (Water Festival) holidays
  void _addThingyanHolidays(
    MyanmarDate date,
    Map<String, int> westernDate,
    List<String> publicHolidays,
    List<String> culturalHolidays,
  ) {
    final solarYear = CalendarConstants.solarYear;
    final myanmarEpoch = CalendarConstants.myanmarEpoch;
    const beginThingyan = 1100;
    const thirdEra = 1312;

    if (date.year >= beginThingyan) {
      final monthType = date.monthType;
      final atatTime = solarYear * (date.year + monthType) + myanmarEpoch;

      final akyaTime = (date.year >= thirdEra)
          ? atatTime - 2.169918982
          : atatTime - 2.1675;

      final atatJdn = atatTime.roundToDouble();
      final akyaJdn = akyaTime.round();
      final akyoJdn = akyaJdn - 1;
      final newYearJdn = atatJdn + 1;
      final currentJdn = date.julianDayNumber.round();

      // Myanmar New Year's Day
      if (currentJdn == newYearJdn) {
        publicHolidays.add(
          TranslationService.translate("Myanmar New Year's Day"),
        );
      }
      // Thingyan Atat
      else if (currentJdn == atatJdn) {
        culturalHolidays.add(TranslationService.translate('Thingyan'));
        culturalHolidays.add(TranslationService.translate('Atat'));
      }
      // Thingyan Akyat (water throwing days)
      else if (currentJdn > akyaJdn && currentJdn < atatJdn) {
        culturalHolidays.add(TranslationService.translate('Thingyan'));
        culturalHolidays.add(TranslationService.translate('Akyat'));
      }
      // Thingyan Akya
      else if (currentJdn == akyaJdn) {
        culturalHolidays.add(TranslationService.translate('Thingyan'));
        culturalHolidays.add(TranslationService.translate('Akya'));
      }
      // Thingyan Akyo
      else if (currentJdn == akyoJdn) {
        culturalHolidays.add(TranslationService.translate('Thingyan'));
        culturalHolidays.add(TranslationService.translate('Akyo'));
      }

      // Additional holiday periods for specific years
      if ((date.year + monthType) >= 1369 && (date.year + monthType) < 1379) {
        if (currentJdn == (akyaJdn - 2) ||
            (currentJdn >= (atatJdn + 2) && currentJdn <= (akyaJdn + 7))) {
          publicHolidays.add(TranslationService.translate('Holiday'));
        }
      } else if ((date.year + monthType) >= 1384 &&
          (date.year + monthType) <= 1385) {
        if (currentJdn >= (akyaJdn - 5) && currentJdn <= (akyaJdn - 2)) {
          publicHolidays.add(TranslationService.translate('Holiday'));
        }
      } else if ((date.year + monthType) >= 1386) {
        if (currentJdn >= (atatJdn + 2) && currentJdn <= (akyaJdn + 7)) {
          publicHolidays.add(TranslationService.translate('Holiday'));
        }
      }
    }
  }

  /// Add other holidays
  void _addOtherHolidays(
    Map<String, int> westernDate,
    List<String> otherHolidays,
  ) {
    final year = westernDate['year']!;
    final month = westernDate['month']!;
    final day = westernDate['day']!;

    // Diwali (approximate calculation)
    if (_isDiwali(year, month, day)) {
      otherHolidays.add(TranslationService.translate('Diwali'));
    }
  }

  /// Check if date is Diwali
  /// Diwali occurs in October or November (15th day of Kartik - Hindu calendar)
  /// This is an approximate calculation
  bool _isDiwali(int year, int month, int day) {
    // Diwali lookup table for known years (you can expand this)
    final diwaliDates = <int, Map<String, int>>{
      2014: {'month': 10, 'day': 23},
      2015: {'month': 11, 'day': 11},
      2016: {'month': 10, 'day': 30},
      2017: {'month': 10, 'day': 19},
      2018: {'month': 11, 'day': 7},
      2019: {'month': 10, 'day': 27},
      2020: {'month': 11, 'day': 14},
      2021: {'month': 11, 'day': 4},
      2022: {'month': 10, 'day': 24},
      2023: {'month': 11, 'day': 12},
      2024: {'month': 11, 'day': 1},
      2025: {'month': 10, 'day': 20},
      2026: {'month': 11, 'day': 8},
      2027: {'month': 10, 'day': 29},
      2028: {'month': 10, 'day': 17},
      2029: {'month': 11, 'day': 5},
      2030: {'month': 10, 'day': 26},
    };

    if (diwaliDates.containsKey(year)) {
      final diwali = diwaliDates[year]!;
      return month == diwali['month'] && day == diwali['day'];
    }

    return false;
  }

  /// Check if date is Eid al-Fitr
  /// Eid al-Fitr is at the end of Ramadan (Islamic calendar)
  bool _isEidAlFitr(int year, int month, int day) {
    // Eid al-Fitr lookup table (you can expand this)
    final eidDates = <int, List<Map<String, int>>>{
      2014: [
        {'month': 7, 'day': 28},
        {'month': 7, 'day': 29},
      ],
      2015: [
        {'month': 7, 'day': 17},
        {'month': 7, 'day': 18},
      ],
      2016: [
        {'month': 7, 'day': 6},
        {'month': 7, 'day': 7},
      ],
      2017: [
        {'month': 6, 'day': 25},
        {'month': 6, 'day': 26},
      ],
      2018: [
        {'month': 6, 'day': 15},
        {'month': 6, 'day': 16},
      ],
      2019: [
        {'month': 6, 'day': 4},
        {'month': 6, 'day': 5},
      ],
      2020: [
        {'month': 5, 'day': 24},
        {'month': 5, 'day': 25},
      ],
      2021: [
        {'month': 5, 'day': 13},
        {'month': 5, 'day': 14},
      ],
      2022: [
        {'month': 5, 'day': 2},
        {'month': 5, 'day': 3},
      ],
      2023: [
        {'month': 4, 'day': 21},
        {'month': 4, 'day': 22},
      ],
      2024: [
        {'month': 4, 'day': 10},
        {'month': 4, 'day': 11},
      ],
      2025: [
        {'month': 3, 'day': 30},
        {'month': 3, 'day': 31},
      ],
      2026: [
        {'month': 3, 'day': 20},
        {'month': 3, 'day': 21},
      ],
      2027: [
        {'month': 3, 'day': 9},
        {'month': 3, 'day': 10},
      ],
      2028: [
        {'month': 2, 'day': 26},
        {'month': 2, 'day': 27},
      ],
      2029: [
        {'month': 2, 'day': 14},
        {'month': 2, 'day': 15},
      ],
      2030: [
        {'month': 2, 'day': 4},
        {'month': 2, 'day': 5},
      ],
    };

    if (eidDates.containsKey(year)) {
      for (final eid in eidDates[year]!) {
        if (month == eid['month'] && day == eid['day']) {
          return true;
        }
      }
    }

    return false;
  }

  /// Check if date is Eid al-Adha
  /// Eid al-Adha is approximately 70 days after Eid al-Fitr
  bool _isEidAlAdha(int year, int month, int day) {
    // Eid al-Adha lookup table (you can expand this)
    final eidAdha = <int, List<Map<String, int>>>{
      2014: [
        {'month': 10, 'day': 4},
        {'month': 10, 'day': 5},
      ],
      2015: [
        {'month': 9, 'day': 23},
        {'month': 9, 'day': 24},
      ],
      2016: [
        {'month': 9, 'day': 12},
        {'month': 9, 'day': 13},
      ],
      2017: [
        {'month': 9, 'day': 1},
        {'month': 9, 'day': 2},
      ],
      2018: [
        {'month': 8, 'day': 21},
        {'month': 8, 'day': 22},
      ],
      2019: [
        {'month': 8, 'day': 11},
        {'month': 8, 'day': 12},
      ],
      2020: [
        {'month': 7, 'day': 31},
        {'month': 8, 'day': 1},
      ],
      2021: [
        {'month': 7, 'day': 20},
        {'month': 7, 'day': 21},
      ],
      2022: [
        {'month': 7, 'day': 9},
        {'month': 7, 'day': 10},
      ],
      2023: [
        {'month': 6, 'day': 28},
        {'month': 6, 'day': 29},
      ],
      2024: [
        {'month': 6, 'day': 16},
        {'month': 6, 'day': 17},
      ],
      2025: [
        {'month': 6, 'day': 6},
        {'month': 6, 'day': 7},
      ],
      2026: [
        {'month': 5, 'day': 27},
        {'month': 5, 'day': 28},
      ],
      2027: [
        {'month': 5, 'day': 16},
        {'month': 5, 'day': 17},
      ],
      2028: [
        {'month': 5, 'day': 5},
        {'month': 5, 'day': 6},
      ],
      2029: [
        {'month': 4, 'day': 24},
        {'month': 4, 'day': 25},
      ],
      2030: [
        {'month': 4, 'day': 13},
        {'month': 4, 'day': 14},
      ],
    };

    if (eidAdha.containsKey(year)) {
      for (final eid in eidAdha[year]!) {
        if (month == eid['month'] && day == eid['day']) {
          return true;
        }
      }
    }

    return false;
  }

  /// Check if date is Chinese New Year
  bool _isChineseNewYear(int year, int month, int day) {
    // Chinese New Year lookup table (you can expand this)
    final chineseNewYear = <int, Map<String, int>>{
      2014: {'month': 1, 'day': 31},
      2015: {'month': 2, 'day': 19},
      2016: {'month': 2, 'day': 8},
      2017: {'month': 1, 'day': 28},
      2018: {'month': 2, 'day': 16},
      2019: {'month': 2, 'day': 5},
      2020: {'month': 1, 'day': 25},
      2021: {'month': 2, 'day': 12},
      2022: {'month': 2, 'day': 1},
      2023: {'month': 1, 'day': 22},
      2024: {'month': 2, 'day': 10},
      2025: {'month': 1, 'day': 29},
      2026: {'month': 2, 'day': 17},
      2027: {'month': 2, 'day': 6},
      2028: {'month': 1, 'day': 26},
      2029: {'month': 2, 'day': 13},
      2030: {'month': 2, 'day': 3},
      2031: {'month': 1, 'day': 23},
      2032: {'month': 2, 'day': 11},
      2033: {'month': 1, 'day': 31},
      2034: {'month': 2, 'day': 19},
      2035: {'month': 2, 'day': 8},
    };

    if (chineseNewYear.containsKey(year)) {
      final cny = chineseNewYear[year]!;
      return month == cny['month'] && day == cny['day'];
    }

    return false;
  }

  /// Calculate Easter Sunday for a given year using Gregorian calendar
  int _calculateEaster(int year) {
    final a = year % 19;
    final b = (year / 100).floor();
    final c = year % 100;
    final d = (b / 4).floor();
    final e = b % 4;
    final f = ((b + 8) / 25).floor();
    final g = ((b - f + 1) / 3).floor();
    final h = (19 * a + b - d - g + 15) % 30;
    final i = (c / 4).floor();
    final k = c % 4;
    final l = (32 + 2 * e + 2 * i - h - k) % 7;
    final m = ((a + 11 * h + 22 * l) / 451).floor();
    final q = h + l - 7 * m + 114;
    final p = (q % 31) + 1;
    final n = (q / 31).floor();

    return _westernToJdn(year, n, p);
  }

  /// Convert Western date to Julian Day Number
  int _westernToJdn(int year, int month, int day) {
    final a = ((14 - month) / 12).floor();
    final y = year + 4800 - a;
    final m = month + (12 * a) - 3;

    var jdn = day + ((153 * m + 2) / 5).floor() + (365 * y) + (y / 4).floor();
    jdn = jdn - (y / 100).floor() + (y / 400).floor() - 32045;

    return jdn;
  }

  /// Convert Julian Day Number to Western date
  Map<String, int> _jdnToWestern(double julianDayNumber) {
    var j = (julianDayNumber + 0.5).floor();
    j -= 1721119;

    final year = ((4 * j - 1) / 146097).floor();
    j = 4 * j - 1 - 146097 * year;
    var day = (j / 4).floor();
    j = ((4 * day + 3) / 1461).floor();
    day = 4 * day + 3 - 1461 * j;
    day = ((day + 4) / 4).floor();
    var month = ((5 * day - 3) / 153).floor();
    day = 5 * day - 3 - 153 * month;
    day = ((day + 5) / 5).floor();
    var finalYear = 100 * year + j;

    if (month < 10) {
      month += 3;
    } else {
      month -= 9;
      finalYear += 1;
    }

    return {'year': finalYear, 'month': month, 'day': day};
  }

  /// Check if a date is a substitute holiday
  bool isSubstituteHoliday(double julianDayNumber, int year) {
    if (year >= 2019 && year <= 2021) {
      final substituteHolidays = _getSubstituteHolidays();
      return substituteHolidays.contains(julianDayNumber.round());
    }
    return false;
  }

  /// Get substitute holidays for specific years (2019-2021)
  List<int> _getSubstituteHolidays() {
    return [
      // 2019
      2458768, 2458772, 2458785, 2458800,
      // 2020
      2458855, 2458918, 2458950, 2459051, 2459062,
      2459152, 2459156, 2459167, 2459181, 2459184,
      // 2021
      2459300, 2459303, 2459323, 2459324,
      2459335, 2459548, 2459573,
    ];
  }
}
