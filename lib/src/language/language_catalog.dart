import 'package:flutter_mmcalendar/src/config/calendar_config.dart';
import 'package:flutter_mmcalendar/src/language/language_extension.dart';

import 'translations.dart';

enum LanguageCode { english, myanmarUnicode, myanmarZawgyi, mon, karen, tai }

class LanguageCatalog {
  static const Map<LanguageCode, Map<String, String>> catalogs = {
    LanguageCode.english: langEngMap,
    LanguageCode.myanmarUnicode: langMyanmarUnicode,
    LanguageCode.myanmarZawgyi: langMyanmarZawgyi,
    LanguageCode.mon: langMonMap,
    LanguageCode.karen: langKarenMap,
    LanguageCode.tai: langTaiMap,
  };

  /// Get translated value
  static String tr(String key, {LanguageCode? langCode}) {
    final lang =
        langCode ?? GlobalCalendarConfig().config.language.toLanguageCode();
    return catalogs[lang]?[key] ?? langEngMap[key] ?? key;
  }
}
