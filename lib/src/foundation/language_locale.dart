import 'dart:ui' show Locale;

import 'package:myanmar_calendar_dart/myanmar_calendar_dart.dart';

/// The calendar [Language] for an app [locale], or `null` when the calendar
/// has none for it.
///
/// Burmese (`my`) maps to Unicode Myanmar, or to Zawgyi when the locale's
/// script or variant says so (`my_Zawgyi`, `my-Qaag`). Shan is `shn`, Mon is
/// `mnw` and S'gaw Karen is `ksw` (or `kar`).
Language? languageForLocale(Locale locale) {
  final code = locale.languageCode.toLowerCase();
  final script = (locale.scriptCode ?? '').toLowerCase();
  final country = (locale.countryCode ?? '').toLowerCase();
  return switch (code) {
    'en' => Language.english,
    'my' when script == 'qaag' || country == 'zawgyi' => Language.zawgyi,
    'my' => Language.myanmar,
    'zawgyi' => Language.zawgyi,
    'shn' => Language.shan,
    'mnw' => Language.mon,
    'ksw' || 'kar' => Language.karen,
    _ => Language.tryFromCode(code),
  };
}

/// Number formatting in the calendar's languages.
extension MmLanguageDigits on Language {
  /// [number] in this language's digits, e.g. `18` as `၁၈` in Myanmar.
  String digits(int number) {
    final glyphs = TranslationService.digitsFor(this);
    final text = number.toString();
    if (glyphs == null) return text;
    final out = StringBuffer();
    for (final unit in text.codeUnits) {
      final digit = unit - 0x30;
      out.write(
        digit >= 0 && digit <= 9 ? glyphs[digit] : String.fromCharCode(unit),
      );
    }
    return out.toString();
  }
}
