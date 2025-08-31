import 'package:flutter_mmcalendar/src/language/language_catalog.dart';
import 'package:flutter_mmcalendar/src/models/enums.dart';

/// Forward mapping: Language → LanguageCode
extension LanguageX on Language {
  LanguageCode toLanguageCode() {
    switch (this) {
      case Language.english:
        return LanguageCode.english;
      case Language.myanmar:
        return LanguageCode.myanmarUnicode;
      case Language.zawgyi:
        return LanguageCode.myanmarZawgyi;
      case Language.mon:
        return LanguageCode.mon;
      case Language.karen:
        return LanguageCode.karen;
      case Language.tai:
        return LanguageCode.tai;
    }
  }

  /// Convert to serializable string (e.g., for JSON or SharedPreferences)
  String toJson() => name;

  /// Restore from JSON string
  static Language fromJson(String value) {
    return Language.values.firstWhere(
      (e) => e.name == value,
      orElse: () => Language.myanmar, // default fallback
    );
  }
}

/// Reverse mapping: LanguageCode → Language
extension LanguageCodeX on LanguageCode {
  Language toLanguage() {
    switch (this) {
      case LanguageCode.english:
        return Language.english;
      case LanguageCode.myanmarUnicode:
        return Language.myanmar;
      case LanguageCode.myanmarZawgyi:
        return Language.zawgyi;
      case LanguageCode.mon:
        return Language.mon;
      case LanguageCode.karen:
        return Language.karen;
      case LanguageCode.tai:
        return Language.tai;
    }
  }

  /// Convert to serializable string (e.g., for JSON or SharedPreferences)
  String toJson() => name;

  /// Restore from JSON string
  static LanguageCode fromJson(String value) {
    return LanguageCode.values.firstWhere(
      (e) => e.name == value,
      orElse: () => LanguageCode.english,
    );
  }
}
