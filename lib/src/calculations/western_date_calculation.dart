import '../config/mm_calendar_config.dart';
import '../models/models.dart';

/// Converting logic for [WesternDate].
///
/// Core Calculation and Algorithm for Western Date
class WesternDateCalculation {
  /// Convert `julian` to `western`.
  ///
  /// Julian date to Western date Credit4 Gregorian date: http://pmyers.pcug.org.au/General/JulianDates.htm
  /// Credit4 Julian Calendar: http://quasar.as.utexas.edu/BillInfo/JulianDatesG.html
  ///
  /// `julianDay` - Julian day
  ///
  /// `config` - [MmCalendarConfig]
  ///
  /// `sg` - Beginning of Gregorian calendar in JDN `Optional argument: (default=2361222)]`
  static WesternDate julianToWestern({
    required double julianDay,
    MmCalendarConfig? config,
    double sg = 0,
  }) {
    // ct=ct||0;
    int calType;
    if (config == null) {
      calType = MmCalendarConfig.defaultConfig().calendarType.number < 0
          ? 0
          : MmCalendarConfig.defaultConfig().calendarType.number;
    } else {
      calType = config.calendarType.number < 0 ? 0 : config.calendarType.number;
    }

    // SG= SG || 2361222;
    // Gregorian start in English calendar (1752/Sep/14)
    sg = sg <= 0 ? 2361222 : sg;

    double j, jf, y, m, d, h, n, s;

    if (calType == 2 || (calType == 0 && (julianDay < sg))) {
      double b, c, f, e;
      j = (julianDay + 0.5).floorToDouble();
      jf = julianDay + 0.5 - j;
      b = j + 1524;
      c = ((b - 122.1) / 365.25).floorToDouble();
      f = (365.25 * c).floorToDouble();
      e = ((b - f) / 30.6001).floorToDouble();
      m = (e > 13) ? (e - 13) : (e - 1);
      d = b - f - (30.6001 * e).floor();
      y = m < 3 ? (c - 4715) : (c - 4716);
    } else {
      j = (julianDay + 0.5).floorToDouble();
      jf = julianDay + 0.5 - j;
      j -= 1721119;
      y = ((4 * j - 1) / 146097.0).floorToDouble();
      j = 4 * j - 1 - 146097 * y;
      d = (j / 4).floorToDouble();
      j = ((4 * d + 3) / 1461.0).floorToDouble();
      d = 4 * d + 3 - 1461 * j;
      d = ((d + 4) / 4.0).floorToDouble();
      m = ((5 * d - 3) / 153.0).floorToDouble();
      d = 5 * d - 3 - 153 * m;
      d = ((d + 5) / 5.0).floorToDouble();
      y = 100 * y + j;
      if (m < 10) {
        m += 3;
      } else {
        m -= 9;
        y = y + 1;
      }
    }

    jf *= 24;
    h = (jf).floorToDouble();
    jf = (jf - h) * 60;
    n = (jf).floorToDouble();
    s = ((jf - n) * 60).roundToDouble();

    return WesternDate(
      year: y.toInt(),
      month: m.toInt(),
      day: d.toInt(),
      hour: h.toInt(),
      minute: m.toInt(),
      second: s.toInt(),
    );
  }

  /// Convert `western` to `julian`.
  ///
  /// Western date to Julian day number. Credit4 Gregorian 2 JD:
  /// http://www.cs.utsa.edu/~cs1063/projects/Spring2011/Project1/jdn-explanation.html
  static double westernToJulian({
    required int year,
    required int month,
    required int day,
    MmCalendarConfig? config,
    double sg = 0,
  }) {
    // ct=ct||0;
    int calType;
    if (config == null) {
      calType = MmCalendarConfig.defaultConfig().calendarType.number < 0
          ? 0
          : MmCalendarConfig.defaultConfig().calendarType.number;
    } else {
      calType = config.calendarType.number < 0 ? 0 : config.calendarType.number;
    }

    // SG= SG || 2361222;
    // Gregorian start in English calendar (1752/Sep/14)
    sg = sg <= 0 ? 2361222 : sg;

    int a = ((14 - month) / 12.0).floor();
    year = year + 4800 - a;
    month = month + (12 * a) - 3;

    double jd = day +
        ((153 * month + 2) / 5.0).floorToDouble() +
        (365 * year) +
        (year / 4.0).floor();

    if (calType == 1) {
      jd = jd - (year / 100).floor() + (year / 400).floor() - 32045;
    } else if (calType == 2) {
      jd = jd - 32083;
    } else {
      jd = jd - (year / 100).floor() + (year / 400).floor() - 32045;
      if (jd < sg) {
        jd = day +
            ((153 * month + 2) / 5).floor() +
            (365 * year) +
            (year / 4).floor() -
            32083;
        if (jd > sg) {
          jd = sg;
        }
      }
    }

    return jd;
  }

  /// Convert `western` to `julian`.
  ///
  /// Western date to Julian day number. Credit4 Gregorian 2 JD:
  /// http://www.cs.utsa.edu/~cs1063/projects/Spring2011/Project1/jdn-explanation.html
  static double westernToJulianWithTime({
    required int year,
    required int month,
    required int day,
    required int hour,
    required int minute,
    required int second,
    MmCalendarConfig? config,
    double sg = 0,
  }) {
    double fractionOfDay = timeToDay(
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

  /// Convert `western` to `julian`.
  ///
  /// Western date to Julian day number. Credit4 Gregorian 2 JD:
  /// http://www.cs.utsa.edu/~cs1063/projects/Spring2011/Project1/jdn-explanation.html
  static double toJulian({
    required WesternDate westernDate,
    MmCalendarConfig? config,
    double sg = 0,
  }) {
    return westernToJulianWithTime(
      year: westernDate.year,
      month: westernDate.month,
      day: westernDate.day,
      hour: westernDate.hour,
      minute: westernDate.minute,
      second: westernDate.second,
      config: config,
      sg: sg,
    );
  }

  /// Time to Fraction of day starting from 12 noon
  static double timeToDay(double hour, double minute, double second) =>
      ((hour - 12) / 24 + minute / 1440 + second / 86400);

  /// Get `julianDay` of start of the month.
  static int getJulianDayNumberOfStartOfMonth(
    int year,
    int month, {
    MmCalendarConfig? config,
  }) {
    return westernToJulian(
      year: year,
      month: month,
      day: 1,
      config: config,
      sg: 0,
    ).toInt();
  }

  /// Get `julianDay` of end of the month.
  static int getJulianDayNumberOfEndOfMonth(
    int year,
    int month, {
    MmCalendarConfig? config,
  }) {
    final julianStart = getJulianDayNumberOfStartOfMonth(
      year,
      month,
      config: config,
    );
    int eml = getLengthOfMonth(
      year,
      month,
      config: config,
    );

    return julianStart + eml - 1;
  }

  /// Find the length of a month (emLen)
  static int getLengthOfMonth(
    int year,
    int month, {
    MmCalendarConfig? config,
  }) {
    int calType;
    if (config == null) {
      calType = MmCalendarConfig.defaultConfig().calendarType.number < 0
          ? 0
          : MmCalendarConfig.defaultConfig().calendarType.number;
    } else {
      calType = config.calendarType.number < 0 ? 0 : config.calendarType.number;
    }

    int leap = 0;
    // length of the current month
    int mLen = 30 + (month + (month / 8.0).floor()) % 2;

    // if february
    if (month == 2) {
      if (calType == 1 || (calType == 0 && year > 1752)) {
        if ((year % 4 == 0 && year % 100 != 0) || year % 400 == 0) {
          leap = 1;
        }
      } else if (year % 4 == 0) {
        leap = 1;
      }
      mLen += leap - 2;
    }

    if (year == 1752 && month == 9 && calType == 0) {
      mLen = 19;
    }

    return mLen;
  }
}
