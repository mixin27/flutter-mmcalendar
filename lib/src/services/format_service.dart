import 'package:flutter_mmcalendar/src/localization/language.dart';
import 'package:flutter_mmcalendar/src/localization/translation_service.dart';
import 'package:flutter_mmcalendar/src/models/astro_info.dart';
import 'package:flutter_mmcalendar/src/models/complete_date.dart';
import 'package:flutter_mmcalendar/src/models/holiday_info.dart';
import 'package:flutter_mmcalendar/src/models/myanmar_date.dart';
import 'package:flutter_mmcalendar/src/models/western_date.dart';

/// Service for formatting dates and providing string representations
class FormatService {
  /// Format Myanmar date according to pattern and language
  ///
  /// Pattern placeholders:
  /// - `&yyyy` : Myanmar year [0000-9999, e.g. 1380]
  /// - `&y` : Myanmar year [0-9999, e.g. 138]
  /// - `&YYYY` : Sasana year [0000-9999, e.g. 2562]
  /// - `&mm` : month with zero padding [01-14]
  /// - `&M` : month name [e.g. Tagu]
  /// - `&m` : month [1-14]
  /// - `&P` : moon phase [e.g. Waxing, Full Moon]
  /// - `&dd` : day with zero padding [01-31]
  /// - `&d` : day [1-31]
  /// - `&ff` : fortnight day with zero padding [01-15]
  /// - `&f` : fortnight day [1-15]
  /// - `&W` : weekday name [e.g. Monday]
  /// - `&w` : weekday number [0-6]
  /// - `&YT` : year type [e.g. Common Year, Little Watat]
  /// - `&N` : year name [e.g. Hpusha, Magha]
  String formatMyanmarDate(
    MyanmarDate date, {
    String? pattern,
    Language? language,
  }) {
    final currentLang = language ?? TranslationService.currentLanguage;
    final oldLang = TranslationService.currentLanguage;

    if (currentLang != oldLang) {
      TranslationService.setLanguage(currentLang);
    }

    try {
      final format = pattern ?? '&y &M &P &ff';
      var result = format;

      // Myanmar year with zero padding
      result = result.replaceAll('&yyyy', date.year.toString().padLeft(4, '0'));

      // Myanmar year
      result = result.replaceAll('&y', date.year.toString());

      // Sasana year with zero padding
      result = result.replaceAll(
        '&YYYY',
        date.sasanaYear.toString().padLeft(4, '0'),
      );

      // Month with zero padding
      result = result.replaceAll('&mm', date.month.toString().padLeft(2, '0'));

      // Month name
      result = result.replaceAll('&M', getMonthName(date.month, date.yearType));

      // Month number
      result = result.replaceAll('&m', date.month.toString());

      // Moon phase
      result = result.replaceAll('&P', _getMoonPhaseName(date.moonPhase));

      // Day with zero padding
      result = result.replaceAll('&dd', date.day.toString().padLeft(2, '0'));

      // Day
      result = result.replaceAll('&d', date.day.toString());

      // Fortnight day with zero padding
      result = result.replaceAll(
        '&ff',
        date.fortnightDay.toString().padLeft(2, '0'),
      );

      // Fortnight day
      result = result.replaceAll('&f', date.fortnightDay.toString());

      // Weekday name
      result = result.replaceAll('&W', _getWeekdayName(date.weekday));

      // Weekday number
      result = result.replaceAll('&w', date.weekday.toString());

      // Year type
      result = result.replaceAll('&YT', _getYearTypeName(date.yearType));

      // Year name (12-year cycle)
      result = result.replaceAll('&N', _getYearName(date.year));

      return _translateNumbers(result);
    } finally {
      if (currentLang != oldLang) {
        TranslationService.setLanguage(oldLang);
      }
    }
  }

  /// Format Western date according to pattern and language
  ///
  /// Pattern placeholders:
  /// - `%yyyy` : year [0000-9999, e.g. 2018]
  /// - `%yy` : year [00-99 e.g. 18]
  /// - `%y` : year [0-9999, e.g. 201]
  /// - `%MMM` : month [e.g. JAN]
  /// - `%Mmm` : month [e.g. Jan]
  /// - `%mm` : month with zero padding [01-12]
  /// - `%M` : month [e.g. January]
  /// - `%m` : month [1-12]
  /// - `%dd` : day with zero padding [01-31]
  /// - `%d` : day [1-31]
  /// - `%HH` : hour [00-23]
  /// - `%hh` : hour [01-12]
  /// - `%H` : hour [0-23]
  /// - `%h` : hour [1-12]
  /// - `%AA` : AM or PM
  /// - `%aa` : am or pm
  /// - `%nn` : minute with zero padding [00-59]
  /// - `%n` : minute [0-59]
  /// - `%ss` : second [00-59]
  /// - `%s` : second [0-59]
  /// - `%WWW` : Weekday [e.g. SAT]
  /// - `%Www` : Weekday [e.g. Sat]
  /// - `%W` : Weekday [e.g. Saturday]
  /// - `%w` : Weekday number [0=sat, 1=sun, ..., 6=fri]
  String formatWesternDate(
    WesternDate date, {
    String? pattern,
    Language? language,
  }) {
    final currentLang = language ?? TranslationService.currentLanguage;
    final oldLang = TranslationService.currentLanguage;

    if (currentLang != oldLang) {
      TranslationService.setLanguage(currentLang);
    }

    try {
      final format = pattern ?? '%Www %y-%mm-%dd %HH:%nn:%ss';
      var result = format;
      final monthName = _getWesternMonthName(date.month);
      String abbreviatedMonthName = monthName;
      if (monthName.length > 3) {
        abbreviatedMonthName = monthName.substring(0, 3);
      }

      // Year with zero padding
      result = result.replaceAll('%yyyy', date.year.toString().padLeft(4, '0'));

      // Year (2 digits)
      final year2 = date.year % 100;
      result = result.replaceAll('%yy', year2.toString().padLeft(2, '0'));

      // Year
      result = result.replaceAll('%y', date.year.toString());

      // Month (abbreviated, uppercase)
      result = result.replaceAll('%MMM', abbreviatedMonthName.toUpperCase());

      // Month (abbreviated)
      result = result.replaceAll('%Mmm', abbreviatedMonthName);

      // Month with zero padding
      result = result.replaceAll('%mm', date.month.toString().padLeft(2, '0'));

      // Month name
      result = result.replaceAll('%M', _getWesternMonthName(date.month));

      // Month number
      result = result.replaceAll('%m', date.month.toString());

      // Day with zero padding
      result = result.replaceAll('%dd', date.day.toString().padLeft(2, '0'));

      // Day
      result = result.replaceAll('%d', date.day.toString());

      // Hour (24-hour with zero padding)
      result = result.replaceAll('%HH', date.hour.toString().padLeft(2, '0'));

      // Hour (24-hour)
      result = result.replaceAll('%H', date.hour.toString());

      // Hour (12-hour with zero padding)
      final hour12 = date.hour == 0
          ? 12
          : (date.hour > 12 ? date.hour - 12 : date.hour);
      result = result.replaceAll('%hh', hour12.toString().padLeft(2, '0'));

      // Hour (12-hour)
      result = result.replaceAll('%h', hour12.toString());

      // AM/PM (uppercase)
      result = result.replaceAll('%AA', date.hour < 12 ? 'AM' : 'PM');

      // am/pm (lowercase)
      result = result.replaceAll('%aa', date.hour < 12 ? 'am' : 'pm');

      // Minute with zero padding
      result = result.replaceAll('%nn', date.minute.toString().padLeft(2, '0'));

      // Minute
      result = result.replaceAll('%n', date.minute.toString());

      // Second with zero padding
      result = result.replaceAll('%ss', date.second.toString().padLeft(2, '0'));

      // Second
      result = result.replaceAll('%s', date.second.toString());

      // Weekday (abbreviated, uppercase)
      result = result.replaceAll(
        '%WWW',
        _getWeekdayName(date.weekday).substring(0, 3).toUpperCase(),
      );

      // Weekday (abbreviated)
      result = result.replaceAll(
        '%Www',
        _getWeekdayName(date.weekday).substring(0, 3),
      );

      // Weekday name
      result = result.replaceAll('%W', _getWeekdayName(date.weekday));

      // Weekday number
      result = result.replaceAll('%w', date.weekday.toString());

      return _translateNumbers(result);
    } finally {
      if (currentLang != oldLang) {
        TranslationService.setLanguage(oldLang);
      }
    }
  }

  /// Get localized month name
  String getMonthName(int monthIndex, int yearType) {
    const months = [
      'First Waso', // 0
      'Tagu', // 1
      'Kason', // 2
      'Nayon', // 3
      'Waso', // 4
      'Wagaung', // 5
      'Tawthalin', // 6
      'Thadingyut', // 7
      'Tazaungmon', // 8
      'Nadaw', // 9
      'Pyatho', // 10
      'Tabodwe', // 11
      'Tabaung', // 12
      'Late Tagu', // 13
      'Late Kason', // 14
    ];

    if (monthIndex >= 0 && monthIndex < months.length) {
      var monthName = TranslationService.translate(months[monthIndex]);

      // Handle special cases for watat years
      if (monthIndex == 4 && yearType > 0) {
        monthName = '${TranslationService.translate('Second')} $monthName';
      }

      return monthName;
    }
    return monthIndex.toString();
  }

  /// Get localized moon phase name
  String _getMoonPhaseName(int phaseIndex) {
    const phases = ['Waxing', 'Full Moon', 'Waning', 'New Moon'];

    if (phaseIndex >= 0 && phaseIndex < phases.length) {
      return TranslationService.translate(phases[phaseIndex]);
    }
    return phaseIndex.toString();
  }

  /// Get localized weekday name
  String _getWeekdayName(int weekdayIndex) {
    const weekdays = [
      'Saturday', // 0
      'Sunday', // 1
      'Monday', // 2
      'Tuesday', // 3
      'Wednesday', // 4
      'Thursday', // 5
      'Friday', // 6
    ];

    if (weekdayIndex >= 0 && weekdayIndex < weekdays.length) {
      return TranslationService.translate(weekdays[weekdayIndex]);
    }
    return weekdayIndex.toString();
  }

  /// Get localized year type name
  String _getYearTypeName(int yearTypeIndex) {
    const yearTypes = ['Common Year', 'Little Watat', 'Big Watat'];

    if (yearTypeIndex >= 0 && yearTypeIndex < yearTypes.length) {
      return TranslationService.translate(yearTypes[yearTypeIndex]);
    }
    return yearTypeIndex.toString();
  }

  /// Get localized year name from 12-year cycle
  String _getYearName(int year) {
    const yearNames = [
      'Hpusha', // 0
      'Magha', // 1
      'Phalguni', // 2
      'Chitra', // 3
      'Visakha', // 4
      'Jyeshtha', // 5
      'Ashadha', // 6
      'Sravana', // 7
      'Bhadrapaha', // 8
      'Asvini', // 9
      'Krittika', // 10
      'Mrigasiras', // 11
    ];

    final index = year % 12;
    return TranslationService.translate(yearNames[index]);
  }

  /// Get localized Western month name
  String _getWesternMonthName(int monthIndex) {
    const months = [
      '', // 0 (placeholder)
      'January', // 1
      'February', // 2
      'March', // 3
      'April', // 4
      'May', // 5
      'June', // 6
      'July', // 7
      'August', // 8
      'September', // 9
      'October', // 10
      'November', // 11
      'December', // 12
    ];

    if (monthIndex >= 1 && monthIndex < months.length) {
      return TranslationService.translate(months[monthIndex]);
    }
    return monthIndex.toString();
  }

  /// Translate numbers to the current language
  String _translateNumbers(String text) {
    final currentLang = TranslationService.currentLanguage;

    // Only translate numbers for Myanmar languages
    if (currentLang == Language.myanmar || currentLang == Language.zawgyi) {
      var result = text;
      for (int i = 0; i <= 9; i++) {
        result = result.replaceAll(
          i.toString(),
          TranslationService.translate(i.toString()),
        );
      }
      return result;
    }

    return text;
  }

  /// Format astro information
  String formatAstroInfo(AstroInfo astro, {Language? language}) {
    final currentLang = language ?? TranslationService.currentLanguage;
    final oldLang = TranslationService.currentLanguage;

    if (currentLang != oldLang) {
      TranslationService.setLanguage(currentLang);
    }

    try {
      final buffer = StringBuffer();

      // Astrological days
      if (astro.astrologicalDays.isNotEmpty) {
        buffer.write(
          astro.astrologicalDays
              .map((day) => TranslationService.translate(day))
              .join(', '),
        );
      }

      // Sabbath info
      if (astro.sabbath.isNotEmpty) {
        if (buffer.isNotEmpty) buffer.write(', ');
        buffer.write(TranslationService.translate(astro.sabbath));
      }

      // Other astro info
      final astroItems = [
        astro.yatyaza,
        astro.pyathada,
        ...astro.astrologicalDays,
      ].where((item) => item.isNotEmpty).toList();

      if (astroItems.isNotEmpty) {
        if (buffer.isNotEmpty) buffer.write(', ');
        buffer.write(
          astroItems
              .map((item) => TranslationService.translate(item))
              .join(', '),
        );
      }

      return buffer.toString();
    } finally {
      if (currentLang != oldLang) {
        TranslationService.setLanguage(oldLang);
      }
    }
  }

  /// Format holiday information
  String formatHolidayInfo(HolidayInfo holidays, {Language? language}) {
    final currentLang = language ?? TranslationService.currentLanguage;
    final oldLang = TranslationService.currentLanguage;

    if (currentLang != oldLang) {
      TranslationService.setLanguage(currentLang);
    }

    try {
      final allHolidays = holidays.allHolidays;
      if (allHolidays.isEmpty) return '';

      return allHolidays
          .map((holiday) => TranslationService.translate(holiday))
          .join(', ');
    } finally {
      if (currentLang != oldLang) {
        TranslationService.setLanguage(oldLang);
      }
    }
  }

  /// Format complete date information
  String formatCompleteDate(
    CompleteDate completeDate, {
    String? myanmarPattern,
    String? westernPattern,
    Language? language,
    bool includeAstro = false,
    bool includeHolidays = false,
  }) {
    final buffer = StringBuffer();

    // Myanmar date
    buffer.write(
      formatMyanmarDate(
        completeDate.myanmar,
        pattern: myanmarPattern,
        language: language,
      ),
    );

    // Western date
    buffer.write(' (');
    buffer.write(
      formatWesternDate(
        completeDate.western,
        pattern: westernPattern,
        language: language,
      ),
    );
    buffer.write(')');

    // Astro information
    if (includeAstro) {
      final astroText = formatAstroInfo(completeDate.astro, language: language);
      if (astroText.isNotEmpty) {
        buffer.write(' - ');
        buffer.write(astroText);
      }
    }

    // Holiday information
    if (includeHolidays) {
      final holidayText = formatHolidayInfo(
        completeDate.holidays,
        language: language,
      );
      if (holidayText.isNotEmpty) {
        buffer.write(' [');
        buffer.write(holidayText);
        buffer.write(']');
      }
    }

    return buffer.toString();
  }
}
