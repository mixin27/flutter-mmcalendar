import 'package:flutter_mmcalendar/src/language/language_catalog.dart';
import 'package:flutter_mmcalendar/src/models/astro.dart';
import 'package:flutter_mmcalendar/src/models/enums.dart';

/// Translator for Astro information to localized strings.
class AstroTranslator {
  final LanguageCode languageCode;

  AstroTranslator({required this.languageCode});

  String translate(String key) =>
      LanguageCatalog.tr(key, langCode: languageCode);

  /// Translate an [AstroEvent] to the current language.
  String translateEvent(AstroEvent event) {
    switch (event) {
      case AstroEvent.yatyaza:
        return LanguageCatalog.tr("Yatyaza", langCode: languageCode);
      case AstroEvent.pyathada:
        return LanguageCatalog.tr("Pyathada", langCode: languageCode);
      case AstroEvent.afternoonPyathada:
        return LanguageCatalog.tr("Afternoon Pyathada", langCode: languageCode);
      case AstroEvent.sabbatheve:
        return LanguageCatalog.tr("Sabbath Eve", langCode: languageCode);
      case AstroEvent.sabbath:
        return LanguageCatalog.tr("Sabbath", langCode: languageCode);
      case AstroEvent.thamanyo:
        return LanguageCatalog.tr("Thamanyo", langCode: languageCode);
      case AstroEvent.amyeittasote:
        return LanguageCatalog.tr("Amyeittasote", langCode: languageCode);
      case AstroEvent.warameittugyi:
        return LanguageCatalog.tr("Warameittugyi", langCode: languageCode);
      case AstroEvent.warameittunge:
        return LanguageCatalog.tr("Warameittunge", langCode: languageCode);
      case AstroEvent.yatpote:
        return LanguageCatalog.tr("Yatpote", langCode: languageCode);
      case AstroEvent.thamaphyu:
        return LanguageCatalog.tr("Thamaphyu", langCode: languageCode);
      case AstroEvent.nagapor:
        return LanguageCatalog.tr("Nagapor", langCode: languageCode);
      case AstroEvent.yatyotema:
        return LanguageCatalog.tr("Yatyotema", langCode: languageCode);
      case AstroEvent.mahayatkyan:
        return LanguageCatalog.tr("Mahayatkyan", langCode: languageCode);
      case AstroEvent.shanyat:
        return LanguageCatalog.tr("Shanyat", langCode: languageCode);
    }
  }

  /// Translate all [activeEvents] in an [Astro] object
  List<String> translateActiveEvents(Astro astro) {
    return astro.activeEvents.map((e) => translateEvent(e)).toList();
  }

  String translateMahabote(int index) {
    final list = [
      "Binga",
      "Atun",
      "Yaza",
      "Adipati",
      "Marana",
      "Thike",
      "Puti",
    ];
    return LanguageCatalog.tr(list[index], langCode: languageCode);
  }

  String translateNakhat(int index) {
    final list = ["Ogre", "Elf", "Human"];
    return LanguageCatalog.tr(list[index], langCode: languageCode);
  }

  String translateNagahle(int index) {
    final list = ["West", "North", "East", "South"];
    return LanguageCatalog.tr(list[index], langCode: languageCode);
  }

  String translateYearName(int index) {
    final list = [
      "Hpusha",
      "Magha",
      "Phalguni",
      "Chitra",
      "Visakha",
      "Jyeshtha",
      "Ashadha",
      "Sravana",
      "Bhadrapaha",
      "Asvini",
      "Krittika",
      "Mrigasiras",
    ];
    return LanguageCatalog.tr(list[index], langCode: languageCode);
  }
}
