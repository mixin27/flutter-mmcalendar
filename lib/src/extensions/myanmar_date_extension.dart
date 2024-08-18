import '../calculations/calculations.dart';
import '../config/mm_calendar_config.dart';
import '../constants/constants.dart';
import '../language/language.dart';
import '../models/models.dart';
import '../utils/calendar_utils.dart';

/// Utility extension of [MyanmarDate]
extension MyanmarDateExtension on MyanmarDate {
  /// Get `julian` day from [MyanmarDate].
  double toJulianDay() {
    return MyanmarDateCalculation.toJulian(
      year: myear,
      month: mmonth,
      monthType: monthType,
      moonPhase: moonPhase,
      fortnightDay: fortnightDay,
    );
  }

  /// Get [WesternDate] from [MyanmarDate].
  WesternDate toWesternDate({
    MmCalendarConfig? config,
    double sg = 0,
  }) {
    final jd = toJulianDay();
    return WesternDateCalculation.julianToWestern(
      julianDay: jd,
      config: config,
      sg: sg,
    );
  }

  /// Get `buddhistEra` string.
  String getBuddhistEraByLanguage(LanguageCatalog languageCatalog) {
    return convertNumberToLanguage(myear + 1182, languageCatalog);
  }

  /// Get `buddhistEra` string.
  String getBuddhistEra() {
    return getBuddhistEraByLanguage(languageCatalog);
  }

  /// Get `year` string.
  String getYearByLanguage(LanguageCatalog languageCatalog) {
    return convertNumberToLanguage(myear.toDouble(), languageCatalog);
  }

  /// Get `year` string.
  String getYear() {
    return getYearByLanguage(languageCatalog);
  }

  /// Get `month` value.
  String _getMnt(LanguageCatalog languageCatalog) {
    // 0=common, 1=little watat, 2=big watat
    String str = '';
    if (monthType > 0) {
      str += languageCatalog.translate("Late");
    }

    if (yearType > 0 && mmonth == 4) {
      str += languageCatalog.translate("Second");
    }

    return str;
  }

  /// Get `month` value.
  String getMnt() {
    return _getMnt(languageCatalog);
  }

  /// Get `month` name.
  String getMonthNameByLanguage(LanguageCatalog languageCatalog) {
    return getMnt() + languageCatalog.translate(mma[mmonth]);
  }

  /// Get `month` name.
  String getMonthName() {
    return getMonthNameByLanguage(languageCatalog);
  }

  /// Get `moonPhase` string.
  String getMoonPhaseByLanguage(LanguageCatalog languageCatalog) {
    return languageCatalog.translate(msa[moonPhase]);
  }

  /// Get `moonPhase` string.
  String getMoonPhase() {
    return getMoonPhaseByLanguage(languageCatalog);
  }

  /// Get `fortnightDay` string by [LanguageCatalog]
  String getFortnightDayByLanguage(LanguageCatalog languageCatalog) {
    return ((moonPhase % 2) == 0)
        ? convertNumberToLanguage(fortnightDay.toDouble(), languageCatalog)
        : "";
  }

  /// Get `fortnightDay` string.
  String getFortnightDay() => getFortnightDayByLanguage(languageCatalog);

  /// Get `weekday` string by [LanguageCatalog]
  String getWeekDayByLanguage(LanguageCatalog languageCatalog) {
    return languageCatalog.translate(wda[weekDay]);
  }

  /// Get `weekday` string
  String getWeekDay() => getWeekDayByLanguage(languageCatalog);

  /// Check is `weekend`
  bool isWeekend() => weekDay == 0 || weekDay == 1;

  /// Format [MyanmarDate] by pattern
  ///
  /// `pattern` - Pattern to be formatted.
  String format([
    String pattern = MyanmarDateFormat.simple,
    LanguageCatalog? langCatalog,
  ]) =>
      formatByPatternAndLanguage(
        pattern: pattern,
        langCatalog: langCatalog ?? languageCatalog,
      );

  /// Format [MyanmarDate] by pattern
  ///
  /// `pattern` - Pattern to be formatted.
  ///
  /// `languageCatalog` - Language catalog to be translated.
  String formatByPatternAndLanguage({
    String pattern = MyanmarDateFormat.simple,
    required LanguageCatalog langCatalog,
  }) {
    if (pattern.isEmpty) {
      throw Exception('Pattern cannot not be empty.');
    }

    final charArray = List<String>.empty(growable: true);
    for (var rune in pattern.runes) {
      var character = String.fromCharCode(rune);
      charArray.add(character);
    }

    String str = '';

    for (var i = 0; i < charArray.length; i++) {
      switch (charArray[i]) {
        case MyanmarDateFormat.sasanaYear:
          str += langCatalog.translate("Sasana Year");
          break;
        case MyanmarDateFormat.buddhistEra:
          str += getBuddhistEraByLanguage(langCatalog);
          break;
        case MyanmarDateFormat.burmeseYear:
          str += langCatalog.translate("Myanmar Year");
          break;
        case MyanmarDateFormat.myanmarYear:
          str += getYearByLanguage(langCatalog);
          break;
        case MyanmarDateFormat.ku:
          str += langCatalog.translate("Ku");
          break;
        case MyanmarDateFormat.monthInYear:
          str += getMonthNameByLanguage(langCatalog);
          break;
        case MyanmarDateFormat.moonPhase:
          str += getMoonPhaseByLanguage(langCatalog);
          break;
        case MyanmarDateFormat.fortnightDay:
          str += getFortnightDayByLanguage(langCatalog);
          break;
        case MyanmarDateFormat.dayNameInWeek:
          str += getWeekDayByLanguage(langCatalog);
          break;
        case MyanmarDateFormat.nay:
          if (langCatalog.language == Language.english) {
            str += " ${langCatalog.translate("Nay")}";
          } else {
            str += langCatalog.translate("Nay");
          }
          break;
        case MyanmarDateFormat.yat:
          if (getFortnightDay().isNotEmpty) {
            str += langCatalog.translate("Yat");
          }
          break;
        default:
          str += charArray[i];
          break;
      }
    }

    return str;
  }

  /// Get [MyanmarThingyan] list by [MyanmarDate].
  List<MyanmarThingyan> getMyanmarThingyanDays() {
    List<MyanmarThingyan> thingyanDays = List.empty(growable: true);
    final thingyan = getThingyan();

    final akyoDay = MyanmarThingyan(
      label: languageCatalog.translate('Thingyan Akyo'),
      jdn: thingyan.akyo.toDouble(),
      date: thingyan.akyoDate,
    );
    thingyanDays.add(akyoDay);

    final akyaDay = MyanmarThingyan(
      label: languageCatalog.translate('Thingyan Akya'),
      jdn: thingyan.akya.toDouble(),
      date: thingyan.akyaDate,
    );
    thingyanDays.add(akyaDay);

    for (var i = 0; i < thingyan.akyat.length; i++) {
      final akyatDay = MyanmarThingyan(
        label: languageCatalog.translate('Thingyan Akyat'),
        jdn: thingyan.akyat[i].toDouble(),
        date: thingyan.akyatDates[i],
      );
      thingyanDays.add(akyatDay);
    }

    final atatDay = MyanmarThingyan(
      label: languageCatalog.translate('Thingyan Atat'),
      jdn: thingyan.atat.toDouble(),
      date: thingyan.atatDate,
    );
    thingyanDays.add(atatDay);

    final newYearDay = MyanmarThingyan(
      label: languageCatalog.translate('Myanmar New Year Day'),
      jdn: thingyan.myanmarNewYearDay.toDouble(),
      date: thingyan.myanmarNewYearDate,
    );
    thingyanDays.add(newYearDay);

    return thingyanDays;
  }

  /// Get [Thingyan] holiday from [MyanmarDate]
  Thingyan getThingyan() {
    final my = myear;
    final mm = mmonth;
    final mmt = (mm / 13).floor();

    // solar year (365.2587565)
    double sy = 1577917828.0 / 4320000.0;

    // beginning of 0 ME
    double mo = 1954168.050623;

    // // start of Thingyan and third era
    int se3 = 1312;
    double atatTime = sy * (my + mmt) + mo; // atat time
    double akyaTime;

    if (my >= se3) {
      akyaTime = atatTime - 2.169918982; // akya time
    } else {
      akyaTime = atatTime - 2.1675;
    }

    // Akya
    int akn = akyaTime.round();
    // Atat
    int atn = atatTime.round();
    // Akyo
    int akyo = akn - 1;

    // Akyat start day
    int akyat = akn + 1;

    /// Akyat days
    List<int> akyats = List.empty(growable: true);
    while (akyat < atn) {
      akyats.add(akyat);
      akyat++;
    }

    return Thingyan(
      akyo: akyo,
      akya: akn,
      akyat: akyats,
      atat: atn,
    );
  }

  /// Get [Astro] from [MyanmarDate].
  ///
  /// `langCatalog` - [LanguageCatalog]. If it is null, it will use from [MyanmarDate].
  Astro getAstro({
    LanguageCatalog? langCatalog,
  }) {
    return AstroCalculation.getAstro(
      mmonth: mmonth,
      monthLength: monthLength,
      monthDay: monthDay,
      weekDay: weekDay,
      myear: myear,
      languageCatalog: langCatalog ?? languageCatalog,
    );
  }

  /// Get [Astro] from [MyanmarDate].
  Astro get astro => getAstro(langCatalog: languageCatalog);

  /// Get all holidays
  ///
  /// `langCatalog` - [LanguageCatalog]. If it is null, it will use from [MyanmarDate].
  List<String> getHolidays({LanguageCatalog? langCatalog}) {
    return HolidaysCalculation.getHolidays(this,
        languageCatalog: langCatalog ?? languageCatalog);
  }

  /// Get all holidays
  List<String> get holidays => getHolidays();
}
