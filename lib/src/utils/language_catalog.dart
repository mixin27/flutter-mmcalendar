import 'package:flutter_mmcalendar/flutter_mmcalendar.dart';
import 'package:flutter_mmcalendar/src/lang/language_map.dart';

/// Language catalog
class LanguageCatalog {
  static LanguageCatalog? _instance;
  static LanguageCatalog get instance => _instance ??=
      LanguageCatalog(language: MmCalendarConfig.instance.language);

  late Language _language;
  Language get language => _language;

  LanguageCatalog({Language? language}) {
    _language = language ??= MmCalendarConfig.instance.language;
  }

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
