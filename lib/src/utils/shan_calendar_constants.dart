/// Shan Calendar Constants and Utilities
///
/// The Shan calendar follows the Myanmar calendar structure but uses
/// a different era calculation: Shan Year = Myanmar Year + 733
///
/// Example: Myanmar Year 1387 = Shan Year 2120
class ShanCalendarConstants {
  ShanCalendarConstants._();

  /// Shan calendar year offset from Myanmar calendar
  ///
  /// Formula: Shan Year = Myanmar Year + 733
  /// This is the traditional Tai Long / Shan State era calculation
  ///
  /// Example:
  /// ```dart
  /// Myanmar Year 1387 + 733 = Shan Year 2120
  /// ```
  static const int shanYearOffset = 733;

  /// Calculate Shan year from Myanmar year
  ///
  /// Example:
  /// ```dart
  /// final shanYear = ShanCalendarConstants.getShanYear(1387); // Returns 2120
  /// ```
  static int getShanYear(int myanmarYear) {
    return myanmarYear + shanYearOffset;
  }

  /// Calculate Myanmar year from Shan year
  ///
  /// Example:
  /// ```dart
  /// final myanmarYear = ShanCalendarConstants.getMyanmarYearFromShan(2120); // Returns 1387
  /// ```
  static int getMyanmarYearFromShan(int shanYear) {
    return shanYear - shanYearOffset;
  }

  /// Verify Shan year calculation
  ///
  /// Returns true if the calculation is correct
  static bool verifyShanYear(int myanmarYear, int expectedShanYear) {
    return getShanYear(myanmarYear) == expectedShanYear;
  }

  /// Shan New Year holiday (same as Myanmar Thingyan - April 13-16)
  /// IMPORTANT: This is a single combined term, not split
  static const String shanNewYearHoliday = 'ပွႆးပီမႂ်ႇတႆး';

  /// Shan month names (follow Myanmar calendar structure)
  /// These are used when displaying dates in Shan language
  static const List<String> shanMonthNames = [
    'လိူၼ်ၵျုတ်ႈ', // 0 - First Waso
    'လိူၼ်ၵျုတ်ႈ', // 1 - Tagu (March-April)
    'လိူၼ်သွင်', // 2 - Kason (April-May)
    'လိူၼ်ႁႃ', // 3 - Nayon (May-June)
    'လိူၼ်ပၢတ်ႇ', // 4 - Waso (June-July)
    'လိူၼ်ၵဝ်', // 5 - Wagaung (July-August)
    'လိူၼ်သိပ်း', // 6 - Tawthalin (August-September)
    'လိူၼ်သိပ်းသွင်', // 7 - Thadingyut (September-October)
    'လိူၼ်ၵျီ', // 8 - Tazaungmon (October-November)
    'လိူၼ်ၵျီႇသွင်', // 9 - Nadaw (November-December)
    'လိူၼ်ပူၼ်', // 10 - Pyatho (December-January)
    'လိူၼ်ၵျီႇႁိုဝ်', // 11 - Tabodwe (January-February)
    'လိူၼ်ၵျီႇဢွၵ်ႇ', // 12 - Tabaung (February-March)
    'လိူၼ်ၶဝ်ႈ', // 13 - Late Tagu
    'လိူၼ်ႁူၼ်ႈသွင်', // 14 - Late Kason
  ];

  /// Get Shan month name by index
  static String getMonthName(int monthIndex) {
    if (monthIndex >= 0 && monthIndex < shanMonthNames.length) {
      return shanMonthNames[monthIndex];
    }
    return '';
  }

  /// Shan weekday names (Myanmar weekday system: 0=Saturday, 1=Sunday, ..., 6=Friday)
  static const List<String> shanWeekdayNames = [
    'ဝၼ်းသဝ်း', // 0 - Saturday
    'ဝၼ်းတိတ်ႉ', // 1 - Sunday
    'ဝၼ်းၸၼ်', // 2 - Monday
    'ဝၼ်းဢၢင်း', // 3 - Tuesday
    'ဝၼ်းပုတ်ႉ', // 4 - Wednesday
    'ဝၼ်းၽတ်း', // 5 - Thursday
    'ဝၼ်းသုၵ်း', // 6 - Friday
  ];

  /// Shan weekday short names
  static const List<String> shanWeekdayShortNames = [
    'သဝ်', // Saturday
    'တိတ်', // Sunday
    'ၸၼ်', // Monday
    'ဢၢင်', // Tuesday
    'ပုတ်', // Wednesday
    'ၽတ်', // Thursday
    'သုၵ်', // Friday
  ];

  /// Get Shan weekday name
  static String getWeekdayName(int weekdayIndex, {bool short = false}) {
    if (weekdayIndex >= 0 && weekdayIndex < 7) {
      return short
          ? shanWeekdayShortNames[weekdayIndex]
          : shanWeekdayNames[weekdayIndex];
    }
    return '';
  }
}
