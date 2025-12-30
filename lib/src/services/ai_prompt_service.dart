import 'package:flutter_mmcalendar/src/localization/language.dart';
import 'package:flutter_mmcalendar/src/localization/translation_service.dart';
import 'package:flutter_mmcalendar/src/models/complete_date.dart';
import 'package:flutter_mmcalendar/src/utils/astro_details.dart';
import 'package:flutter_mmcalendar/src/utils/date_extension.dart';

/// Types of AI prompts that can be generated
enum AIPromptType {
  /// General horoscope reading
  horoscope,

  /// Focus on future predictions, career, and wealth
  fortuneTelling,

  /// Focus on spiritual guidance and inner growth
  divination,
}

/// Service to generate structured AI prompts for astrological information
class AIPromptService {
  /// Generate a structured AI prompt for the given [date] and [language]
  static String generatePrompt(
    CompleteDate date, {
    Language? language,
    AIPromptType type = AIPromptType.horoscope,
  }) {
    final lang = language ?? TranslationService.currentLanguage;
    final buffer = StringBuffer();

    // Introduction
    final introKey = _getIntroKey(type);
    buffer.writeln(TranslationService.translateTo(introKey, lang));
    buffer.writeln();

    // Western Date
    buffer.writeln(
      '${TranslationService.translateTo('Western Date', lang)}: ${date.western.format()}',
    );

    // Myanmar Date
    buffer.writeln(
      '${TranslationService.translateTo('Myanmar Date', lang)}: ${date.myanmar.format(language: lang)}',
    );
    buffer.writeln();

    // Nakhat
    final nakhatName = TranslationService.translateTo(date.astro.nakhat, lang);
    final nakhatDesc = AstroDetails.getNakhatDescription(
      date.astro.nakhat,
      language: lang,
    );
    buffer.writeln(
      '${TranslationService.translateTo('Nakhat', lang)}: $nakhatName',
    );
    buffer.writeln(
      '${TranslationService.translateTo('Description', lang)}: $nakhatDesc',
    );
    buffer.writeln();

    // Mahabote
    final mahaboteName = TranslationService.translateTo(
      date.astro.mahabote,
      lang,
    );
    final mahaboteDesc = AstroDetails.getMahaboteCharacteristics(
      date.astro.mahabote,
      language: lang,
    );
    buffer.writeln(
      '${TranslationService.translateTo('Mahabote', lang)}: $mahaboteName',
    );
    buffer.writeln(
      '${TranslationService.translateTo('Characteristics', lang)}: $mahaboteDesc',
    );
    buffer.writeln();

    // Astrological Days
    final days = date.astro.astrologicalDays;
    if (days.isNotEmpty) {
      buffer.writeln(
        '${TranslationService.translateTo('Astrological Days', lang)}:',
      );
      for (final day in days) {
        final dayName = TranslationService.translateTo(day, lang);
        final dayDesc = AstroDetails.getAstrologicalDayDescription(
          day,
          language: lang,
        );
        buffer.writeln('- $dayName: $dayDesc');
      }
      buffer.writeln();
    }

    // Naga Head
    final nagaDir = TranslationService.translateTo(date.astro.nagahle, lang);
    buffer.writeln(
      '${TranslationService.translateTo('Naga Head', lang)}: $nagaDir',
    );
    buffer.writeln();

    // Analysis Request
    final requestKey = _getRequestKey(type);
    buffer.writeln(TranslationService.translateTo(requestKey, lang));

    return buffer.toString();
  }

  static String _getIntroKey(AIPromptType type) {
    switch (type) {
      case AIPromptType.horoscope:
        return 'prompt_intro';
      case AIPromptType.fortuneTelling:
        return 'prompt_fortune_telling_intro';
      case AIPromptType.divination:
        return 'prompt_divination_intro';
    }
  }

  static String _getRequestKey(AIPromptType type) {
    switch (type) {
      case AIPromptType.horoscope:
        return 'prompt_analysis_req';
      case AIPromptType.fortuneTelling:
        return 'prompt_fortune_telling_req';
      case AIPromptType.divination:
        return 'prompt_divination_req';
    }
  }
}
