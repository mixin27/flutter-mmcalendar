import 'dart:math';

import 'package:flutter_mmcalendar/src/config/calendar_config.dart';
import 'package:flutter_mmcalendar/src/core/binary_search.dart';
import 'package:flutter_mmcalendar/src/core/constants.dart';
import 'package:flutter_mmcalendar/src/language/language_catalog.dart';
import 'package:flutter_mmcalendar/src/language/language_extension.dart';
import 'package:flutter_mmcalendar/src/models/astro.dart';
import 'package:flutter_mmcalendar/src/models/era.dart';
import 'package:flutter_mmcalendar/src/models/date.dart';
import 'package:flutter_mmcalendar/src/models/months.dart';

/// Core conversion logic for Myanmar dates.
class MyanmarDateCalculation {
  /// Convert Julian day to [MyanmarDate].
  static MyanmarDate fromJulianDay(double julianDay) {
    final int jdn = julianDay.round();

    // Calculate Myanmar year
    final int myYear =
        ((jdn - 0.5 - CalendarConstants.mo) / CalendarConstants.solarYear)
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

    int monthDay =
        dayCount - (29.544 * mmonth - 29.26).floor() - b * e + c * f * 30;
    mmonth += f * 3 - e * 4;

    // Month length
    int monthLength = 30 - mmonth % 2;
    if (mmonth == 3) monthLength += (yearInfo['myt']! / 2).toInt();

    // Moon phase calculation
    final moonPhase =
        ((monthDay + 1) / 16).floor() +
        (monthDay / 16).floor() +
        (monthDay / monthLength).floor();

    final fortnightDay = monthDay - 15 * (monthDay ~/ 16);
    final weekDay = (jdn + 2) % 7;

    return MyanmarDate(
      myear: myYear,
      yearType: yearInfo["myt"]!.toInt(),
      yearLength: yearLength,
      mmonth: mmonth,
      monthType: monthType,
      monthLength: monthLength,
      monthDay: monthDay,
      fortnightDay: fortnightDay,
      moonPhase: moonPhase,
      weekDay: weekDay,
      jd: julianDay,
    );
  }

  /// Private helper: Check Myanmar year dependencies
  static Map<String, double> _getMyanmarYearInfo(int myear) {
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

  /// Private helper: Check watat (intercalary month)
  static Map<String, double> _checkWatat(int myear) {
    int i = eraList.length - 1;
    while (i > 0) {
      if (myear >= eraList[i].begin) break;
      i--;
    }

    final Era era = eraList[i];
    final int nm = era.nm;
    final double wo = era.wo;

    double ta =
        (CalendarConstants.solarYear / 12 - CalendarConstants.lunarMonth) *
        (12 - nm);
    double ed =
        (CalendarConstants.solarYear * (myear + 3739)) %
        CalendarConstants.lunarMonth;
    if (ed < ta) ed += CalendarConstants.lunarMonth;

    double fm =
        (CalendarConstants.solarYear * myear +
                CalendarConstants.mo -
                ed +
                4.5 * CalendarConstants.lunarMonth +
                wo)
            .roundToDouble();
    double watat = 0, tw = 0;

    if (era.eid >= 2) {
      tw =
          CalendarConstants.lunarMonth -
          (CalendarConstants.solarYear / 12 - CalendarConstants.lunarMonth) *
              nm;
      if (ed >= tw) watat = 1;
    } else {
      watat = (myear * 7 + 2) % 19;
      if (watat < 0) watat += 19;
      watat = (watat / 12).floorToDouble();
    }

    i = search2DArray(myear, era.wte);
    if (i >= 0) watat = era.wte[i][1].toDouble();

    if (watat > 0) {
      i = search2DArray(myear, era.fme);
      if (i >= 0) fm += era.fme[i][1];
    }

    return {"fm": fm, "watat": watat};
  }

  /// Convert [MyanmarDate] to Julian day
  static double toJulian({
    required int year,
    required int month,
    required int monthType,
    required int moonPhase,
    required int fortnightDay,
  }) {
    final yo = _getMyanmarYearInfo(year);

    final b = (yo["myt"]! / 2).floorToDouble();
    final c = (yo["myt"] == 0) ? 1 : 0;

    int mml = 30 - month % 2;
    if (month == 3) mml += b.toInt();

    final m1 = moonPhase % 2;
    final m2 = (moonPhase / 2).floorToDouble();

    final md =
        m1 * (15 + m2 * (mml - 15)) + (1 - m1) * (fortnightDay + 15 * m2);
    month += 4 - ((month + 15) / 16).floor() * 4 + ((month + 12) / 16).floor();

    double dd =
        md +
        (29.544 * month - 29.26).floor() -
        c * ((month + 11) / 16).floor() * 30 +
        b * ((month + 12) / 16).floor();

    dd += monthType * (354 + (1 - c) * 30 + b);

    return dd + yo["tg1"]! - 1;
  }

  /// Convert [MyanmarDate] to Julian day
  static double myanmarDateToJulian(MyanmarDate myanmarDate) => toJulian(
    year: myanmarDate.myear,
    month: myanmarDate.mmonth,
    monthType: myanmarDate.monthType,
    moonPhase: myanmarDate.moonPhase,
    fortnightDay: myanmarDate.fortnightDay,
  );

  /// Time to fraction of day from 12 noon
  static double timeToDayFraction(double hour, double minute, double second) =>
      ((hour - 12) / 24) + (minute / 1440) + (second / 86400);

  /// Calculate Myanmar months list
  static MyanmarMonths getMyanmarMonths(int year, int month) {
    final j1 =
        (CalendarConstants.solarYear * year + CalendarConstants.mo)
            .roundToDouble() +
        1;
    final j2 = (CalendarConstants.solarYear * (year + 1) + CalendarConstants.mo)
        .roundToDouble();

    final MyanmarDate m1 = fromJulianDay(j1);
    final MyanmarDate m2 = fromJulianDay(j2);

    int si = m1.mmonth + 12 * m1.monthType;
    int ei = m2.mmonth + 12 * m2.monthType;

    si = si == 0 ? 4 : si;
    month = (month == 0 && m1.yearType == 0) ? 4 : month;
    month = (month != 0 && month < si) ? si : month;
    month = month > ei ? ei : month;

    final List<int> indices = [];
    final List<String> monthNames = [];
    int currentIndex = 0;

    for (int i = si; i <= ei; i++) {
      if (i == 4 && m1.yearType != 0) {
        indices.add(0);
        monthNames.add(emaList[0]);
        if (month == 0) currentIndex = 0;
      }

      indices.add(i);
      monthNames.add(
        (i == 4 && m1.yearType != 0 ? "Second " : "") + emaList[i],
      );

      if (i == month) currentIndex = i;
    }

    return MyanmarMonths(
      indices: indices,
      monthNameList: monthNames,
      currentIndex: currentIndex,
    );
  }
}

/// Converting logic for [WesternDate].
///
/// Core calculation and algorithm for Western dates.
class WesternDateCalculation {
  /// Resolve calendar type safely from [MmCalendarConfig] or global config.
  static int _resolveCalendarType([MmCalendarConfig? config]) =>
      (config ?? GlobalCalendarConfig().config).calendarType.number.clamp(0, 2);

  /// Resolve Gregorian start day (SG). Default: 14 Sep 1752.
  static double _resolveGregorianStart([double? sg]) =>
      sg ?? CalendarConstants.sg;

  /// Convert Julian Day Number to [WesternDate].
  static WesternDate julianToWestern({
    required double julianDay,
    MmCalendarConfig? config,
    double? sg,
  }) {
    final calType = _resolveCalendarType(config);
    final gregorianStart = _resolveGregorianStart(sg);

    double j, jf, y, m, d;

    if (calType == 2 || (calType == 0 && julianDay < gregorianStart)) {
      // Julian Calendar
      final b = (julianDay + 0.5).floorToDouble() + 1524;
      final c = ((b - 122.1) / 365.25).floorToDouble();
      final f = (365.25 * c).floorToDouble();
      final e = ((b - f) / 30.6001).floorToDouble();

      m = e > 13 ? e - 13 : e - 1;
      d = b - f - (30.6001 * e).floor();
      y = m < 3 ? c - 4715 : c - 4716;

      j = julianDay + 0.5;
      jf = j - j.floorToDouble();
    } else {
      // Gregorian Calendar
      j = (julianDay + 0.5).floorToDouble();
      jf = julianDay + 0.5 - j;

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

    // Fractional day → time
    jf *= 24;
    final h = jf.floorToDouble();
    jf = (jf - h) * 60;
    final n = jf.floorToDouble();
    final s = ((jf - n) * 60).roundToDouble();

    return WesternDate(
      year: y.toInt(),
      month: m.toInt(),
      day: d.toInt(),
      hour: h.toInt(),
      minute: n.toInt(),
      second: s.toInt(),
    );
  }

  /// Convert [WesternDate] to Julian day number.
  static double westernToJulian({
    required int year,
    required int month,
    required int day,
    MmCalendarConfig? config,
    double? sg,
  }) {
    final calType = _resolveCalendarType(config);
    final gregorianStart = _resolveGregorianStart(sg);

    final a = ((14 - month) / 12).floor();
    year += 4800 - a;
    month += 12 * a - 3;

    double jd =
        day +
        ((153 * month + 2) / 5).floorToDouble() +
        365 * year +
        (year / 4).floorToDouble();

    if (calType == 1) {
      jd = jd - (year / 100).floor() + (year / 400).floor() - 32045;
    } else if (calType == 2) {
      jd = jd - 32083;
    } else {
      jd = jd - (year / 100).floor() + (year / 400).floor() - 32045;
      if (jd < gregorianStart) {
        jd =
            day +
            ((153 * month + 2) / 5).floor() +
            365 * year +
            (year / 4).floor() -
            32083;
        if (jd > gregorianStart) jd = gregorianStart;
      }
    }
    return jd;
  }

  /// Convert [WesternDate] with time to Julian day number.
  static double westernToJulianWithTime({
    required int year,
    required int month,
    required int day,
    required int hour,
    required int minute,
    required int second,
    MmCalendarConfig? config,
    double? sg,
  }) {
    final fractionOfDay = timeToDay(
      hour.toDouble(),
      minute.toDouble(),
      second.toDouble(),
    );
    return westernToJulian(
          year: year,
          month: month,
          day: day,
          config: config,
          sg: sg,
        ) +
        fractionOfDay;
  }

  /// Convert [WesternDate] to Julian day number.
  static double toJulian({
    required WesternDate westernDate,
    MmCalendarConfig? config,
    double? sg,
  }) => westernToJulianWithTime(
    year: westernDate.year,
    month: westernDate.month,
    day: westernDate.day,
    hour: westernDate.hour,
    minute: westernDate.minute,
    second: westernDate.second,
    config: config,
    sg: sg,
  );

  /// Convert time → fraction of day (starting at 12 noon).
  static double timeToDay(double hour, double minute, double second) =>
      (hour - 12) / 24 + minute / 1440 + second / 86400;

  /// Get Julian day number for start of month.
  static int getJulianDayNumberOfStartOfMonth(
    int year,
    int month, {
    MmCalendarConfig? config,
  }) =>
      westernToJulian(year: year, month: month, day: 1, config: config).toInt();

  /// Get Julian day number for end of month.
  static int getJulianDayNumberOfEndOfMonth(
    int year,
    int month, {
    MmCalendarConfig? config,
  }) {
    final start = getJulianDayNumberOfStartOfMonth(year, month, config: config);
    return start + getLengthOfMonth(year, month, config: config) - 1;
  }

  /// Find the length of a month.
  static int getLengthOfMonth(int year, int month, {MmCalendarConfig? config}) {
    final calType = _resolveCalendarType(config);
    int days = 30 + (month + (month ~/ 8)) % 2;

    if (month == 2) {
      bool leap = calType == 1 || (calType == 0 && year > 1752)
          ? (year % 4 == 0 && year % 100 != 0) || (year % 400 == 0)
          : (year % 4 == 0);
      days += (leap ? 1 : 0) - 2;
    }

    // Handle September 1752 cutover
    if (year == 1752 && month == 9 && calType == 0) days = 19;

    return days;
  }
}

/// Utility class for calculating moon phase angles.
class MoonPhaseCalculation {
  MoonPhaseCalculation._(); // Prevent instantiation

  static const double _deg2rad = pi / 180.0;

  /// Normalize an angle in degrees to the range [0, 360).
  static double _normalizeAngle(double degree) {
    degree %= 360.0;
    if (degree < 0) degree += 360.0;
    return degree * _deg2rad;
  }

  /// Returns the phase angle for the given date, in **radians**.
  ///
  /// Formula from Meeus, Astronomical Algorithms, eqn. 46.4.
  static double getMoonPhaseAngle(DateTime date) {
    final tEpoch = DateTime.utc(2000, 1, 1, 12); // J2000.0 epoch
    final t = (decimalYears(date) - decimalYears(tEpoch)) / 100.0;
    final t2 = t * t;
    final t3 = t2 * t;
    final t4 = t3 * t;

    // Mean elongation of the Moon (D)
    final D = _normalizeAngle(
      297.8502042 +
          445267.1115168 * t -
          0.0016300 * t2 +
          t3 / 545868 +
          t4 / 113065000,
    );

    // Sun's mean anomaly (M)
    final M = _normalizeAngle(
      357.5291092 + 35999.0502909 * t - 0.0001536 * t2 + t3 / 24490000,
    );

    // Moon's mean anomaly (M')
    // ignore: non_constant_identifier_names
    final MPrime = _normalizeAngle(
      134.9634114 +
          477198.8676313 * t +
          0.0089970 * t2 -
          t3 / 3536000 +
          t4 / 14712000,
    );

    // Phase angle formula (radians)
    return _normalizeAngle(
      180 -
          (D / _deg2rad) -
          6.289 * sin(MPrime) +
          2.100 * sin(M) -
          1.274 * sin(2 * D - MPrime) -
          0.658 * sin(2 * D) -
          0.214 * sin(2 * MPrime) -
          0.110 * sin(D),
    );
  }

  /// Converts a date to decimal years.
  static double decimalYears(DateTime date) {
    return date.millisecondsSinceEpoch / (1000 * 60 * 60 * 24 * 365.242191);
  }

  /// Converts a date to decimal days since epoch.
  static double decimalDays(DateTime date) {
    return date.millisecondsSinceEpoch / (1000 * 60 * 60 * 24);
  }
}

/// Pure calculation algorithms for Myanmar astrology.
class AstroCalculation {
  /// Computes [Astro] values for given Myanmar month/day/year/week.
  static Astro getAstro({
    required int mmonth,
    required int monthLength,
    required int monthDay,
    required int weekDay,
    required int myear,
  }) {
    double d, m1, wd1, wd2;
    int sabbath, sabbatheve, yatyaza, pyathada, thamanyo, amyeittasote;
    int warameittugyi, warameittunge, yatpote, thamaphyu, nagapor, yatyotema;
    int mahayatkyan, shanyat, nagahle, mahabote, nakhat;
    List<int> wda = [];
    List<int> sya = [];

    if (mmonth <= 0) mmonth = 4;

    d = monthDay - 15 * (monthDay / 16.0).floorToDouble();

    // Sabbath calculation
    sabbath =
        ((monthDay == 8) ||
            (monthDay == 15) ||
            (monthDay == 23) ||
            (monthDay == monthLength))
        ? 1
        : 0;

    sabbatheve =
        ((monthDay == 7) ||
            (monthDay == 14) ||
            (monthDay == 22) ||
            (monthDay == (monthLength - 1)))
        ? 1
        : 0;

    // Yatyaza
    yatyaza = 0;
    m1 = mmonth % 4;
    wd1 = (m1 / 2.0).floorToDouble() + 4;
    wd2 = ((1 - (m1 / 2.0).floor()) + m1 % 2) * (1 + 2 * (m1 % 2));
    if (((weekDay - wd1).abs() < 0.0000001) ||
        ((weekDay - wd2).abs() < 0.0000001)) {
      yatyaza = 1;
    }

    // Pyathada
    pyathada = 0;
    wda = [1, 3, 3, 0, 2, 1, 2];
    if (m1 == wda[weekDay]) pyathada = 1;
    if ((m1 == 0) && (weekDay == 4)) pyathada = 2;

    // Thamanyo
    thamanyo = 0;
    m1 = mmonth - 1 - (mmonth / 9.0).floorToDouble();
    wd1 = (m1 * 2 - (m1 / 8.0).floor()) % 7;
    wd2 = (weekDay + 7 - wd1) % 7;
    if (wd2 <= 1) thamanyo = 1;

    // Amyeittasote
    amyeittasote = 0;
    wda = [5, 8, 3, 7, 2, 4, 1];
    if (d.toInt() == wda[weekDay]) amyeittasote = 1;

    // Warameittugyi
    warameittugyi = 0;
    wda = [7, 1, 4, 8, 9, 6, 3];
    if (d == wda[weekDay]) warameittugyi = 1;

    // Warameittunge
    warameittunge = 0;
    double wn = (weekDay + 6) % 7;
    if ((12 - d) == wn) warameittunge = 1;

    // Yatpote
    yatpote = 0;
    wda = [8, 1, 4, 6, 9, 8, 7];
    if (d == wda[weekDay]) yatpote = 1;

    // Thamaphyu
    thamaphyu = 0;
    wda = [1, 2, 6, 6, 5, 6, 7];
    if (d == wda[weekDay]) thamaphyu = 1;
    wda = [0, 1, 0, 0, 0, 3, 3];
    if (d == wda[weekDay]) thamaphyu = 1;
    if ((d == 4) && (weekDay == 5)) thamaphyu = 1;

    // Nagapor
    nagapor = 0;
    wda = [26, 21, 2, 10, 18, 2, 21];
    if (monthDay == wda[weekDay]) nagapor = 1;
    wda = [17, 19, 1, 0, 9, 0, 0];
    if (monthDay == wda[weekDay]) nagapor = 1;
    if (((monthDay == 2) && (weekDay == 1)) ||
        (((monthDay == 12) || (monthDay == 4) || (monthDay == 18)) &&
            (weekDay == 2))) {
      nagapor = 1;
    }

    // Yatyotema
    yatyotema = 0;
    m1 = (mmonth % 2 > 0) ? mmonth.toDouble() : ((mmonth + 9) % 12);
    m1 = (m1 + 4) % 12 + 1;
    if (d == m1) yatyotema = 1;

    // Mahayatkyan
    mahayatkyan = 0;
    m1 = (((mmonth % 12) / 2.0).floorToDouble() + 4) % 6 + 1;
    if (d == m1) mahayatkyan = 1;

    // Shanyat
    shanyat = 0;
    sya = [8, 8, 2, 2, 9, 3, 3, 5, 1, 4, 7, 4];
    if (d == sya[mmonth - 1]) shanyat = 1;

    // Nagahle
    nagahle = ((mmonth % 12) / 3.0).floor();

    // Mahabote
    mahabote = (myear - weekDay) % 7;

    // Nakhat
    nakhat = myear % 3;

    return Astro(
      sabbath: sabbath,
      sabbatheve: sabbatheve,
      yatyaza: yatyaza,
      pyathada: pyathada,
      thamanyo: thamanyo,
      amyeittasote: amyeittasote,
      warameittugyi: warameittugyi,
      warameittunge: warameittunge,
      yatpote: yatpote,
      thamaphyu: thamaphyu,
      nagapor: nagapor,
      yatyotema: yatyotema,
      mahayatkyan: mahayatkyan,
      shanyat: shanyat,
      nagahle: nagahle,
      mahabote: mahabote,
      nakhat: nakhat,
      yearName: myear % 12,
    );
  }
}

/// Holiday Calculation
class HolidaysCalculation {
  /// Get all holidays for a given Myanmar date.
  static List<String> getHolidays(MyanmarDate myanmarDate) {
    final langCode = GlobalCalendarConfig().config.language.toLanguageCode();

    final westernDate = WesternDateCalculation.julianToWestern(
      julianDay: myanmarDate.jd,
    );

    return [
      ..._englishHolidays(
        westernDate.year,
        westernDate.month,
        westernDate.day,
        langCode,
      ),
      ..._myanmarHolidays(
        myanmarDate.myear.toDouble(),
        myanmarDate.mmonth,
        myanmarDate.monthDay,
        myanmarDate.moonPhase,
        langCode,
      ),
      ..._thingyanHolidays(
        myanmarDate.jd,
        myanmarDate.myear.toDouble(),
        myanmarDate.monthType,
        langCode,
      ),
      ..._otherHolidays(myanmarDate.jd, langCode),
    ];
  }

  /// English holidays
  static List<String> _englishHolidays(
    int year,
    int month,
    int day,
    LanguageCode langCode,
  ) {
    final holidays = <String>[];

    if (year >= 2018 && month == 1 && day == 1) {
      holidays.add(LanguageCatalog.tr('New Year Day', langCode: langCode));
    }
    if (year >= 1948 && month == 1 && day == 4) {
      holidays.add(LanguageCatalog.tr('Independence Day', langCode: langCode));
    }
    if (year >= 1947 && month == 2 && day == 12) {
      holidays.add(LanguageCatalog.tr('Union Day', langCode: langCode));
    }
    if (year >= 1958 && month == 3 && day == 2) {
      holidays.add(LanguageCatalog.tr('Peasants Day', langCode: langCode));
    }
    if (year >= 1945 && month == 3 && day == 27) {
      holidays.add(LanguageCatalog.tr('Resistance Day', langCode: langCode));
    }
    if (year >= 1923 && month == 5 && day == 1) {
      holidays.add(LanguageCatalog.tr('Labour Day', langCode: langCode));
    }
    if (year >= 1947 && month == 7 && day == 19) {
      holidays.add(LanguageCatalog.tr('Martyrs Day', langCode: langCode));
    }
    if (year >= 1752 && month == 12 && day == 25) {
      holidays.add(LanguageCatalog.tr('Christmas Day', langCode: langCode));
    }
    if (year >= 2017 && (month == 12 && (day == 30 || day == 31))) {
      holidays.add(LanguageCatalog.tr('Holiday', langCode: langCode));
    }

    return holidays;
  }

  /// Myanmar holidays
  static List<String> _myanmarHolidays(
    double year,
    int month,
    int day,
    int moonPhase,
    LanguageCode langCode,
  ) {
    final holidays = <String>[];

    if (month == 2 && moonPhase == 1) {
      holidays.add(LanguageCatalog.tr('Buddha Day', langCode: langCode));
    }
    if (month == 4 && moonPhase == 1) {
      holidays.add(
        LanguageCatalog.tr('Start of Buddhist Lent', langCode: langCode),
      );
    }
    if (month == 7 && moonPhase == 1) {
      holidays.add(
        LanguageCatalog.tr('End of Buddhist Lent', langCode: langCode),
      );
    }
    if (year >= 1379 && month == 7 && (day == 14 || day == 16)) {
      holidays.add(LanguageCatalog.tr('Holiday', langCode: langCode));
    }
    if (month == 8 && moonPhase == 1) {
      holidays.add(LanguageCatalog.tr('Tazaungdaing', langCode: langCode));
    }
    if (year >= 1379 && month == 8 && day == 14) {
      holidays.add(LanguageCatalog.tr('Holiday', langCode: langCode));
    }
    if (year >= 1282 && month == 8 && day == 25) {
      holidays.add(LanguageCatalog.tr('National Day', langCode: langCode));
    }
    if (month == 10 && day == 1) {
      holidays.add(
        LanguageCatalog.tr('Karen New Year Day', langCode: langCode),
      );
    }
    if (month == 12 && moonPhase == 1) {
      holidays.add(LanguageCatalog.tr('Tabaung Pwe', langCode: langCode));
    }

    return holidays;
  }

  /// Thingyan holidays
  static List<String> _thingyanHolidays(
    double jd,
    double year,
    int monthType,
    LanguageCode langCode,
  ) {
    final holidays = <String>[];
    final startOfThingyan = 1100;
    final se3 = 1312;

    final ja =
        CalendarConstants.solarYear * (year + monthType) + CalendarConstants.mo;
    final jk = (year >= se3) ? ja - 2.169918982 : ja - 2.1675;

    final atn = ja.roundToDouble();
    final akn = jk.roundToDouble();

    if ((jd - (atn + 1)).abs() < 0.0000001) {
      holidays.add(
        LanguageCatalog.tr('Myanmar New Year Day', langCode: langCode),
      );
    }

    if ((year + monthType) >= startOfThingyan) {
      if (jd == atn) {
        holidays.add(LanguageCatalog.tr('Thingyan Atat', langCode: langCode));
      } else if ((jd > akn) && (jd < atn)) {
        holidays.add(LanguageCatalog.tr('Thingyan Akyat', langCode: langCode));
      } else if (jd == akn) {
        holidays.add(LanguageCatalog.tr('Thingyan Akya', langCode: langCode));
      } else if (jd == (akn - 1)) {
        holidays.add(LanguageCatalog.tr('Thingyan Akyo', langCode: langCode));
      } else if ((year + monthType) >= 1369 &&
          (year + monthType) < 1379 &&
          ((jd == (akn - 2)) || ((jd >= (atn + 2)) && (jd <= (akn + 7))))) {
        holidays.add(LanguageCatalog.tr('Holiday', langCode: langCode));
      }
    }

    return holidays;
  }

  /// Other holidays (Diwali, Eid)
  static List<String> _otherHolidays(double jd, LanguageCode langCode) {
    final holidays = <String>[];
    if (search1DArray(jd, ghDiwali) >= 0) {
      holidays.add(LanguageCatalog.tr('Diwali', langCode: langCode));
    }
    if (search1DArray(jd, ghEid) >= 0) {
      holidays.add(LanguageCatalog.tr('Eid', langCode: langCode));
    }
    return holidays;
  }

  /// English anniversary days
  static List<String> englishAnniversaryDays(double jd) {
    final holidays = <String>[];
    final langCode = GlobalCalendarConfig().config.language.toLanguageCode();

    final wd = WesternDateCalculation.julianToWestern(julianDay: jd);
    final doe = dateOfEaster(wd.year);

    if ((wd.year <= 2017) && (wd.month == 1 && wd.day == 1)) {
      holidays.add(LanguageCatalog.tr('New Year Day', langCode: langCode));
    }
    if ((wd.year >= 1915) && (wd.month == 2 && wd.day == 13)) {
      holidays.add(LanguageCatalog.tr('G. Aung San BD', langCode: langCode));
    }
    if ((wd.year >= 1969) && (wd.month == 2 && wd.day == 14)) {
      holidays.add(LanguageCatalog.tr('Valentines Day', langCode: langCode));
    }
    if ((wd.year >= 1970) && (wd.month == 4 && wd.day == 22)) {
      holidays.add(LanguageCatalog.tr('Earth Day', langCode: langCode));
    }
    if ((wd.year >= 1392) && (wd.month == 4 && wd.day == 1)) {
      holidays.add(LanguageCatalog.tr('April Fools Day', langCode: langCode));
    }
    if ((wd.year >= 1948) && (wd.month == 5 && wd.day == 8)) {
      holidays.add(LanguageCatalog.tr('Red Cross Day', langCode: langCode));
    }
    if ((wd.year >= 1994) && (wd.month == 10 && wd.day == 5)) {
      holidays.add(
        LanguageCatalog.tr('World Teachers Day', langCode: langCode),
      );
    }
    if ((wd.year >= 1947) && (wd.month == 10 && wd.day == 24)) {
      holidays.add(
        LanguageCatalog.tr('United Nations Day', langCode: langCode),
      );
    }
    if ((wd.year >= 1753) && (wd.month == 10 && wd.day == 31)) {
      holidays.add(LanguageCatalog.tr('Halloween', langCode: langCode));
    }
    if ((wd.year >= 1876) && (jd == doe)) {
      holidays.add(LanguageCatalog.tr('Easter', langCode: langCode));
    }
    if ((wd.year >= 1876) && (jd == (doe - 2))) {
      holidays.add(LanguageCatalog.tr('Good Friday', langCode: langCode));
    }
    if (search1DArray(jd, ghEid2) >= 0) {
      holidays.add(LanguageCatalog.tr('Eid', langCode: langCode));
    }
    if (search1DArray(jd, ghCNY) >= 0) {
      holidays.add(LanguageCatalog.tr('Chinese New Year', langCode: langCode));
    }

    return holidays;
  }

  /// Compute Easter date
  static double dateOfEaster(int year) {
    final a = year % 19;
    final b = (year / 100).floorToDouble();
    final c = year % 100;
    final d = (b / 4).floorToDouble();
    final e = b % 4;
    final f = ((b + 8) / 25).floorToDouble();
    final g = ((b - f + 1) / 3).floorToDouble();
    final h = (19 * a + b - d - g + 15) % 30;
    final i = (c / 4).floorToDouble();
    final k = c % 4;
    final l = (32 + 2 * e + 2 * i - h - k) % 7;
    final m = ((a + 11 * h + 22 * l) / 451).floorToDouble();
    final q = h + l - 7 * m + 114;
    final day = ((q % 31) + 1).toInt();
    final month = (q / 31).floor();

    return WesternDateCalculation.westernToJulian(
      year: year,
      month: month,
      day: day,
    );
  }

  /// Myanmar anniversary days
  static List<String> myanmarAnniversaryDays(
    double year,
    int month,
    int day,
    int moonPhase,
  ) {
    final holidays = <String>[];
    final langCode = GlobalCalendarConfig().config.language.toLanguageCode();

    if ((year >= 1309) && (month == 11 && day == 16)) {
      holidays.add(LanguageCatalog.tr('Mon National Day', langCode: langCode));
    }
    if ((month == 9 && day == 1)) {
      holidays.add(LanguageCatalog.tr('Shan New Year Day', langCode: langCode));
      if (year >= 1306) {
        holidays.add(LanguageCatalog.tr('Authors Day', langCode: langCode));
      }
    }
    if ((month == 3 && moonPhase == 1)) {
      holidays.add(LanguageCatalog.tr('Mahathamaya Day', langCode: langCode));
    }
    if ((month == 6 && moonPhase == 1)) {
      holidays.add(LanguageCatalog.tr('Garudhamma Day', langCode: langCode));
    }
    if ((year >= 1356 && month == 10 && moonPhase == 1)) {
      holidays.add(LanguageCatalog.tr('Mothers Day', langCode: langCode));
    }
    if ((year >= 1370 && month == 12 && moonPhase == 1)) {
      holidays.add(LanguageCatalog.tr('Fathers Day', langCode: langCode));
    }
    if ((month == 5 && moonPhase == 1)) {
      holidays.add(LanguageCatalog.tr('Metta Day', langCode: langCode));
    }
    if ((month == 5 && day == 10)) {
      holidays.add(LanguageCatalog.tr('Taungpyone Pwe', langCode: langCode));
    }
    if ((month == 5 && day == 23)) {
      holidays.add(LanguageCatalog.tr('Yadanagu Pwe', langCode: langCode));
    }

    return holidays;
  }

  /// Get all anniversaries for a given Myanmar date
  static List<String> getAnniversaries(MyanmarDate myanmarDate) {
    return [
      ...englishAnniversaryDays(myanmarDate.jd),
      ...myanmarAnniversaryDays(
        myanmarDate.myear.toDouble(),
        myanmarDate.mmonth,
        myanmarDate.monthDay,
        myanmarDate.moonPhase,
      ),
    ];
  }
}
