import 'package:flutter_mmcalendar/flutter_mmcalendar.dart';
import 'package:flutter_mmcalendar/src/western/western_date.dart';

class WesternDateKernel {
  // static WesternDate j2w(double julianDate, CalendarType calendarType) {}

  /// Julian date to Western date Credit4 Gregorian date:
  /// http://pmyers.pcug.org.au/General/JulianDates.htm
  /// Credit4 Julian Calendar: http://quasar.as.utexas.edu/BillInfo/JulianDatesG.html
  ///
  /// `sg` - Beginning of Gregorian calendar in JDN `Optional argument: (default=2361222)]`
  static WesternDate j2w(double jd, int calType, double sg) {
    // ct=ct||0;
    calType = calType < 0 ? 0 : calType;

    // SG= SG || 2361222;
    // Gregorian start in English calendar (1752/Sep/14)
    sg = sg <= 0 ? 2361222 : sg;

    double j, jf, y, m, d, h, n, s;

    if (calType == 2 || (calType == 0 && (jd < sg))) {
      double b, c, f, e;
      j = (jd + 0.5).floorToDouble();
      jf = jd + 0.5 - j;
      b = j + 1524;
      c = ((b - 122.1) / 365.25).floorToDouble();
      f = (365.25 * c).floorToDouble();
      e = ((b - f) / 30.6001).floorToDouble();
      m = (e > 13) ? (e - 13) : (e - 1);
      d = b - f - (30.6001 * e).floor();
      y = m < 3 ? (c - 4715) : (c - 4716);
    } else {
      j = (jd + 0.5).floorToDouble();
      jf = jd + 0.5 - j;
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

  /// Julian date to Western date Credit4 Gregorian date:
  /// http://pmyers.pcug.org.au/General/JulianDates.htm
  /// Credit4 Julian Calendar: http://quasar.as.utexas.edu/BillInfo/JulianDatesG.html
  static WesternDate j2wByJulianDateAndCalendarType(
      double jd, CalendarType calendarType) {
    return j2w(jd, calendarType.getNumber(), 0);
  }

  /// Western date to Julian day number. Credit4 Gregorian 2 JD:
  /// http://www.cs.utsa.edu/~cs1063/projects/Spring2011/Project1/jdn-explanation.html
  ///
  /// `sg` - Beginning of Gregorian calendar in JDN `Optional argument: (default=2361222)]`
  static double w2j(int year, int month, int day, int calType, double sg) {
    // ct=ct||0;
    calType = calType < 0 ? 0 : calType;

    // SG= SG || 2361222;
    // Gregorian start in English calendar (1752/Sep/14)
    sg = sg <= 0 ? 2361222 : sg;

    int a = ((14 - month) / 12.0).floor();
    year = year + 4800 - a;
    month = month + (12 * a) - 3;

    double jd = day +
        ((153 * month + 2) / 5.0).floor() +
        (365 * year) +
        (year / 4.0).floorToDouble();

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

  /// Western date to Julian day number. Credit4 Gregorian 2 JD:
  /// http://www.cs.utsa.edu/~cs1063/projects/Spring2011/Project1/jdn-explanation.html
  static double w2jByYMDTSG(
      int year, int month, int day, CalendarType calendarType, double sg) {
    return w2j(year, month, day, calendarType.number, sg);
  }

  /// Western date to Julian day number. Credit4 Gregorian 2 JD:
  /// http://www.cs.utsa.edu/~cs1063/projects/Spring2011/Project1/jdn-explanation.html
  static double w2jByYMDHMSTSG(int year, int month, int day, int hour,
      int minute, int second, CalendarType calendarType, double sg) {
    double fractionOfDay =
        t2d(hour.toDouble(), minute.toDouble(), second.toDouble());
    return w2j(year, month, day, calendarType.number, sg) + fractionOfDay;
  }

  /// Time to Fraction of day starting from 12 noon
  static double t2d(double h, double n, double s) =>
      ((h - 12) / 24 + n / 1440 + s / 86400);

  /// Western date to Julian day number. Credit4 Gregorian 2 JD:
  /// http://www.cs.utsa.edu/~cs1063/projects/Spring2011/Project1/jdn-explanation.html
  static double w2jByWesternDate(
      WesternDate westernDate, CalendarType calendarType, double sg) {
    return w2jByYMDHMSTSG(
      westernDate.year,
      westernDate.month,
      westernDate.day,
      westernDate.hour,
      westernDate.minute,
      westernDate.second,
      calendarType,
      sg,
    );
  }

  /// The month according to calendar type
  static int getJulianDayNumberOfStartOfMonth(int year, int month) {
    return w2j(
      year.toInt(),
      month.toInt(),
      1,
      Config.instance.calendarType.number,
      0,
    ).toInt();
  }

  /// Find the length of a month (emLen)
  static int getLengthOfMonth(int year, int month, int calendarType) {
    int leap = 0;
    // length of the current month
    int mLen = (30 + (month + (month / 8.0).floor()) % 2);

    // if february
    if (month == 2) {
      if (calendarType == 1 || (calendarType == 0 && year > 1752)) {
        if ((year % 4 == 0 && year % 100 != 0) || year % 400 == 0) {
          leap = 1;
        }
      } else if (year % 4 == 0) {
        leap = 1;
      }

      mLen += leap - 2;
    }

    if (year == 1752 && month == 9 && calendarType == 0) {
      mLen = 19;
    }

    return mLen;
  }

  static int getJulianDayNumberOfEndOfMonth(int year, int month) {
    int js = getJulianDayNumberOfStartOfMonth(year, month);
    int eml =
        getLengthOfMonth(year, month, Config.instance.calendarType.number);
    return js + eml - 1;
  }
}
