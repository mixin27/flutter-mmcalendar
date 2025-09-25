/// ------------------------------------------------------------
/// Astrological Information Calculation Core
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

import 'package:flutter_mmcalendar/src/models/astro_info.dart';
import 'package:flutter_mmcalendar/src/models/myanmar_date.dart';
import 'package:flutter_mmcalendar/src/utils/calendar_constants.dart';

/// Calculator for astrological information in Myanmar calendar
class AstroCalculator {
  /// Calculate astrological information for a Myanmar date
  AstroInfo calculate(MyanmarDate md) {
    final sabbath = _calculateSabbath(md.day, md.month, md.yearType);

    return AstroInfo(
      astrologicalDays: _calculateAstrologicalDays(md),
      sabbath: sabbath == 1
          ? 'Sabbath'
          : sabbath == 2
          ? 'Sabbath Eve'
          : '',
      yatyaza: _calculateYatyaza(md.month, md.weekday) ? 'Yatyaza' : '',
      pyathada: _calculatePyathada(md.month, md.weekday),
      nagahle: _calculateNagahle(md.month),
      mahabote: _calculateMahabote(md.year, md.weekday),
      nakhat: _calculateNakhat(md.year),
      yearName: _calculateYearName(md.year),
    );
  }

  /// Calculate month length
  int _calculateMonthLength(int month, int yearType) {
    var length = 30 - month % 2;
    if (month == 3) length += (yearType / 2).floor(); // Nayon in big watat
    return length;
  }

  /// Calculate sabbath day and sabbath eve
  ///
  /// Returns:
  /// - 0: normal day
  /// - 1: sabbath
  /// - 2: sabbath eve
  int _calculateSabbath(int day, int month, int yearType) {
    final monthLength = _calculateMonthLength(month, yearType);
    if (day == 8 || day == 15 || day == 23 || day == monthLength) return 1;
    if (day == 7 || day == 14 || day == 22 || day == monthLength - 1) return 2;
    return 0;
  }

  /// Calculate yatyaza (inauspicious day based on month and weekday)
  ///
  /// [month] - Myanmar month (1-14)
  /// [weekday] - Weekday (0=Saturday, 1=Sunday, ..., 6=Friday)
  ///
  /// Returns true if yatyaza day
  bool _calculateYatyaza(int month, int weekday) {
    final m1 = month % 4;
    final wd1 = (m1 / 2).floor() + 4;
    final wd2 = ((1 - (m1 / 2).floor()) + m1 % 2) * (1 + 2 * (m1 % 2));
    return weekday == wd1 || weekday == wd2;
  }

  /// Calculate pyathada (inauspicious day)
  ///
  /// Returns:
  /// - 0: empty string (not pyathada)
  /// - 1: pyathada
  /// - 2: afternoon pyathada
  String _calculatePyathada(int month, int weekday) {
    final m1 = month % 4;
    const weekdayArray = [1, 3, 3, 0, 2, 1, 2];

    if (m1 == 0 && weekday == 4) return 'Afternoon Pyathada';
    if (m1 == weekdayArray[weekday]) return 'Pyathada';
    return '';
  }

  /// Calculate Naga head direction
  String _calculateNagahle(int month) {
    if (month <= 0) month = 4; // First Waso is considered Waso
    const directions = ['West', 'North', 'East', 'South'];
    return directions[((month % 12) / 3).floor()];
  }

  /// Calculate mahabote
  String _calculateMahabote(int year, int weekday) {
    const mahabotes = [
      'Binga',
      'Atun',
      'Yaza',
      'Adipati',
      'Marana',
      'Thike',
      'Puti',
    ];
    return mahabotes[(year - weekday) % 7];
  }

  /// Calculate mahabote
  String _calculateYearName(int year) {
    return CalendarConstants.yearNames[year % 12];
  }

  /// Calculate nakhat
  String _calculateNakhat(int year) {
    const nakhats = ['Ogre', 'Elf', 'Human'];
    return nakhats[year % 3];
  }

  /// Calculate astrological days
  List<String> _calculateAstrologicalDays(MyanmarDate myanmarDate) {
    final md = myanmarDate;
    final days = <String>[];

    if (_calculateThamanyo(md.month, md.weekday)) days.add('Thamanyo');
    if (_calculateAmyeittasote(md.day, md.weekday)) days.add('Amyeittasote');
    if (_calculateWarameittugyi(md.day, md.weekday)) days.add('Warameittugyi');
    if (_calculateWarameittunge(md.day, md.weekday)) days.add('Warameittunge');
    if (_calculateYatpote(md.day, md.weekday)) days.add('Yatpote');
    if (_calculateThamaphyu(md.day, md.weekday)) days.add('Thamaphyu');
    if (_calculateNagapor(md.day, md.weekday)) days.add('Nagapor');
    if (_calculateYatyotema(md.month, md.day)) days.add('Yatyotema');
    if (_calculateMahayatkyan(md.month, md.day)) days.add('Mahayatkyan');
    if (_calculateShanyat(md.month, md.day)) days.add('Shanyat');

    return days;
  }

  // Individual astrological day calculations
  bool _calculateThamanyo(int month, int weekday) {
    var mmt = (month / 13).floor();
    month = month % 13 + mmt;
    if (month <= 0) month = 4;

    final m1 = month - 1 - (month / 9).floor();
    final wd1 = (m1 * 2 - (m1 / 8).floor()) % 7;
    final wd2 = (weekday + 7 - wd1) % 7;

    return wd2 <= 1;
  }

  bool _calculateAmyeittasote(int day, int weekday) {
    final fortnightDay = day - 15 * (day / 16).floor();
    const weekdayArray = [5, 8, 3, 7, 2, 4, 1];
    return fortnightDay == weekdayArray[weekday];
  }

  bool _calculateWarameittugyi(int day, int weekday) {
    final fortnightDay = day - 15 * (day / 16).floor();
    const weekdayArray = [7, 1, 4, 8, 9, 6, 3];
    return fortnightDay == weekdayArray[weekday];
  }

  bool _calculateWarameittunge(int day, int weekday) {
    final fortnightDay = day - 15 * (day / 16).floor();
    final wn = (weekday + 6) % 7;
    return (12 - fortnightDay) == wn;
  }

  bool _calculateYatpote(int day, int weekday) {
    final fortnightDay = day - 15 * (day / 16).floor();
    const weekdayArray = [8, 1, 4, 6, 9, 8, 7];
    return fortnightDay == weekdayArray[weekday];
  }

  bool _calculateThamaphyu(int day, int weekday) {
    final fortnightDay = day - 15 * (day / 16).floor();
    const weekdayArrayA = [1, 2, 6, 6, 5, 6, 7];
    const weekdayArrayB = [0, 1, 0, 0, 0, 3, 3];

    return fortnightDay == weekdayArrayA[weekday] ||
        fortnightDay == weekdayArrayB[weekday] ||
        (fortnightDay == 4 && weekday == 5);
  }

  bool _calculateNagapor(int day, int weekday) {
    const weekdayArrayA = [26, 21, 2, 10, 18, 2, 21];
    const weekdayArrayB = [17, 19, 1, 0, 9, 0, 0];

    return day == weekdayArrayA[weekday] ||
        day == weekdayArrayB[weekday] ||
        (day == 2 && weekday == 1) ||
        ((day == 12 || day == 4 || day == 18) && weekday == 2);
  }

  bool _calculateYatyotema(int month, int day) {
    var mmt = (month / 13).floor();
    month = month % 13 + mmt;
    if (month <= 0) month = 4;

    final fortnightDay = day - 15 * (day / 16).floor();
    final m1 = (month % 2 == 1) ? month : ((month + 9) % 12);
    final targetDay = (m1 + 4) % 12 + 1;

    return fortnightDay == targetDay;
  }

  bool _calculateMahayatkyan(int month, int day) {
    if (month <= 0) month = 4;
    final fortnightDay = day - 15 * (day / 16).floor();
    final targetDay = (((month % 12) / 2).floor() + 4) % 6 + 1;
    return fortnightDay == targetDay;
  }

  bool _calculateShanyat(int month, int day) {
    var mmt = (month / 13).floor();
    month = month % 13 + mmt;
    if (month <= 0) month = 4;

    final fortnightDay = day - 15 * (day / 16).floor();
    const shanyatArray = [8, 8, 2, 2, 9, 3, 3, 5, 1, 4, 7, 4];
    return fortnightDay == shanyatArray[month - 1];
  }
}
