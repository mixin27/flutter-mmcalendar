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

  /// Simple date format `pattern` for `Myanmar` calendar.
  static const String simpleMyanmarDateFormatPattern =
      "S s k, B y k, M p f r En";
}
