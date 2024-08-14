import 'package:flutter/foundation.dart';

import '../language/language.dart';

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
    LanguageCatalog? languageCatalog,
  }) : _languageCatalog = languageCatalog ?? LanguageCatalog.myanmar() {
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

  /// Language config
  final LanguageCatalog _languageCatalog;

  /// Current [LanguageCatalog] instance.
  LanguageCatalog get languageCatalog => _languageCatalog;

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

/// Myanmar Months List for Specific Myanmar Year
class MyanmarMonths {
  const MyanmarMonths({
    required this.indices,
    required this.monthNameList,
    required this.currentIndex,
  });

  /// Month index list
  final List<int> indices;

  /// Myanmar month name list
  final List<String> monthNameList;

  /// Current index of the list
  final int currentIndex;

  MyanmarMonths copyWith({
    List<int>? indices,
    List<String>? monthNameList,
    int? currentIndex,
  }) {
    return MyanmarMonths(
      indices: indices ?? this.indices,
      monthNameList: monthNameList ?? this.monthNameList,
      currentIndex: currentIndex ?? this.currentIndex,
    );
  }

  @override
  String toString() =>
      'MyanmarMonths(indices: $indices, monthNameList: $monthNameList, currentIndex: $currentIndex)';

  @override
  bool operator ==(covariant MyanmarMonths other) {
    if (identical(this, other)) return true;

    return listEquals(other.indices, indices) &&
        listEquals(other.monthNameList, monthNameList) &&
        other.currentIndex == currentIndex;
  }

  @override
  int get hashCode =>
      indices.hashCode ^ monthNameList.hashCode ^ currentIndex.hashCode;
}
