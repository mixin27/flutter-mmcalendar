/// Constants used throughout the Myanmar calendar calculations
class CalendarConstants {
  /// Solar year constant, `1577917828.0 / 4320000.0`
  static const double solarYear = 365.2587564814815;

  /// Lunar month constant, `1577917828.0 / 53433336.0`
  static const double lunarMonth = 29.53058794607172;

  /// Beginning of 0 ME for MMT
  static const double myanmarEpoch = 1954168.050623;

  /// Buddhist Era offset
  static const int buddhistEraOffset = 1182;

  /// Calendar type constant - `British`
  static const int calendarTypeBritish = 0;

  /// Calendar type constant - `Gregorian`
  static const int calendarTypeGregorian = 1;

  /// Calendar type constant - `Julian`
  static const int calendarTypeJulian = 2;

  /// Gregorian start in British calendar (1752/Sep/14)
  static const int gregorianStartBritish = 2361222;

  /// Year type constant - `Common`
  static const int yearTypeCommon = 0;

  /// Year type constant - `Little Watat`
  static const int yearTypeLittleWatat = 1;

  /// Year type constant - `Big Watat`
  static const int yearTypeBigWatat = 2;

  /// Moon phase constant - `Waxing`
  static const int moonPhaseWaxing = 0;

  /// Moon phase constant - `Full Moon`
  static const int moonPhaseFullMoon = 1;

  /// Moon phase constant - `Waning`
  static const int moonPhaseWaning = 2;

  /// Moon phase constant - `New Moon`
  static const int moonPhaseNewMoon = 3;

  /// Weekday constants (Myanmar system) - `Saturday`
  static const int weekdaySaturday = 0;

  /// Weekday constant (Myanmar system) - `Sunday`
  static const int weekdaySunday = 1;

  /// Weekday constant (Myanmar system) - `Monday`
  static const int weekdayMonday = 2;

  /// Weekday constant (Myanmar system) - `Tuesday`
  static const int weekdayTuesday = 3;

  /// Weekday constant (Myanmar system) - `Wednesday`
  static const int weekdayWednesday = 4;

  /// Weekday constant (Myanmar system) - `Thursday`
  static const int weekdayThursday = 5;

  /// Weekday constant (Myanmar system) - `Friday`
  static const int weekdayFriday = 6;

  /// Month constant - `Tagu`
  static const int monthTagu = 1;

  /// Month constant - `Kason`
  static const int monthKason = 2;

  /// Month constant - `Nayon`
  static const int monthNayon = 3;

  /// Month constant - `First Waso`
  static const int monthFirstWaso = 0;

  /// Month constant - `Waso`
  static const int monthWaso = 4;

  /// Month constant - `Wagaung`
  static const int monthWagaung = 5;

  /// Month constant - `Tawthalin`
  static const int monthTawthalin = 6;

  /// Month constant - `Thadingyut`
  static const int monthThadingyut = 7;

  /// Month constant - `Tazaungmon`
  static const int monthTazaungmon = 8;

  /// Month constant - `Nadaw`
  static const int monthNadaw = 9;

  /// Month constant - `Pyatho`
  static const int monthPyatho = 10;

  /// Month constant - `Tabodwe`
  static const int monthTabodwe = 11;

  /// Month constant - `Tabaung`
  static const int monthTabaung = 12;

  /// Month constant - `Late Tagu`
  static const int monthLateTagu = 13;

  /// Month constant - `Kason`
  static const int monthLateKason = 14;

  /// Month names in English
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

  /// Moon phase names
  static const List<String> moonPhaseNames = [
    'Waxing',
    'Full Moon',
    'Waning',
    'New Moon',
  ];

  /// Weekday names
  static const List<String> weekdayNames = [
    'Saturday',
    'Sunday',
    'Monday',
    'Tuesday',
    'Wednesday',
    'Thursday',
    'Friday',
  ];

  /// Year names (12-year cycle)
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
}
