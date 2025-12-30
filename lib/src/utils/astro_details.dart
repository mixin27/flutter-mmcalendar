import 'package:flutter_mmcalendar/src/localization/language.dart';
import 'package:flutter_mmcalendar/src/localization/translation_service.dart';

/// Descriptive information for Myanmar astrological elements
class AstroDetails {
  /// Get description for Nakhat type
  static String getNakhatDescription(String nakhat, {Language? language}) {
    final key = 'desc_${nakhat.toLowerCase()}';
    if (TranslationService.hasTranslation(key)) {
      return language != null
          ? TranslationService.translateTo(key, language)
          : TranslationService.translate(key);
    }
    return language != null
        ? TranslationService.translateTo('desc_not_available', language)
        : TranslationService.translate('desc_not_available');
  }

  /// Get characteristics for Mahabote type
  static String getMahaboteCharacteristics(
    String mahabote, {
    Language? language,
  }) {
    final key = 'desc_${mahabote.toLowerCase()}';
    if (TranslationService.hasTranslation(key)) {
      return language != null
          ? TranslationService.translateTo(key, language)
          : TranslationService.translate(key);
    }
    return language != null
        ? TranslationService.translateTo('desc_not_available', language)
        : TranslationService.translate('desc_not_available');
  }

  /// Get description for astrological days
  static String getAstrologicalDayDescription(
    String dayName, {
    Language? language,
  }) {
    final key = 'desc_${dayName.toLowerCase()}';
    if (TranslationService.hasTranslation(key)) {
      return language != null
          ? TranslationService.translateTo(key, language)
          : TranslationService.translate(key);
    }
    return language != null
        ? TranslationService.translateTo('desc_not_available', language)
        : TranslationService.translate('desc_not_available');
  }
}
