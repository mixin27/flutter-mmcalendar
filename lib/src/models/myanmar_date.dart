import 'package:flutter_mmcalendar/flutter_mmcalendar.dart';

/// Myanmar date
class MyanmarDate implements Comparable<MyanmarDate> {
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

  MyanmarDate copyWith({
    int? myear,
    int? yearType,
    int? yearLength,
    int? mmonth,
    int? monthType,
    int? monthLength,
    int? monthDay,
    int? fortnightDay,
    int? moonPhase,
    int? weekDay,
    double? jd,
  }) {
    return MyanmarDate(
      myear: myear ?? this.myear,
      yearType: yearType ?? this.yearType,
      yearLength: yearLength ?? this.yearLength,
      mmonth: mmonth ?? this.mmonth,
      monthType: monthType ?? this.monthType,
      monthLength: monthLength ?? this.monthLength,
      monthDay: monthDay ?? this.monthDay,
      fortnightDay: fortnightDay ?? this.fortnightDay,
      moonPhase: moonPhase ?? this.moonPhase,
      weekDay: weekDay ?? this.weekDay,
      jd: jd ?? this.jd,
    );
  }

  @override
  String toString() {
    return 'MyanmarDate(myear: $myear, yearType: $yearType, yearLength: $yearLength, mmonth: $mmonth, monthType: $monthType, monthLength: $monthLength, monthDay: $monthDay, fortnightDay: $fortnightDay, moonPhase: $moonPhase, weekDay: $weekDay, jd: $jd)';
  }

  @override
  bool operator ==(covariant MyanmarDate other) {
    if (identical(this, other)) return true;

    return other.myear == myear &&
        other.yearType == yearType &&
        other.yearLength == yearLength &&
        other.mmonth == mmonth &&
        other.monthType == monthType &&
        other.monthLength == monthLength &&
        other.monthDay == monthDay &&
        other.fortnightDay == fortnightDay &&
        other.moonPhase == moonPhase &&
        other.weekDay == weekDay &&
        other.jd == jd;
  }

  @override
  int get hashCode {
    return myear.hashCode ^
        yearType.hashCode ^
        yearLength.hashCode ^
        mmonth.hashCode ^
        monthType.hashCode ^
        monthLength.hashCode ^
        monthDay.hashCode ^
        fortnightDay.hashCode ^
        moonPhase.hashCode ^
        weekDay.hashCode ^
        jd.hashCode;
  }

  @override
  int compareTo(MyanmarDate other) {
    return jd.compareTo(other.jd);
  }
}

const List<String> mma = [
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
const List<String> msa = ["waxing", "full moon", "waning", "new moon"];

/// Week days
const List<String> wda = [
  "Saturday",
  "Sunday",
  "Monday",
  "Tuesday",
  "Wednesday",
  "Thursday",
  "Friday"
];

extension MyanmarDateX on MyanmarDate {
  /// Get `buddhistEra` string.
  String getBuddhistEraByLanguage(LanguageCatalog languageCatalog) {
    return convertNumberToLanguage(myear + 1182, languageCatalog);
  }

  /// Get `buddhistEra` string.
  String getBuddhistEra() {
    return getBuddhistEraByLanguage(LanguageCatalog.instance);
  }

  /// Get `year` string.
  String getYearByLanguage(LanguageCatalog languageCatalog) {
    return convertNumberToLanguage(myear.toDouble(), languageCatalog);
  }

  /// Get `year` string.
  String getYear() {
    return getYearByLanguage(LanguageCatalog.instance);
  }

  /// Get `month` value.
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

  /// Get `month` value.
  String getMnt() {
    return _getMnt(LanguageCatalog.instance);
  }

  /// Get `month` name.
  String getMonthNameByLanguage(LanguageCatalog languageCatalog) {
    return getMnt() + languageCatalog.translate(mma[mmonth]);
  }

  /// Get `month` name.
  String getMonthName() {
    return getMonthNameByLanguage(LanguageCatalog.instance);
  }

  /// Get `moonPhase` string.
  String getMoonPhaseByLanguage(LanguageCatalog languageCatalog) {
    return languageCatalog.translate(msa[moonPhase]);
  }

  /// Get `moonPhase` string.
  String getMoonPhase() {
    return getMoonPhaseByLanguage(LanguageCatalog.instance);
  }

  /// Get `fortnightDay` string by [LanguageCatalog]
  String getFortnightDayByLanguage(LanguageCatalog languageCatalog) {
    return ((moonPhase % 2) == 0)
        ? convertNumberToLanguage(fortnightDay.toDouble(), languageCatalog)
        : "";
  }

  /// Get `fortnightDay` string.
  String getFortnightDay() =>
      getFortnightDayByLanguage(LanguageCatalog.instance);

  /// Get `weekday` string by [LanguageCatalog]
  String getWeekDayByLanguage(LanguageCatalog languageCatalog) {
    return languageCatalog.translate(wda[weekDay]);
  }

  /// Get `weekday` string
  String getWeekDay() => getWeekDayByLanguage(LanguageCatalog.instance);

  /// Check is `weekend`
  bool isWeekend() => weekDay == 0 || weekDay == 1;

  /// Format [MyanmarDate] by pattern
  ///
  /// `pattern` - Pattern to be formatted.
  String format([
    String pattern = CalendarConstants.simpleMyanmarDateFormatPattern,
  ]) =>
      formatByPatternAndLanguage(
        pattern: pattern,
        languageCatalog: LanguageCatalog.instance,
      );

  /// Format [MyanmarDate] by pattern
  ///
  /// `pattern` - Pattern to be formatted.
  ///
  /// `languageCatalog` - Language catalog to be translated.
  String formatByPatternAndLanguage({
    String pattern = CalendarConstants.simpleMyanmarDateFormatPattern,
    required LanguageCatalog languageCatalog,
  }) {
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
          if (languageCatalog.language == Language.english) {
            str += " ${languageCatalog.translate("Nay")}";
          } else {
            str += languageCatalog.translate("Nay");
          }
          break;
        case MyanmarDateFormat.yat:
          if (getFortnightDay().isNotEmpty) {
            str += languageCatalog.translate("Yat");
          }
          break;
        default:
          str += charArray[i];
          break;
      }
    }

    return str;
  }
}
