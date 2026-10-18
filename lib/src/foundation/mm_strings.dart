import 'package:myanmar_calendar_dart/myanmar_calendar_dart.dart';

import 'language_locale.dart';

/// The words the calendar widgets show or read out that the core library
/// doesn't translate: button tooltips and screen-reader states.
///
/// English and Myanmar are built in. For the other languages, add the
/// English text as a key with `TranslationService.addTranslation`; until
/// then they read in English.
class MmStrings {
  const MmStrings._(this.language);

  /// The strings for [language].
  factory MmStrings.of(Language language) => MmStrings._(language);

  /// The language the strings are in.
  final Language language;

  static const Map<String, String> _myanmar = {
    'Previous month': 'ယခင်လ',
    'Next month': 'နောက်လ',
    'Previous week': 'ယခင်ပတ်',
    'Next week': 'နောက်ပတ်',
    'Previous year': 'ယခင်နှစ်',
    'Next year': 'နောက်နှစ်',
    'Today': 'ယနေ့',
    'Selected': 'ရွေးထားသည်',
    'Range start': 'အစရက်',
    'Range end': 'အဆုံးရက်',
    'In range': 'ရွေးထားသော ကာလအတွင်း',
    'Unavailable': 'ရွေး၍မရ',
    'events': 'ပွဲ',
    'Nothing on these days': 'ဤရက်များတွင် ဘာမှမရှိပါ',
  };

  String _t(String key) {
    if (TranslationService.hasTranslation(key, language)) {
      return TranslationService.translateTo(key, language);
    }
    if (language == Language.myanmar) return _myanmar[key] ?? key;
    return key;
  }

  /// "Previous month".
  String get previousMonth => _t('Previous month');

  /// "Next month".
  String get nextMonth => _t('Next month');

  /// "Previous week".
  String get previousWeek => _t('Previous week');

  /// "Next week".
  String get nextWeek => _t('Next week');

  /// "Previous year".
  String get previousYear => _t('Previous year');

  /// "Next year".
  String get nextYear => _t('Next year');

  /// "Today".
  String get today => _t('Today');

  /// "Selected".
  String get selected => _t('Selected');

  /// The first day of a selected range.
  String get rangeStart => _t('Range start');

  /// The last day of a selected range.
  String get rangeEnd => _t('Range end');

  /// A day inside a selected range.
  String get inRange => _t('In range');

  /// A day that can't be selected.
  String get unavailable => _t('Unavailable');

  /// The agenda's empty state.
  String get nothingOnTheseDays => _t('Nothing on these days');

  /// "3 events", in this language's digits.
  String eventCount(int count) {
    if (language == Language.english &&
        !TranslationService.hasTranslation('events', language)) {
      return count == 1 ? '1 event' : '$count events';
    }
    return '${language.digits(count)} ${_t('events')}';
  }

  /// The Western month name, e.g. "October".
  String westernMonth(int month) =>
      TranslationService.getWesternMonthName(month, language);

  /// "October 2026", in this language.
  String westernMonthYear(DateTime month) =>
      '${westernMonth(month.month)} ${language.digits(month.year)}';

  /// The weekday's full name; [weekday] is a `DateTime` weekday.
  String weekdayName(int weekday) =>
      TranslationService.getWeekdayName(_coreWeekday(weekday), language);

  /// The weekday's short name, e.g. "Sun".
  String weekdayShort(int weekday) =>
      TranslationService.getShortWeekdayName(_coreWeekday(weekday), language);

  /// The narrowest form: one letter in English, the short name otherwise.
  String weekdayNarrow(int weekday) {
    final short = weekdayShort(weekday);
    return language == Language.english ? short.substring(0, 1) : short;
  }

  /// The Myanmar month's name, e.g. "Second Waso" in a watat year.
  String myanmarMonth(int month, int yearType) =>
      TranslationService.getMonthName(month, yearType, language);

  /// The moon phase's name: waxing, full moon, waning or new moon.
  String moonPhase(MoonPhase phase) =>
      TranslationService.getMoonPhaseName(phase.index, language);

  /// "Waxing 7", "Full Moon" or "Waning 3".
  String fortnightDay(MyanmarDate date) {
    final phase = date.phase;
    if (phase == MoonPhase.fullMoon || phase == MoonPhase.newMoon) {
      return moonPhase(phase);
    }
    return '${moonPhase(phase)} ${language.digits(date.fortnightDay)}';
  }

  /// "Thadingyut Waxing 7".
  String myanmarDate(MyanmarDate date) =>
      '${myanmarMonth(date.month, date.yearType)} ${fortnightDay(date)}';

  /// "18 October 2026".
  String westernDate(DateTime day) =>
      '${language.digits(day.day)} ${westernMonth(day.month)} '
      '${language.digits(day.year)}';

  // Core weekday indexes start on Saturday.
  static int _coreWeekday(int dartWeekday) => (dartWeekday + 1) % 7;
}
