import 'package:flutter_mmcalendar/flutter_mmcalendar.dart';
import 'package:flutter_mmcalendar/src/old/western/western_date.dart';
import 'package:flutter_mmcalendar/src/old/western/western_date_converter.dart';
import 'package:flutter_mmcalendar/src/old/western/western_date_kernel.dart';

class HolidayCalculator {
  /// Eid 2
  static const List<int> ghEid2 = [2456936, 2457290, 2457644, 2457998, 2458353];

  /// Chinese new year ref
  static const List<int> ghCNY = [
    2456689,
    2456690,
    2457073,
    2457074,
    2457427,
    2457428,
    2457782,
    2457783,
    2458166,
    2458167
  ];

  /// Diwali
  static const List<int> ghDiwali = [
    2456599,
    2456953,
    2457337,
    2457691,
    2458045,
    2458429
  ];

  /// Eid
  static const List<int> ghEid = [
    2456513,
    2456867,
    2457221,
    2457576,
    2457930,
    2458285
  ];

  /// Check for English Holiday
  ///
  /// `gy` - Year
  ///
  /// `gm` - Month `Jan=1,..., Dec=12`
  ///
  /// `gd` - Day `0-31`
  static List<String> englishHoliday(int gy, int gm, int gd) {
    final List<String> holiday = List.empty();
    if ((gy >= 2018) && (gm == 1) && (gd == 1)) {
      holiday.add("New Year Day");
    } else if ((gy >= 1948) && (gm == 1) && (gd == 4)) {
      holiday.add("Independence Day");
    } else if ((gy >= 1947) && (gm == 2) && (gd == 12)) {
      holiday.add("Union Day");
    } else if ((gy >= 1958) && (gm == 3) && (gd == 2)) {
      holiday.add("Peasants Day");
    } else if ((gy >= 1945) && (gm == 3) && (gd == 27)) {
      holiday.add("Resistance Day");
    } else if ((gy >= 1923) && (gm == 5) && (gd == 1)) {
      holiday.add("Labour Day");
    } else if ((gy >= 1947) && (gm == 7) && (gd == 19)) {
      holiday.add("Martyrs Day");
    } else if ((gm == 12) && (gd == 25)) {
      holiday.add("Christmas Day");
    } else if ((gy == 2017) && (gm == 12) && (gd == 30)) {
      holiday.add("Holiday");
    } else if ((gy >= 2017) && (gm == 12) && (gd == 31)) {
      holiday.add("Holiday");
    }

    return holiday;
  }

  /// Check for Myanmar Holiday
  ///
  /// `myear` - Myanmar year
  ///
  /// `mmonth` - Myanmar month `Tagu=1,..., Tabaung=12`
  ///
  /// `monthDay` - Myanmar month day `0-30`
  ///
  /// `moonPhase` - Moon phase `0=waxing, 1=full moon, 2=waning, 3=new moon`
  static List<String> myanmarHoliday(
      double myear, int mmonth, int monthDay, int moonPhase) {
    final List<String> holiday = List.empty();

    if ((mmonth == 2) && (moonPhase == 1)) {
      holiday.add("Buddha Day");
    } // Vesak day
    else if ((mmonth == 4) && (moonPhase == 1)) {
      holiday.add("Start of Buddhist Lent");
    } // Warso day
    else if ((mmonth == 7) && (moonPhase == 1)) {
      holiday.add("End of Buddhist Lent");
    } else if ((myear >= 1379) &&
        (mmonth == 7) &&
        (monthDay == 14 || monthDay == 16)) {
      holiday.add("Holiday");
    } else if ((mmonth == 8) && (moonPhase == 1)) {
      holiday.add("Tazaungdaing");
    } else if ((myear >= 1379) && (mmonth == 8) && (monthDay == 14)) {
      holiday.add("Holiday");
    } else if ((myear >= 1282) && (mmonth == 8) && (monthDay == 25)) {
      holiday.add("National Day");
    } else if ((mmonth == 10) && (monthDay == 1)) {
      holiday.add("Karen New Year Day");
    } else if ((mmonth == 12) && (moonPhase == 1)) {
      holiday.add("Tabaung Pwe");
    }

    return holiday;
  }

  /// Thingyan holiday
  static List<String> thingyan(double jdn, double myear, int monthType) {
    // start of Thingyan
    int startOfThingyan = 1100;

    final List<String> holiday = List.empty();

    // double atat;
    double akn, atn;
    // start of third era
    int se3 = 1312;

    double ja = Constants.solarYear * (myear + monthType) + Constants.mo;
    double jk;

    if (myear >= se3) {
      jk = ja - 2.169918982;
    } else {
      jk = ja - 2.1675;
    }

    akn = (jk).roundToDouble();
    atn = (ja).roundToDouble();

    // if (jdn == (atn + 1))
    if ((jdn - (atn + 1)).abs() < 0.0000001) {
      holiday.add("Myanmar New Year Day");
    }

    if ((myear + monthType) >= startOfThingyan) {
      if (jdn == atn) {
        holiday.add("Thingyan Atat");
      } else if ((jdn > akn) && (jdn < atn)) {
        holiday.add("Thingyan Akyat");
      } else if (jdn == akn) {
        holiday.add("Thingyan Akya");
      } else if (jdn == (akn - 1)) {
        holiday.add("Thingyan Akyo");
      } else if (((myear + monthType) >= 1369) &&
          ((myear + monthType) < 1379) &&
          ((jdn == (akn - 2)) || ((jdn >= (atn + 2)) && (jdn <= (akn + 7))))) {
        holiday.add("Holiday");
      }
    }

    return holiday;
  }

  /// Other holidays (ohol) Diwali or Eid
  static List<String> otherHolidays(double jd) {
    final List<String> holiday = List.empty();

    if (BinarySearchUtils.searchOf1DArray(jd, ghDiwali) >= 0) {
      holiday.add("Diwali");
    }
    if (BinarySearchUtils.searchOf1DArray(jd, ghEid) >= 0) {
      holiday.add("Eid");
    }

    return holiday;
  }

  /// Anniversary day
  static List<String> ecd(double jd, CalendarType calendarType) {
    final List<String> holiday = List.empty();

    // WesternDate wd = WesternDateConverter.convert(jd, calendarType);
    // double doe = DoE(wd.getYear());

    // if ((wd.getYear() <= 2017) && (wd.getMonth() == 1) && (wd.getDay() == 1)) {
    // 	holiday.add( "New Year Day");
    // } else if ((wd.getYear() >= 1915) && (wd.getMonth() == 2) && (wd.getDay() == 13)) {
    // 	holiday.add("G. Aung San BD");
    // } else if ((wd.getYear() >= 1969) && (wd.getMonth() == 2) && (wd.getDay() == 14)) {
    // 	holiday.add("Valentines Day");
    // } else if ((wd.getYear() >= 1970) && (wd.getMonth() == 4) && (wd.getDay() == 22)) {
    // 	holiday.add("Earth Day");
    // } else if ((wd.getYear() >= 1392) && (wd.getMonth() == 4) && (wd.getDay() == 1)) {
    // 	holiday.add("April Fools Day");
    // } else if ((wd.getYear() >= 1948) && (wd.getMonth() == 5) && (wd.getDay() == 8)) {
    // 	holiday.add("Red Cross Day");
    // } else if ((wd.getYear() >= 1994) && (wd.getMonth() == 10) && (wd.getDay() == 5)) {
    // 	holiday.add("World Teachers Day");
    // } else if ((wd.getYear() >= 1947) && (wd.getMonth() == 10) && (wd.getDay() == 24)) {
    // 	holiday.add("United Nations Day");
    // } else if ((wd.getYear() >= 1753) && (wd.getMonth() == 10) && (wd.getDay() == 31)) {
    // 	holiday.add("Halloween");
    // }

    // if ((wd.getYear() >= 1876) && (jd == doe)) {
    // 	holiday.add("Easter");
    // } else if ((wd.getYear() >= 1876) && (jd == (doe - 2))) {
    // 	holiday.add("Good Friday");
    // } else if (BinarySearchUtil.search(jd, ghEid2) >= 0) {
    // 	holiday.add("Eid");
    // }
    // if (BinarySearchUtil.search(jd, ghCNY) >= 0) {
    // 	holiday.add("Chinese New Year");
    // }

    return holiday;
  }

  /// Date of Easter using "Meeus/Jones/Butcher" algorithm Reference: Peter
  /// Duffett-Smith, Jonathan Zwart',
  /// "Practical Astronomy with your Calculator or Spreadsheet," 4th Etd,
  /// Cambridge university press, 2011. Page-4.
  static double doe(int year) {
    double a = year % 19;
    double b = (year / 100).floorToDouble();
    double c = year % 100;
    double d = (b / 4).floorToDouble();
    double e = b % 4;
    double f = ((b + 8) / 25).floorToDouble();
    double g = ((b - f + 1) / 3).floorToDouble();
    double h = (19 * a + b - d - g + 15) % 30;
    double i = (c / 4).floorToDouble();
    double k = c % 4;
    double l = (32 + 2 * e + 2 * i - h - k) % 7;
    double m = ((a + 11 * h + 22 * l) / 451).floorToDouble();
    double q = h + l - 7 * m + 114;
    int day = ((q % 31) + 1).toInt();
    int month = (q / 31).floor();
    // this is for Gregorian
    return WesternDateKernel.w2j(year, month, day, 1, 0);
  }

  /// Myanmar Anniversary day
  static List<String> mcd(
      double myear, int mmonth, int monthDay, int moonPhase) {
    final List<String> holiday = List.empty();

    if ((myear >= 1309) && (mmonth == 11) && (monthDay == 16)) {
      holiday.add("Mon National Day");
    } // the ancient founding of Hanthawady
    else if ((mmonth == 9) && (monthDay == 1)) {
      holiday.add("Shan New Year Day");
      if (myear >= 1306) {
        holiday.add("Authors Day");
      }
    } // Nadaw waxing moon 1
    else if ((mmonth == 3) && (moonPhase == 1)) {
      holiday.add("Mahathamaya Day");
    } // Nayon full moon
    else if ((mmonth == 6) && (moonPhase == 1)) {
      holiday.add("Garudhamma Day");
    } // Tawthalin full moon
    else if ((myear >= 1356) && (mmonth == 10) && (moonPhase == 1)) {
      holiday.add("Mothers Day");
    } // Pyatho full moon
    else if ((myear >= 1370) && (mmonth == 12) && (moonPhase == 1)) {
      holiday.add("Fathers Day");
    } // Tabaung full moon
    else if ((mmonth == 5) && (moonPhase == 1)) {
      holiday.add("Metta Day");
      // if(my>=1324) {hs[h++]="Mon Revolution Day";}//Mon Revolution day
    } // Waguang full moon
    else if ((mmonth == 5) && (monthDay == 10)) {
      holiday.add("Taungpyone Pwe");
    } // Taung Pyone Pwe
    else if ((mmonth == 5) && (monthDay == 23)) {
      holiday.add("Yadanagu Pwe");
    } // Yadanagu Pwe

    return holiday;
  }

  static List<String> getHoliday(MyanmarDate myanmarDate) {
    return getHolidayByCalendarType(myanmarDate, Config.instance.calendarType);
  }

  static List<String> getHolidayByCalendarType(
      MyanmarDate myanmarDate, CalendarType calendarType) {
    WesternDate westernDate =
        WesternDateConverter.convertByJulianDayAndCalendarType(
            myanmarDate.jd, calendarType);
    // Office Off
    List<String> hde =
        englishHoliday(westernDate.year, westernDate.month, westernDate.day);
    List<String> hdm = myanmarHoliday(myanmarDate.myear.toDouble(),
        myanmarDate.mmonth, myanmarDate.monthDay, myanmarDate.moonPhase);
    List<String> hdt = thingyan(
        myanmarDate.jd, myanmarDate.myear.toDouble(), myanmarDate.monthType);
    List<String> hdo = otherHolidays(myanmarDate.jd); // Diwali Eid

    final List<String> holiday = List.empty();

    holiday.addAll(hde);
    holiday.addAll(hdm);
    holiday.addAll(hdt);
    holiday.addAll(hdo);

    return holiday;
  }

  static bool isHoliday(MyanmarDate myanmarDate) =>
      getHoliday(myanmarDate).isNotEmpty;

  static List<String> getAnniversary(MyanmarDate myanmarDate) =>
      getAnniversaryByCalendarType(myanmarDate, Config.instance.calendarType);

  static List<String> getAnniversaryByCalendarType(
    MyanmarDate myanmarDate,
    CalendarType calendarType,
  ) {
    List<String> ecdVal = ecd(myanmarDate.jd, calendarType); // anniversary day
    List<String> mcdVal = mcd(
      myanmarDate.myear.toDouble(),
      myanmarDate.mmonth,
      myanmarDate.monthDay,
      myanmarDate.moonPhase,
    );

    final List<String> holiday = List.empty();

    holiday.addAll(ecdVal);
    holiday.addAll(mcdVal);

    return holiday;
  }
}
