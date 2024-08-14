import '../config/mm_calendar_config.dart';
import '../constants/constants.dart';
import '../language/language.dart';
import '../models/models.dart';
import '../utils/binary_search_utils.dart';
import 'western_date_calculation.dart';

/// Holiday Calculation
class HolidaysCalculation {
  /// Get all holidays.
  static List<String> getHolidays(
    MyanmarDate myanmarDate, {
    LanguageCatalog? languageCatalog,
  }) {
    WesternDate westernDate = WesternDateCalculation.julianToWestern(
      julianDay: myanmarDate.jd,
      config: languageCatalog == null
          ? MmCalendarConfig.defaultConfig()
          : MmCalendarConfig(
              language: languageCatalog.language,
            ),
    );

    List<String> holiday = List.empty(growable: true);

    // Office Off
    List<String> hde = englishHolidays(
      westernDate.year,
      westernDate.month,
      westernDate.day,
      languageCatalog: languageCatalog,
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
  static List<String> englishHolidays(
    int gy,
    int gm,
    int gd, {
    LanguageCatalog? languageCatalog,
  }) {
    final lang = languageCatalog ?? LanguageCatalog.myanmar();

    List<String> holiday = List.empty(growable: true);

    if (gy >= 2018 && gm == 1 && gd == 1) {
      holiday.add(lang.translate('New Year Day'));
    } else if (gy >= 1948 && gm == 1 && gd == 4) {
      holiday.add(lang.translate('Independence Day'));
    } else if (gy >= 1947 && gm == 2 && gd == 12) {
      holiday.add(lang.translate('Union Day'));
    } else if (gy >= 1958 && gm == 3 && gd == 2) {
      holiday.add(lang.translate('Peasants Day'));
    } else if (gy >= 1945 && gm == 3 && gd == 27) {
      holiday.add(lang.translate('Resistance Day'));
    } else if (gy >= 1923 && gm == 5 && gd == 1) {
      holiday.add(lang.translate('Labour Day'));
    } else if (gy >= 1947 && gm == 7 && gd == 19) {
      holiday.add(lang.translate('Martyrs Day'));
    } else if (gy >= 1752 && gm == 12 && gd == 25) {
      holiday.add(lang.translate('Christmas Day'));
    } else if (gy == 2017 && gm == 12 && gd == 30) {
      holiday.add(lang.translate('Holiday'));
    } else if (gy >= 2017 && gm == 12 && gd == 31) {
      holiday.add(lang.translate('Holiday'));
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
      double myear, int mmonth, int monthDay, int moonPhase,
      {LanguageCatalog? languageCatalog}) {
    final lang = languageCatalog ?? LanguageCatalog.myanmar();

    List<String> holiday = List.empty(growable: true);

    if (mmonth == 2 && moonPhase == 1) {
      holiday.add(lang.translate('Buddha Day'));
    } //Vesak day
    else if (mmonth == 4 && moonPhase == 1) {
      holiday.add(lang.translate('Start of Buddhist Lent'));
    } //Warso day
    else if (mmonth == 7 && moonPhase == 1) {
      holiday.add(lang.translate('End of Buddhist Lent'));
    } else if (myear >= 1379 &&
        mmonth == 7 &&
        (monthDay == 14 || monthDay == 16)) {
      holiday.add(lang.translate('Holiday'));
    } else if (mmonth == 8 && moonPhase == 1) {
      holiday.add(lang.translate('Tazaungdaing'));
    } else if (myear >= 1379 && mmonth == 8 && monthDay == 14) {
      holiday.add(lang.translate('Holiday'));
    } else if (myear >= 1282 && mmonth == 8 && monthDay == 25) {
      holiday.add(lang.translate('National Day'));
    } else if (mmonth == 10 && monthDay == 1) {
      holiday.add(lang.translate('Karen New Year Day'));
    } else if (mmonth == 12 && moonPhase == 1) {
      holiday.add(lang.translate('Tabaung Pwe'));
    }

    return holiday;
  }

  /// Thingyan holidays
  ///
  /// `jdn` - Julian Day Number to check
  static List<String> thingyanHolidays(
    double jdn,
    double myear,
    int monthType, {
    LanguageCatalog? languageCatalog,
  }) {
    final lang = languageCatalog ?? LanguageCatalog.myanmar();

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
      holiday.add(lang.translate('Myanmar New Year Day'));
    }

    if ((myear + monthType) >= startOfThingyan) {
      if (jdn == atn) {
        holiday.add(lang.translate('Thingyan Atat'));
      } else if ((jdn > akn) && (jdn < atn)) {
        holiday.add(lang.translate('Thingyan Akyat'));
      } else if (jdn == akn) {
        holiday.add(lang.translate('Thingyan Akya'));
      } else if (jdn == (akn - 1)) {
        holiday.add(lang.translate('Thingyan Akyo'));
      } else if (((myear + monthType) >= 1369) &&
          ((myear + monthType) < 1379) &&
          ((jdn == (akn - 2)) || ((jdn >= (atn + 2)) && (jdn <= (akn + 7))))) {
        holiday.add(lang.translate('Holiday'));
      }
    }

    return holiday;
  }

  /// Other holidays (ohol) Diwali or Eid
  ///
  /// `jd` - Julian Day Number to check
  static List<String> otherHolidays(
    double jd, {
    LanguageCatalog? languageCatalog,
  }) {
    final lang = languageCatalog ?? LanguageCatalog.myanmar();

    List<String> holiday = List.empty(growable: true);
    if (searchOf1DArray(jd, ghDiwali) >= 0) {
      holiday.add(lang.translate('Diwali'));
    }
    if (searchOf1DArray(jd, ghEid) >= 0) {
      holiday.add(lang.translate('Eid'));
    }

    return holiday;
  }

  /// English Anniversary days
  ///
  /// `jd` - Julian Day Number to check
  static List<String> englishAnniversaryDays(double jd,
      {CalendarType? calendarType, LanguageCatalog? languageCatalog}) {
    final lang = languageCatalog ?? LanguageCatalog.myanmar();

    calendarType ??= CalendarType.english;

    List<String> holiday = List.empty(growable: true);

    WesternDate wd = WesternDateCalculation.julianToWestern(
      julianDay: jd,
      config: languageCatalog == null
          ? MmCalendarConfig.defaultConfig()
          : MmCalendarConfig(language: languageCatalog.language),
    );
    double doe = dateOfEaster(wd.year);

    if ((wd.year <= 2017) && (wd.month == 1) && (wd.day == 1)) {
      holiday.add(lang.translate('New Year Day'));
    } else if ((wd.year >= 1915) && (wd.month == 2) && (wd.day == 13)) {
      holiday.add(lang.translate('G. Aung San BD'));
    } else if ((wd.year >= 1969) && (wd.month == 2) && (wd.day == 14)) {
      holiday.add(lang.translate('Valentines Day'));
    } else if ((wd.year >= 1970) && (wd.month == 4) && (wd.day == 22)) {
      holiday.add(lang.translate('Earth Day'));
    } else if ((wd.year >= 1392) && (wd.month == 4) && (wd.day == 1)) {
      holiday.add(lang.translate('April Fools Day'));
    } else if ((wd.year >= 1948) && (wd.month == 5) && (wd.day == 8)) {
      holiday.add(lang.translate('Red Cross Day'));
    } else if ((wd.year >= 1994) && (wd.month == 10) && (wd.day == 5)) {
      holiday.add(lang.translate('World Teachers Day'));
    } else if ((wd.year >= 1947) && (wd.month == 10) && (wd.day == 24)) {
      holiday.add(lang.translate('United Nations Day'));
    } else if ((wd.year >= 1753) && (wd.month == 10) && (wd.day == 31)) {
      holiday.add(lang.translate('Halloween'));
    }

    if ((wd.year >= 1876) && (jd == doe)) {
      holiday.add(lang.translate('Easter'));
    } else if ((wd.year >= 1876) && (jd == (doe - 2))) {
      holiday.add(lang.translate('Good Friday'));
    } else if (searchOf1DArray(jd, ghEid2) >= 0) {
      holiday.add(lang.translate('Eid'));
    }
    if (searchOf1DArray(jd, ghCNY) >= 0) {
      holiday.add(lang.translate('Chinese New Year'));
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

    return WesternDateCalculation.westernToJulian(
      year: year,
      month: month,
      day: day,
      config: MmCalendarConfig.defaultConfig(),
    );
  }

  /// Myanmar anniversary days.
  ///
  static List<String> myanmarAnniversaryDays(
      double myear, int mmonth, int monthDay, int moonPhase,
      {LanguageCatalog? languageCatalog}) {
    final lang = languageCatalog ?? LanguageCatalog.myanmar();

    List<String> holiday = List.empty(growable: true);

    if ((myear >= 1309) && (mmonth == 11) && (monthDay == 16)) {
      holiday.add(lang.translate('Mon National Day'));
    } // the ancient founding of Hanthawady
    else if ((mmonth == 9) && (monthDay == 1)) {
      holiday.add(lang.translate('Shan New Year Day'));
      if (myear >= 1306) {
        holiday.add(lang.translate('Authors Day'));
      }
    } // Nadaw waxing moon 1
    else if ((mmonth == 3) && (moonPhase == 1)) {
      holiday.add(lang.translate('Mahathamaya Day'));
    } // Nayon full moon
    else if ((mmonth == 6) && (moonPhase == 1)) {
      holiday.add(lang.translate('Garudhamma Day'));
    } // Tawthalin full moon
    else if ((myear >= 1356) && (mmonth == 10) && (moonPhase == 1)) {
      holiday.add(lang.translate('Mothers Day'));
    } // Pyatho full moon
    else if ((myear >= 1370) && (mmonth == 12) && (moonPhase == 1)) {
      holiday.add(lang.translate('Fathers Day'));
    } // Tabaung full moon
    else if ((mmonth == 5) && (moonPhase == 1)) {
      holiday.add(lang.translate('Metta Day'));
      // if(my>=1324) {hs[h++]="Mon Revolution Day";}//Mon Revolution day
    } // Waguang full moon
    else if ((mmonth == 5) && (monthDay == 10)) {
      holiday.add(lang.translate('Taungpyone Pwe'));
    } // Taung Pyone Pwe
    else if ((mmonth == 5) && (monthDay == 23)) {
      holiday.add(lang.translate('Yadanagu Pwe'));
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
    LanguageCatalog? languageCatalog,
  }) {
    List<String> ecd = englishAnniversaryDays(
      myanmarDate.jd,
      calendarType: calendarType,
      languageCatalog: languageCatalog,
    ); // anniversary day
    List<String> mcd = myanmarAnniversaryDays(
      myanmarDate.myear.toDouble(),
      myanmarDate.mmonth,
      myanmarDate.monthDay,
      myanmarDate.moonPhase,
      languageCatalog: languageCatalog,
    );

    List<String> holiday = List.empty(growable: true);

    holiday.addAll(ecd);
    holiday.addAll(mcd);

    return holiday;
  }
}
