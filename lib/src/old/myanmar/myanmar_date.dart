import 'package:flutter_mmcalendar/flutter_mmcalendar.dart';
import 'package:flutter_mmcalendar/src/old/constants/date_format.dart';

/// Myanmar date
class MyanmarDate implements Comparable<MyanmarDate> {
  static const List<String> mma = [
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
    "Tabaung"
  ];

  /// New Moon mean Dark moon
  static const List<String> msa = ["waxing", "full moon", "waning", "new moon"];

  /// Week days
  static const List<String> wda = [
    "Saturday",
    "Sunday",
    "Monday",
    "Tuesday",
    "Wednesday",
    "Thursday",
    "Friday"
  ];

  /// Myanmar year
  final int myear;

  /// Year type `0=common, 1=little watat, 2=big watat`
  final int yearType;

  /// `myl` : Year length `normal = 354, small watat = 384, or big watat = 385 days`
  final int yearLength;

  /// Myanmar month
  ///
  /// Tagu=1, Kason=2, Nayon=3, 1st Waso=0, (2nd) Waso=4, Wagaung=5,
  /// Tawthalin=6, Thadingyut=7, Tazaungmon=8, Nadaw=9, Pyatho=10, Tabodwe=11,
  /// Tabaung=12
  final int mmonth;

  /// Myanmar month type
  ///
  /// month type: `(1=hnaung, 0= Oo)`
  final int monthType;

  /// Myanmar month length: `(29 or 30 days)`
  final int monthLength;

  /// Myanmar month day: `(1 to 30)`
  final int monthDay;

  /// Fortnight day `(1 to 15)`
  final int fortnightDay;

  /// Moon phase `(0=waxing, 1=full moon, 2=waning, 3=new moon)`
  final int moonPhase;

  /// Week day `(0=sat, 1=sun, ..., 6=fri)`
  final int weekDay;

  /// Julian day number
  final double jd;

  MyanmarDate({
    required this.myear,
    required this.yearType,
    required this.yearLength,
    required this.mmonth,
    required this.monthType,
    required this.monthLength,
    required this.monthDay,
    required this.fortnightDay,
    required this.moonPhase,
    required this.weekDay,
    required this.jd,
  }) {
    if (myear < 0) {
      throw Exception("Myanmar year must be positive number");
    }
    if (mmonth < 0 || mmonth > 13) {
      throw Exception("Month must be 0 to 12");
    }
    if (monthType < 0 || monthType > 1) {
      throw Exception("Month type must be 0 to 1");
    }
    if (fortnightDay < 1 || fortnightDay > 15) {
      throw Exception("Fortnight day must be 0 to 15");
    }
    if (moonPhase < 0 || moonPhase > 3) {
      throw Exception("Moon phase must be 0 to 3");
    }
  }

  String getBuddhistEraByLanguage(LanguageCatalog languageCatalog) {
    return NumberToStringUtil.convert(myear + 1182, languageCatalog);
  }

  String getBuddhistEra() {
    return getBuddhistEraByLanguage(LanguageCatalog.instance);
  }

  String getYearByLanguage(LanguageCatalog languageCatalog) {
    return NumberToStringUtil.convert(myear.toDouble(), languageCatalog);
  }

  String getYear() {
    return getYearByLanguage(LanguageCatalog.instance);
  }

  String _getMnt(LanguageCatalog languageCatalog) {
    // 0=common, 1=little watat, 2=big watat
    String str = '';
    if (monthType > 0) {
      str += languageCatalog.translate("Late");
    }

    if (yearType > 0 && mmonth == 4) {
      str += languageCatalog.translate("Second");
    }

    return str;
  }

  String getMnt() {
    return _getMnt(LanguageCatalog.instance);
  }

  String getMonthNameByLanguage(LanguageCatalog languageCatalog) {
    return getMnt() + languageCatalog.translate(mma[mmonth]);
  }

  String getMonthName() {
    return getMonthNameByLanguage(LanguageCatalog.instance);
  }

  String getMoonPhaseByLanguage(LanguageCatalog languageCatalog) {
    return languageCatalog.translate(msa[moonPhase]);
  }

  String getMoonPhase() {
    return getMoonPhaseByLanguage(LanguageCatalog.instance);
  }

  String getFortnightDayByLanguage(LanguageCatalog languageCatalog) {
    return ((moonPhase % 2) == 0)
        ? NumberToStringUtil.convert(fortnightDay.toDouble(), languageCatalog)
        : "";
  }

  String getFortnightDay() =>
      getFortnightDayByLanguage(LanguageCatalog.instance);

  String getWeekDayByLanguage(LanguageCatalog languageCatalog) {
    return languageCatalog.translate(wda[weekDay]);
  }

  String getWeekDay() => getWeekDayByLanguage(LanguageCatalog.instance);

  bool isWeekend() => weekDay == 0 || weekDay == 1;

  String format(String pattern) =>
      formatByPatternAndLanguage(pattern, LanguageCatalog.instance);

  String formatByPatternAndLanguage(
      String pattern, LanguageCatalog languageCatalog) {
    if (pattern.isEmpty) {
      throw Exception('Pattern cannot not be empty.');
    }

    final charArray = List<String>.empty(growable: true);
    for (var rune in pattern.runes) {
      var character = String.fromCharCode(rune);
      charArray.add(character);
    }

    String str = '';

    for (var i = 0; i < charArray.length; i++) {
      switch (charArray[i]) {
        case MyanmarDateFormat.sasanaYear:
          str += languageCatalog.translate("Sasana Year");
          break;
        case MyanmarDateFormat.buddhistEra:
          str += getBuddhistEraByLanguage(languageCatalog);
          break;
        case MyanmarDateFormat.burmeseYear:
          str += languageCatalog.translate("Myanmar Year");
          break;
        case MyanmarDateFormat.myanmarYear:
          str += getYearByLanguage(languageCatalog);
          break;
        case MyanmarDateFormat.ku:
          str += languageCatalog.translate("Ku");
          break;
        case MyanmarDateFormat.monthInYear:
          str += getMonthNameByLanguage(languageCatalog);
          break;
        case MyanmarDateFormat.moonPhase:
          str += getMoonPhaseByLanguage(languageCatalog);
          break;
        case MyanmarDateFormat.fortnightDay:
          str += getFortnightDayByLanguage(languageCatalog);
          break;
        case MyanmarDateFormat.dayNameInWeek:
          str += getWeekDayByLanguage(languageCatalog);
          break;
        case MyanmarDateFormat.nay:
          str += languageCatalog.translate("Nay");
          break;
        case MyanmarDateFormat.yat:
          str += languageCatalog.translate("Yat");
          break;
        default:
          str += charArray[i];
          break;
      }
    }

    return str;
  }

  @override
  int compareTo(MyanmarDate other) {
    return jd.compareTo(other.jd);
  }
}
