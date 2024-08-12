import 'package:flutter_mmcalendar/flutter_mmcalendar.dart';

/// Converting logic for [MyanmarDate].
///
/// Core Calculation and Algorithms for Myanmar Date
class MyanmarDateLogic {
  /// Julian date to Myanmar date.
  ///
  /// `julianDay` - Julian day
  ///
  /// Return - [MyanmarDate]
  static MyanmarDate julianToMyanmarDate(double julianDay) {
    int jdn,
        dd,
        yearLength,
        monthType,
        a,
        b,
        c,
        e,
        f,
        mmonth,
        monthDay,
        monthLength,
        moonPhase,
        fortnightDay,
        weekDay;

    int myear;

    Map<String, double> yo;

    // convert jd to jdn
    jdn = (julianDay).round();

    /// Myanmar year
    myear = ((jdn - 0.5 - CalendarConstants.mo) / CalendarConstants.solarYear)
        .floor();
    // check year
    yo = chkMy(myear);
    // day count
    dd = (jdn - (yo["tg1"] as double) + 1).toInt();
    b = (((yo["myt"] as double) / 2.0.floor())).toInt();
    // big wa and common yr
    c = (1 / ((yo["myt"] as double) + 1)).floor();
    // year length
    yearLength = 354 + (1 - c) * 30 + b;
    // month type: Hnaung =1 or Oo = 0
    monthType = ((dd - 1) / yearLength).floor();
    dd -= monthType * yearLength;
    // adjust day count and threshold
    a = ((dd + 423) / 512.0).floor();
    // month
    mmonth = ((dd - b * a + c * a * 30 + 29.26) / 29.544).floor();
    e = ((mmonth + 12) / 16.0).floor();
    f = ((mmonth + 11) / 16.0).floor();
    // day
    monthDay = dd - (29.544 * mmonth - 29.26).floor() - b * e + c * f * 30;
    mmonth += f * 3 - e * 4;
    // adjust month and month length
    monthLength = 30 - mmonth % 2;

    if (mmonth == 3) {
      // adjust if Nayon in big watat
      monthLength += ((yo['myt'] as double) / 2).toInt();
    }

    moonPhase = ((monthDay + 1) / 16.0).floor() +
        (monthDay / 16.0).floor() +
        (monthDay / monthLength).floor();
    // waxing or waning day
    fortnightDay = monthDay - 15 * (monthDay / 16.0).floor();
    // week day
    weekDay = (jdn + 2) % 7;

    MyanmarDate myanmarDate = MyanmarDate(
      myear: myear,
      yearType: (yo["myt"] as double).toInt(),
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

    return myanmarDate;
  }

  /// Check Myanmar Year dependency
  static Map<String, double> chkMy(int myear) {
    int yd = 0;
    Map<String, double> y1;
    double nd = 0;
    double werr = 0;
    double fm = 0;

    Map<String, double> y2 = chkWatat(myear);
    double myt = y2["watat"] as double;

    do {
      yd++;
      y1 = chkWatat(myear - yd);
    } while (y1["watat"] == 0 && yd < 3);

    if (myt > 0) {
      nd = ((y2["fm"] as double) - (y1["fm"] as double)) % 354;
      myt = (nd / 31.0).floorToDouble() + 1;
      fm = y2["fm"] as double;
      if (nd != 30 && nd != 31) {
        werr = 1;
      }
    } else {
      fm = (y1["fm"] as double) + 354 * yd;
    }

    double tg1 = (y1["fm"] as double) + 354 * yd - 102;

    Map<String, double> map = {
      "myt": myt,
      "tg1": tg1,
      "fm": fm,
      "werr": werr,
    };

    return map;
  }

  /// Check watat (intercalary month)
  static Map<String, double> chkWatat(int myear) {
    int i = eraList.length - 1;

    do {
      // get data for respective era
      if (myear >= eraList[i].begin) {
        break;
      }
      i--;
    } while (i > 0);

    Era era = eraList[i];
    int nm = era.nm;
    double wo = era.wo;

    // threshold to adjust
    double ta =
        (CalendarConstants.solarYear / 12.0 - CalendarConstants.lunarMonth) *
            (12 - nm);
    // excess day
    double ed = (CalendarConstants.solarYear * (myear + 3739)) %
        CalendarConstants.lunarMonth;

    if (ed < ta) {
      // adjust excess days
      ed += CalendarConstants.lunarMonth;
    }

    // full moon day of 2nd Waso
    double fm = (CalendarConstants.solarYear * myear +
            CalendarConstants.mo -
            ed +
            4.5 * CalendarConstants.lunarMonth +
            wo)
        .roundToDouble();

    double tw = 0;
    double watat = 0; // find watat

    if (era.eid >= 2) {
      // if 2nd era or later find watat based on excess days
      tw = CalendarConstants.lunarMonth -
          (CalendarConstants.solarYear / 12.0 - CalendarConstants.lunarMonth) *
              nm;

      if (ed >= tw) {
        watat = 1;
      }
    } else {
      // if 1st era,find watat by 19 years metonic cycle
      // Myanmar year is divided by 19 and there is intercalary month
      // if the remainder is 2,5,7,10,13,15,18
      // https://github.com/kanasimi/CeJS/blob/master/data/date/calendar.js#L2330
      watat = (myear * 7 + 2) % 19;
      if (watat < 0) {
        watat += 19;
      }
      watat = (watat / 12.0).floorToDouble();
    }

    i = searchOf2DArray(myear, era.wte);
    if (i >= 0) {
      // correct watat exceptions
      watat = (era.wte[i][1]).toDouble();
    }

    if (watat > 0) {
      i = searchOf2DArray(myear, era.fme);
      if (i >= 0) {
        fm += era.fme[i][1];
      }
    } // correct full moon day exceptions

    Map<String, double> map = {};
    map["fm"] = fm;
    map["watat"] = watat;

    return map;
  }

  /// Convert [MyanmarDate] to `julian`
  ///
  /// `year` - Myanmar year
  ///
  /// `month` - Myanmar month
  ///
  /// `monthType` - Month type `1=hnaung, 0=Oo`
  ///
  /// `fortnightDay` - Fortnight day `1 to 15`
  ///
  /// Return - Julian day number
  static double myanmarDateToJulian({
    required int year,
    required int month,
    required int monthType,
    required int moonPhase,
    required int fortnightDay,
  }) {
    double b, c, mml, m1, m2, md, dd;

    //check year
    Map<String, double> yo = chkMy(year);

    b = ((yo["myt"] as double) / 2).floorToDouble();

    //if big watat and common year
    c = (yo["myt"] == 0) ? 1 : 0;

    //month length
    mml = 30 - month % 2;

    if (month == 3) {
      //adjust if Nayon in big watat
      mml += b;
    }

    m1 = moonPhase % 2;
    m2 = (moonPhase / 2.0).floorToDouble();
    md = m1 * (15 + m2 * (mml - 15)) + (1 - m1) * (fortnightDay + 15 * m2);

    // adjust month
    month +=
        4 - ((month + 15) / 16.0).floor() * 4 + ((month + 12) / 16).floor();

    dd = md +
        (29.544 * month - 29.26).floor() -
        c * ((month + 11) / 16.0).floor() * 30 +
        b * ((month + 12) / 16.0).floor();
    // year length
    double myl = 354 + (1 - c) * 30 + b;
    // adjust day count
    dd += monthType * myl;

    return dd + (yo["tg1"] as double) - 1;
  }

  /// Convert [MyanmarDate] to `julian`
  static double toJulian(MyanmarDate myanmarDate) {
    return myanmarDateToJulian(
      year: myanmarDate.myear,
      month: myanmarDate.mmonth,
      monthType: myanmarDate.monthType,
      moonPhase: myanmarDate.moonPhase,
      fortnightDay: myanmarDate.fortnightDay,
    );
  }

  /// Time to Fraction of day starting from 12 noon (t2d)
  static double timeToDayFraction(double hour, double minute, double second) =>
      ((hour - 12) / 24) + (minute / 1440) + (second / 86400);

  /// Calculate Myanmar Month List
  ///
  /// `year` - Myanmar year
  ///
  /// `month` - Myanmar month
  ///
  /// Return - [MyanmarMonths]
  static MyanmarMonths getMyanmarMonths(int year, int month) {
    double j1 = (CalendarConstants.solarYear * year + CalendarConstants.mo)
            .roundToDouble() +
        1;
    double j2 =
        (CalendarConstants.solarYear * (year + 1) + CalendarConstants.mo)
            .roundToDouble();

    MyanmarDate m1 = julianToMyanmarDate(j1);
    MyanmarDate m2 = julianToMyanmarDate(j2);

    int si = m1.mmonth + 12 * m1.monthType;
    int ei = m2.mmonth + 12 * m2.monthType;

    if (si == 0) {
      si = 4;
    }
    if (month == 0 && m1.yearType == 0) {
      month = 4;
    }
    if (month != 0 && month < si) {
      month = si;
    }
    if (month > ei) {
      month = ei;
    }

    List<int> index = [];
    List<String> monthNameList = [];
    int currentIndex = 0;

    for (int i = si; i <= ei; i++) {
      if (i == 4 && m1.yearType != 0) {
        index.add(0);
        monthNameList.add(_emaList[0]);
        if (month == 0) {
          currentIndex = 0;
        }
      }
      index.add(i);
      monthNameList
          .add(((i == 4 && m1.yearType != 0) ? "Second " : "") + _emaList[i]);

      if (i == month) {
        //if(Math.abs(i - mmonth) < 0.0000001 ) {
        currentIndex = i;
      }
    }

    return MyanmarMonths(
      indices: index,
      monthNameList: monthNameList,
      currentIndex: currentIndex,
    );
  }
}

const List<String> _emaList = [
  "First Waso",
  "Tagu",
  "Kason",
  "Nayon",
  "Waso",
  "Wagaung",
  "Tawthalin",
  "Thadingyut",
  "Tazaungmon",
  "Nadaw",
  "Pyatho",
  "Tabodwe",
  "Tabaung",
  "Late Tagu",
  "Late Kason"
];
