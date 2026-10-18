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
    'Select date': 'ရက်စွဲ ရွေးပါ',
    'Select dates': 'ရက်များ ရွေးပါ',
    'Select range': 'ရက်အပိုင်းအခြား ရွေးပါ',
    'Choose month': 'လ ရွေးပါ',
    'Cancel': 'မလုပ်တော့',
    'OK': 'ရွေးမည်',
    'Done': 'ပြီးပြီ',
    'Clear': 'ရှင်းမည်',
    'Western': 'ခရစ်နှစ်',
    'Myanmar': 'မြန်မာ',
    'Month': 'လ',
    'Day': 'ရက်',
    'days': 'ရက်',
    'Dates': 'ရက်စွဲများ',
    'Moon': 'လ',
    'Holidays': 'ရုံးပိတ်ရက်များ',
    'Astrology': 'ဗေဒင်',
    'Shan year': 'ရှမ်းနှစ်',
    'No holidays': 'ရုံးပိတ်ရက် မရှိ',
    'Copy': 'ကူးယူရန်',
    'Tomorrow': 'မနက်ဖြန်',
    'in': '',
    'days later': 'ရက်အကြာ',
    'Upcoming holidays': 'လာမည့် ရုံးပိတ်ရက်များ',
    'Public holiday': 'ရုံးပိတ်ရက်',
    'Religious': 'ဘာသာရေး',
    'Cultural': 'ယဉ်ကျေးမှု',
    'Anniversary': 'နှစ်ပတ်လည်နေ့',
    'Other': 'အခြား',
    'Custom': 'ကိုယ်ပိုင်',
    'lit': 'လင်း',
    'Days between': 'ရက်ကွာခြားချက်',
    'From': 'မှ',
    'To': 'အထိ',
    'Add': 'ပေါင်းရန်',
    'Myanmar months': 'မြန်မာလ',
    'Swap': 'ပြောင်းရန်',
    'Horoscope': 'ဇာတာ',
    'Fortune': 'ဗေဒင်',
    'Divination': 'နိမိတ်',
    'Copy prompt': 'Prompt ကူးယူရန်',
    'History': 'ရာဇဝင်',
    'No records for this date': 'ဤရက်အတွက် မှတ်တမ်းမရှိပါ',
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

  /// A date picker's title.
  String get selectDate => _t('Select date');

  /// A multi-date picker's title.
  String get selectDates => _t('Select dates');

  /// A range picker's title.
  String get selectRange => _t('Select range');

  /// The month-year picker's tooltip.
  String get chooseMonth => _t('Choose month');

  /// "Cancel".
  String get cancel => _t('Cancel');

  /// "OK".
  String get ok => _t('OK');

  /// "Done".
  String get done => _t('Done');

  /// "Clear".
  String get clear => _t('Clear');

  /// The Western (Gregorian) calendar's name.
  String get western => _t('Western');

  /// The Myanmar calendar's name.
  String get myanmar => _t('Myanmar');

  /// "Month".
  String get month => _t('Month');

  /// "Day".
  String get day => _t('Day');

  /// "3 days", in this language's digits.
  String dayCount(int count) {
    if (language == Language.english &&
        !TranslationService.hasTranslation('days', language)) {
      return count == 1 ? '1 day' : '$count days';
    }
    return '${language.digits(count)} ${_t('days')}';
  }

  /// The day details' dates section.
  String get dates => _t('Dates');

  /// The moon section.
  String get moon => _t('Moon');

  /// The holidays section.
  String get holidays => _t('Holidays');

  /// The astrology section.
  String get astrology => _t('Astrology');

  /// "Shan year".
  String get shanYear => _t('Shan year');

  /// "Myanmar year", from the core's translations.
  String get myanmarYear => _t('Myanmar Year');

  /// "Sasana year", from the core's translations.
  String get sasanaYear => _t('Sasana Year');

  /// Shown when a day has no holidays.
  String get noHolidays => _t('No holidays');

  /// The copy button's tooltip.
  String get copy => _t('Copy');

  /// "Upcoming holidays".
  String get upcomingHolidays => _t('Upcoming holidays');

  /// "Today", "Tomorrow" or "in 8 days".
  String daysUntil(int days) {
    if (days == 0) return today;
    if (days == 1) return _t('Tomorrow');
    if (language == Language.english &&
        !TranslationService.hasTranslation('days later', language)) {
      return 'in $days days';
    }
    return '${language.digits(days)} ${_t('days later')}';
  }

  /// What kind of holiday [type] is: "Public holiday", "Religious"...
  String holidayType(HolidayType type) => _t(switch (type) {
    HolidayType.public => 'Public holiday',
    HolidayType.religious => 'Religious',
    HolidayType.cultural => 'Cultural',
    HolidayType.myanmarAnniversary ||
    HolidayType.otherAnniversary => 'Anniversary',
    HolidayType.other => 'Other',
  });

  /// A custom holiday's label.
  String get customHoliday => _t('Custom');

  /// "62% lit".
  String percentLit(int percent) => language == Language.english
      ? '$percent% lit'
      : '${language.digits(percent)}% ${_t('lit')}';

  /// "Days between".
  String get daysBetween => _t('Days between');

  /// The start of a span.
  String get from => _t('From');

  /// The end of a span.
  String get to => _t('To');

  /// "Add".
  String get add => _t('Add');

  /// The unit of Myanmar months.
  String get myanmarMonths => _t('Myanmar months');

  /// The swap button's label.
  String get swap => _t('Swap');

  /// The AI prompt kinds.
  String get horoscope => _t('Horoscope');

  /// See [horoscope].
  String get fortune => _t('Fortune');

  /// See [horoscope].
  String get divination => _t('Divination');

  /// "Copy prompt".
  String get copyPrompt => _t('Copy prompt');

  /// The chronicle card's title.
  String get history => _t('History');

  /// The chronicle card's empty state.
  String get noRecords => _t('No records for this date');

  /// A core term (Sabbath, Yatyaza, Human, East...) in this language.
  String term(String key) => TranslationService.translateTo(key, language);

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

  /// "18 Oct".
  String westernShort(DateTime day) =>
      '${language.digits(day.day)} '
      '${TranslationService.getShortWesternMonthName(day.month, language)}';

  /// "18 October 2026".
  String westernDate(DateTime day) =>
      '${language.digits(day.day)} ${westernMonth(day.month)} '
      '${language.digits(day.year)}';

  // Core weekday indexes start on Saturday.
  static int _coreWeekday(int dartWeekday) => (dartWeekday + 1) % 7;
}
