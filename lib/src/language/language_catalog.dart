import '../models/models.dart';
import 'lang_en.dart';
import 'lang_karen.dart';
import 'lang_mon.dart';
import 'lang_my.dart';
import 'lang_tai.dart';
import 'lang_zawgyi.dart';

/// Language catalog
class LanguageCatalog {
  LanguageCatalog({
    Language? language,
  }) : _language = language ?? Language.myanmar;

  /// Language
  final Language _language;

  /// Public getter field of [Language].
  Language get language => _language;

  /// Myanmar language
  factory LanguageCatalog.myanmar() =>
      LanguageCatalog(language: Language.myanmar);

  /// Zawgyi language
  factory LanguageCatalog.zawgyi() =>
      LanguageCatalog(language: Language.zawgyi);

  /// Mon language
  factory LanguageCatalog.mon() => LanguageCatalog(language: Language.mon);

  /// Karen language
  factory LanguageCatalog.karen() => LanguageCatalog(language: Language.karen);

  /// Tai language
  factory LanguageCatalog.tai() => LanguageCatalog(language: Language.tai);

  /// English language
  factory LanguageCatalog.english() =>
      LanguageCatalog(language: Language.english);

  /// Translate by `key` and default [Language] type config.
  String translate(String key) {
    return _translate(_language, key);
  }

  /// Translate accorting to [Language] type.
  String _translate(Language language, String key) {
    return switch (language) {
      Language.english => langEngMap[key] ?? '',
      Language.myanmar => langMyanMap[key] ?? '',
      Language.zawgyi => langZawgyiMap[key] ?? '',
      Language.mon => langMonMap[key] ?? '',
      Language.tai => langTaiMap[key] ?? '',
      Language.karen => langKarenMap[key] ?? '',
    };
  }
}
