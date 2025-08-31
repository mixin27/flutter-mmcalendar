/// Supported languages for Myanmar Calendar.
enum Language {
  english(0, ", ", ". "),
  myanmar(1, "၊ ", "။ "),
  mon(2, "၊ ", "။ "),
  zawgyi(3, "၊ ", "။ "),
  tai(4, "၊ ", "။ "),
  karen(5, "၊ ", "။ ");

  /// Index of the language.
  final int languageIndex;

  /// Punctuation used between items.
  final String punctuationMark;

  /// Punctuation used at the end.
  final String punctuation;

  const Language(this.languageIndex, this.punctuationMark, this.punctuation);
}

/// Calendar types
/// `English` | `Gregorian` | `Julian`
enum CalendarType {
  english(0, "English"),
  gregorian(1, "Gregorian"),
  julian(2, "Julian");

  /// Index of the calendar type.
  final int number;

  /// Label for the calendar type.
  final String label;

  const CalendarType(this.number, this.label);
}

extension CalendarTypeX on CalendarType {
  /// Convert to JSON-friendly string
  String toJson() => name;

  /// Restore from JSON string
  static CalendarType fromJson(String value) {
    return CalendarType.values.firstWhere(
      (e) => e.name == value,
      orElse: () => CalendarType.english, // default fallback
    );
  }
}

enum AstroEvent {
  yatyaza,
  pyathada,
  afternoonPyathada,
  sabbatheve,
  sabbath,
  thamanyo,
  amyeittasote,
  warameittugyi,
  warameittunge,
  yatpote,
  thamaphyu,
  nagapor,
  yatyotema,
  mahayatkyan,
  shanyat,
}
