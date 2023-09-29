import 'package:flutter_mmcalendar/flutter_mmcalendar.dart';
import 'package:flutter_mmcalendar/src/era.dart';
import 'package:flutter_mmcalendar/src/myanmar/myanmar_date.dart';
import 'package:flutter_mmcalendar/src/myanmar/myanmar_months.dart';

class MyanmarDateKernel {
  static const List<String> ema = [
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

  /// Julian date to Myanmar date dependency: chk_my(my)
  static MyanmarDate j2m(double jd) {
    double jdn,
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

    double myear;

    Map<String, double> yo;

    // convert jd to jdn
    jdn = jd.roundToDouble();

    // Myanmar year
    myear = ((jdn - 0.5 - Constants.mo) / Constants.solarYear).floorToDouble();

    // check year
    yo = chkMy(myear);

    // day count
    dd = jdn - (yo["tg1"] ?? 0) + 1;
    b = ((yo["myt"] ?? 0) / 2.0).floorToDouble();

    // big wa and common yr
    c = (1 / (yo["myt"] ?? 0) + 1).floorToDouble();

    // year length
    yearLength = 354 + (1 - c) * 30 + b;

    // month type: Hnaung = 1 or Oo = 0
    monthType = ((dd - 1) / yearLength).floorToDouble();
    dd -= monthType * yearLength;

    // adjust day count and threshold
    a = ((dd + 423) / 512.0).floorToDouble();

    // month
    mmonth = ((dd - b * a + c * a * 30 + 29.26) / 29.544).floorToDouble();
    e = ((mmonth + 12) / 16.0).floorToDouble();
    f = ((mmonth + 11) / 16.0).floorToDouble();
    // day
    monthDay = dd - (29.544 * mmonth - 29.26).floor() - b * e + c * f * 30;
    mmonth += f * 3 - e * 4;
    // adjust month and month length
    monthLength = 30 - mmonth % 2;

    if (mmonth == 3) {
      // adjust if Nayon in big watat
      monthLength += b;
    }

    moonPhase = ((monthDay + 1) / 16.0).floorToDouble() +
        (monthDay / 16.0).floor() +
        (monthDay / monthLength).floor();
    // waxing or waning day
    fortnightDay = monthDay - 15 * (monthDay / 16.0).floor();
    // week day
    weekDay = (jdn + 2) % 7;

    final myanmarDate = MyanmarDate(
      myear: myear.toInt(),
      yearType: (yo["myt"] ?? 0).toInt(),
      yearLength: yearLength.toInt(),
      mmonth: mmonth.toInt(),
      monthType: monthType.toInt(),
      monthLength: monthLength.toInt(),
      monthDay: monthDay.toInt(),
      fortnightDay: fortnightDay.toInt(),
      moonPhase: moonPhase.toInt(),
      weekDay: weekDay.toInt(),
      jd: jd,
    );

    return myanmarDate;
  }

  /// Check Myanmar Year dependency: chk_watat(my)
  static Map<String, double> chkMy(double myear) {
    int yd = 0;
    Map<String, double> y1;
    double nd = 0;
    double werr = 0;
    double fm = 0;

    Map<String, double> y2 = chkWatat(myear);
    double myt = y2["watat"] ?? 0.0;

    do {
      yd++;
      y1 = chkWatat(myear - yd);
    } while (y1["watat"] == 0 && yd < 3);

    if (myt > 0) {
      nd = ((y2["fm"] ?? 0) - (y1["fm"] ?? 0)) % 354;
      myt = (nd / 31.0).floorToDouble() + 1;
      fm = y2["fm"] ?? 0;
      if (nd != 30 && nd != 31) {
        werr = 1;
      }
    } else {
      fm = (y1["fm"] ?? 0) + 354 * yd;
    }

    double tg1 = (y1["fm"] ?? 0) + 354 * yd - 102;

    Map<String, double> map = {
      "myt": myt,
      "tg1": tg1,
      "fm": fm,
      "werr": werr,
    };

    return map;
  }

  /// Check watat (intercalary month) dependency: chk_exception(my,fm,watat,ei)
  static Map<String, double> chkWatat(double myear) {
    int i = Era.gEras.length - 1;

    do {
      // get data for respective era
      if (myear >= Era.gEras[i].begin) {
        break;
      }
      i--;
    } while (i > 0);

    Era era = Era.gEras[i];
    int nm = era.nm;
    double wo = era.wo;

    // threshold to adjust
    double ta = (Constants.solarYear / 12.0 - Constants.lunarMonth) * (12 - nm);
    // excess day
    double ed = (Constants.solarYear * (myear + 3739)) % Constants.lunarMonth;

    if (ed < ta) {
      // adjust excess days
      ed += Constants.lunarMonth;
    }

    // full moon day of 2nd Waso
    double fm = (Constants.solarYear * myear +
            Constants.mo -
            ed +
            4.5 * Constants.lunarMonth +
            wo)
        .roundToDouble();

    double tw = 0;
    double watat = 0; // find watat

    if (era.eid >= 2) {
      // if 2nd era or later find watat based on excess days
      tw = Constants.lunarMonth -
          (Constants.solarYear / 12.0 - Constants.lunarMonth) * nm;

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

    i = BinarySearchUtils.searchOf2DArray(myear, era.wte);
    if (i >= 0) {
      // correct watat exceptions
      watat = (era.wte[i][1]).toDouble();
    }

    if (watat > 0) {
      i = BinarySearchUtils.searchOf2DArray(myear, era.fme);
      if (i >= 0) {
        fm += era.fme[i][1];
      }
    } // correct full moon day exceptions

    Map<String, double> map = {};
    map["fm"] = fm;
    map["watat"] = watat;

    return map;
  }

  /// Myanmar date to Julian date
  static double m2jByMyanmarDate(MyanmarDate myanmarDate) {
    return m2j(
      myanmarDate.myear.toDouble(),
      myanmarDate.mmonth.toDouble(),
      myanmarDate.monthType.toDouble(),
      myanmarDate.moonPhase.toDouble(),
      myanmarDate.fortnightDay.toDouble(),
    );
  }

  /// Myanmar date to Julian date dependency: chk_my(my)
  static double m2jByYearMonthDay(double myear, double mmonth, double mmday) {
    double monthType = (mmonth / 13).floorToDouble();
    double month = mmonth % 12;
    return m2j(myear, month, monthType, 0, mmday);
  }

  /// Myanmar date to Julian date dependency: chk_my(my)
  ///
  /// `myear` - Myanmar year
  ///
  /// `mmonth` - Myanmar month (Tagu=1, Kason=2, Nayon=3, 1st Waso=0, (2nd)
  /// Waso=4, Wagaung=5, Tawthalin=6, Thadingyut=7, Tazaungmon=8,
  /// Nadaw=9, Pyatho=10, Tabodwe=11, Tabaung=12)
  ///
  /// `monthType` - month type (1=hnaung, 0=Oo)
  ///
  /// `moonPhase` - moon phase (0=waxing, 1=full moon, 2=waning, 3=new moon)
  ///
  /// `fortnightDay` - fortnight day (1 to 15)
  ///
  /// Return julian day number
  static double m2j(
    double myear,
    double mmonth,
    double monthType,
    double moonPhase,
    double fortnightDay,
  ) {
    double b, c, mml, m1, m2, md, dd;

    // check year
    Map<String, double> yo = chkMy(myear);

    b = (yo["myt"] ?? 0 / 2).floorToDouble();

    //if big watat and common year
    c = (yo["myt"] == 0) ? 1 : 0;

    //month length
    mml = 30 - mmonth % 2;

    if (mmonth == 3) {
      //adjust if Nayon in big watat
      mml += b;
    }

    m1 = moonPhase % 2;
    m2 = (moonPhase / 2.0).floorToDouble();
    md = m1 * (15 + m2 * (mml - 15)) + (1 - m1) * (fortnightDay + 15 * m2);

    // adjust month
    mmonth +=
        4 - ((mmonth + 15) / 16.0).floor() * 4 + ((mmonth + 12) / 16).floor();

    dd = md +
        (29.544 * mmonth - 29.26).floor() -
        c * ((mmonth + 11) / 16.0).floor() * 30 +
        b * ((mmonth + 12) / 16.0).floor();
    // year length
    double myl = 354 + (1 - c) * 30 + b;
    // adjust day count
    dd += monthType * myl;

    return dd + (yo["tg1"] ?? 0) - 1;
  }

  /// Time to Fraction of day starting from 12 noon (t2d)
  static double time2dayFraction(double hour, double minute, double second) {
    return ((hour - 12) / 24) + (minute / 1440) + (second / 86400);
  }

  /// Calculate Myanmar Month List
  static MyanmarMonths getMyanmarMonth(int myear, int mmonth) {
    double j1 = (Constants.solarYear * myear + Constants.mo).round() + 1;
    double j2 =
        (Constants.solarYear * (myear + 1) + Constants.mo).roundToDouble();

    MyanmarDate m1 = j2m(j1);
    MyanmarDate m2 = j2m(j2);

    int si = m1.mmonth + 12 * m1.monthType;
    int ei = m2.mmonth + 12 * m2.monthType;

    if (si == 0) {
      si = 4;
    }
    if (mmonth == 0 && m1.yearType == 0) {
      mmonth = 4;
    }
    if (mmonth != 0 && mmonth < si) {
      mmonth = si;
    }
    if (mmonth > ei) {
      mmonth = ei;
    }

    List<int> index = List.empty();
    List<String> monthNameList = List.empty();
    int currentIndex = 0;

    for (int i = si; i <= ei; i++) {
      if (i == 4 && m1.yearType != 0) {
        index.add(0);
        monthNameList.add(ema[0]);
        if (mmonth == 0) {
          currentIndex = 0;
        }
      }
      index.add(i);
      monthNameList
          .add(((i == 4 && m1.yearType != 0) ? "Second " : "") + ema[i]);

      if (i == mmonth) {
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
