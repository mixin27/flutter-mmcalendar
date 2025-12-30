/// ------------------------------------------------------------
/// Translation service.
///
/// Based on original algorithms by: [Dr Yan Naing Aye]
/// Source: https://github.com/yan9a/mmcal
/// Language: [Original Language, e.g. CPP/JavaScript]
/// License: [License type, MIT]
///
/// Dart/Flutter conversion and adaptations by: Kyaw Zayar Tun
/// Website: https://github.com/mixin27
///
/// Notes:
/// - Most of translations originate from the above source.
/// - This implementation is a re-creation in Dart, with
///   modifications and optimizations for Flutter usage.
/// ------------------------------------------------------------
library;

import 'language.dart';

/// Service for translating text between different languages
class TranslationService {
  /// Current language setting
  static Language _currentLanguage = Language.english;

  /// Get current language
  static Language get currentLanguage => _currentLanguage;

  /// Set current language
  static void setLanguage(Language language) {
    _currentLanguage = language;
  }

  /// Translate a key to the current language
  static String translate(String key) {
    return _translations[key]?[_currentLanguage] ?? key;
  }

  /// Translate a key to a specific language
  static String translateTo(String key, Language language) {
    return _translations[key]?[language] ?? key;
  }

  /// Get all available translations for a key
  static Map<Language, String>? getTranslations(String key) {
    return _translations[key];
  }

  /// Check if a translation exists for a key
  static bool hasTranslation(String key, [Language? language]) {
    language ??= _currentLanguage;
    return _translations[key]?.containsKey(language) ?? false;
  }

  /// Add or update a translation
  static void addTranslation(
    String key,
    Language language,
    String translation,
  ) {
    _translations[key] ??= {};
    _translations[key]![language] = translation;
  }

  /// Remove a translation
  static void removeTranslation(String key, [Language? language]) {
    if (language == null) {
      _translations.remove(key);
    } else {
      _translations[key]?.remove(language);
    }
  }

  /// Get all translation keys
  static List<String> get allKeys => _translations.keys.toList();

  /// Get month name by index (0-14)
  static String getMonthName(
    int monthIndex,
    int yearType, [
    Language? language,
  ]) {
    language ??= _currentLanguage;

    const months = [
      'First Waso', // 0
      'Tagu', // 1
      'Kason', // 2
      'Nayon', // 3
      'Waso', // 4
      'Wagaung', // 5
      'Tawthalin', // 6
      'Thadingyut', // 7
      'Tazaungmon', // 8
      'Nadaw', // 9
      'Pyatho', // 10
      'Tabodwe', // 11
      'Tabaung', // 12
      'Late Tagu', // 13
      'Late Kason', // 14
    ];

    if (monthIndex >= 0 && monthIndex < months.length) {
      var monthName = TranslationService.translate(months[monthIndex]);

      // // Handle special cases for watat years
      if (monthIndex == 4 && yearType > 0) {
        monthName = '${TranslationService.translate('Second')} $monthName';
      }

      return monthName;
    }
    return monthIndex.toString();
  }

  /// Get month name by index (0-14)
  static String getWesternMonthName(int monthIndex, [Language? language]) {
    language ??= _currentLanguage;
    const months = [
      'January',
      'February',
      'March',
      'April',
      'May',
      'June',
      'July',
      'August',
      'September',
      'October',
      'November',
      'December',
    ];

    if (monthIndex >= 0 && monthIndex < months.length) {
      return translateTo(months[monthIndex], language);
    }
    return monthIndex.toString();
  }

  /// Get month name by index (0-14)
  static String getShortWesternMonthName(int monthIndex, [Language? language]) {
    language ??= _currentLanguage;
    const months = [
      'Jan',
      'Feb',
      'Mar',
      'Apr',
      'May',
      'Jun',
      'Jul',
      'Aug',
      'Sep',
      'Oct',
      'Nov',
      'Dec',
    ];

    if (monthIndex >= 0 && monthIndex < months.length) {
      return translateTo(months[monthIndex], language);
    }
    return monthIndex.toString();
  }

  /// Get weekday name by index (0-6)
  static String getWeekdayName(int weekdayIndex, [Language? language]) {
    language ??= _currentLanguage;
    const weekdays = [
      'Saturday',
      'Sunday',
      'Monday',
      'Tuesday',
      'Wednesday',
      'Thursday',
      'Friday',
    ];

    if (weekdayIndex >= 0 && weekdayIndex < weekdays.length) {
      return translateTo(weekdays[weekdayIndex], language);
    }
    return weekdayIndex.toString();
  }

  /// Get short weekday name by index (0-6)
  static String getShortWeekdayName(int weekdayIndex, [Language? language]) {
    language ??= _currentLanguage;
    const weekdays = ['wSat', 'wSun', 'wMon', 'wTue', 'wWed', 'wThu', 'wFri'];

    if (weekdayIndex >= 0 && weekdayIndex < weekdays.length) {
      return translateTo(weekdays[weekdayIndex], language);
    }
    return weekdayIndex.toString();
  }

  /// Get moon phase name by index (0-3)
  static String getMoonPhaseName(int phaseIndex, [Language? language]) {
    language ??= _currentLanguage;
    const phases = ['Waxing', 'Full Moon', 'Waning', 'New Moon'];

    if (phaseIndex >= 0 && phaseIndex < phases.length) {
      return translateTo(phases[phaseIndex], language);
    }
    return phaseIndex.toString();
  }

  /// Get year type name by index (0-2)
  static String getYearTypeName(int yearTypeIndex, [Language? language]) {
    language ??= _currentLanguage;
    const yearTypes = ['Common Year', 'Little Watat', 'Big Watat'];

    if (yearTypeIndex >= 0 && yearTypeIndex < yearTypes.length) {
      return translateTo(yearTypes[yearTypeIndex], language);
    }
    return yearTypeIndex.toString();
  }

  static final Map<String, Map<Language, String>> _translations = {
    // Core calendar terms
    'Myanmar Year': {
      Language.english: 'Myanmar Year',
      Language.myanmar: 'မြန်မာနှစ်',
      Language.zawgyi: 'ျမန္မာႏွစ္',
      Language.mon: 'သက္ကရာဇ်ဍုၚ်',
      Language.shan: 'ပီ​​ၵေႃးၸႃႇ',
      Language.karen: 'ကီၢ်ပယီၤ',
    },
    'Sasana Year': {
      Language.english: 'Sasana Year',
      Language.myanmar: 'သာသနာနှစ်',
      Language.zawgyi: 'သာသနာႏွစ္',
      Language.mon: 'သက္ကရာဇ်သာသနာ',
      Language.shan: 'ပီသႃႇသၼႃႇ',
      Language.karen: 'နံၣ်သာသနာ',
    },
    // Month names
    'Tagu': {
      Language.english: 'Tagu',
      Language.myanmar: 'တန်ခူး',
      Language.zawgyi: 'တန္ခူး',
      Language.mon: 'ဂိတုစဲ',
      Language.shan: 'ၸၢၵ်ႉ',
      Language.karen: 'လၜူတါ',
    },
    'Kason': {
      Language.english: 'Kason',
      Language.myanmar: 'ကဆုန်',
      Language.zawgyi: 'ကဆုန္',
      Language.mon: 'ဂိတုပသာခ်',
      Language.shan: 'ၸွမ်း',
      Language.karen: 'ဒါၩႃ',
    },
    'Late Kason': {
      Language.english: 'Late Kason',
      Language.myanmar: 'နှောင်းကဆုန်',
      Language.zawgyi: 'ေႏွာင္းကဆုန္',
      Language.mon: 'နှောင်းဂိတုပသာခ်',
      Language.shan: 'ဝၢႆးၸွမ်း',
      Language.karen: 'စဲၤဒါၩႃ',
    },
    'Nayon': {
      Language.english: 'Nayon',
      Language.myanmar: 'နယုန်',
      Language.zawgyi: 'နယုန္',
      Language.mon: 'ဂိတုဇဲးခ်',
      Language.shan: 'ၼွင်း',
      Language.karen: 'လၜူနွါ',
    },
    'Waso': {
      Language.english: 'Waso',
      Language.myanmar: 'ဝါဆို',
      Language.zawgyi: 'ဝါဆို',
      Language.mon: 'ဂိတုဒ္ဂိုန်',
      Language.shan: 'ပၢႆ်ႇ',
      Language.karen: 'လၜူဇိး',
    },
    'Wagaung': {
      Language.english: 'Wagaung',
      Language.myanmar: 'ဝါခေါင်',
      Language.zawgyi: 'ဝါေခါင္',
      Language.mon: 'ဂိတုတ္တဲသ်',
      Language.shan: 'ဝၵ်း',
      Language.karen: 'လၜူတး',
    },
    'Tawthalin': {
      Language.english: 'Tawthalin',
      Language.myanmar: 'တော်သလင်း',
      Language.zawgyi: 'ေတာ္သလင္း',
      Language.mon: 'ဂိတုဘတ်',
      Language.shan: 'သိပ်း',
      Language.karen: 'ဆါးမုဲါ',
    },
    'Thadingyut': {
      Language.english: 'Thadingyut',
      Language.myanmar: 'သီတင်းကျွတ်',
      Language.zawgyi: 'သီတင္းကြ်တ္',
      Language.mon: 'ဂိတုဝှ်',
      Language.shan: 'သိပ်းဢဵတ်း',
      Language.karen: 'ဆံးဆၣ်',
    },
    'Tazaungmon': {
      Language.english: 'Tazaungmon',
      Language.myanmar: 'တန်ဆောင်မုန်း',
      Language.zawgyi: 'တန္ေဆာင္မုန္း',
      Language.mon: 'ဂိတုက္ထိုန်',
      Language.shan: 'သိပ်းသွင်',
      Language.karen: 'လါနီ',
    },
    'Nadaw': {
      Language.english: 'Nadaw',
      Language.myanmar: 'နတ်တော်',
      Language.zawgyi: 'နတ္ေတာ္',
      Language.mon: 'ဂိတုမြေက္ကသဵု',
      Language.shan: 'ၸဵင်',
      Language.karen: 'လါပျုၤ',
    },
    'Pyatho': {
      Language.english: 'Pyatho',
      Language.myanmar: 'ပြာသို',
      Language.zawgyi: "ျပာသို",
      Language.mon: 'ဂိတုပှော်',
      Language.shan: 'ၵမ်',
      Language.karen: 'သလ့ၤ',
    },
    'Tabodwe': {
      Language.english: 'Tabodwe',
      Language.myanmar: 'တပို့တွဲ',
      Language.zawgyi: 'တပို႔တြဲ',
      Language.mon: 'ဂိတုမာ်',
      Language.shan: 'သၢမ်',
      Language.karen: 'ထ့ကူး',
    },
    'Tabaung': {
      Language.english: 'Tabaung',
      Language.myanmar: 'တပေါင်း',
      Language.zawgyi: 'တေပါင္း',
      Language.mon: 'ဂိတုဖဝ်ရဂိုန်',
      Language.shan: 'သီႇ',
      Language.karen: 'သွ့ကီ',
    },
    'First': {
      Language.english: 'First',
      Language.myanmar: 'ပ',
      Language.zawgyi: 'ပ',
      Language.mon: 'ပ',
      Language.shan: 'ပ',
      Language.karen: '၁ ',
    },
    'Second': {
      Language.english: 'Second',
      Language.myanmar: 'ဒု',
      Language.zawgyi: 'ဒု',
      Language.mon: 'ဒု',
      Language.shan: 'တု',
      Language.karen: '၂ ',
    },
    'Late': {
      Language.english: 'Late',
      Language.myanmar: 'နှောင်း',
      Language.zawgyi: "ေႏွာင္း",
      Language.mon: 'နှောင်း',
      Language.shan: 'ဝၢႆး',
      Language.karen: 'စဲၤ',
    },
    // Moon phase
    'Waxing': {
      Language.english: 'Waxing',
      Language.myanmar: 'လဆန်း',
      Language.zawgyi: "လဆန္း",
      Language.mon: 'မံက်',
      Language.shan: 'လိူၼ်မႂ်ႇ',
      Language.karen: 'လါထီၣ်',
    },
    'Waning': {
      Language.english: 'Waning',
      Language.myanmar: 'လဆုတ်',
      Language.zawgyi: "လဆုတ္",
      Language.mon: 'စွေက်',
      Language.shan: 'လိူၼ်လွင်ႈ',
      Language.karen: 'လါလီၤ',
    },
    'Full Moon': {
      Language.english: 'Full Moon',
      Language.myanmar: 'လပြည့်',
      Language.zawgyi: "လျပည့္",
      Language.mon: 'ပေၚ်',
      Language.shan: 'လိူၼ်မူၼ်း',
      Language.karen: 'လါပှဲၤ',
    },
    'New Moon': {
      Language.english: 'New Moon',
      Language.myanmar: 'လကွယ်',
      Language.zawgyi: "လကြယ္",
      Language.mon: 'အိုတ်',
      Language.shan: 'လိူၼ်လပ်း',
      Language.karen: 'လါဘၢ',
    },
    'Nay': {
      Language.english: 'Nay',
      Language.myanmar: 'နေ့',
      Language.zawgyi: "ေန႔",
      Language.mon: 'တ္ၚဲ',
      Language.shan: 'ဝၼ်း',
      Language.karen: 'နံၤ',
    },
    'Day': {
      Language.english: 'Day',
      Language.myanmar: 'နေ့',
      Language.zawgyi: "ေန႔",
      Language.mon: 'တ္ၚဲ',
      Language.shan: 'ဝၼ်း',
      Language.karen: 'နံၤ',
    },
    'Yat': {
      Language.english: 'Yat',
      Language.myanmar: 'ရက်',
      Language.zawgyi: "ရက္",
      Language.mon: 'ရက်',
      Language.shan: 'ဝၼ်း',
      Language.karen: 'ရက်',
    },
    'Year': {
      Language.english: 'Year',
      Language.myanmar: 'နှစ်',
      Language.zawgyi: "ႏွစ္",
      Language.mon: 'နှစ်',
      Language.shan: 'ပီ',
      Language.karen: 'နံၣ်',
    },
    'Ku': {
      Language.english: 'Ku',
      Language.myanmar: 'ခု',
      Language.zawgyi: 'ခု',
      Language.mon: 'သၞာံ',
      Language.shan: 'ၶု',
      Language.karen: '',
    },
    // English month names
    'January': {
      Language.english: 'January',
      Language.myanmar: 'ဇန်နဝါရီ',
      Language.zawgyi: 'ဇန္နဝါရီ',
      Language.mon: 'ဂျာန်နျူအာရဳ',
      Language.shan: 'ၶၸၼ်ႇဝႃႇရီႇ',
      Language.karen: 'ယနူၤအါရံၤ',
    },
    'February': {
      Language.english: 'February',
      Language.myanmar: 'ဖေဖော်ဝါရီ',
      Language.zawgyi: "ေဖေဖာ္ဝါရီ",
      Language.mon: 'ဝှေဝ်ဗျူအာရဳ',
      Language.shan: 'ၾႅပ်ႉဝႃႇရီႇ',
      Language.karen: 'ဖ့ၤဘြူၤအါရံၤ',
    },
    'March': {
      Language.english: 'March',
      Language.myanmar: 'မတ်',
      Language.zawgyi: 'မတ္',
      Language.mon: 'မာတ်ချ်',
      Language.shan: 'မျၢတ်ႉၶျ်',
      Language.karen: 'မၢ်ၡး',
    },
    'April': {
      Language.english: 'April',
      Language.myanmar: 'ဧပြီ',
      Language.zawgyi: 'ဧၿပီ',
      Language.mon: 'ဨပြေယ်လ်',
      Language.shan: 'ဢေႇပရႄႇ',
      Language.karen: 'အ့ဖြ့ၣ်',
    },
    'May': {
      Language.english: 'May',
      Language.myanmar: 'မေ',
      Language.zawgyi: "ေမ",
      Language.mon: 'မေ',
      Language.shan: 'မေ',
      Language.karen: 'မ့ၤ',
    },
    'June': {
      Language.english: 'June',
      Language.myanmar: 'ဇွန်',
      Language.zawgyi: 'ဇြန္',
      Language.mon: 'ဂျုန်',
      Language.shan: 'ၵျုၼ်ႇ',
      Language.karen: 'ယူၤ',
    },
    'July': {
      Language.english: 'July',
      Language.myanmar: 'ဇူလိုင်',
      Language.zawgyi: 'ဇူလိုင္',
      Language.mon: 'ဂျူလာၚ်',
      Language.shan: 'ၵျူႇလၢႆႇ',
      Language.karen: 'ယူၤလံ',
    },
    'August': {
      Language.english: 'August',
      Language.myanmar: 'ဩဂုတ်',
      Language.zawgyi: 'ဩဂုတ္',
      Language.mon: 'အဝ်ဂါတ်',
      Language.shan: 'ဢေႃးၵၢတ်ႉ',
      Language.karen: 'အီကူး',
    },
    'September': {
      Language.english: 'September',
      Language.myanmar: 'စက်တင်ဘာ',
      Language.zawgyi: 'စက္တင္ဘာ',
      Language.mon: 'သိတ်ထီဗာ',
      Language.shan: 'သႅပ်ႇထႅမ်ႇပႃႇ',
      Language.karen: 'စဲးပတ့ဘၢၣ်',
    },
    'October': {
      Language.english: 'October',
      Language.myanmar: 'အောက်တိုဘာ',
      Language.zawgyi: "ေအာက္တိုဘာ",
      Language.mon: 'အံက်ထဝ်ဗာ',
      Language.shan: 'ဢွၵ်ႇထူဝ်ႇပႃႇ',
      Language.karen: 'အီးကထိဘၢၣ်',
    },
    'November': {
      Language.english: 'November',
      Language.myanmar: 'နိုဝင်ဘာ',
      Language.zawgyi: 'နိုဝင္ဘာ',
      Language.mon: 'နဝ်ဝါမ်ဗာ',
      Language.shan: 'ၼူဝ်ႇဝႅမ်ႇပႃႇ',
      Language.karen: 'နိၣ်ဝ့ဘၢၣ်',
    },
    'December': {
      Language.english: 'December',
      Language.myanmar: 'ဒီဇင်ဘာ',
      Language.zawgyi: 'ဒီဇင္ဘာ',
      Language.mon: 'ဒီဇြေန်ဗာ',
      Language.shan: 'တီႇသႅမ်ႇပႃႇ',
      Language.karen: 'ဒံၣ်စ့ဘၢၣ်',
    },
    'Jan': {
      Language.english: 'Jan',
      Language.myanmar: 'ဇန်',
      Language.zawgyi: 'ဇန္',
      Language.mon: 'Jan',
      Language.shan: 'Jan',
      Language.karen: 'Jan',
    },
    'Feb': {
      Language.english: 'Feb',
      Language.myanmar: 'ဖေ',
      Language.zawgyi: "ေဖ",
      Language.mon: 'Feb',
      Language.shan: 'Feb',
      Language.karen: 'Feb',
    },
    'Mar': {
      Language.english: 'Mar',
      Language.myanmar: 'မတ်',
      Language.zawgyi: 'မတ္',
      Language.mon: 'မာတ်ချ်',
      Language.shan: 'မျၢတ်ႉၶျ်',
      Language.karen: 'မၢ်ၡး',
    },
    'Apr': {
      Language.english: 'Apr',
      Language.myanmar: 'ဧပြီ',
      Language.zawgyi: 'ဧၿပီ',
      Language.mon: 'ဨပြေယ်လ်',
      Language.shan: 'ဢေႇပရႄႇ',
      Language.karen: 'အ့ဖြ့ၣ်',
    },
    'Jun': {
      Language.english: 'Jun',
      Language.myanmar: 'ဇွန်',
      Language.zawgyi: 'ဇြန္',
      Language.mon: 'ဂျုန်',
      Language.shan: 'ၵျုၼ်ႇ',
      Language.karen: 'ယူၤ',
    },
    'Jul': {
      Language.english: 'Jul',
      Language.myanmar: 'ဇူ',
      Language.zawgyi: 'ဇူ',
      Language.mon: 'ဂျူ',
      Language.shan: 'Jul',
      Language.karen: 'Jul',
    },
    'Aug': {
      Language.english: 'Aug',
      Language.myanmar: 'ဩ',
      Language.zawgyi: 'ဩ',
      Language.mon: 'အဝ်ဂါတ်',
      Language.shan: 'ဢေႃးၵၢတ်ႉ',
      Language.karen: 'အီကူး',
    },
    'Sep': {
      Language.english: 'Sep',
      Language.myanmar: 'စက်',
      Language.zawgyi: 'စက္',
      Language.mon: 'Sep',
      Language.shan: 'Sep',
      Language.karen: 'Sep',
    },
    'Oct': {
      Language.english: 'Oct',
      Language.myanmar: 'အောက်',
      Language.zawgyi: "ေအာက္",
      Language.mon: 'Oct',
      Language.shan: 'Oct',
      Language.karen: 'Oct',
    },
    'Nov': {
      Language.english: 'Nov',
      Language.myanmar: 'နို',
      Language.zawgyi: 'ႏို',
      Language.mon: 'Nov',
      Language.shan: 'Nov',
      Language.karen: 'Nov',
    },
    'Dec': {
      Language.english: 'Dec',
      Language.myanmar: 'ဒီ',
      Language.zawgyi: 'ဒီ',
      Language.mon: 'Dec',
      Language.shan: 'Dec',
      Language.karen: 'Dec',
    },
    // Weekday names
    'Sunday': {
      Language.english: 'Sunday',
      Language.myanmar: 'တနင်္ဂနွေ',
      Language.zawgyi: 'တနဂၤေႏြ',
      Language.mon: 'တ္ၚဲအဒိုတ်',
      Language.shan: 'ဝၼ်းဢႃးတိတ်ႉ',
      Language.karen: 'မုၢ်ဒဲး',
    },
    'Monday': {
      Language.english: 'Monday',
      Language.myanmar: 'တနင်္လာ',
      Language.zawgyi: 'တနလၤာ',
      Language.mon: 'တ္ၚဲစန်',
      Language.shan: 'ဝၼ်းၸၼ်',
      Language.karen: 'မုၢ်ဆၣ်',
    },
    'Tuesday': {
      Language.english: 'Tuesday',
      Language.myanmar: 'အင်္ဂါ',
      Language.zawgyi: 'အဂၤါ',
      Language.mon: 'တ္ၚဲအင္ၚာ',
      Language.shan: 'ဝၼ်းဢၢင်းၵၢၼ်း',
      Language.karen: 'မုၢ်ယူာ်',
    },
    'Wednesday': {
      Language.english: 'Wednesday',
      Language.myanmar: 'ဗုဒ္ဓဟူး',
      Language.zawgyi: 'ဗုဒၶဟူး',
      Language.mon: 'တ္ၚဲဗုဒ္ဓဝါ',
      Language.shan: 'ဝၼ်းပုတ်ႉ',
      Language.karen: 'မုၢ်ပျဲၤ',
    },
    'Thursday': {
      Language.english: 'Thursday',
      Language.myanmar: 'ကြာသပတေး',
      Language.zawgyi: 'ၾကာသပေတး',
      Language.mon: 'တ္ၚဲဗြဴဗတိ',
      Language.shan: 'ဝၼ်းၽတ်း',
      Language.karen: 'မုၢ်လ့ၤဧိၤ',
    },
    'Friday': {
      Language.english: 'Friday',
      Language.myanmar: 'သောကြာ',
      Language.zawgyi: "ေသာၾကာ",
      Language.mon: 'တ္ၚဲသိုက်',
      Language.shan: 'ဝၼ်းသုၵ်း',
      Language.karen: 'မုၢ်ဖီဖး',
    },
    'Saturday': {
      Language.english: 'Saturday',
      Language.myanmar: 'စနေ',
      Language.zawgyi: 'စေန',
      Language.mon: 'တ္ၚဲသ္ၚိသဝ်',
      Language.shan: 'ဝၼ်းသဝ်',
      Language.karen: 'မုၢ်ဘူၣ်',
    },
    'wSun': {
      Language.english: 'Sun',
      Language.myanmar: 'န',
      Language.zawgyi: 'န',
      Language.mon: 'ရ',
      Language.shan: 'ဢ',
      Language.karen: 'တ',
    },
    'wMon': {
      Language.english: 'Mon',
      Language.myanmar: 'လ',
      Language.zawgyi: 'လ',
      Language.mon: 'လ',
      Language.shan: 'ၸ',
      Language.karen: 'ဒ',
    },
    'wTue': {
      Language.english: 'Tue',
      Language.myanmar: 'ဂါ',
      Language.zawgyi: 'ဂါ',
      Language.mon: 'ဂါ',
      Language.shan: 'ၢ',
      Language.karen: 'ပ',
    },
    'wWed': {
      Language.english: 'Wed',
      Language.myanmar: 'ဟူး',
      Language.zawgyi: 'ဟူး',
      Language.mon: 'ဗု',
      Language.shan: 'ပ',
      Language.karen: 'ဖ',
    },
    'wThu': {
      Language.english: 'Thu',
      Language.myanmar: 'ကြာ',
      Language.zawgyi: 'ၾကာ',
      Language.mon: 'ကြာ',
      Language.shan: 'ၽ',
      Language.karen: 'ယ',
    },
    'wFri': {
      Language.english: 'Fri',
      Language.myanmar: 'သော',
      Language.zawgyi: "ေသာ",
      Language.mon: 'သ',
      Language.shan: 'သု',
      Language.karen: 'မ',
    },
    'wSat': {
      Language.english: 'Sat',
      Language.myanmar: 'စ',
      Language.zawgyi: 'စ',
      Language.mon: 'စ',
      Language.shan: 'သ',
      Language.karen: 'ဆ',
    },

    // Year types
    'Common Year': {
      Language.english: 'Common Year',
      Language.myanmar: 'သာမန်နှစ်',
      Language.zawgyi: 'သာမန္ႏွစ္',
      Language.mon: 'သက္ကရာဇ်ပကတိ',
      Language.shan: 'ပီႈထႅမ်',
      Language.karen: 'နါၟးထံး',
    },
    'Little Watat': {
      Language.english: 'Little Watat',
      Language.myanmar: 'ဝါတပ်လေး',
      Language.zawgyi: 'ဝါတပ္ေလး',
      Language.mon: 'အတိုဟ်',
      Language.shan: 'ဝၢၼိၵ်',
      Language.karen: 'ဝါတပ်လီး',
    },
    'Big Watat': {
      Language.english: 'Big Watat',
      Language.myanmar: 'ဝါတပ်ကြီး',
      Language.zawgyi: 'ဝါတပ္ႀကီး',
      Language.mon: 'အတိုဟ်ဇၞော်',
      Language.shan: 'ဝၢလုင်',
      Language.karen: 'ဝါတပ်ကီး',
    },
    // Numbers
    '0': {
      Language.english: '0',
      Language.myanmar: '၀',
      Language.zawgyi: '၀',
      Language.mon: '၀',
      Language.shan: '0',
      Language.karen: '၀',
    },
    '1': {
      Language.english: '1',
      Language.myanmar: '၁',
      Language.zawgyi: '၁',
      Language.mon: '၁',
      Language.shan: '1',
      Language.karen: '၁',
    },
    '2': {
      Language.english: '2',
      Language.myanmar: '၂',
      Language.zawgyi: '၂',
      Language.mon: '၂',
      Language.shan: '2',
      Language.karen: '၂',
    },
    '3': {
      Language.english: '3',
      Language.myanmar: '၃',
      Language.zawgyi: '၃',
      Language.mon: '၃',
      Language.shan: '3',
      Language.karen: '၃',
    },
    '4': {
      Language.english: '4',
      Language.myanmar: '၄',
      Language.zawgyi: '၄',
      Language.mon: '၄',
      Language.shan: '4',
      Language.karen: '၄',
    },
    '5': {
      Language.english: '5',
      Language.myanmar: '၅',
      Language.zawgyi: '၅',
      Language.mon: '၅',
      Language.shan: '5',
      Language.karen: '၅',
    },
    '6': {
      Language.english: '6',
      Language.myanmar: '၆',
      Language.zawgyi: '၆',
      Language.mon: '၆',
      Language.shan: '6',
      Language.karen: '၆',
    },
    '7': {
      Language.english: '7',
      Language.myanmar: '၇',
      Language.zawgyi: '၇',
      Language.mon: '၇',
      Language.shan: '7',
      Language.karen: '၇',
    },
    '8': {
      Language.english: '8',
      Language.myanmar: '၈',
      Language.zawgyi: '၈',
      Language.mon: '၈',
      Language.shan: '8',
      Language.karen: '၈',
    },
    '9': {
      Language.english: '9',
      Language.myanmar: '၉',
      Language.zawgyi: '၉',
      Language.mon: '၉',
      Language.shan: '9',
      Language.karen: '၉',
    },
    // Astro
    'Sabbath Eve': {
      Language.english: 'Sabbath Eve',
      Language.myanmar: 'အဖိတ်',
      Language.zawgyi: 'အဖိတ္',
      Language.mon: 'တ္ၚဲတိၚ်',
      Language.shan: 'ၽိတ်ႈ',
      Language.karen: 'အဖိတ်',
    },
    'Sabbath': {
      Language.english: 'Sabbath',
      Language.myanmar: 'ဥပုသ်',
      Language.zawgyi: 'ဥပုသ္',
      Language.mon: 'တ္ၚဲသဳ',
      Language.shan: 'သိၼ်',
      Language.karen: 'အိၣ်ဘှံး',
    },
    'Yatyaza': {
      Language.english: 'Yatyaza',
      Language.myanmar: 'ရက်ရာဇာ',
      Language.zawgyi: 'ရက္ရာဇာ',
      Language.mon: 'တ္ၚဲရာဇာ',
      Language.shan: 'ဝၼ်းထုၼ်း',
      Language.karen: 'ရက်ရာဇာ',
    },
    'Pyathada': {
      Language.english: 'Pyathada',
      Language.myanmar: 'ပြဿဒါး',
      Language.zawgyi: "ျပႆဒါး",
      Language.mon: 'တ္ၚဲပြာဗ္ဗဒါ',
      Language.shan: 'ဝၼ်းပျၢတ်ႈ',
      Language.karen: 'ပြဿဒါး',
    },
    'Afternoon': {
      Language.english: 'Afternoon',
      Language.myanmar: 'မွန်းလွဲ',
      Language.zawgyi: 'မြန္းလြဲ',
      Language.mon: 'မွန်းလွဲ',
      Language.shan: 'ဝၢႆးဝၼ်း',
      Language.karen: 'မွန်းလွဲ',
    },
    'Afternoon Pyathada': {
      Language.english: 'Afternoon Pyathada',
      Language.myanmar: 'မွန်းလွဲ ပြဿဒါး',
      Language.zawgyi: 'မြန္းလြဲ ျပႆဒါး',
      Language.mon: 'မွန်းလွဲ တ္ၚဲပြာဗ္ဗဒါ',
      Language.shan: 'ဝၢႆးဝၼ်း ဝၼ်းပျၢတ်ႈ',
      Language.karen: 'မွန်းလွဲ ပြဿဒါး',
    },
    'Amyeittasote': {
      Language.english: 'Amyeittasote',
      Language.myanmar: 'အမြိတ္တစုတ်',
      Language.zawgyi: 'အၿမိတၱစုတ္',
      Language.mon: 'ကိုန်အမြိုတ်',
      Language.shan: 'အမြိတ္တစုတ်',
      Language.karen: 'အမြိတ္တစုတ်',
    },
    'Warameittugyi': {
      Language.english: 'Warameittugyi',
      Language.myanmar: 'ဝါရမိတ္တုကြီး',
      Language.zawgyi: 'ဝါရမိတၱဳႀကီး',
      Language.mon: 'ကိုန်ဝါရမိတ္တုဇၞော်',
      Language.shan: 'ဝါရမိတ္တုကြီး',
      Language.karen: 'ဝါရမိတ္တုကြီး',
    },
    'Warameittunge': {
      Language.english: 'Warameittunge',
      Language.myanmar: 'ဝါရမိတ္တုငယ်',
      Language.zawgyi: 'ဝါရမိတၱဳငယ္',
      Language.mon: 'ကိုန်ဝါရမိတ္တုဍောတ်',
      Language.shan: 'ဝါရမိတ္တုငယ်',
      Language.karen: 'ဝါရမိတ္တုငယ်',
    },
    'Thamaphyu': {
      Language.english: 'Thamaphyu',
      Language.myanmar: 'သမားဖြူ',
      Language.zawgyi: 'သမားျဖဴ',
      Language.mon: 'ကိုန်လေၚ်ဒိုက်',
      Language.shan: 'သမားဖြူ',
      Language.karen: 'သမားဖြူ',
    },
    'Thamanyo': {
      Language.english: 'Thamanyo',
      Language.myanmar: 'သမားညို',
      Language.zawgyi: 'သမားညိဳ',
      Language.mon: 'ကိုန်ဟုံဗြမ်',
      Language.shan: 'သမားညို',
      Language.karen: 'သမားညို',
    },
    'Yatpote': {
      Language.english: 'Yatpote',
      Language.myanmar: 'ရက်ပုပ်',
      Language.zawgyi: 'ရက္ပုပ္',
      Language.mon: 'ကိုန်လီုလာ်',
      Language.shan: 'ရက်ပုပ်',
      Language.karen: 'ရက်ပုပ်',
    },
    'Yatyotema': {
      Language.english: 'Yatyotema',
      Language.myanmar: 'ရက်ယုတ်မာ',
      Language.zawgyi: 'ရက္ယုတ္မာ',
      Language.mon: 'ကိုန်ယုတ်မာ',
      Language.shan: 'ရက်ယုတ်မာ',
      Language.karen: 'ရက်ယုတ်မာ',
    },
    'Mahayatkyan': {
      Language.english: 'Mahayatkyan',
      Language.myanmar: 'မဟာရက်ကြမ်း',
      Language.zawgyi: 'မဟာရက္ၾကမ္း',
      Language.mon: 'ကိုန်ဟွံခိုဟ်',
      Language.shan: 'မဟာရက်ကြမ်း',
      Language.karen: 'မဟာရက်ကြမ်း',
    },
    'Nagapor': {
      Language.english: 'Nagapor',
      Language.myanmar: 'နဂါးပေါ်',
      Language.zawgyi: 'နဂါးေပၚ',
      Language.mon: 'နာ်မံက်',
      Language.shan: 'နဂါးပေါ်',
      Language.karen: 'နဂါးပေါ်',
    },
    'Shanyat': {
      Language.english: 'Shanyat',
      Language.myanmar: 'ရှမ်းရက်',
      Language.zawgyi: 'ရွမ္းရက္',
      Language.mon: 'တ္ၚဲဒတန်',
      Language.shan: 'ရှမ်းရက်',
      Language.karen: 'ရှမ်းရက်',
    },
    // Year names
    'Hpusha': {
      Language.english: 'Hpusha',
      Language.myanmar: 'ပုဿ',
      Language.zawgyi: "ပုႆ",
      Language.mon: 'ပုဿ',
      Language.shan: 'ပုဿ',
      Language.karen: 'ပုဿ',
    },
    'Magha': {
      Language.english: 'Magha',
      Language.myanmar: 'မာခ',
      Language.zawgyi: "မာခ",
      Language.mon: 'မာခ',
      Language.shan: 'မာခ',
      Language.karen: 'မာခ',
    },
    'Phalguni': {
      Language.english: 'Phalguni',
      Language.myanmar: 'ဖ္လကိုန်',
      Language.zawgyi: 'ဖႅကိုန္',
      Language.mon: 'ဖ္လကိုန်',
      Language.shan: 'ဖ္လကိုန်',
      Language.karen: 'ဖ္လကိုန်',
    },
    'Chitra': {
      Language.english: 'Chitra',
      Language.myanmar: 'စယ်',
      Language.zawgyi: 'စယ္',
      Language.mon: 'စယ်',
      Language.shan: 'စယ်',
      Language.karen: 'စယ်',
    },
    'Visakha': {
      Language.english: 'Visakha',
      Language.myanmar: 'ပိသျက်',
      Language.zawgyi: 'ပိသ်က္',
      Language.mon: 'ပိသျက်',
      Language.shan: 'ပိသျက်',
      Language.karen: 'ပိသျက်',
    },
    'Jyeshtha': {
      Language.english: 'Jyeshtha',
      Language.myanmar: 'စိဿ',
      Language.zawgyi: 'စိႆ',
      Language.mon: 'စိဿ',
      Language.shan: 'စိဿ',
      Language.karen: 'စိဿ',
    },
    'Ashadha': {
      Language.english: 'Ashadha',
      Language.myanmar: 'အာသတ်',
      Language.zawgyi: 'အာသတ္',
      Language.mon: 'အာသတ်',
      Language.shan: 'အာသတ်',
      Language.karen: 'အာသတ်',
    },
    'Sravana': {
      Language.english: 'Sravana',
      Language.myanmar: 'သရဝန်',
      Language.zawgyi: 'သရဝန္',
      Language.mon: 'သရဝန်',
      Language.shan: 'သရဝန်',
      Language.karen: 'သရဝန်',
    },
    'Bhadrapaha': {
      Language.english: 'Bhadrapaha',
      Language.myanmar: 'ဘဒြ',
      Language.zawgyi: 'ဘျဒ',
      Language.mon: 'ဘဒြ',
      Language.shan: 'ဘဒြ',
      Language.karen: 'ဘဒြ',
    },
    'Asvini': {
      Language.english: 'Asvini',
      Language.myanmar: 'အာသိန်',
      Language.zawgyi: 'အာသိန္',
      Language.mon: 'အာသိန်',
      Language.shan: 'အာသိန်',
      Language.karen: 'အာသိန်',
    },
    'Krittika': {
      Language.english: 'Krittika',
      Language.myanmar: 'ကြတိုက်',
      Language.zawgyi: 'ၾကတိုက္',
      Language.mon: 'ကြတိုက်',
      Language.shan: 'ကြတိုက်',
      Language.karen: 'ကြတိုက်',
    },
    'Mrigasiras': {
      Language.english: 'Mrigasiras',
      Language.myanmar: 'မြိက္ကသိုဝ်',
      Language.zawgyi: 'ၿမိကၠသိုဝ္',
      Language.mon: 'မြိက္ကသိုဝ်',
      Language.shan: 'မြိက္ကသိုဝ်',
      Language.karen: 'မြိက္ကသိုဝ်',
    },
    // Mahabote
    'Mahabote': {
      Language.english: 'Mahabote',
      Language.myanmar: 'မဟာဘုတ်',
      Language.zawgyi: 'မဟာဘုတ္',
      Language.mon: 'မဟာဘုတ်',
      Language.shan: 'မဟာဘုတ်',
      Language.karen: 'မဟာဘုတ်',
    },
    'Born': {
      Language.english: 'Born',
      Language.myanmar: 'ဖွား',
      Language.zawgyi: 'ဖြား',
      Language.mon: 'ဖွား',
      Language.shan: 'ဢၼ်မီးပႃႇရမီ',
      Language.karen: 'ဖွား',
    },
    'Binga': {
      Language.english: 'Binga',
      Language.myanmar: 'ဘင်္ဂ',
      Language.zawgyi: 'ဘဂၤ',
      Language.mon: 'ဘင်္ဂ',
      Language.shan: 'ပိင်ႉၵႃႉ',
      Language.karen: 'ဘင်္ဂ',
    },
    'Atun': {
      Language.english: 'Atun',
      Language.myanmar: 'အထွန်း',
      Language.zawgyi: 'အထြန္း',
      Language.mon: 'အထွန်း',
      Language.shan: 'ဢထုၼ်း',
      Language.karen: 'အထွန်း',
    },
    'Yaza': {
      Language.english: 'Yaza',
      Language.myanmar: 'ရာဇ',
      Language.zawgyi: 'ရာဇ',
      Language.mon: 'ရာဇ',
      Language.shan: 'ယႃႇၸႃႇ',
      Language.karen: 'ရာဇ',
    },
    'Adipati': {
      Language.english: 'Adipati',
      Language.myanmar: 'အဓိပတိ',
      Language.zawgyi: 'အဓိပတိ',
      Language.mon: 'အဓိပတိ',
      Language.shan: 'ဢထိပ်ႉပတိ',
      Language.karen: 'အဓိပတိ',
    },
    'Marana': {
      Language.english: 'Marana',
      Language.myanmar: 'မရဏ',
      Language.zawgyi: 'မရဏ',
      Language.mon: 'မရဏ',
      Language.shan: 'မရၼႃႇ',
      Language.karen: 'မရဏ',
    },
    'Thike': {
      Language.english: 'Thike',
      Language.myanmar: 'သိုက်',
      Language.zawgyi: 'သိုက္',
      Language.mon: 'သိုက်',
      Language.shan: 'သႅၵ်ႈ',
      Language.karen: 'သိုက်',
    },
    'Puti': {
      Language.english: 'Puti',
      Language.myanmar: 'ပုတိ',
      Language.zawgyi: 'ပုတိ',
      Language.mon: 'ပုတိ',
      Language.shan: 'ပုတေႃႉ',
      Language.karen: 'ပုတိ',
    },
    'Ogre': {
      Language.english: 'Ogre',
      Language.myanmar: 'ဘီလူး',
      Language.zawgyi: 'ဘီလူး',
      Language.mon: 'ဘီလူး',
      Language.shan: 'ၽီလူ',
      Language.karen: 'ဘီလူး',
    },
    'Elf': {
      Language.english: 'Elf',
      Language.myanmar: 'နတ်',
      Language.zawgyi: 'နတ္',
      Language.mon: 'နတ်',
      Language.shan: 'ၽီမႅၼ်းဢွၼ်',
      Language.karen: 'နတ်',
    },
    'Human': {
      Language.english: 'Human',
      Language.myanmar: 'လူ',
      Language.zawgyi: 'လူ',
      Language.mon: 'လူ',
      Language.shan: 'ဢၼ်ပဵၼ်ၵူၼ်',
      Language.karen: 'လူ',
    },

    // Astrological Descriptions
    'desc_ogre': {
      Language.english:
          'Ogre Nakhat (Thane-Nakhat) is associated with strength and fierce energy. It is considered suitable for activities requiring boldness.',
      Language.myanmar:
          'ဘီလူးနက္ခတ် (သိန်းနက္ခတ်) သည် ခွန်အားနှင့် ပြင်းထန်သော စွမ်းအင်တို့နှင့် ဆက်စပ်နေသည်။ ရဲရင့်ပြတ်သားမှု လိုအပ်သော လုပ်ငန်းများအတွက် သင့်တော်သည်ဟု ယူဆကြသည်။',
      Language.zawgyi:
          'ဘီလူးနကၡတ္ (သိန္းနကၡတ္) သည္ ခြန္အားႏွင့္ ျပင္းထန္ေသာ စြမ္းအင္တို႔ႏွင့္ ဆက္စပ္ေနသည္။ ရဲရင့္ျပတ္သားမႈ လိုအပ္ေသာ လုပ္ငန္းမ်ားအတြက္ သင့္ေတာ္သည္ဟု ယူဆၾကသည္။',
      Language.karen:
          'ဘီလူးနက္ခတ် (သိန်းနက္ခတ်) ဝွေဟှဗ္ဗာန်၊ တုဟှင့်၊ အရဲးအရာ ဟှေအုဲင်။',
      Language.mon:
          'နက္ခတ်ဘုတ် (နက္ခတ်သိန်း) ဝွံ ဆက်စပ်ကဵု ဒြဟတ် ကေုာံ စွမ်းအင်သ္ကာတ်မြဟ်။ သွက်ကမၠောန် မနွံပၟိက် ကေုာံ ဂတ်ဂတ်ဂဟ် သၟဟ်အစောံရ။',
      Language.shan:
          'ၼၵ်ႈၶတ်ႈၽီလူး (ၼၵ်ႈၶတ်ႈသိၵ်ႈ) မိူၼ်ၼင်ႇ မီးႁႅင်းယႂ်ႇ လႄႈ မီးသႅင်လႅင်း။ သုၼ်ႇတႃႇ ၵၢၼ်ငၢၼ်း ဢၼ်လူဝ်ႇတၢင်းႁတ်းႁၢၼ်။',
    },
    'desc_elf': {
      Language.english:
          'Elf Nakhat (De-wa-Nakhat) is associated with grace, beauty, and celestial harmony. It is ideal for peaceful and creative pursuits.',
      Language.myanmar:
          'နတ်နက္ခတ် (ဒေဝနက္ခတ်) သည် ကျက်သရေ၊ အလှအပနှင့် ကောင်းကင်ဘုံ သဟဇာတဖြစ်မှုတို့နှင့် ဆက်စပ်နေသည်။ အေးချမ်းသာယာသော လုပ်ငန်းများနှင့် ဖန်တီးမှုဆိုင်ရာ ဝါသနာများအတွက် အထူးသင့်လျော်သည်။',
      Language.zawgyi:
          'နတ္နကၡတ္ (ေဒဝနကၡတ္) သည္ က်က္သေရ၊ အလွအပႏွင့္ ေကာင္းကင္ဘုံ သဟဇာတျဖစ္မႈတို႔ႏွင့္ ဆက္စပ္ေနသည္။ ေအးခ်မ္းသာယာေသာ လုပ္ငန္းမ်ားႏွင့္ ဖန္တီးမႈဆိုင္ရာ ဝါသနာမ်ားအတြက္ အထူးသင့္ေလ်ာ္သည္။',
      Language.karen:
          'နတ်နက္ခတ် (ဒေဝနက္ခတ်) ဝွေဟှဗ္ဗာန်၊ တုဟှင့်၊ ကျာ်သရေ ဟှေအုဲင်။',
      Language.mon:
          'နက္ခတ်ဒေဝတာ (နက္ခတ်ဒေဝ) ဝွံ ဆက်စပ်ကဵု ဂုဏ်ဝိသေသ၊ သစ္စာ ကေုာံ တင်္ခဏဥာဏ်။ သွက်ကမၠောန် မၜိုဟ်သြိုဟ် ကေုာံ ဖန်ဗဒှ်ဂဟ် ခိုဟ်သန်ရ။',
      Language.shan:
          'ၼၵ်ႈၶတ်ႈၽီ (ၼၵ်ႈၶတ်ႈတေႇဝႃႇ) မိူၼ်ၼင်ႇ မီးတၢင်းလႅင်း၊ တၢင်းႁၢင်ႈလီ လႄႈ တၢင်းငမ်းယဵၼ်။ သုၼ်ႇတႃႇ ၵၢၼ်ငမ်းယဵၼ် လႄႈ ၵၢၼ်သၢင်ႈပၢႆးယဵၼ်။',
    },
    'desc_human': {
      Language.english:
          'Human Nakhat (Ma-nu-tha-Nakhat) is associated with earthiness, social connections, and practical matters. It is good for community projects.',
      Language.myanmar:
          'လူနက္ခတ် (မနုဿနက္ခတ်) သည် လက်တွေ့ကျမှု၊ လူမှုဆက်ဆံရေးနှင့် လူမှုရေးကိစ္စရပ်များနှင့် ဆက်စပ်နေသည်။ လူမှုအကျိုးပြု လုပ်ငန်းများအတွက် ကောင်းမွန်သည်။',
      Language.zawgyi:
          'လူနကၡတ္ (မႏုႆနကၡတ္) သည္ လက္ေတြ႕က်မႈ၊ လူမႈဆက္ဆံေရးႏွင့္ လူမႈေရးကိစၥရပ္မ်ားႏွင့္ ဆက္စပ္ေနသည္။ လူမႈအက်ိဳးျပဳ လုပ္ငန္းမ်ားအတြက္ ေကာင္းမြန္သည္။',
      Language.karen:
          'လူနက္ခတ် (မနုဿနက္ခတ်) ဝွေဟှဗ္ဗာန်၊ တုဟှင့်၊ ဆို့ရဲး ဟှေအုဲင်။',
      Language.mon:
          'နက္ခတ်မနုဿ (နက္ခတ်မနုဿ) ဝွံ ဆက်စပ်ကဵု ဘဝမၞိဟ်၊ ပရေင်မၞိဟ် ကေုာံ ပရေင်ဆက်ဆောံ။ သွက်ကမၠောန် ပရေင်မၞိဟ်ဂဟ် သၟဟ်အစောံရ။',
      Language.shan:
          'ၼၵ်ႈၶတ်ႈၵူၼ်း (ၼၵ်ႈၶတ်ႈမၼုတ်ႉသႃႉ) မိူၼ်ၼင်ႇ မီးတၢင်းမေႃ၊ တၢင်းႁူႉ လႄႈ ၵၢၼ်တူင်ႇဝူင်းၵူၼ်း။ သုၼ်ႇတႃႇ ၵၢၼ်တူင်ႇဝူင်းၵူၼ်း။',
    },
    'desc_binga': {
      Language.english:
          'Binga (The Restless) indicates a character that is energetic, versatile, but may struggle with focus or stability.',
      Language.myanmar:
          'ဘင်္ဂ (ဖျက်ဆီးခြင်း) သည် တက်ကြွလှုပ်ရှားမှု၊ ဘက်စုံကျွမ်းကျင်မှုကို ညွှန်ပြသော်လည်း တည်ငြိမ်မှု သို့မဟုတ် အာရုံစူးစိုက်မှုအတွက် ရုန်းကန်ရတတ်သည်။',
      Language.zawgyi:
          'ဘဂၤ (ဖ်က္ဆီးျခင္း) သည္ တက္ႂကြလႈပ္ရွားမႈ၊ ဘက္စုံကြၽမ္းက်င္မႈကို ၫႊန္ျပေသာ္လည္း တည္ၿငိမ္မႈ သို႔မဟုတ္ အာ႐ုံစူးစိုက္မႈအတြက္ ႐ုန္းကန္ရတတ္သည္။',
      Language.karen:
          'ဘင်္ဂ (ဟှေဖျက်ဆီး) ဝွေဟှဗ္ဗာန်၊ တုဟှင့်၊ တက်ကြွလှုပ်ရှား ဟှေအုဲင်။',
      Language.mon:
          'ဘင်္ဂ (ပလီုပလာ်) ဝွံ ထ္ၜးကဵု ပရေင်ချဳဒရာင် ကေုာံ ဍာ်ဒကေဝ်နာနာ ဆဂး ဝါတ်ဂါတ် ပ္ဍဲပရေင်တန်ကြန် ကေုာံ စိုတ်ဓါတ်။',
      Language.shan:
          'ပိင်ႉၵႃႉ (ၵၢၼ်ယႃႉလူႉ) မိူၼ်ၼင်ႇ မီးတၢင်းတူင်ႉၼိုင် လႄႈ မီးတၢင်းမေႃ ၵူႈလွင်ႈလွင်ႈ သေတႃႉ မီးတၢင်းယၢပ်ႇ တႃႇတၢင်းၼိမ် လႄႈ ဝူၼ်ႉၸႂ်။',
    },
    'desc_atun': {
      Language.english:
          'Atun (The Exalted) represents brilliance, pride, and leadership qualities. Often indicates a public-facing personality.',
      Language.myanmar:
          'အထွန်း (တောက်ပခြင်း) သည် ထူးကဲသော အရည်အချင်း၊ ဂုဏ်သိက္ခာနှင့် ခေါင်းဆောင်မှု အရည်အသွေးများကို ကိုယ်စားပြုသည်။ လူသိရှင်ကြား ပေါ်လွင်သော ပင်ကိုယ်စရိုက်ကို ကိုယ်စားပြုလေ့ရှိသည်။',
      Language.zawgyi:
          'အထြန္း (ေတာက္ပျခင္း) သည္ ထူးကဲေသာ အရည္အခ်င္း၊ ဂုဏ္သိကၡာႏွင့္ ေခါင္းေဆာင္မႈ အရည္အေသြးမ်ားကို ကိုယ္စားျပဳသည္။ လူသိရွင္ၾကား ေပၚလြင္ေသာ ပင္ကိုယ္စ႐ိုက္ကို ကိုယ္စားျပဳေလ့ရွိသည္။',
      Language.karen:
          'အထွန်း (ဟှေတောက်ပ) ဝွေဟှဗ္ဗာန်၊ တုဟှင့်၊ ခေါင်းဆောင်မှု ဟှေအုဲင်။',
      Language.mon:
          'အထွန်း (တောက်ပ) ဝွံ ထ္ၜးကဵု ဍာ်ဒကေဝ်တၟေင်၊ ဂုဏ်သိက္ခာ ကေုာံ ဍာ်ဒကေဝ်က္ဍိုပ်သကိုပ်။ မလေပ်နွံကဵု စိုတ်ဓါတ် မပေါ်လွင် ပ္ဍဲညးဂမၠိုင်။',
      Language.shan:
          'ဢထုၼ်း (ၵၢၼ်လႅင်း) မိူၼ်ၼင်ႇ မီးတၢင်းမေႃ၊ တၢင်းမီးၵုင်ႇ လႄႈ တၢင်းပဵၼ်ႁူဝ်ၼႃႈ။ မီးတၢင်းလႅင်း တႃႇတူင်ႇဝူင်းၵူၼ်း။',
    },
    'desc_yaza': {
      Language.english:
          'Yaza (The Kingly) signifies authority, responsibility, and a sense of duty toward others.',
      Language.myanmar:
          'ရာဇ (မင်းကဲ့သို့သော) သည် အာဏာ၊ တာဝန်ခံမှုနှင့် သူတစ်ပါးအပေါ် တာဝန်သိတတ်မှုကို ကိုယ်စားပြုသည်။',
      Language.zawgyi:
          'ရာဇ (မင္းကဲ့သို႔ေသာ) သည္ အာဏာ၊ တာဝန္ခံမႈႏွင့္ သူတစ္ပါးအေပၚ တာဝန္သိတတ္မႈကို ကိုယ္စားျပဳသည္။',
      Language.karen:
          'ရာဇ (မင်းကဲ့သို့သော) ဝွေဟှဗ္ဗာန်၊ တုဟှင့်၊ အာဏာ၊ တာဝန်ခံမှု ဟှေအုဲင်။',
      Language.mon:
          'ရာဇ (ညံင်ရဴသၟိင်) ဝွံ ထ္ၜးကဵု အဓိပတိ၊ ပရေင်တာဝန် ကေုာံ ဆန္ဒမဇ္ဇျဟ် ပ္ဍဲညးတၞဟ်။',
      Language.shan:
          'ယႃႇၸႃႇ (မိူၼ်ၼင်ႇၸဝ်ႈၾႃႉ) မိူၼ်ၼင်ႇ မီးဢႃႇၼႃႇ၊ တၢင်းမီးပုၼ်ႈၽွၼ်း လႄႈ တၢင်းမီးၼမ်ႉၸႂ်လီ။',
    },
    'desc_adipati': {
      Language.english:
          'Adipati (The Master) represents dominance, strategic thinking, and independence.',
      Language.myanmar:
          'အဓိပတိ (အရှင်သခင်) သည် လွှမ်းမိုးချုပ်ကိုင်နိုင်မှု၊ ဗျူဟာကျကျ စဉ်းစားမှုနှင့် လွတ်လပ်မှုကို ကိုယ်စားပြုသည်။',
      Language.zawgyi:
          'အဓိပတိ (အရွင္သခင္) သည္ လႊမ္းမိုးခ်ဳပ္ကိုင္ႏိုင္မႈ၊ ဗ်ဴဟာက်က် စဥ္းစားမႈႏွင့္ လြတ္လပ္မႈကို ကိုယ္စားျပဳသည္။',
      Language.karen:
          'အဓိပတိ (အရှင်သခင်) ဝွေဟှဗ္ဗာန်၊ တုဟှင့်၊ လွှမ်းမိုးမှု၊ လွတ်လပ်မှု ဟှေအုဲင်။',
      Language.mon:
          'အဓိပတိ (နာဲညး) ဝွံ ထ္ၜးကဵု ပရေင်အုပ်ချုပ်၊ ပရေင်ဗျူဟာ ကေုာံ အခေါင်ဗၠးၜး။',
      Language.shan:
          'ဢထိပ်ႉပတိ (ၸဝ်ႈၾႃႉ) မိူၼ်ၼင်ႇ မီးဢႃႇၼႃႇ၊ မေႃဝူၼ်ႉၸႂ် လႄႈ မီးတၢင်းလွတ်ႈလႅဝ်း။',
    },
    'desc_marana': {
      Language.english:
          'Marana (The Fragile) suggests a sensitive, thoughtful, and perhaps more introspective nature.',
      Language.myanmar:
          'မရဏ (ပျက်စီးခြင်း) သည် ထိခိုက်လွယ်သော၊ နက်နက်နဲနဲ စဉ်းစားတတ်သော၊ တစ်သီးပုဂ္ဂလဆန်သော သဘာဝကို ဖော်ပြသည်။',
      Language.zawgyi:
          'မရဏ (ပ်က္စီးျခင္း) သည္ ထိခိုက္လြယ္ေသာ၊ နက္နက္နဲနဲ စဥ္းစားတတ္ေသာ၊ တစ္သီးပုဂၢလဆန္ေသာ သဘာဝကို ေဖာ္ျပသည္။',
      Language.karen:
          'မရဏ (ပျက်စီးခြင်း) ဝွေဟှဗ္ဗာန်၊ တုဟှင့်၊ စဉ်းစားတတ် ဟှေအုဲင်။',
      Language.mon:
          'မရဏ (ပလီုပလာ်) ဝွံ ထ္ၜးကဵု စိုတ်ဓါတ်မဍိုန်မံက်၊ မလေပ်ချပ်နက်နက်နဲနဲ ကေုာံ စိုတ်ဓါတ်မၞုံပၟိက်မၞုံကဵုပူဂိုလ်ဝိသေသ။',
      Language.shan:
          'မရဏ (ၵၢၼ်ยႃႉလူႉ) မိူၼ်ၼင်ႇ မီးတၢင်းဝူၼ်ႉၸႂ် လႄႈ မီးတၢင်းမေႃဝူၼ်ႉၸႂ် လွင်ႈပူၵ်ႉၵူဝ်ႇ။',
    },
    'desc_thike': {
      Language.english:
          'Thike (The Wealthy) indicates good fortune, resourcefulness, and ability to accumulate gains.',
      Language.myanmar:
          'သိုက် (သိုလှောင်ခြင်း) သည် ကံကောင်းခြင်း၊ အရင်းအမြစ် ကြွယ်ဝခြင်းနှင့် စည်းစိမ်ဥစ္စာ စုဆောင်းနိုင်စွမ်းကို ဖော်ပြသည်။',
      Language.zawgyi: '''
သိုက္ (သိုေလွာင္ျခင္း) သည္ ကံေကာင္းျခင္း၊ အရင္းအျမစ္ ႂကြယ္ဝျခင္းႏွင့္ စည္းစိမ္ဥစၥာစုေဆာင္းႏိုင္စြမ္းကို ေဖာ္ျပသည္။
''',
      Language.karen:
          'သိုက် (ဟှေသိုလှောင်) ဝွေဟှဗ္ဗာန်၊ တုဟှင့်၊ စည်းစိမ်ဥစ္စာ ဟှေအုဲင်။',
      Language.mon:
          'သိုက် (ဂိုဟ်) ဝွံ ထ္ၜးကဵု ကံခိုဟ်၊ ဒြပ်ရတ် ကေုာံ ဍာ်ဒကေဝ် မပကောံပကေဝ် ဒြပ်ရတ်။',
      Language.shan:
          'သႅၵ်ႈ (ၵၢၼ်သိမ်း) မိူၼ်ၼင်ႇ မီးၵၢမ်ႇလီ၊ မီးၶူဝ်းၶွင် လႄႈ မီးတၢင်းမေႃ သိမ်းႁွမ်ၶူဝ်းၶွင်။',
    },
    'desc_puti': {
      Language.english:
          'Puti (The Rotting/Decaying) signifies transformation, resilience, and the ability to find value in what others discard.',
      Language.myanmar:
          'ပုတိ (ပုပ်သိုးခြင်း) သည် ပြောင်းလဲခြင်း၊ ကြံ့ကြံ့ခံနိုင်မှုနှင့် သူတစ်ပါး အသုံးမဝင်ဟု ထင်သောအရာများထဲမှ တန်ဖိုးကို ရှာဖွေနိုင်စွမ်းကို ကိုယ်စားပြုသည်။',
      Language.zawgyi:
          'ပုတိ (ပုပ္သိုးျခင္း) သည္ ေျပာင္းလဲျခင္း၊ ႀကံ့ႀကံ့ခံႏိုင္မႈႏွင့္ သူတစ္ပါး အသုံးမဝင္ဟု ထင္ေသာအရာမ်ားထဲမွ တန္ဖိုးကို ရွာေဖြႏိုင္စြမ္းကို ကိုယ္စားျပဳသည္။',
      Language.karen:
          'ပုတိ (ပုပ်သိုးခြင်း) ဝွေဟှဗ္ဗာန်၊ တုဟှင့်၊ ကြံ့ကြံ့ခံမှု ဟှေအုဲင်။',
      Language.mon:
          'ပုတိ (ပုပ္သိုး) ဝွံ ထ္ၜးကဵု ပရေင်ပြောင်းလဲ၊ ပရေင်ဒုင်ဒြဟတ် ကေုာံ ဍာ်ဒကေဝ် မဂၠာဲၚုဟ်မး ပ္ဍဲအရာညးတၞဟ် မထောံကၠေံ။',
      Language.shan:
          'ပုတိ (ၵၢၼ်ၼဝ်ႇ) မိူၼ်ၼင်ႇ မီးတၢင်းလႅၵ်ႈလၢႆႈ၊ တၢင်းမေႃၸူး လႄႈ မီးတၢင်းမေႃၵူတ်ႇဢဝ် ၶူဝ်းၶွင် ဢၼ်ၵူၼ်းတၢင်ႇၸိူဝ်း လိုပ်ႇပႅတ်ႈ။',
    },
    'desc_thamanyo': {
      Language.english:
          'Thamanyo (The Restrainer) is an inauspicious day for starting new ventures or travel.',
      Language.myanmar:
          'သမားညိုသည် အသစ်စတင်ခြင်း သို့မဟုတ် ခရီးသွားလာခြင်းများအတွက် မသင့်တော်သော နေ့တစ်နေ့ဖြစ်သည်။',
      Language.zawgyi:
          'သမားညိဳသည္ အသစ္စတင္ျခင္း သို႔မဟုတ္ ခရီးသြားလာျခင္းမ်ားအတြက္ မသင့္ေတာ္ေသာ ေန႔တစ္ေန႔ျဖစ္သည္။',
      Language.karen: 'သမားညို ဝွေဟှဗ္ဗာန်၊ တုဟှင့်၊ တုဟိုင် ဟှေအုဲင်။',
      Language.mon:
          'တ္ၚဲသမားညို ဝွံ သွက်ဂွံစပဋိသန္ဓေတၟိ ဟွံသေင်မ္ဂး အာတရဴ ဟွံခိုဟ်ရ။',
      Language.shan:
          'ဝၼ်းသမႃးၺူဝ်ႇ မိူၼ်ၼင်ႇ ဝၼ်းဢမ်ႇလီ တႃႇတႄႇၵၢၼ်မႂ်ႇ ဢမ်ႇၼၼ် ၵၢၼ်ၶၢႆႉတၢင်း။',
    },
    'desc_amyeittasote': {
      Language.english:
          'Amyeittasote (The Nectar) is a highly auspicious day for celebrations and important beginnings.',
      Language.myanmar:
          'အမြိတ္တစုတ်သည် မင်္ဂလာအခမ်းအနားများနှင့် အရေးကြီးသော စတင်မှုများအတွက် အလွန်မင်္ဂလာရှိသော နေ့တစ်နေ့ဖြစ်သည်။',
      Language.zawgyi:
          'အၿမိတၱစုတ္သည္ မဂၤလာအခမ္းအနားမ်ားႏွင့္ အေရးႀကီးေသာ စတင္မႈမ်ားအတြက္ အလြန္မဂၤလာရွိေသာ ေန႔တစ္ေန႔ျဖစ္သည္။',
      Language.karen: 'အမြိတ္တစုတ် ဝွေဟှဗ္ဗာန်၊ တုဟှင့်၊ မင်္ဂလာ ဟှေအုဲင်။',
      Language.mon:
          'တ္ၚဲအမြိတ္တစုတ် ဝွံ သွက်သဘင်မင်္ဂလာ ကေုာံ ပရေင်စပဋိသန္ဓေ ကိစ္စဇၞော်ဂမၠိုင် ခိုဟ်သန်ရ။',
      Language.shan:
          'ဝၼ်းဢမျဵၵ်ႉတၸုတ်ႉ မိူၼ်ၼင်ႇ ဝၼ်းမီးမင်ႇၵလႃႇ တႃႇပွႆး လႄႈ ၵၢၼ်တႄႇ ဢၼ်ယႂ်ႇလူင်။',
    },
    'desc_warameittugyi': {
      Language.english:
          'Warameittugyi (Major Bad Friend) is an inauspicious day particularly for social or collaborative work.',
      Language.myanmar:
          'ဝါရမိတ္တုကြီးသည် အထူးသဖြင့် လူမှုရေး သို့မဟုတ် ပူးပေါင်းဆောင်ရွက်ရသော အလုပ်များအတွက် မသင့်တော်သော နေ့တစ်နေ့ဖြစ်သည်။',
      Language.zawgyi: '''
ဝါရမိတၱဳႀကီးသည္ အထူးသျဖင့္ လူမႈေရး သို႔မဟုတ္ ပူးေပါင္းေဆာင္႐ြက္ရေသာ အလုပ္မ်ားအတြက္ မသင့္ေတာ္ေသာ ေန႔တစ္ေန႔ျဖစ္သည္။
''',
      Language.karen: 'ဝါရမိတ္တုကြီး ဝွေဟှဗ္ဗာန်၊ တုဟှင့်၊ တုဟိုင် ဟှေအုဲင်။',
      Language.mon:
          'တ္ၚဲဝါရမိတ္တုကြီး ဝွံ သွက်ပရေင်မၞိဟ် ဟွံသေင်မ္ဂး ကမၠောန်မပံင်ဖက်ဂမၠိုင် ဟွံခိုဟ်ရ။',
      Language.shan:
          'ဝၼ်းဝႃႇရမိၵ်ႉတုႉလူင် မိူၼ်ၼင်ႇ ဝၼ်းဢမ်ႇလီ တႃႇၵၢၼ်တူင်ႇဝူင်းၵူၼ်း လႄႈ ၵၢၼ်ႁူမ်ႈမိုဝ်း။',
    },
    'desc_warameittunge': {
      Language.english:
          'Warameittunge (Minor Bad Friend) is a mildly inauspicious day.',
      Language.myanmar:
          'ဝါရမိတ္တုငယ်သည် အနည်းငယ် မသင့်တော်သော နေ့တစ်နေ့ဖြစ်သည်။',
      Language.zawgyi: 'ဝါရမိတၱဳငယ္သည္ အနည္းငယ္ မသင့္ေတာ္ေသာ ေန႔တစ္ေန႔ျဖစ္သည္။',
      Language.karen: 'ဝါရမိတ္တုငယ် ဝွေဟှဗ္ဗာန်၊ တုဟှင့်၊ တုဟိုင် ဟှေအုဲင်။',
      Language.mon: 'တ္ၚဲဝါရမိတ္တုငယ် ဝွံ အောန်ညိ ဟွံခိုဟ်ရ။',
      Language.shan: 'ဝၼ်းဝႃႇရမိၵ်ႉတုႉဢွၼ်ႇ မိူၼ်ၼင်ႇ ဝၼ်းဢမ်ႇလီဢိတ်းၼိုင်ႈ။',
    },
    'desc_yatpote': {
      Language.english:
          'Yatpote (Rotten Day) is considered poor for activities involving food, agriculture, or durable goods.',
      Language.myanmar:
          'ရက်ပုပ်သည် အစားအစာ၊ စိုက်ပျိုးရေး သို့မဟုတ် ရေရှည်ခံပစ္စည်းများအတွက် မသင့်တော်သော နေ့တစ်နေ့ဖြစ်သည်။',
      Language.zawgyi:
          'ရက္ပုပ္သည္ အစားအစာ၊ စိုက္ပ်ိဳးေရး သို႔မဟုတ္ ေရရွည္ခံပစၥည္းမ်ားအတြက္ မသင့္ေတာ္ေသာ ေန႔တစ္ေန႔ျဖစ္သည္။',
      Language.karen: 'ရက်ပုပ် ဝွေဟှဗ္ဗာန်၊ တုဟှင့်၊ တုဟိုင် ဟှေအုဲင်။',
      Language.mon:
          'တ္ၚဲရက်ပုပ် ဝွံ သွက်ပရေင်စၞ၊ ပရေင်ကမၠောန်ဝါဗ္ၚ ဟွံသေင်မ္ဂး ဒြပ်ရတ် မတန်တဴလံဂမၠိုင် ဟွံခိုဟ်ရ။',
      Language.shan:
          'ဝၼ်းဝၼ်းၼဝ်ႈ မိူၼ်ၼင်ႇ ဝၼ်းဢမ်ႇလီ တႃႇၶဝ်ႈၼမ်ႉတၢင်းၵိၼ်၊ ၵၢၼ်ၼႃး ဢမ်ႇၼၼ် ၶူဝ်းၶွင်ယိုၼ်းယၢဝ်း။',
    },
    'desc_thamaphyu': {
      Language.english:
          'Thamaphyu (The White Restrainer) is a day recommended for religious offerings and spiritual study.',
      Language.myanmar:
          'သမားဖြူသည် ဘာသာရေး ဆိုင်ရာ လှူဒါန်းမှုများနှင့် ဝိညာဉ်ရေးရာ လေ့လာမှုများအတွက် အကြံပြုထားသော နေ့ဖြစ်သည်။',
      Language.zawgyi:
          'သမားျဖဴသည္ ဘာသာေရး ဆိုင္ရာ လႉဒါန္းမႈမ်ားႏွင့္ ဝိညာဥ္ေရးရာ ေလ့လာမႈမ်ားအတြက္ အႀကံျပဳထားေသာ ေန႔ျဖစ္သည္။',
      Language.karen: 'သမားဖြူ ဝွေဟှဗ္ဗာန်၊ တုဟှင့်၊ မင်္ဂလာ ဟှေအုဲင်။',
      Language.mon:
          'တ္ၚဲသမားဖြူ ဝွံ သွက်ပရေင်သာသနာ၊ ပရေင်ပူဇဴ ကေုာံ ပရေင်ကလေင်လ္ၚတ် ဝိညာဉ် ခိုဟ်သန်ရ။',
      Language.shan:
          'ဝၼ်းသမႃးၽိူၵ်ႇ မိူၼ်ၼင်ႇ ဝၼ်းလီ တႃႇၵၢၼ်သႃႇသၼႃႇ လႄႈ ၵၢၼ်သွၼ်ႁဵၼ်း။',
    },
    'desc_nagapor': {
      Language.english:
          'Nagapor (Dragon Burden) is inauspicious for construction or ground-breaking activities.',
      Language.myanmar:
          'နဂါးပေါ်သည် ဆောက်လုပ်ရေး သို့မဟုတ် မြေစတင်တူးဖော်ခြင်း လုပ်ငန်းများအတွက် မသင့်တော်သော နေ့ဖြစ်သည်။',
      Language.zawgyi:
          'နဂါးေပၚသည္ ေဆာက္လုပ္ေရး သို႔မဟုတ္ ေျမစတင္တူးေဖာ္ျခင္း လုပ္ငန္းမ်ားအတြက္ မသင့္ေတာ္ေသာ ေန႔ျဖစ္သည္။',
      Language.karen: 'နဂါးပေါ် ဝွေဟှဗ္ဗာန်၊ တုဟှင့်၊ တုဟိုင် ဟှေအုဲင်။',
      Language.mon:
          'တ္ၚဲနဂါးပေါ် ဝွံ သွက်ပရေင်သြိုင်ခၞံ ဟွံသေင်မ္ဂး ပရေင်ခါဲတိ ဟွံခိုဟ်ရ။',
      Language.shan:
          'ဝၼ်းၼၵႃးပေႃႇ မိူၼ်ၼင်ႇ ဝၼ်းဢမ်ႇလီ တႃႇၵၢၼ်ပူၵ်းသၢင်ႈ လႄႈ ၵၢၼ်ၶုတ်းလိၼ်။',
    },
    'desc_yatyotema': {
      Language.english:
          'Yatyotema (Broken Day) is an inauspicious day where efforts might not yield desired results.',
      Language.myanmar:
          'ရက်ယုတ်မာသည် ကြိုးပမ်းအားထုတ်မှုများ ထိရောက်မှုမရှိနိုင်သော မကောင်းသော နေ့ဖြစ်သည်။',
      Language.zawgyi:
          'ရက္ယုတ္မာသည္ ႀကိဳးပမ္းအားထုတ္မႈမ်ား ထိေရာက္မႈမရွိႏိုင္ေသာ မေကာင္းေသာ ေန႔ျဖစ္သည္။',
      Language.karen: 'ရက်ယုတ်မာ ဝွေဟှဗ္ဗာန်၊ တုဟှင့်၊ တုဟိုင် ဟှေအုဲင်။',
      Language.mon:
          'တ္ၚဲရက်ယုတ်မာ ဝွံ သွက်ဂွံပ္တိတ်ဒြဟတ်ဂမၠိုင် ဟွံသၟဟ်အစောံရ။',
      Language.shan:
          'ဝၼ်းယုတ်ႉမႃႇ မိူၼ်ၼင်ႇ ဝၼ်းဢမ်ႇလီ တႃႇၵၢၼ်တႄႇ ဢၼ်လူဝ်ႇတၢင်းၶတ်းၸႂ်။',
    },
    'desc_mahayatkyan': {
      Language.english:
          'Mahayatkyan (Great Remainder) is considered a powerful day for starting long-term projects.',
      Language.myanmar:
          'မဟာရက်ကြမ်းသည် ရေရှည်စီမံကိန်းများကို စတင်ရန်အတွက် အစွမ်းထက်သော နေ့တစ်နေ့အဖြစ် သတ်မှတ်သည်။',
      Language.zawgyi:
          'မဟာရက္ၾကမ္းသည္ ေရရွည္စီမံကိန္းမ်ားကို စတင္ရန္အတြက္ အစြမ္းထက္ေသာ ေန႔တစ္ေန႔အျဖစ္ သတ္မွတ္သည္။',
      Language.karen: 'မဟာရက်ကြမ်း ဝွေဟှဗ္ဗာန်၊ တုဟှင့်၊ မင်္ဂလာ ဟှေအုဲင်။',
      Language.mon:
          'တ္ၚဲမဟာရက်ကြမ်း ဝွံ သွက်ပရေင်စပဋိသန္ဓေ ကမၠောန်ရေရှည်ဂမၠိုင် ခိုဟ်သန်ရ။',
      Language.shan:
          'ဝၼ်းၵျၢမ်းလူင် မိူၼ်ၼင်ႇ ဝၼ်းလီ တႃႇၵၢၼ်တႄႇ ဢၼ်တေယူႇႁိုင်။',
    },
    'desc_shanyat': {
      Language.english:
          'Shanyat (Conflict Day) is a day where disagreements are more likely; use caution in negotiations.',
      Language.myanmar:
          'ရှမ်းရက်သည် အငြင်းပွားမှုများ ဖြစ်ပွားနိုင်ခြေရှိသော နေ့ဖြစ်သောကြောင့် ဆွေးနွေးညှိနှိုင်းမှုများတွင် သတိရှိသင့်သည်။',
      Language.zawgyi:
          'ရွမ္းရက္သည္ အျငင္းပြားမႈမ်ား ျဖစ္ပြားႏိုင္ေျခရွိေသာ ေန႔ျဖစ္ေသာေၾကာင့္ ေဆြးေႏြးညႇိႏႈိင္းမႈမ်ားတြင္ သတိရွိသင့္သည္။',
      Language.karen: 'ရှမ်းရက် ဝွေဟှဗ္ဗာန်၊ တုဟှင့်၊ တုဟိုင် ဟှေအုဲင်။',
      Language.mon:
          'တ္ၚဲရှမ်းရက် ဝွံ သွက်ပရေင်ဆွေးနွေးညှိနှိုင်းဂမၠိုင် ဒးစွံသတိရ။',
      Language.shan:
          'ဝၼ်းတႆး မိူၼ်ၼင်ႇ ဝၼ်းဢၼ်လူဝ်ႇတၢင်းသတိ ပုၼ်ႈတႃႇၵၢၼ်ဢုပ်ႇၵုမ်။',
    },
    'desc_yatyaza': {
      Language.english:
          'Yatyaza (King Day) is generally auspicious for most activities, especially those involving authority.',
      Language.myanmar:
          'ရက်ရာဇာသည် အရာရာတွင် မင်္ဂလာရှိသောနေ့ဖြစ်ပြီး အထူးသဖြင့် အာဏာပိုင်များနှင့် ဆက်စပ်သော ကိစ္စများအတွက် ကောင်းမွန်သည်။',
      Language.zawgyi: '''
ရက္ရာဇာသည္ အရာရာတြင္ မဂၤလာရွိေသာေန႔ျဖစ္ၿပီး အထူးသျဖင့္ အာဏာပိုင္မ်ားႏွင့္ ဆက္စပ္ေသာ ကိစၥမ်ားအတြက္ ေကာင္းမြန္သည္။
''',
      Language.karen: 'ရက်ရာဇာ ဝွေဟှဗ္ဗာန်၊ တုဟှင့်၊ မင်္ဂလာ ဟှေအုဲင်။',
      Language.mon: 'တ္ၚဲရက်ရာဇာ ဝွံ သွက်ကိစ္စနာနာဂမၠိုင် ခိုဟ်သန်ရ။',
      Language.shan: 'ဝၼ်းယႃႇၸႃႇ မိူၼ်ၼင်ႇ ဝၼ်းလီ တႃႇၵၢၼ်ငၢၼ်းၵူႈလွင်ႈလွင်ႈ။',
    },
    'desc_pyathada': {
      Language.english:
          'Pyathada (Calamity) is generally inauspicious for travel or major life events.',
      Language.myanmar:
          'ပြဿဒါးသည် ခရီးသွားခြင်း သို့မဟုတ် အရေးကြီးသော ဘဝဖြစ်ရပ်များအတွက် ယေဘုယျအားဖြင့် မင်္ဂလာမရှိသော နေ့ဖြစ်သည်။',
      Language.zawgyi:
          'ျပႆဒါးသည္ ခရီးသြားျခင္း သို႔မဟုတ္ အေရးႀကီးေသာ ဘဝျဖစ္ရပ္မ်ားအတြက္ ေယဘုယ်အားျဖင့္ မဂၤလာမရွိေသာ ေန႔ျဖစ္သည္။',
      Language.karen: 'ပြဿဒါး ဝွေဟှဗ္ဗာန်၊ တုဟှင့်၊ တုဟိုင် ဟှေအုဲင်။',
      Language.mon:
          'တ္ၚဲပြဿဒါး ဝွံ သွက်အာတရဴ ဟွံသေင်မ္ဂး ကိစ္စဘဝကိစ္စဇၞော်ဂမၠိုင် ဟွံခိုဟ်ရ။',
      Language.shan:
          'ဝၼ်းပျတ်ႉတႃႉ မိူၼ်ၼင်ႇ ဝၼ်းဢမ်ႇလီ တႃႇၵၢၼ်ၶၢႆႉတၢင်း လႄႈ ၵၢၼ်ယႂ်ႇလူင်။',
    },
    'desc_not_available': {
      Language.english: 'Details are not available.',
      Language.myanmar: 'အသေးစိတ်အချက်အလက်များ မရှိပါ။',
      Language.zawgyi: 'အေသးစိတ္အခ်က္အလက္မ်ား မရွိပါ။',
      Language.karen: 'ဟွံမွဲတုဟှင့် အသေးစိတ် ဟှေအုဲင်။',
      Language.mon: 'တင်ဂၞင် အသေးစိတ် ဟွံမွဲရ။',
      Language.shan: 'ဢမ်ႇမီး ၶေႃႈမုၼ်း လွင်ႈတၢင်းဢမ်ႇမီး။',
    },
    'Horoscope Details': {
      Language.english: 'Horoscope Details',
      Language.myanmar: 'ဟောစာတမ်း အသေးစိတ်',
      Language.zawgyi: 'ေဟာစာတမ္း အေသးစိတ္',
      Language.karen: 'ဟောစာတမ်း အသေးစိတ်',
      Language.mon: 'ဟောစာတမ်း အသေးစိတ်',
      Language.shan: 'ၶေႃႈမုၼ်း ႁေႃၸႃႇတၢမ်း',
    },
    'Astrological Days': {
      Language.english: 'Astrological Days',
      Language.myanmar: 'နက္ခတ်ဗေဒဆိုင်ရာ နေ့ရက်များ',
      Language.zawgyi: 'နကၡတ္ေဗဒဆိုင္ရာ ေန႔ရက္မ်ား',
      Language.karen: 'နက္ခတ်ဗေဒဆိုင်ရာ နေ့ရက်များ',
      Language.mon: 'တ္ၚဲနက္ခတ်ဗေဒဂမၠိုင်',
      Language.shan: 'ဝၼ်းလႅင်ႊလၢဝ် ၼၵ်ႈၶတ်ႈ',
    },
    'Nakhat & Year': {
      Language.english: 'Nakhat & Year',
      Language.myanmar: 'နက္ခတ်နှင့် နှစ်နာမည်',
      Language.zawgyi: 'နကၡတ္ႏွင့္ ႏွစ္နာမည္',
      Language.karen: 'နက္ခတ်နှင့် နှစ်နာမည်',
      Language.mon: 'နက္ခတ် ကေုာံ ယၟုသၞာံ',
      Language.shan: 'ၼၵ်ႈၶတ်ႈ လႄႈ ၸိုဝ်ႈပီႊ',
    },
    'Western Date': {
      Language.english: 'Western Date',
      Language.myanmar: 'အင်္ဂလိပ်ရက်စွဲ',
      Language.zawgyi: 'အင်္ဂလိပ္ရက္စြဲ',
      Language.mon: 'ပရေင်စၟတ်တ္ၚဲ အင်္ဂလိက်',
      Language.shan: 'ဝၼ်းထီႉ ဢိင်းၵလဵတ်ႈ',
      Language.karen: 'အင်္ဂလိပ်ရက်စွဲ',
    },
    'Myanmar Date': {
      Language.english: 'Myanmar Date',
      Language.myanmar: 'မြန်မာရက်စွဲ',
      Language.zawgyi: 'ျမန္မာရက္စြဲ',
      Language.mon: 'ပရေင်စၟတ်တ္ၚဲ ဗၟာ',
      Language.shan: 'ဝၼ်းထီႉ မိူင်းမၢၼ်ႈ',
      Language.karen: 'မြန်မာရက်စွဲ',
    },
    'Description': {
      Language.english: 'Description',
      Language.myanmar: 'အသေးစိတ် ဖော်ပြချက်',
      Language.zawgyi: 'အေသးစိတ္ ေဖာ္ျပခ်က္',
      Language.mon: 'တင်ဂၞင် အသေးစိတ်',
      Language.shan: 'ၶေႃႈမုၼ်း လွင်ႈတၢင်း',
      Language.karen: 'အသေးစိတ် ဖော်ပြချက်',
    },
    'Characteristics': {
      Language.english: 'Characteristics',
      Language.myanmar: 'ပင်ကိုယ်စရိုက် လက္ခဏာများ',
      Language.zawgyi: 'ပင္ကိုယ္စရိုက္ လကၡဏာမ်ား',
      Language.mon: 'လက်သဏ် ပင်ကိုယ်စရိုက်ဂမၠိုင်',
      Language.shan: 'တၢင်းပဵၼ်ၵူၼ်း လႄႈ ၼမ်ႉၸႂ်',
      Language.karen: 'ပင်ကိုယ်စရိုက် လက္ခဏာများ',
    },
    'Mahabote & Characteristics': {
      Language.english: 'Mahabote & Characteristics',
      Language.myanmar: 'မဟာဘုတ်နှင့် ပင်ကိုယ်စရိုက်',
      Language.zawgyi: 'မဟာဘုတ္ႏွင့္ ပင္ကိုယ္စရိုက္',
      Language.karen: 'မဟာဘုတ်နှင့် ပင်ကိုယ်စရိုက်',
      Language.mon: 'မဟာဘုတ် ကေုာံ ပင်ကိုယ်စရိုက်',
      Language.shan: 'မႁႃႇပုတ်ႉ လႄႈ တၢင်းပဵၼ်ၵူၼ်း',
    },
    'General Info': {
      Language.english: 'General Info',
      Language.myanmar: 'အထွေထွေ အချက်အလက်',
      Language.zawgyi: 'အထွေထွေ အခ်က္အလက္',
      Language.karen: 'အထွေထွေ အချက်အလက်',
      Language.mon: 'တင်ဂၞင် အထွေထွေ',
      Language.shan: 'ၶေႃႈမုၼ်း တၢင်းၵူႈလွင်ႈ',
    },
    'Year Name': {
      Language.english: 'Year Name',
      Language.myanmar: 'နှစ်နာမည်',
      Language.zawgyi: 'နှစ္နာမည္',
      Language.karen: 'နှစ်နာမည်',
      Language.mon: 'ယၟုသၞာံ',
      Language.shan: 'ၸိုဝ်ႈပီႊ',
    },
    'Naga Head': {
      Language.english: 'Naga Head',
      Language.myanmar: 'နဂါးခေါင်း',
      Language.zawgyi: 'နဂါ္ခေါင္း',
      Language.karen: 'နဂါးခေါင်း',
      Language.mon: 'က္ဍိုပ်နာ်',
      Language.shan: 'ႁူဝ်ၼၵႃး',
    },
    'Religious Day': {
      Language.english: 'Religious Day',
      Language.myanmar: 'သာသနာရေးဆိုင်ရာနေ့',
      Language.zawgyi: 'သာသနာရေးဆိုင္ရာနေ့',
      Language.karen: 'သာသနာရေးဆိုင်ရာနေ့',
      Language.mon: 'တ္ၚဲသာသနာ',
      Language.shan: 'ဝၼ်းသႃႇသၼႃႇ',
    },
    'no_events_msg': {
      Language.english: 'No significant astrological events for this day.',
      Language.myanmar: 'ယနေ့အတွက် ထူးခြားသော နက္ခတ်ဗေဒ ဖြစ်ရပ်များ မရှိပါ။',
      Language.zawgyi: 'ယန့္အတ္က္ ထူးခြားသား နကၡတ္ဗေဒ ဖြစ္ရပ္များ မရွိပါ။',
      Language.karen: 'ယနေ့အတွက် ထူးခြားသော ဖြစ်ရပ်များ မရှိပါ။',
      Language.mon: 'သွက်တ္ၚဲဝွံ တင်ဂၞင်ထူးခြား ဟွံမွဲရ။',
      Language.shan: 'ဝၼ်းမိူဝ်ႈၼႆႉ ဢမ်ႇမီးလွင်ႈထူးၸႃး။',
    },
    'year_name_desc': {
      Language.english: 'This year is known as @year in the 12-year cycle.',
      Language.myanmar: 'ဤနှစ်သည် ၁၂ နှစ်စက်ဝန်းတွင် @year နှစ်ဟု လူသိများသည်။',
      Language.zawgyi:
          'ဤနှစ္သည္ ၁၂ နှစ္စက္ဝန္းတ္ောင္း @year နှစ္ဟု လူသိမ္းသည္။',
      Language.karen: 'သၞာံဝွံ လူသိများသည္ @year သၞာံ။',
      Language.mon: 'သၞာံဝွံ ပ္ဍဲသၞာံ ၁၂ ဂဟ် ဒှ်သၞာံ @year ရ။',
      Language.shan: 'ပီႊၼႆႉ ပဵၼ်ပီႊ @year ၼႂ်းပီႊ ၁၂ မိူဝ်ႈ။',
    },
    'naga_head_desc': {
      Language.english:
          'The head of the Naga is turned towards @dir. It is recommended to avoid facing this direction for important travels.',
      Language.myanmar:
          'နဂါးခေါင်းသည် @dir ဘက်သို့ လှည့်နေသည်။ အရေးကြီးသော ခရီးသွားလာမှုများအတွက် ဤဘက်သို့ မျက်နှာမူခြင်းကို ရှောင်ကြဉ်ရန် အကြံပြုထားသည်။',
      Language.zawgyi:
          'နဂါ္ခေါင္းသည္ @dir ဘက္သို့ လှည္နေသည္။ အရေးက္ော့သော ခရီးသွားလာမှုမ်ားအတ္က္တွက္ ဤဘက္သို့ မျက်န္ာမူခြင္းကို ရှောင္ကြည္ရန္ အကြံပိုးထားသည္။',
      Language.karen: 'နဂါးခေါင်း @dir ဘက်သို့ လှည့်နေသည်။',
      Language.mon: 'က္ဍိုပ်နာ် ဝွံ ဝေင်ဂရီုမံင် လ္ပာ် @dir ရ။',
      Language.shan: 'ႁူဝ်ၼၵႃး ဝၢႆႇၵႂႃႇတၢင်း @dir။',
    },
    'today_is_msg': {
      Language.english: 'Today is @day.',
      Language.myanmar: 'ယနေ့သည် @day ဖြစ်သည်။',
      Language.zawgyi: 'ယန့္သည္ @day ဖြစ္သည္။',
      Language.karen: 'ယနေ့သည် @day ဖြစ်သည်။',
      Language.mon: 'တ္ၚဲဝွံ ဒှ်တ္ၚဲ @day ရ။',
      Language.shan: 'ဝၼ်းမိူဝ်ႈၼႆႉ ပဵၼ်ဝၼ်း @day။',
    },
    'Nakhat': {
      Language.english: 'Nakhat',
      Language.myanmar: 'နက္ခတ်',
      Language.zawgyi: 'နကၡတ္',
      Language.mon: 'နက္ခတ်',
      Language.shan: 'လႅင်ႊလၢဝ်',
      Language.karen: 'နက္ခတ်',
    },
    // Nagahle
    'Naga': {
      Language.english: 'Naga',
      Language.myanmar: 'နဂါး',
      Language.zawgyi: 'နဂါး',
      Language.mon: 'နဂါး',
      Language.shan: 'ႁူဝ်',
      Language.karen: 'နဂါး',
    },
    'Head': {
      Language.english: 'Head',
      Language.myanmar: 'ခေါင်း',
      Language.zawgyi: "ေခါင္း",
      Language.mon: 'ခေါင်း',
      Language.shan: 'ၼၵႃး',
      Language.karen: 'ခေါင်း',
    },
    'Facing': {
      Language.english: 'Facing',
      Language.myanmar: 'လှည့်',
      Language.zawgyi: 'လွည့္',
      Language.mon: 'လှည့်',
      Language.shan: 'ဝၢႆႇ',
      Language.karen: 'လှည့်',
    },
    'East': {
      Language.english: 'East',
      Language.myanmar: 'အရှေ့',
      Language.zawgyi: 'အေရွ႕',
      Language.mon: 'ဗၟံက်',
      Language.shan: 'တၢင်းဢွၵ်ႇ',
      Language.karen: 'မုဟ်ထီၣ်',
    },
    'West': {
      Language.english: 'West',
      Language.myanmar: 'အနောက်',
      Language.zawgyi: 'အေနာက္',
      Language.mon: 'ပလိုတ်',
      Language.shan: 'တၢင်းတူၵ်း',
      Language.karen: 'မုဟ်နုာ်',
    },
    'South': {
      Language.english: 'South',
      Language.myanmar: 'တောင်',
      Language.zawgyi: "ေတာင္",
      Language.mon: 'သၠုင်ကျာ',
      Language.shan: 'တၢင်းၸၢၼ်း',
      Language.karen: 'လာနီ',
    },
    'North': {
      Language.english: 'North',
      Language.myanmar: 'မြောက်',
      Language.zawgyi: "ေျမာက္",
      Language.mon: 'သၟဝ်ကျာ',
      Language.shan: 'တၢင်းႁွင်ႇ',
      Language.karen: 'စလာ',
    },
    // Holidays
    // Thingyan
    'Thingyan': {
      Language.english: 'Thingyan',
      Language.myanmar: 'သင်္ကြန်',
      Language.zawgyi: 'သၾကၤန္',
      Language.mon: 'အတး',
      Language.shan: 'သၢင်းၵျၢၼ်ႇ',
      Language.karen: 'သင်္ကြန်',
    },
    'Akyo': {
      Language.english: 'Akyo',
      Language.myanmar: 'အကြို',
      Language.zawgyi: 'အႀကိဳ',
      Language.mon: 'ဒစး',
      Language.shan: 'ႁပ်ႉထိုင်း',
      Language.karen: 'ထံးဆီဉ်',
    },

    'Akya': {
      Language.english: 'Akya',
      Language.myanmar: 'အကျ',
      Language.zawgyi: 'အက်',
      Language.mon: 'စှေ်',
      Language.shan: 'တူၵ်း',
      Language.karen: 'လီၤ',
    },
    'Akyat': {
      Language.english: 'Akyat',
      Language.myanmar: 'အကြတ်',
      Language.zawgyi: 'အၾကတ္',
      Language.mon: 'ကြာပ်',
      Language.shan: 'ၵျၢပ်ႈ',
      Language.karen: 'ဃာ်',
    },
    'Atat': {
      Language.english: 'Atat',
      Language.myanmar: 'အတက်',
      Language.zawgyi: 'အတက္',
      Language.mon: 'တိုန်',
      Language.shan: 'ၶိုၼ်ႈ',
      Language.karen: 'ထီၣ်',
    },
    // other holidays
    'Good Friday': {
      Language.english: 'Good Friday',
      Language.myanmar: 'သောကြာနေ့ကြီး',
      Language.zawgyi: "ေသာၾကာေန႔ႀကီး",
      Language.mon: 'တ္ၚဲသောကြာဇၞော်',
      Language.shan: 'ဝၼ်းသုၵ်းမျတ်ႉ',
      Language.karen: 'မုၢ်ဖီဖး',
    },
    "New Year's": {
      Language.english: "New Year's",
      Language.myanmar: 'နှစ်သစ်ကူး',
      Language.zawgyi: 'ႏွစ္သစ္ကူး',
      Language.mon: 'သၞာံတၟိ',
      Language.shan: 'ပီႊမႂ်ႇ',
      Language.karen: 'တၢ်ထီၣ်သီ',
    },
    'Independence': {
      Language.english: 'Independence',
      Language.myanmar: 'လွတ်လပ်ရေး',
      Language.zawgyi: 'လြတ္လပ္ေရး',
      Language.mon: 'သၠးပွး',
      Language.shan: 'ဢၼ်လွတ်ႈလႅဝ်',
      Language.karen: 'မုၢ်နံၤလွတ်လပ်ရေး',
    },
    'Union': {
      Language.english: 'Union',
      Language.myanmar: 'ပြည်ထောင်စု',
      Language.zawgyi: 'ျပည္ေထာင္စု',
      Language.mon: 'ကၟိန်ဍုၚ်',
      Language.shan: 'ၸိုင်ႈမိူင်းႁူမ်ႈတုမ်ႊ',
      Language.karen: 'မုၢ်နံၤပြည်ထောင်စု',
    },
    'Peasants': {
      Language.english: 'Peasants',
      Language.myanmar: 'တောင်သူလယ်သမား',
      Language.zawgyi: 'ေတာင္သူလယ္သမား',
      Language.mon: 'သၟာဗ္ၚ',
      Language.shan: 'ၸဝ်ႈႁႆႈၸဝ်ႈၼႃး',
      Language.karen: 'မုၢ်နံၤတောင်သူလယ်သမား',
    },
    'Resistance': {
      Language.english: 'Resistance',
      Language.myanmar: 'တော်လှန်ရေး',
      Language.zawgyi: 'ေတာ္လွန္ေရး',
      Language.mon: 'တ္ၚဲပၠန်ဂတး',
      Language.shan: 'ဝၼ်းတေႃႇၸုၼ်ႉ',
      Language.karen: 'မုၢ်နံၤပၠန်ဆၢ',
    },
    'Labour': {
      Language.english: 'Labour',
      Language.myanmar: 'အလုပ်သမား',
      Language.zawgyi: 'အလုပ္သမား',
      Language.mon: 'တ္ၚဲသၟာကမၠောန်',
      Language.shan: 'ဝၼ်းၵူၼ်းႁဵတ်းၵၢၼ်',
      Language.karen: 'မုၢ်နံၤအလုပ်သမား',
    },
    "Martyrs'": {
      Language.english: "Martyrs'",
      Language.myanmar: 'အာဇာနည်',
      Language.zawgyi: 'အာဇာနည္',
      Language.mon: 'တ္ၚဲအာဇာနဲ',
      Language.shan: 'ဝၼ်းဢႃႇၸႃႇၼီႇ',
      Language.karen: 'မုၢ်နံၤအာဇာနည်',
    },
    "Christmas": {
      Language.english: "Christmas",
      Language.myanmar: 'ခရစ္စမတ်',
      Language.zawgyi: 'ခရစၥမတ္',
      Language.mon: 'ခရေဿမာတ်',
      Language.shan: 'ပွႆးၶရိတ်ႉသမတ်ႉၸ်',
      Language.karen: 'ခရံာ်အိၣ်ဖျဲၣ်မူးပွဲ',
    },
    "Buddha": {
      Language.english: "Buddha",
      Language.myanmar: 'ဗုဒ္ဓ',
      Language.zawgyi: 'ဗုဒၶ',
      Language.mon: 'တ္ၚဲပုရိသာဒ်',
      Language.shan: 'ဝၼ်းပုတ်ႉထ',
      Language.karen: 'မုၢ်နံၤဗုဒ္ဓ',
    },
    "Start of Buddhist Lent": {
      Language.english: "Start of Buddhist Lent",
      Language.myanmar: 'ဓမ္မစကြာနေ့',
      Language.zawgyi: 'ဓမၼစၾကာေန႔',
      Language.mon: 'တ္ၚဲဓမ္မစက်',
      Language.shan: 'ဝၼ်းထမ်ႇမၸၵ်ႉၵျႃႇ',
      Language.karen: 'မုၢ်နံၤဓမ္မစကြာ',
    },
    "End of Buddhist Lent": {
      Language.english: "End of Buddhist Lent",
      Language.myanmar: 'မီးထွန်းပွဲ',
      Language.zawgyi: 'မီးထြန္းပြဲ',
      Language.mon: 'တ္ၚဲအဘိဓရ်',
      Language.shan: 'ဝၼ်းတႆႈၾႆး',
      Language.karen: 'မုၢ်နံၤမီးထွန်းပွဲ',
    },
    "Tazaungdaing": {
      Language.english: "Tazaungdaing",
      Language.myanmar: 'တန်ဆောင်တိုင်',
      Language.zawgyi: 'တန္ေဆာင္တိုင္',
      Language.mon: 'သ္ဘၚ်ပူဇဴပၟတ်ပၞာၚ်',
      Language.shan: 'ဝၼ်းတိုၼ်းလူင်',
      Language.karen: 'မုၢ်နံၤပူဇဴပၟတ်',
    },
    "National": {
      Language.english: "National",
      Language.myanmar: 'အမျိုးသား',
      Language.zawgyi: 'အမ်ိဳးသား',
      Language.mon: 'ကောန်ဂကူ',
      Language.shan: 'ၸိူဝ်ႉၸၢတ်ႈ',
      Language.karen: 'မုၢ်နံၤဂကူ',
    },
    "National Day": {
      Language.english: "National Day",
      Language.myanmar: 'အမျိုးသားနေ့',
      Language.zawgyi: 'အမ်ိဳးသားေန႔',
      Language.mon: 'တ္ၚဲကောန်ဂကူ',
      Language.shan: 'ဝၼ်းၸိူဝ်ႉၸၢတ်ႈ',
      Language.karen: 'မုၢ်နံၤအမျိုးသားနေ့',
    },
    "G. Aung San BD": {
      Language.english: "G. Aung San BD",
      Language.myanmar: 'ဗိုလ်ချုပ်မွေးနေ့',
      Language.zawgyi: 'ဗိုလ္ခ်ဳပ္ေမြးေန႔',
      Language.mon: 'တ္ၚဲအံၚ်သာန်ဒှ်မၞိဟ်',
      Language.shan: 'ဝၼ်းၵိူတ်ၸွမ်သိုၵ်းဢွင်ႇသၢၼ်း',
      Language.karen: 'ဗိုလ်ချုပ်မွေးနေ့',
    },
    "Valentines": {
      Language.english: "Valentines",
      Language.myanmar: 'ချစ်သူများ',
      Language.zawgyi: 'ခ်စ္သူမ်ား',
      Language.mon: 'တ္ၚဲဝုတ်ဗၠာဲ',
      Language.shan: 'ဝၼ်းၵေႃႉႁၵ်ႉ',
      Language.karen: 'မုၢ်နံၤချစ်သူများ',
    },
    "Earth": {
      Language.english: "Earth",
      Language.myanmar: 'ကမ္ဘာမြေ',
      Language.zawgyi: 'ကမၻာေျမ',
      Language.mon: 'ဂၠးကဝ်',
      Language.shan: 'လိၼ်မိူင်း',
      Language.karen: 'ဟီၣ်ခိၣ်',
    },
    "April Fools'": {
      Language.english: "April Fools'",
      Language.myanmar: 'ဧပြီအရူး',
      Language.zawgyi: 'ဧၿပီအ႐ူး',
      Language.mon: 'သ္ပပရအ်',
      Language.shan: 'ဢေႇပရႄႇၵူၼ်းယွင်ႇ',
      Language.karen: 'အ့ဖြ့ၣ် fool',
    },
    "Red Cross": {
      Language.english: "Red Cross",
      Language.myanmar: 'ကြက်ခြေနီ',
      Language.zawgyi: 'ၾကက္ေျခနီ',
      Language.mon: 'ဇိုၚ်ခ္ဍာ်ဍာဲ',
      Language.shan: 'ဢၼ်မီးသီလႅင်ႁၢင်ႈၶႂၢႆႇၶႃပေ',
      Language.karen: 'ကြက်ခြေနီ',
    },
    "United Nations": {
      Language.english: "United Nations",
      Language.myanmar: 'ကုလသမ္မဂ္ဂ',
      Language.zawgyi: 'ကုလသမၼဂၢ',
      Language.mon: 'ကုလသမ္မဂ္ဂ',
      Language.shan: 'ၸိုင်ႈမိူင်းႁူမ်ႈတုမ်ႊကုလ',
      Language.karen: 'ကုလသမ္မဂ္ဂ',
    },
    "Halloween": {
      Language.english: "Halloween",
      Language.myanmar: 'သရဲနေ့',
      Language.zawgyi: 'သရဲေန႔',
      Language.mon: 'သ္ဘၚ်ဟေဝ်လဝ်ဝိန်',
      Language.shan: 'ဝၼ်းၽဵတ်ႇ',
      Language.karen: 'မုၢ်နံၤကစၢ်ဆီ',
    },
    "Mothers": {
      Language.english: "Mothers",
      Language.myanmar: 'အမေများ',
      Language.zawgyi: 'အေမမ်ား',
      Language.mon: 'မိအံက်ဂမၠိုင်',
      Language.shan: 'ဝၼ်းမႄႈ',
      Language.karen: 'မုၢ်နံၤမိၢ်',
    },
    "Fathers": {
      Language.english: "Fathers",
      Language.myanmar: 'အဖေများ',
      Language.zawgyi: 'အေဖမ်ား',
      Language.mon: 'မအံက်ဂမၠိုင်',
      Language.shan: 'ဝၼ်းပေႃႈ',
      Language.karen: 'မုၢ်နံၤပၢ်',
    },
    "Eid": {
      Language.english: "Eid",
      Language.myanmar: 'အိဒ်',
      Language.zawgyi: 'အိဒ္',
      Language.mon: 'ပွဲအိဒ်',
      Language.shan: 'ပွႆးအိဒ်ႇ',
      Language.karen: 'ပွဲအိဒ်',
    },
    "Diwali": {
      Language.english: "Diwali",
      Language.myanmar: 'ဒီဝါလီ',
      Language.zawgyi: 'ဒီဝါလီ',
      Language.mon: 'ပွဲဒီဝါလီ',
      Language.shan: 'ပွႆးဒီဝါလီ',
      Language.karen: 'ပွဲဒီဝါလီ',
    },
    "Mahathamaya": {
      Language.english: "Mahathamaya",
      Language.myanmar: 'မဟာသမယ',
      Language.zawgyi: 'မဟာသမယ',
      Language.mon: 'တ္ၚဲမဟာသမယ',
      Language.shan: 'ဝၼ်းမႁႃႇသမယ',
      Language.karen: 'မုၢ်နံၤမဟာသမယ',
    },
    "Garudhamma": {
      Language.english: "Garudhamma",
      Language.myanmar: 'ဂရုဓမ္မ',
      Language.zawgyi: 'ဂ႐ုဓမၼ',
      Language.mon: 'တ္ၚဲဂရုဓမ္မ',
      Language.shan: 'ဝၼ်းၵရုထမ်ႇမ',
      Language.karen: 'မုၢ်နံၤဂရုဓမ္မ',
    },
    "Metta": {
      Language.english: "Metta",
      Language.myanmar: 'မေတ္တာ',
      Language.zawgyi: 'ေမတၱာ',
      Language.mon: 'တ္ၚဲမေတ္တာ',
      Language.shan: 'ဝၼ်းမႅတ်ႉတႃႇ',
      Language.karen: 'မုၢ်နံၤမေတ္တာ',
    },
    "Taungpyone": {
      Language.english: "Taungpyone",
      Language.myanmar: 'တောင်ပြုန်း',
      Language.zawgyi: 'ေတာင္ျပဳန္း',
      Language.mon: 'တောင်ပြုန်း',
      Language.shan: 'တောင်ပြုန်း',
      Language.karen: 'တောင်ပြုန်း',
    },
    "Yadanagu": {
      Language.english: "Yadanagu",
      Language.myanmar: 'ရတနာ့ဂူ',
      Language.zawgyi: 'ရတနာ့ဂူ',
      Language.mon: 'ရတနာ့ဂူ',
      Language.shan: 'ရတနာ့ဂူ',
      Language.karen: 'ရတနာ့ဂူ',
    },
    "Authors": {
      Language.english: "Authors",
      Language.myanmar: 'စာဆိုတော်',
      Language.zawgyi: 'စာဆိုေတာ္',
      Language.mon: 'စာဆိုတော်',
      Language.shan: 'ၽူႈတႅမ်ႈၽႅၼ်',
      Language.karen: 'စာဆိုတော်',
    },
    "World": {
      Language.english: "World",
      Language.myanmar: 'ကမ္ဘာ့',
      Language.zawgyi: 'ကမၻာ့',
      Language.mon: 'ကမ္ဘာ့',
      Language.shan: 'လူၵ်',
      Language.karen: 'ကမ္ဘာ့',
    },
    "Teachers": {
      Language.english: "Teachers",
      Language.myanmar: 'ဆရာများ',
      Language.zawgyi: 'ဆရာမ်ား',
      Language.mon: 'ဆရာများ',
      Language.shan: 'ၶူးသွၼ်',
      Language.karen: 'ဆရာများ',
    },
    "Easter": {
      Language.english: "Easter",
      Language.myanmar: 'ထမြောက်ရာနေ့',
      Language.zawgyi: 'ထေျမာက္ရာေန႔',
      Language.mon: 'ထမြောက်ရာနေ့',
      Language.shan: 'ပၢင်ႇပွႆးၶွပ်ႈၶူပ်ႇၸဝ်ႈၶရိတ်',
      Language.karen: 'ထမြောက်ရာနေ့',
    },
    "Karen New Year Day": {
      Language.english: "Karen New Year Day",
      Language.myanmar: 'ကရင်နှစ်သစ်ကူးနေ့',
      Language.zawgyi: 'ကရင္ႏွစ္သစ္ကူးေန႔',
      Language.mon: 'တ္ၚဲသၞာံတၟိကရေၚ်',
      Language.shan: 'ဝၼ်းပီႊမႂ်ႇယၢင်း',
      Language.karen: 'မုၢ်နံၤထီၣ်သီကညီ',
    },
    "Tabaung Pwe": {
      Language.english: "Tabaung Pwe",
      Language.myanmar: 'တပေါင်းပွဲတော်',
      Language.zawgyi: 'တေပါင္းပြဲေတာ္',
      Language.mon: 'သ္ဘၚ်ဖဍာ်ဗြာတ်',
      Language.shan: 'ပွႆးလိူၼ်သီႇ',
      Language.karen: 'ပွဲတပေါင်း',
    },
    "Myanmar New Year's Day": {
      Language.english: "Myanmar New Year's Day",
      Language.myanmar: 'နှစ်ဆန်းတစ်ရက်',
      Language.zawgyi: 'နွစ္ဆန္း တစ္ရက္',
      Language.mon: 'တ္ၚဲသင်္ကြန်အတက်',
      Language.shan: 'ဝၼ်းပီႊမႂ်ႇမိူင်းမၢၼ်ႈ',
      Language.karen: 'မုၢ်နံၤထီၣ်သီမိူင်းမၢၼ်ႈ',
    },
    "Mon National Day": {
      Language.english: "Mon National Day",
      Language.myanmar: 'မန်အမျိုးသားနေ့',
      Language.zawgyi: 'မန္အမ်ိဳးသားေန႔',
      Language.mon: 'တ္ၚဲကောန်ဂကူမန်',
      Language.shan: 'ဝၼ်းၸိူဝ်ႉၸၢတ်ႈမၼ်း',
      Language.karen: 'မုၢ်နံၤဂကူမန်',
    },
    "Mon Fallen Day": {
      Language.english: "Mon Fallen Day",
      Language.myanmar: 'ဟံသာဝတီပျက်သုဉ်းခြင်းနေ့',
      Language.zawgyi: 'ဟံသာဝတီပ်က္သုန္းျခင္းေန႔',
      Language.mon: 'တ္ၚဲဟံသာဝတဳလီု',
      Language.shan: 'ဝၼ်းႁူင်းသႃႇဝတီႇလူႉ',
      Language.karen: 'ဟံသာဝတီပျက်သုဉ်းခြင်းနေ့',
    },
    "Mon Revolution Day": {
      Language.english: "Mon Revolution Day",
      Language.myanmar: 'မန်တော်လှန်ရေးနေ့',
      Language.zawgyi: 'မန္ေတာ္လွန္ေရးေန႔',
      Language.mon: 'တ္ၚဲပၠန်ဂတးမန်',
      Language.shan: 'ဝၼ်းတေႃႇၸုၼ်ႉမၼ်း',
      Language.karen: 'မုၢ်နံၤပၠန်ဆၢမန်',
    },
    "Mon Women Day": {
      Language.english: "Mon Women Day",
      Language.myanmar: 'မန်အမျိုးသမီးနေ့',
      Language.zawgyi: 'မန္အမ်ိဳးသမီးေန႔',
      Language.mon: 'တ္ၚဲဗြဴမန်',
      Language.shan: 'ဝၼ်းၼၢင်းယိင်းမၼ်း',
      Language.karen: 'မုၢ်နံၤဂကူမန်ပိာ်မုၣ်',
    },
    "Shan New Year Day": {
      Language.english: "Shan New Year Day",
      Language.myanmar: 'ရှမ်းနှစ်သစ်ကူးနေ့',
      Language.zawgyi: 'ရွမ္းႏွစ္သစ္ကူးေန႔',
      Language.mon: 'တ္ၚဲသၞာံတၟိသေံ',
      Language.shan: 'ဝၼ်းပီႊမႂ်ႇတႆး',
      Language.karen: 'မုၢ်နံၤထီၣ်သီၡၢၼ်း',
    },
    "Mothers Day": {
      Language.english: "Mothers Day",
      Language.myanmar: 'အမေများနေ့',
      Language.zawgyi: 'အေမမ်ားေန႔',
      Language.mon: 'တ္ၚဲမိအံက်',
      Language.shan: 'ဝၼ်းမႄႈ',
      Language.karen: 'မုၢ်နံၤမိၢ်',
    },
    "Fathers Day": {
      Language.english: "Fathers Day",
      Language.myanmar: 'အဖေများနေ့',
      Language.zawgyi: 'အေဖမ်ားေန႔',
      Language.mon: 'တ္ၚဲမအံက်',
      Language.shan: 'ဝၼ်းပေႃႈ',
      Language.karen: 'မုၢ်နံၤပၢ်',
    },
    "Mahathamaya Day": {
      Language.english: "Mahathamaya Day",
      Language.myanmar: 'မဟာသမယနေ့',
      Language.zawgyi: 'မဟာသမယေန႔',
      Language.mon: 'တ္ၚဲမဟာသမယ',
      Language.shan: 'ဝၼ်းမႁႃႇသမယ',
      Language.karen: 'မုၢ်နံၤမဟာသမယ',
    },
    "Garudhamma Day": {
      Language.english: "Garudhamma Day",
      Language.myanmar: 'ဂရုဓမ္မနေ့',
      Language.zawgyi: 'ဂ႐ုဓမၼေန႔',
      Language.mon: 'တ္ၚဲဂရုဓမ္မ',
      Language.shan: 'ဝၼ်းၶရုထမ်ႇမ',
      Language.karen: 'မုၢ်နံၤဂရုဓမ္မ',
    },
    "Metta Day": {
      Language.english: "Metta Day",
      Language.myanmar: 'မေတ္တာနေ့',
      Language.zawgyi: 'ေမတၱာေန႔',
      Language.mon: 'တ္ၚဲမေတ္တာ',
      Language.shan: 'ဝၼ်းမႅတ်ႉတႃႇ',
      Language.karen: 'မုၢ်နံၤမေတ္တာ',
    },
    "Taungpyone Pwe": {
      Language.english: "Taungpyone Pwe",
      Language.myanmar: 'တောင်ပြုန်းပွဲ',
      Language.zawgyi: 'ေတာင္ျပဳန္းပြဲ',
      Language.mon: 'သ္ဘၚ်တောင်ပြုန်း',
      Language.shan: 'ပွႆးတူင်းပျူင်း',
      Language.karen: 'ပွဲတောင်ပြုန်း',
    },
    "Yadanagu Pwe": {
      Language.english: "Yadanagu Pwe",
      Language.myanmar: 'ရတနာ့ဂူပွဲ',
      Language.zawgyi: 'ရတနာ့ဂူပြဲ',
      Language.mon: 'သ္ဘၚ်ရတနာ့ဂူ',
      Language.shan: 'ပွႆးရတနာ့ဂူ',
      Language.karen: 'ပွဲရတနာ့ဂူ',
    },
    "Authors Day": {
      Language.english: "Authors Day",
      Language.myanmar: 'စာဆိုတော်နေ့',
      Language.zawgyi: 'စာဆိုေတာ္ေန႔',
      Language.mon: 'တ္ၚဲစာဆိုတော်',
      Language.shan: 'ဝၼ်းၽူႈတႅမ်ႈ',
      Language.karen: 'မုၢ်နံၤစာဆိုတော်',
    },
    "World Teachers Day": {
      Language.english: "World Teachers Day",
      Language.myanmar: 'ကမ္ဘာ့ဆရာများနေ့',
      Language.zawgyi: 'ကမၻာ့ဆရာမ်ားေန႔',
      Language.mon: 'တ္ၚဲဆရာဂမၠိုင်ကမ္ဘာ',
      Language.shan: 'ဝၼ်းၶူးသွၼ်လူၵ်ႈ',
      Language.karen: 'မုၢ်နံၤဆရာဂီၢ်ကမ္ဘာ့',
    },
    "Chinese New Year's": {
      Language.english: "Chinese New Year's",
      Language.myanmar: 'တရုတ်နှစ်သစ်ကူး',
      Language.zawgyi: 'တ႐ုတ္ႏွစ္သစ္ကူး',
      Language.mon: 'သ္ဘၚ်သၞာံတၟိတရုတ်',
      Language.shan: 'ဝၼ်းပီႊမႂ်ႇၶေ',
      Language.karen: 'မုၢ်နံၤထီၣ်သီတရုတ်',
    },
    "Holiday": {
      Language.english: "Holiday",
      Language.myanmar: 'ရုံးပိတ်ရက်',
      Language.zawgyi: '႐ုံးပိတ္ရက္',
      Language.mon: 'တ္ၚဲဇူ',
      Language.shan: 'ဝၼ်းပိၵ်ႉလုမ်း',
      Language.karen: 'မုၢ်နံၤအိၣ်ဘှံး',
    },

    // misc
    "Mon": {
      Language.english: "Mon",
      Language.myanmar: 'မွန်',
      Language.zawgyi: 'မြန္',
      Language.mon: 'မန်',
      Language.shan: 'မၼ်း',
      Language.karen: 'မန်',
    },
    "Karen": {
      Language.english: "Karen",
      Language.myanmar: 'ကရင်',
      Language.zawgyi: 'ကရင္',
      Language.mon: 'ကရေၚ်',
      Language.shan: 'ယၢင်း',
      Language.karen: 'ကညီ',
    },
    "Shan": {
      Language.english: "Shan",
      Language.myanmar: 'ရှမ်း',
      Language.zawgyi: 'ရွမ္း',
      Language.mon: 'သေံ',
      Language.shan: 'တႆး',
      Language.karen: 'ၡၢၼ်း',
    },
    "Chinese": {
      Language.english: "Chinese",
      Language.myanmar: 'တရုတ်',
      Language.zawgyi: 'တ႐ုတ္',
      Language.mon: 'တရုတ်',
      Language.shan: 'ၶေ',
      Language.karen: 'တရုတ်',
    },
    "Pwe": {
      Language.english: "Pwe",
      Language.myanmar: 'ပွဲတော်',
      Language.zawgyi: 'ပြဲေတာ္',
      Language.mon: 'သ္ဘၚ်',
      Language.shan: 'ပွႆး',
      Language.karen: 'ပွဲ',
    },
    "Calculator": {
      Language.english: "Calculator",
      Language.myanmar: 'တွက်စက်',
      Language.zawgyi: 'တြက္စက္',
      Language.mon: 'တွက်စက်',
      Language.shan: 'ၶိူင်ႈၼပ်ႉ',
      Language.karen: 'စကးတ့ၢ်',
    },
    ".": {
      Language.english: ". ",
      Language.myanmar: '။ ',
      Language.zawgyi: '။ ',
      Language.mon: '။ ',
      Language.shan: '။ ',
      Language.karen: '။ ',
    },
    ",": {
      Language.english: ", ",
      Language.myanmar: '၊ ',
      Language.zawgyi: '၊ ',
      Language.mon: '၊ ',
      Language.shan: ', ',
      Language.karen: '၊ ',
    },
    'Calendar': {
      Language.myanmar: 'ပြက္ခဒိန်',
      Language.zawgyi: 'ျပကၡဒိန္',
      Language.mon: 'ပြက္ခဒိန်',
      Language.shan: 'ပပ်ႉပိတ်း',
      Language.karen: 'ဒိနံၣ်',
      Language.english: 'Calendar',
    },
    'Year View': {
      Language.myanmar: 'နှစ်ကြည့်ရှုခြင်း',
      Language.zawgyi: 'ႏွစ္ၾကည့္ရႈျခင္း',
      Language.mon: 'ဗ္စတ်သၟာံ',
      Language.shan: 'တူၺ်းပီႊ',
      Language.karen: 'ကွၢ်နံၣ်',
      Language.english: 'Year View',
    },
    'Today': {
      Language.myanmar: 'ယနေ့',
      Language.zawgyi: 'ယေန႔',
      Language.mon: 'တ္ၚဲဏအ်',
      Language.shan: 'မိူဝ်ႈၼႆႉ',
      Language.karen: 'မုၢ်နံၤအံၤ',
      Language.english: 'Today',
    },
    'Clear': {
      Language.myanmar: 'ရှင်းလင်း',
      Language.zawgyi: 'ရွင္းလင္း',
      Language.mon: 'သ္အးဇၚ်',
      Language.shan: 'လၢင်း',
      Language.karen: 'ဖျီအီၤ',
      Language.english: 'Clear',
    },
    'Cancel': {
      Language.myanmar: 'ပယ်ဖျက်',
      Language.zawgyi: 'ပယ္ဖ်က္',
      Language.mon: 'ဇုက်ထောံ',
      Language.shan: 'ႁၢမ်ႈ',
      Language.karen: 'တ့ၢ်ကွံာ်',
      Language.english: 'Cancel',
    },
    'OK': {
      Language.myanmar: 'အိုကေ',
      Language.zawgyi: 'အိုေက',
      Language.mon: 'ညးရ',
      Language.shan: 'တူၵ်းလူင်ႈ',
      Language.karen: 'အိုကေ',
      Language.english: 'OK',
    },
    'Back to Calendar': {
      Language.myanmar: 'ပြက္ခဒိန်သို့ ပြန်သွား',
      Language.zawgyi: 'ျပကၡဒိန္သို႔ ျပန္သြား',
      Language.mon: 'ကလေၚ်အာပြက္ခဒိန်',
      Language.shan: 'ၶိုၼ်းသွႆး လိၵ်ႈပိတ်း',
      Language.karen: 'က့ၤဆူဒိနံၣ်',
      Language.english: 'Back to Calendar',
    },
    'Select Month and Year': {
      Language.myanmar: 'လနှင့်နှစ်ရွေးချယ်ပါ',
      Language.zawgyi: 'လႏွင့္ႏွစ္ေရြးခ်ယ္ပါ',
      Language.mon: 'ရုဲစှဗရလ ကေုာံ သၞာံ',
      Language.shan: 'လိူဝ်ႈ လႄႈ ပီႇ',
      Language.karen: 'ဃုထၢလါဒီးနံၣ်',
      Language.english: 'Select Month and Year',
    },
    'previousMonth': {
      Language.myanmar: 'ယခင်လ',
      Language.zawgyi: 'ယခင္လ',
      Language.mon: 'ဂိတုမတုဲကၠုင်',
      Language.shan: 'လိူဝ်ႈၵွၼ်း',
      Language.karen: 'လါလၢကမၤအသး',
      Language.english: 'Previous Month',
    },
    'nextMonth': {
      Language.myanmar: 'နောက်လ',
      Language.zawgyi: 'ေနာက္လ',
      Language.mon: 'ဂိတုဂတ',
      Language.shan: 'လိူဝ်ႈႁူဝ်',
      Language.karen: 'လါခါဆဲး',
      Language.english: 'Next Month',
    },

    // Shan Calendar specific translations
    'Shan Era': {
      Language.english: 'Shan Era',
      Language.myanmar: 'ရှမ်းသက္ကရာဇ်',
      Language.zawgyi: 'ရွမ္းသကၠရာဇ္',
      Language.mon: 'သက္ကရာဇ်သေံ',
      Language.shan: 'သႅင်ၸဝ်ႈတႆး',
      Language.karen: 'သက္ကရာဇ်ၡၢၼ်း',
    },
    'Shan Calendar Year': {
      Language.english: 'Shan Calendar Year',
      Language.myanmar: 'ရှမ်းပြက္ခဒိန်နှစ်',
      Language.zawgyi: 'ရွမ္းျပကၡဒိန္ႏွစ္',
      Language.mon: 'သၞာံပြက္ခဒိန်သေံ',
      Language.shan: 'ပီလိၵ်ႈတိၼ်တႆး',
      Language.karen: 'နံၣ်ဒိနံၣ်ၡၢၼ်း',
    },
    'Shan New Year': {
      Language.english: 'Shan New Year',
      Language.myanmar: 'ရှမ်းနှစ်သစ်ကူး',
      Language.zawgyi: 'ရွမ္းႏွစ္သစ္ကူး',
      Language.mon: 'တ္ၚဲသၞာံတၟိသေံ',
      Language.shan: 'ပွႆးပီမႂ်ႇတႆး',
      Language.karen: 'မုၢ်နံၤထီၣ်သီၡၢၼ်း',
    },

    // AI Prompt Generation
    'Generate AI Prompt': {
      Language.english: 'Generate AI Prompt',
      Language.myanmar: 'AI ဟောစာတမ်း တောင်းဆိုချက် ထုတ်ယူရန်',
      Language.zawgyi: 'AI ေဟာစာတမ္း ေတာင္းဆိုခ်က္ ထုတ္ယူရန္',
      Language.mon: 'ပ္တိတ် ပရောမ် AI',
      Language.shan: 'ထုတ်ယူ ပုၼ်ႈ AI',
      Language.karen: 'ထုတ်ယူ AI',
    },
    'Fortune Telling': {
      Language.english: 'Fortune Telling',
      Language.myanmar: 'ဗေဒင်ဟောစာတမ်း',
      Language.zawgyi: 'ေဗဒင္ေဟာစာတမ္း',
      Language.mon: 'ပရေင်ဟောဗေဒင်',
      Language.shan: 'ၵၢၼ်ႁေႃၸႃႇတၢမ်း',
      Language.karen: 'ဗေဒင်ဟောစာတမ်း',
    },
    'Divination': {
      Language.english: 'Divination',
      Language.myanmar: 'နိမိတ်ဖတ်စာ',
      Language.zawgyi: 'နိမိတ္ဖတ္စာ',
      Language.mon: 'ပရေင်နိမိတ်',
      Language.shan: 'ၵၢၼ်ႁေႃလၢတ်ႈ',
      Language.karen: 'နိမိတ်ဖတ်စာ',
    },
    'Horoscope': {
      Language.english: 'Horoscope',
      Language.myanmar: 'ဟောစာတမ်း',
      Language.zawgyi: 'ေဟာစာတမ္း',
      Language.mon: 'ဟောစာတမ်း',
      Language.shan: 'ႁေႃၸႃႇတၢမ်း',
      Language.karen: 'ဟောစာတမ်း',
    },
    'Copy Prompt': {
      Language.english: 'Copy Prompt',
      Language.myanmar: 'တောင်းဆိုချက်ကို ကူးယူပါ',
      Language.zawgyi: 'ေတာင္းဆိုခ်က္ကို ကူးယူပါ',
      Language.mon: 'ကူးယူ ပရောမ်',
      Language.shan: 'ၵူတ်ႇဢဝ်',
      Language.karen: 'ကူးယူ',
    },
    'Prompt Copied': {
      Language.english: 'Prompt Copied to Clipboard',
      Language.myanmar: 'တောင်းဆိုချက်ကို Clipboard ထဲသို့ ကူးယူပြီးပါပြီ',
      Language.zawgyi: 'ေတာင္းဆိုခ်က္ကို Clipboard ထဲသို့ ကူးယူၿပီးပါၿပီ',
      Language.mon: 'ကူးယူတုဲယျ',
      Language.shan: 'ၵူတ်ႇဢဝ်ယဝ်ႉယဝ်ႉ',
      Language.karen: 'ကူးယူပြီးပြီ',
    },
    'prompt_intro': {
      Language.english:
          'Please provide a detailed horoscope reading based on the following Myanmar astrological details:',
      Language.myanmar:
          'အောက်ပါ မြန်မာ့နက္ခတ်ဗေဒ အချက်အလက်များအပေါ် အခြေခံ၍ အသေးစိတ် ဟောစာတမ်း ထုတ်ပေးပါရန် -',
      Language.zawgyi:
          'ေအာက္ပါ ျမန္မာ့နကၡတ္ေဗဒ အခ်က္အလကလမ္းမ်ားအေပၚ အေျခခံ၍ အေသးစိတ္ ေဟာစာတမ္း ထုတ္ေပးပါရန္ -',
      Language.mon:
          'သြဝ်ပလံင်ကဵု ဟောစာတမ်း အသေးစိတ် မဒုင်သဇိုင်ကဵု တင်ဂၞင် နက္ခတ္တဗေဒ ဗၟာ အတိုင်ဗွဲသၟဝ်ဝွံညိ -',
      Language.shan:
          'လူဝ်ႇႁၢင်ႈႁဵတ်းပၼ် ႁေႃၸႃႇတၢမ်း ဢၼ်ဢိင်ၼိူဝ် ၶေႃႈမုၼ်း ၼၵ်ႈၶတ်ႈ လႄႈ လၢဝ်မိူင်းမၢၼ်ႈ ပႃႈတႂ်ႈၼႆႉ -',
      Language.karen:
          'ဝံသးစဲးထီၣ် မြန်မာ့နက္ခတ်ဗေဒ အချက်အလက်တဖၣ်အဖီခိအခြေခံဒီး အသေးစိတ် ဟောစာတမ်း ထုတ်ပေးပါရန် -',
    },
    'prompt_analysis_req': {
      Language.english:
          'Please analyze these details based on traditional Myanmar astrology and provide insights into personality, career, and health for the near future.',
      Language.myanmar:
          'ဤအချက်အလက်များကို ရိုးရာမြန်မာ့နက္ခတ်ဗေဒအတိုင်း ခွဲခြမ်းစိတ်ဖြာပြီး ပင်ကိုယ်စရိုက်၊ အသက်မွေးဝမ်းကျောင်းနှင့် မကြာမီကာလအတွင်း ကျန်းမာရေးဆိုင်ရာများကို အသေးစိတ် ဟောကြားပေးပါ။',
      Language.zawgyi:
          'ဤအခ်က္အလက္မ်ားကို ႐ိုးရာျမန္မာ့နကၡတ္ေဗဒအတိုင္း ခြဲျခမ္းစိတ္ျဖာၿပီး ပင္ကိုယ္စ႐ိုက္၊ အသက္ေမြးဝမ္းေက်ာင္းႏွင့္ မၾကာမီကာလအတြင္း က်န္မာေရးဆိုင္ရာမ်ားကို အေသးစိတ္ ေဟာၾကားေပးပါ။',
      Language.mon:
          'သြဝ်စၟဳစၟတ် တင်ဂၞင်တအ်ဝွံ အတိုင်နက္ခတ္တဗေဒ ဗၟာတြေံ ကေုာံ ပလံင်ကဵု တင်ဂၞင် စပ်ကဵု စိုတ်ဓါတ်၊ ကမၠောန် ကေုာံ ပရေင်ထတ်ယုက် သွက်အခိင်ဂတဝွံညိ။',
      Language.shan:
          'လူဝ်ႇတူၺ်း ၶေႃႈမုၼ်းၸိူဝ်းၼႆႉ ၸွမ်းၼင်ႇ ၼၵ်ႈၶတ်ႈ မိူင်းမၢၼ်ႈ တႄႇငဝ်ႈ လႄႈ တွပ်ႇပၼ် တၢင်းဝူၼ်ႉ လွင်ႈၵူၼ်း၊ ၵၢၼ်ငၢၼ်း လႄႈ လွင်ႈယူႇလီ ပုၼ်ႈတႃႇ မိူဝ်းၼႃႈ။',
      Language.karen:
          'ဝံသးစဲးထီၣ် အချက်အလက်တဖၣ်အံၤ ရိုးရာမြန်မာ့နက္ခတ်ဗေဒအတိုငျး ခွဲခြမ်းစိတ်ဖြာပြီး ပင်ကိုယ်စရိုက်၊ အသက်မွေးဝေးကျောင်းနှင့် မကြာမီကာလအတွင်း ကျန်းမာရေးဆိုင်ရာများကို အသေးစိတ် ဟောကြားပေးပါ။',
    },
    'prompt_fortune_telling_intro': {
      Language.english:
          'Please provide a professional fortune-telling reading based on these Burmese astrological details:',
      Language.myanmar:
          'အောက်ပါ မြန်မာ့နက္ခတ်ဗေဒ အချက်အလက်များအပေါ် အခြေခံ၍ ကျွမ်းကျင်သော ဗေဒင်ဟောစာတမ်း တစ်စောင် ထုတ်ပေးပါရန် -',
      Language.zawgyi:
          'ေအာက္ပါ ျမန္မာ့နကၡတ္ေဗဒ အခ်က္အလက္မ်ားအေပၚ အေျခခံ၍ ကြၽမ္းက်င္ေသာ ေဗဒင္ေဟာစာတမ္း တစ္ေစာင္ ထုတ္ေပးပါရန္ -',
      Language.mon:
          'သြဝ်ပလံင်ကဵု ပရေင်ဟောဗေဒင် မၞုံကဵုဍာ်ဒေတာဗွ် မဒုင်သဇိုင်ကဵု တင်ဂၞင် နက္ခတ္တဗေဒ ဗၟာတအ်ဝွံညိ -',
      Language.shan:
          'လူဝ်ႇႁၢင်ႈႁဵတ်းပၼ် ၵၢၼ်ႁေႃၸႃႇတၢမ်း ဢၼ်မီးၸၼ်ႉ ဢိင်ၼိူဝ် ၶေႃႈမုၼ်း ၼၵ်ႈၶတ်ႈ မိူင်းမၢၼ်ႈ -',
      Language.karen:
          'ဝံသးစဲးထီၣ် မြန်မာ့နက္ခတ်ဗေဒ အချက်အလက်တဖၣ်အဖီခိအခြေခံဒီး ကျွမ်းကျင်သော ဗေဒင်ဟောစာတမ်း တစ်စောင် ထုတ်ပေးပါရန် -',
    },
    'prompt_fortune_telling_req': {
      Language.english:
          'Focus on predicting future trends in wealth, relationships, and success. Provide specific guidance and remedies if applicable according to Burmese tradition.',
      Language.myanmar:
          'စည်းစိမ်ဥစ္စာ၊ အိမ်ထောင်ရေးနှင့် အောင်မြင်မှုဆိုင်ရာ အနာဂတ်အလားအလာများကို အလေးပေး ဟောကြားပေးပါ။ မြန်မာ့ရိုးရာဗေဒင်ပညာအရ လိုအပ်ပါက ယတြာနှင့် အကြံပြုချက်များကိုပါ ထည့်သွင်းပေးပါ။',
      Language.zawgyi:
          'စည္းစိမ္ဥစၥာ၊ အိမ္ေထာင္ေရးႏွင့္ ေေဏာင္ျမင္မႈဆိုင္ရာ အနာဂတ္အလားအလာမ်ားကို အေလးေပး ေဟာၾကားေပးပါ။ ျမန္မာ့႐ိုးရာေဗဒင္ပညာအရ လိုအပ္ပါက ယၾတြာႏွင့္ အႀကံျပဳခ်က္မ်ားကိုပါ ထည့္သြင္းေပးပါ။',
      Language.mon:
          'သြဝ်အာရုံစွံ ပ္ဍဲပရေင်ဟောအတိုင် ဒြပ်ရတ်၊ ပရေင်ဆက်ဆောံ ကေုာံ ပရေင်အောင်ဇၞး သွက်အခိင်ဂတဝွံညိ။ သြဝ်ကဵု ကဏ္ဍလမ်းညွှန် ကေုาံ ယတြာ အတိုင်ရိုးရာဗၟာ လိုအပ်မ္ဂး ထပ်ဗပေင်ကဵုညိ။',
      Language.shan:
          'လူဝ်ႇတွပ်ႇပၼ် တၢင်းဝူၼ်ႉ မိူဝ်းၼႃႈ လွင်ႈၶူဝ်းၶွင်၊ တၢင်းႁၵ်ႉ လႄႈ တၢင်းဢောင်ႇမၼိူဝ်။ လူဝ်ႇပၼ် တၢင်းႁူႉ လႄႈ ယတြႃႇ ၸွမ်းၼင်ႇ ထုင်းမိူင်းမၢၼ်ႈ သင်ဝႃႈလူဝ်ႇ။',
      Language.karen:
          'ဝံသးစဲးထီၣ် စည်းစိမ်ဥစ္စာ၊ အိမ်ထောင်ရေးနှင့် အောင်မြင်မှုဆိုင်ရာ အနာဂတ်အလားအလာများကို အလေးပေး ဟောကြားပေးပါ။ မြန်မာ့ရိုးရာဗေဒင်ပညာအရ လိုအပ်ပါက ယတြာနှင့် အကြံပြုချက်များကိုပါ ထည့်သွင်းပေးပါ။',
    },
    'prompt_divination_intro': {
      Language.english:
          'Use these astrological indicators for a divination session to provide spiritual guidance:',
      Language.myanmar:
          'ဤနက္ခတ်ဗေဒ အညွှန်းကိန်းများကို အသုံးပြု၍ ဘာသာရေးနှင့် စိတ်ပိုင်းဆိုင်ရာ လမ်းညွှန်မှုပေးနိုင်သော နိမိတ်ဖတ်စာ ထုတ်ပေးပါရန် -',
      Language.zawgyi:
          'ဤနကၡတ္ေဗဒ အၫႊန္းကိန္းမ်ားကို အသုံးျပဳ၍ ဘာသာေရးႏွင့္ စိတ္ပိုင္းဆိုင္ရာ လမ္းၫႊန္မႈေပးႏိုင္ေသာ နိမိတ္ဖတ္စာ ထုတ္ေပးပါရန္ -',
      Language.mon:
          'သြဝ်အသုံးပြု တင်ဂၞင်နက္ခတ္တဗေဒတအ်ဝွံ သွက်ဂွံဟောနိမိတ် မၞုံကဵုပရေင်လမ်းညွှန် ဝိညာဉ် -',
      Language.shan:
          'လူဝ်ႇၸႂ်ႉ ၶေႃႈမုၼ်းလႅင်ႊလၢဝ် ၸိူဝ်းၼႆႉ တႃႇၵၢၼ်ႁေႃလၢတ်ႈ လွင်ႈပၢႆးၸႂ် -',
      Language.karen:
          'သူအင်ကနျား မြန်မာ့နက္ခတ်ဗေဒ အချက်အလက်တဖၣ်အံၤဒီး ဘာသာရေးနှင့် စိတ်ပိုင်းဆိုင်ရာ လမ်းညွှန်မှုပေးနိုင်သော နိမိတ်ဖတ်စာ ထုတ်ပေးပါရန် -',
    },
    'prompt_divination_req': {
      Language.english:
          'Provide a deep, intuitive reading focused on the spiritual path, inner growth, and overcoming obstacles.',
      Language.myanmar:
          'စိတ်ပိုင်းဆိုင်ရာ ရင့်ကျက်မှု၊ ဝိညာဉ်ရေးရာ ဖွံ့ဖြိုးမှုနှင့် အခက်အခဲများကို ကျော်လွှားနိုင်မည့် နက်နဲသော နိမိတ်ဖတ်ကြားချက်များကို ဖော်ပြပေးပါ။',
      Language.zawgyi:
          'စိတ္ပိုင္းဆိုင္ရာ ရင့္က်က္မႈ၊ ဝိညာဥ္ေရးရာ ဖြံႚၿဖိဳးမႈႏွင့္ အခက္အေနမ်ားကို ေက်ာ္လႊားႏိုင္မည့္ နက္နဲေသာ နိမိတ္ဖတ္ၾကားခ်က္မ်ားကို ေဖာ္ျပေပးပါ။',
      Language.mon:
          'သြဝ်ပလံင်ကဵု ပရေင်ဟောနိမိတ် နက္နဲ၊ မၞုံကဵုပရေင်အာရုံစွံ ပ္ဍဲဂၠံင်တရဴဝိညာဉ်၊ ပရေင်ဇၞော်မော ပ္ဍဲစိုတ် ကေုာံ ပရေင်ကျော်လွှား အခက်အခုဲဂမၠိုင်။',
      Language.shan:
          'လူဝ်ႇတွပ်ႇပၼ် ၵၢၼ်ႁေႃလၢတ်ႈ ဢၼ်လိုၵ်ႉလၢမ်ႇ ဢိင်ၼိူဝ် သဵၼ်ႈတၢင်းပၢႆးၸႂ်၊ တၢင်းယႂ်ႇမၢၵ်ႈ ပၢႆးၼႂ်း လႄႈ ၵၢၼ်ပူၼ်ႉလွတ်ႈ တၢင်းယၢပ်ႇၽိုတ်ႇ။',
      Language.karen:
          'ဝံသးစဲးထီၣ် စိတ်ပိုင်းဆိုင်ရာ ရင့်ကျက်မှု၊ ဝိညာဉ်ရေးရာ ဖွံ့ဖြိုးမှုနှင့် အခက်အခဲများကို ကျော်လွှားနိုင်မည့် နက်နဲသော နိမိတ်ဖတ်ကြားချက်များကို ဖော်ပြပေးပါ။',
    },
  };
}
