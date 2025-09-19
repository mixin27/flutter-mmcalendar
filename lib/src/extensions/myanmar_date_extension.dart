import 'package:flutter_mmcalendar/src/config/calendar_config.dart';
import 'package:flutter_mmcalendar/src/core/calculations.dart';
import 'package:flutter_mmcalendar/src/core/constants.dart';
import 'package:flutter_mmcalendar/src/language/language_catalog.dart';
import 'package:flutter_mmcalendar/src/language/language_extension.dart';
import 'package:flutter_mmcalendar/src/models/astro.dart';
import 'package:flutter_mmcalendar/src/models/date.dart';
import 'package:flutter_mmcalendar/src/models/thingyan.dart';
import 'package:flutter_mmcalendar/src/utils/utils.dart';

/// Utility extension for [MyanmarDate].
/// Uses global config for language and calendar settings.
extension MyanmarDateExtension on MyanmarDate {
  /// Julian day number.
  double toJulianDay() {
    return MyanmarDateCalculation.toJulian(
      year: myear,
      month: mmonth,
      monthType: monthType,
      moonPhase: moonPhase,
      fortnightDay: fortnightDay,
    );
  }

  /// Convert to Western date.
  WesternDate toWesternDate({double? sg}) {
    final jd = toJulianDay();
    return WesternDateCalculation.julianToWestern(julianDay: jd);
  }

  /// Buddhist era string.
  String getBuddhistEra() => convertNumberToLanguage(myear + 1182);

  /// Myanmar year string.
  String getYear() => convertNumberToLanguage(myear.toDouble());

  /// Month type prefix (Late/Second).
  String _getMnt() {
    String str = '';
    if (monthType > 0) str += LanguageCatalog.tr("Late");
    if (yearType > 0 && mmonth == 4) str += LanguageCatalog.tr("Second");
    return str;
  }

  /// Month name string.
  String getMonthName() => "${_getMnt()} ${LanguageCatalog.tr(mma[mmonth])}";

  /// Moon phase string.
  String getMoonPhase() => LanguageCatalog.tr(msa[moonPhase]);

  /// Check moon phase - Waxing
  bool get isWaxingMoon =>
      moonPhase == 0; // ["waxing", "full moon", "waning", "new moon"]

  /// Check moon phase - Full Moon
  bool get isFullMoon =>
      moonPhase == 1; // ["waxing", "full moon", "waning", "new moon"]

  /// Check moon phase - Waning
  bool get isWaningMoon =>
      moonPhase == 2; // ["waxing", "full moon", "waning", "new moon"]

  /// Check moon phase - New Moon
  bool get isNewMoon =>
      moonPhase == 3; // ["waxing", "full moon", "waning", "new moon"]

  /// Fortnight day string.
  String getFortnightDay() => ((moonPhase % 2) == 0)
      ? convertNumberToLanguage(fortnightDay.toDouble())
      : '';

  /// Weekday string.
  String getWeekDay() => LanguageCatalog.tr(wda[weekDay]);

  /// Check if weekend.
  bool isWeekend() => weekDay == 0 || weekDay == 1;

  /// Format MyanmarDate with pattern.
  String format([String pattern = MyanmarDateFormat.simple]) => formatByPattern(
    pattern,
    langCode: GlobalCalendarConfig().config.language.toLanguageCode(),
  );

  String formatByPattern(String pattern, {LanguageCode? langCode}) {
    if (pattern.isEmpty) throw Exception('Pattern cannot be empty.');

    final language =
        langCode?.toLanguage() ?? GlobalCalendarConfig().config.language;
    final buffer = StringBuffer();
    final charArray = pattern.runes.map((r) => String.fromCharCode(r)).toList();

    for (var char in charArray) {
      switch (char) {
        case MyanmarDateFormat.sasanaYear:
          buffer.write(LanguageCatalog.tr("Sasana Year", langCode: langCode));
          break;
        case MyanmarDateFormat.buddhistEra:
          buffer.write(getBuddhistEra());
          break;
        case MyanmarDateFormat.burmeseYear:
          buffer.write(LanguageCatalog.tr("Myanmar Year", langCode: langCode));
          break;
        case MyanmarDateFormat.myanmarYear:
          buffer.write(getYear());
          break;
        case MyanmarDateFormat.ku:
          buffer.write(LanguageCatalog.tr("Ku", langCode: langCode));
          break;
        case MyanmarDateFormat.monthInYear:
          buffer.write(getMonthName());
          break;
        case MyanmarDateFormat.moonPhase:
          buffer.write(getMoonPhase());
          break;
        case MyanmarDateFormat.fortnightDay:
          buffer.write(getFortnightDay());
          break;
        case MyanmarDateFormat.dayNameInWeek:
          buffer.write(getWeekDay());
          break;
        case MyanmarDateFormat.nay:
          buffer.write(LanguageCatalog.tr("Nay", langCode: langCode));
          break;
        case MyanmarDateFormat.yat:
          if (getFortnightDay().isNotEmpty) {
            buffer.write(LanguageCatalog.tr("Yat", langCode: langCode));
          }
          break;
        case ",":
          buffer.write(language.punctuationMark);
          break;
        case ".":
          buffer.write(language.punctuation);
          break;
        default:
          buffer.write(char);
      }
    }
    return buffer.toString();
  }

  /// Thingyan days.
  List<MyanmarThingyan> getMyanmarThingyanDays() {
    final thingyan = getThingyan();
    final days = <MyanmarThingyan>[];

    days.add(
      MyanmarThingyan(
        label: LanguageCatalog.tr('Thingyan Akyo'),
        jdn: thingyan.akyo.toDouble(),
        date: thingyan.akyoDate,
      ),
    );

    days.add(
      MyanmarThingyan(
        label: LanguageCatalog.tr('Thingyan Akya'),
        jdn: thingyan.akya.toDouble(),
        date: thingyan.akyaDate,
      ),
    );

    for (int i = 0; i < thingyan.akyat.length; i++) {
      days.add(
        MyanmarThingyan(
          label: LanguageCatalog.tr('Thingyan Akyat'),
          jdn: thingyan.akyat[i].toDouble(),
          date: thingyan.akyatDates[i],
        ),
      );
    }

    days.add(
      MyanmarThingyan(
        label: LanguageCatalog.tr('Thingyan Atat'),
        jdn: thingyan.atat.toDouble(),
        date: thingyan.atatDate,
      ),
    );

    days.add(
      MyanmarThingyan(
        label: LanguageCatalog.tr('Myanmar New Year Day'),
        jdn: thingyan.myanmarNewYearDay.toDouble(),
        date: thingyan.myanmarNewYearDate,
      ),
    );

    return days;
  }

  /// Thingyan calculation.
  Thingyan getThingyan() {
    final my = myear;
    final mm = mmonth;
    final mmt = (mm / 13).floor();
    double sy = 1577917828.0 / 4320000.0;
    double mo = 1954168.050623;

    int se3 = 1312;
    double atatTime = sy * (my + mmt) + mo;
    double akyaTime = (my >= se3) ? atatTime - 2.169918982 : atatTime - 2.1675;

    int akn = akyaTime.round();
    int atn = atatTime.round();
    int akyo = akn - 1;

    List<int> akyats = [];
    int akyat = akn + 1;
    while (akyat < atn) {
      akyats.add(akyat);
      akyat++;
    }

    return Thingyan(akyo: akyo, akya: akn, akyat: akyats, atat: atn);
  }

  /// Astro information.
  Astro get astro => AstroCalculation.getAstro(
    mmonth: mmonth,
    monthLength: monthLength,
    monthDay: monthDay,
    weekDay: weekDay,
    myear: myear,
  );

  /// Holidays.
  List<String> get holidays => HolidaysCalculation.getHolidays(this);
}
