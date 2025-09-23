/// Supported languages for the Myanmar Calendar
enum Language {
  english('en'),
  myanmar('my'),
  zawgyi('zawgyi'),
  mon('mon'),
  shan('shan'),
  karen('karen');

  const Language(this.code);
  final String code;

  static Language fromCode(String code) {
    return Language.values.firstWhere(
      (lang) => lang.code == code,
      orElse: () => Language.english,
    );
  }
}
