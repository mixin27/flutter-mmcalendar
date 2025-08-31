import 'package:flutter_mmcalendar/src/config/calendar_config.dart';
import 'package:flutter_mmcalendar/src/language/language_extension.dart';
import 'package:flutter_mmcalendar/src/models/astro.dart';
import 'package:flutter_mmcalendar/src/models/enums.dart';
import 'package:flutter_mmcalendar/src/utils/astro_translator.dart';

extension AstroExtension on Astro {
  String getAstrologicalDay([AstroTranslator? translator]) {
    final tr =
        translator ??
        AstroTranslator(
          languageCode: GlobalCalendarConfig().config.language.toLanguageCode(),
        );
    String result = "";
    if (yatyaza > 0) result += tr.translateEvent(AstroEvent.yatyaza);
    if (pyathada == 1) result += tr.translateEvent(AstroEvent.pyathada);
    if (pyathada == 2) {
      result += tr.translateEvent(AstroEvent.afternoonPyathada);
    }
    return result;
  }

  bool get isSabbath => (sabbath > 0) || (sabbatheve > 0);

  String getSabbath([AstroTranslator? translator]) {
    final tr =
        translator ??
        AstroTranslator(
          languageCode: GlobalCalendarConfig().config.language.toLanguageCode(),
        );
    if (sabbath > 0) return tr.translate("Sabbath");
    if (sabbatheve > 0) return tr.translate("Sabbath Eve");
    return '';
  }

  bool get isThamanyo => thamanyo > 0;
  String getThamanyo([AstroTranslator? translator]) {
    final tr =
        translator ??
        AstroTranslator(
          languageCode: GlobalCalendarConfig().config.language.toLanguageCode(),
        );
    return isThamanyo ? tr.translateEvent(AstroEvent.thamanyo) : '';
  }

  bool get isAmyeittasote => amyeittasote > 0;
  String getAmyeittasote([AstroTranslator? translator]) {
    final tr =
        translator ??
        AstroTranslator(
          languageCode: GlobalCalendarConfig().config.language.toLanguageCode(),
        );
    return isAmyeittasote ? tr.translateEvent(AstroEvent.amyeittasote) : '';
  }

  bool get isWarameittugyi => warameittugyi > 0;
  String getWarameittugyi([AstroTranslator? translator]) {
    final tr =
        translator ??
        AstroTranslator(
          languageCode: GlobalCalendarConfig().config.language.toLanguageCode(),
        );
    return isWarameittugyi ? tr.translateEvent(AstroEvent.warameittugyi) : '';
  }

  bool get isWarameittunge => warameittunge > 0;
  String getWarameittunge([AstroTranslator? translator]) {
    final tr =
        translator ??
        AstroTranslator(
          languageCode: GlobalCalendarConfig().config.language.toLanguageCode(),
        );
    return isWarameittunge ? tr.translateEvent(AstroEvent.warameittunge) : '';
  }

  bool get isYatpote => yatpote > 0;
  String getYatpote([AstroTranslator? translator]) {
    final tr =
        translator ??
        AstroTranslator(
          languageCode: GlobalCalendarConfig().config.language.toLanguageCode(),
        );
    return isYatpote ? tr.translateEvent(AstroEvent.yatpote) : '';
  }

  bool get isThamaphyu => thamaphyu > 0;
  String getThamaphyu([AstroTranslator? translator]) {
    final tr =
        translator ??
        AstroTranslator(
          languageCode: GlobalCalendarConfig().config.language.toLanguageCode(),
        );
    return isThamaphyu ? tr.translateEvent(AstroEvent.thamaphyu) : '';
  }

  bool get isNagapor => nagapor > 0;
  String getNagapor([AstroTranslator? translator]) {
    final tr =
        translator ??
        AstroTranslator(
          languageCode: GlobalCalendarConfig().config.language.toLanguageCode(),
        );
    return isNagapor ? tr.translateEvent(AstroEvent.nagapor) : '';
  }

  bool get isYatyotema => yatyotema > 0;
  String getYatyotema([AstroTranslator? translator]) {
    final tr =
        translator ??
        AstroTranslator(
          languageCode: GlobalCalendarConfig().config.language.toLanguageCode(),
        );
    return isYatyotema ? tr.translateEvent(AstroEvent.yatyotema) : '';
  }

  bool get isMahayatkyan => mahayatkyan > 0;
  String getMahayatkyan([AstroTranslator? translator]) {
    final tr =
        translator ??
        AstroTranslator(
          languageCode: GlobalCalendarConfig().config.language.toLanguageCode(),
        );
    return isMahayatkyan ? tr.translateEvent(AstroEvent.mahayatkyan) : '';
  }

  bool get isShanyat => shanyat > 0;
  String getShanyat([AstroTranslator? translator]) {
    final tr =
        translator ??
        AstroTranslator(
          languageCode: GlobalCalendarConfig().config.language.toLanguageCode(),
        );
    return isShanyat ? tr.translateEvent(AstroEvent.shanyat) : '';
  }

  String getNagahle([AstroTranslator? translator]) {
    final tr =
        translator ??
        AstroTranslator(
          languageCode: GlobalCalendarConfig().config.language.toLanguageCode(),
        );
    return tr.translateNagahle(nagahle);
  }

  String getMahabote([AstroTranslator? translator]) {
    final tr =
        translator ??
        AstroTranslator(
          languageCode: GlobalCalendarConfig().config.language.toLanguageCode(),
        );
    return tr.translateMahabote(mahabote);
  }

  String getNakhat([AstroTranslator? translator]) {
    final tr =
        translator ??
        AstroTranslator(
          languageCode: GlobalCalendarConfig().config.language.toLanguageCode(),
        );
    return tr.translateNakhat(nakhat);
  }

  String getYearName([AstroTranslator? translator]) {
    final tr =
        translator ??
        AstroTranslator(
          languageCode: GlobalCalendarConfig().config.language.toLanguageCode(),
        );
    return tr.translateYearName(yearName);
  }
}
