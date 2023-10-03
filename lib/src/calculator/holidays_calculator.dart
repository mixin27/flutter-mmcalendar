import 'package:flutter_mmcalendar/flutter_mmcalendar.dart';

/// Holiday Calculator
class HolidaysCalculator {
  /// Get all holidays.
  static List<String> getHolidays(
    MyanmarDate myanmarDate, {
    CalendarType? calendarType,
  }) {
    // WesternDate westernDate = WesternDateConverter.convert(myanmarDate.jd, calendarType);
    WesternDate westernDate = WesternDateConverter.fromMyanmarDate(
      myanmarDate,
      calendarType: calendarType,
    );

    List<String> holiday = List.empty(growable: true);

    // Office Off
    List<String> hde = englishHolidays(
      westernDate.year,
      westernDate.month,
      westernDate.day,
    );
    holiday.addAll(hde);

    List<String> hdm = myanmarHolidays(
      myanmarDate.myear.toDouble(),
      myanmarDate.mmonth,
      myanmarDate.monthDay,
      myanmarDate.moonPhase,
    );
    holiday.addAll(hdm);

    List<String> hdt = thingyanHolidays(
      myanmarDate.jd,
      myanmarDate.myear.toDouble(),
      myanmarDate.monthType,
    );
    holiday.addAll(hdt);

    List<String> hdo = otherHolidays(myanmarDate.jd); // Diwali Eid
    holiday.addAll(hdo);

    return holiday;
  }

  /// Check for English Holiday
  ///
  /// `gy` - Gregorian year
  ///
  /// `gm` - Gregorian Month `Jan=1,..., Dec=12`
  ///
  /// `gd` - Gregorian Day `0-31`
  static List<String> englishHolidays(int gy, int gm, int gd) {
    List<String> holiday = List.empty(growable: true);

    if (gy >= 2018 && gm == 1 && gd == 1) {
      holiday.add("New Year's Day");
    } else if (gy >= 1948 && gm == 1 && gd == 4) {
      holiday.add("Independence Day");
    } else if (gy >= 1947 && gm == 2 && gd == 12) {
      holiday.add("Union Day");
    } else if (gy >= 1958 && gm == 3 && gd == 2) {
      holiday.add("Peasants' Day");
    } else if (gy >= 1945 && gm == 3 && gd == 27) {
      holiday.add("Resistance Day");
    } else if (gy >= 1923 && gm == 5 && gd == 1) {
      holiday.add("Labour Day");
    } else if (gy >= 1947 && gm == 7 && gd == 19) {
      holiday.add("Martyrs' Day");
    } else if (gy >= 1752 && gm == 12 && gd == 25) {
      holiday.add("Christmas Day");
    } else if (gy == 2017 && gm == 12 && gd == 30) {
      holiday.add("Holiday");
    } else if (gy >= 2017 && gm == 12 && gd == 31) {
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
  static List<String> myanmarHolidays(
    double myear,
    int mmonth,
    int monthDay,
    int moonPhase,
  ) {
    List<String> holiday = List.empty(growable: true);

    if (mmonth == 2 && moonPhase == 1) {
      holiday.add("Buddha Day");
    } //Vesak day
    else if (mmonth == 4 && moonPhase == 1) {
      holiday.add("Start of Buddhist Lent");
    } //Warso day
    else if (mmonth == 7 && moonPhase == 1) {
      holiday.add("End of Buddhist Lent");
    } else if (myear >= 1379 &&
        mmonth == 7 &&
        (monthDay == 14 || monthDay == 16)) {
      holiday.add("Holiday");
    } else if (mmonth == 8 && moonPhase == 1) {
      holiday.add("Tazaungdaing");
    } else if (myear >= 1379 && mmonth == 8 && monthDay == 14) {
      holiday.add("Holiday");
    } else if (myear >= 1282 && mmonth == 8 && monthDay == 25) {
      holiday.add("National Day");
    } else if (mmonth == 10 && monthDay == 1) {
      holiday.add("Karen New Year's Day");
    } else if (mmonth == 12 && moonPhase == 1) {
      holiday.add("Tabaung Pwe");
    }

    return holiday;
  }

  /// Thingyan holidays
  ///
  /// `jdn` - Julian Day Number to check
  static List<String> thingyanHolidays(
    double jdn,
    double myear,
    int monthType,
  ) {
    // start of Thingyan
    int startOfThingyan = 1100;

    List<String> holiday = List.empty(growable: true);

    // double atat;
    double akn, atn;
    // start of third era
    int se3 = 1312;

    double ja = CalendarConstants.solarYear * (myear + monthType) +
        CalendarConstants.mo;
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
  ///
  /// `jd` - Julian Day Number to check
  static List<String> otherHolidays(double jd) {
    List<String> holiday = List.empty(growable: true);
    if (searchOf1DArray(jd, _ghDiwali) >= 0) {
      holiday.add("Diwali");
    }
    if (searchOf1DArray(jd, _ghEid) >= 0) {
      holiday.add("Eid");
    }

    return holiday;
  }

  /// English Anniversary days
  ///
  /// `jd` - Julian Day Number to check
  static List<String> englishAnniversaryDays(
    double jd, {
    CalendarType? calendarType,
  }) {
    calendarType ??= CalendarType.english;

    List<String> holiday = List.empty(growable: true);

    // WesternDate wd = WesternDateConverter.convert(jd, calendarType);
    WesternDate wd =
        WesternDateConverter.fromJulianDate(jd, calendarType: calendarType);
    double doe = dateOfEaster(wd.year);

    if ((wd.year <= 2017) && (wd.month == 1) && (wd.day == 1)) {
      holiday.add("New Year Day");
    } else if ((wd.year >= 1915) && (wd.month == 2) && (wd.day == 13)) {
      holiday.add("G. Aung San BD");
    } else if ((wd.year >= 1969) && (wd.month == 2) && (wd.day == 14)) {
      holiday.add("Valentines Day");
    } else if ((wd.year >= 1970) && (wd.month == 4) && (wd.day == 22)) {
      holiday.add("Earth Day");
    } else if ((wd.year >= 1392) && (wd.month == 4) && (wd.day == 1)) {
      holiday.add("April Fools Day");
    } else if ((wd.year >= 1948) && (wd.month == 5) && (wd.day == 8)) {
      holiday.add("Red Cross Day");
    } else if ((wd.year >= 1994) && (wd.month == 10) && (wd.day == 5)) {
      holiday.add("World Teachers Day");
    } else if ((wd.year >= 1947) && (wd.month == 10) && (wd.day == 24)) {
      holiday.add("United Nations Day");
    } else if ((wd.year >= 1753) && (wd.month == 10) && (wd.day == 31)) {
      holiday.add("Halloween");
    }

    if ((wd.year >= 1876) && (jd == doe)) {
      holiday.add("Easter");
    } else if ((wd.year >= 1876) && (jd == (doe - 2))) {
      holiday.add("Good Friday");
    } else if (searchOf1DArray(jd, _ghEid2) >= 0) {
      holiday.add("Eid");
    }
    if (searchOf1DArray(jd, _ghCNY) >= 0) {
      holiday.add("Chinese New Year");
    }

    return holiday;
  }

  /// Date of Easter using "Meeus/Jones/Butcher" algorithm Reference: Peter
  /// Duffett-Smith, Jonathan Zwart',
  /// "Practical Astronomy with your Calculator or Spreadsheet," 4th Etd,
  /// Cambridge university press, 2011. Page-4.
  static double dateOfEaster(int year) {
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

    return WesternDateLogic.westernToJulian(
        year: year, month: month, day: day, calendarType: CalendarType.english);
  }

  /// Myanmar anniversary days.
  ///
  static List<String> myanmarAnniversaryDays(
    double myear,
    int mmonth,
    int monthDay,
    int moonPhase,
  ) {
    List<String> holiday = List.empty(growable: true);

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

    // else if((my>=1119) && (mm==2) && (md==23))
    // {hs[h++]="Mon Fallen Day";}
    // else if((mm==12) && (md==12)) {hs[h++]="Mon Women Day";}

    return holiday;
  }

  /// Get all anniversary days
  static List<String> getAnniversaries(
    MyanmarDate myanmarDate, {
    CalendarType? calendarType,
  }) {
    List<String> ecd = englishAnniversaryDays(
      myanmarDate.jd,
      calendarType: calendarType,
    ); // anniversary day
    List<String> mcd = myanmarAnniversaryDays(
      myanmarDate.myear.toDouble(),
      myanmarDate.mmonth,
      myanmarDate.monthDay,
      myanmarDate.moonPhase,
    );

    List<String> holiday = List.empty(growable: true);

    holiday.addAll(ecd);
    holiday.addAll(mcd);

    return holiday;
  }
}

/// Eid 2
const List<int> _ghEid2 = [2456936, 2457290, 2457644, 2457998, 2458353];

/// Chinese new year ref
const List<int> _ghCNY = [
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
const List<int> _ghDiwali = [
  2456599,
  2456953,
  2457337,
  2457691,
  2458045,
  2458429
];

/// Eid
const List<int> _ghEid = [2456513, 2456867, 2457221, 2457576, 2457930, 2458285];
