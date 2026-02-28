// ignore_for_file: public_member_api_docs

import 'package:myanmar_calendar_dart/myanmar_calendar_dart.dart';

/// Lightweight localization helpers for widget labels.
class CalendarLocalizationUtils {
  static String tr(String key, Language language, {String? fallback}) {
    final translated = TranslationService.translateTo(key, language);
    if (translated == key && fallback != null) {
      return fallback;
    }
    return translated;
  }

  static String weekday(
    int myanmarWeekday,
    Language language, {
    bool compact = false,
  }) {
    if (compact) {
      return TranslationService.getShortWeekdayName(myanmarWeekday, language);
    }
    return TranslationService.getWeekdayName(myanmarWeekday, language);
  }

  static String westernMonth(int month, Language language) {
    return TranslationService.getWesternMonthName(month, language);
  }

  static String shortWesternMonth(int month, Language language) {
    return TranslationService.getShortWesternMonthName(month, language);
  }

  static String cancel(Language language) {
    return tr('Cancel', language, fallback: 'Cancel');
  }

  static String ok(Language language) {
    return tr('OK', language, fallback: 'OK');
  }

  static String selectDate(Language language) {
    return tr('Select Date', language, fallback: 'Select Date');
  }

  static String today(Language language) {
    return tr('Today', language, fallback: 'Today');
  }

  static String clear(Language language) {
    return tr('Clear', language, fallback: 'Clear');
  }

  static String calendar(Language language) {
    return tr('Calendar', language, fallback: 'Calendar');
  }

  static String yearView(Language language) {
    return tr('Year View', language, fallback: 'Year View');
  }
}
