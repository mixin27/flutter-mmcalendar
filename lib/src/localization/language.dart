/// Supported languages for the Myanmar Calendar
enum Language {
  /// English
  english('en'),

  /// Myanmar
  myanmar('my'),

  /// Myanmar (Zawgyi)
  zawgyi('zawgyi'),

  /// Mon
  mon('mon'),

  /// Shan
  shan('shan'),

  /// Karen
  karen('karen');

  const Language(this.code);

  /// code
  final String code;

  /// Get language from code
  static Language fromCode(String code) {
    return Language.values.firstWhere(
      (lang) => lang.code == code,
      orElse: () => Language.english,
    );
  }
}
