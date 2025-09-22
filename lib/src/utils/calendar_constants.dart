/// Constants used throughout the Myanmar calendar calculations
class CalendarConstants {
  // Solar year (365.2587565)
  static const double solarYear = 1577917828.0 / 4320000.0;

  // Lunar month (29.53058795)
  static const double lunarMonth = 1577917828.0 / 53433336.0;

  // Beginning of 0 ME for MMT
  static const double myanmarEpoch = 1954168.050623;

  // Buddhist Era offset
  static const int buddhistEraOffset = 1182;

  // Calendar type constants
  static const int calendarTypeBritish = 0;
  static const int calendarTypeGregorian = 1;
  static const int calendarTypeJulian = 2;

  // Gregorian start in British calendar (1752/Sep/14)
  static const int gregorianStartBritish = 2361222;

  // Year type constants
  static const int yearTypeCommon = 0;
  static const int yearTypeLittleWatat = 1;
  static const int yearTypeBigWatat = 2;

  // Moon phase constants
  static const int moonPhaseWaxing = 0;
  static const int moonPhaseFullMoon = 1;
  static const int moonPhaseWaning = 2;
  static const int moonPhaseNewMoon = 3;

  // Weekday constants (Myanmar system)
  static const int weekdaySaturday = 0;
  static const int weekdaySunday = 1;
  static const int weekdayMonday = 2;
  static const int weekdayTuesday = 3;
  static const int weekdayWednesday = 4;
  static const int weekdayThursday = 5;
  static const int weekdayFriday = 6;

  // Month constants
  static const int monthTagu = 1;
  static const int monthKason = 2;
  static const int monthNayon = 3;
  static const int monthFirstWaso = 0;
  static const int monthWaso = 4;
  static const int monthWagaung = 5;
  static const int monthTawthalin = 6;
  static const int monthThadingyut = 7;
  static const int monthTazaungmon = 8;
  static const int monthNadaw = 9;
  static const int monthPyatho = 10;
  static const int monthTabodwe = 11;
  static const int monthTabaung = 12;
  static const int monthLateTagu = 13;
  static const int monthLateKason = 14;

  // Month names in English
  static const List<String> monthNames = [
    'First Waso',
    'Tagu',
    'Kason',
    'Nayon',
    'Waso',
    'Wagaung',
    'Tawthalin',
    'Thadingyut',
    'Tazaungmon',
    'Nadaw',
    'Pyatho',
    'Tabodwe',
    'Tabaung',
    'Late Tagu',
    'Late Kason',
  ];

  // Moon phase names
  static const List<String> moonPhaseNames = [
    'Waxing',
    'Full Moon',
    'Waning',
    'New Moon',
  ];

  // Weekday names
  static const List<String> weekdayNames = [
    'Saturday',
    'Sunday',
    'Monday',
    'Tuesday',
    'Wednesday',
    'Thursday',
    'Friday',
  ];

  // Year names (12-year cycle)
  static const List<String> yearNames = [
    'Hpusha',
    'Magha',
    'Phalguni',
    'Chitra',
    'Visakha',
    'Jyeshtha',
    'Ashadha',
    'Sravana',
    'Bhadrapaha',
    'Asvini',
    'Krittika',
    'Mrigasiras',
  ];

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
    2458167,
  ];

  /// Diwali
  static const List<int> ghDiwali = [
    2456599,
    2456953,
    2457337,
    2457691,
    2458045,
    2458429,
  ];

  /// Eid
  static const List<int> ghEid = [
    2456513,
    2456867,
    2457221,
    2457576,
    2457930,
    2458285,
  ];
}
