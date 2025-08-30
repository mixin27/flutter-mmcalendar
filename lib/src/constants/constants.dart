/// Constants value for Algorithm calculations
class CalendarConstants {
  /// Solar year - `(365.2587565) (1577917828 / 4320000.0)`
  static const double solarYear = 365.2587564814815;

  /// Lunar month - `(29.53058795) (1577917828 / 53433336.0)`
  static const double lunarMonth = 29.53058794607172;

  /// Beginning of 0 ME - `Myanmar era`
  ///
  /// Starting year of Myanmar era (year 0)
  static const double mo = 1954168.050623;

  /// Beginning of `3rd Era`
  static const double se3 = 1312;

  /// Beginning of `English` calendar.
  static const int by = 640;

  /// End of `English` calendar.
  static const int ey = 2140;

  /// Beginning of `Myanmar` calendar.
  static const int mby = 2;

  /// End of `Myanmar` calendar.
  static const int mey = 1500;

  /// Minimum accurate `English` year.
  static const int lt = 1700;

  /// Maximum accurate `English` year.
  static const int ut = 2018;

  /// Minumum accurate `Myanmar` year.
  static const int mlt = 1062;

  /// Maximum accurate `Myanmar` year.
  static const int mut = 1379;

  /// Gregorian start in `English` calendar (1752/Sep/14)
  static const double sg = 2361222;
}

/// Date format constant values for `Myanmar`
class MyanmarDateFormat {
  static const String sasanaYear = 'S';

  static const String buddhistEra = 's';

  static const String burmeseYear = 'B';

  static const String myanmarYear = 'y';

  static const String ku = 'k';

  static const String monthInYear = 'M';

  static const String moonPhase = 'p';

  static const String fortnightDay = 'f';

  static const String dayNameInWeek = 'E';

  static const String nay = 'n';

  static const String yat = 'r';

  /// Simple date format `pattern` for `Myanmar` calendar.
  static const String simple = "S s k, B y k, M p f r, En";
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

const List<String> emaList = [
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

/// Eid 2
const List<int> ghEid2 = [2456936, 2457290, 2457644, 2457998, 2458353];

/// Chinese new year ref
const List<int> ghCNY = [
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
const List<int> ghDiwali = [
  2456599,
  2456953,
  2457337,
  2457691,
  2458045,
  2458429
];

/// Eid
const List<int> ghEid = [2456513, 2456867, 2457221, 2457576, 2457930, 2458285];
