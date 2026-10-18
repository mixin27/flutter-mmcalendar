import 'package:flutter/material.dart';
import 'package:flutter_mmcalendar/flutter_mmcalendar.dart';
import 'package:flutter_mmcalendar/src/foundation/apple_os_version_io.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('MmVisualStyle', () {
    test('automatic follows the platform and Apple OS version', () {
      MmVisualStyle r(TargetPlatform p, [int? v]) =>
          MmVisualStyle.automatic.resolve(platform: p, appleMajorVersion: v);
      expect(r(TargetPlatform.android), MmVisualStyle.material);
      expect(r(TargetPlatform.windows), MmVisualStyle.material);
      expect(r(TargetPlatform.iOS, 18), MmVisualStyle.cupertino);
      expect(r(TargetPlatform.iOS, 26), MmVisualStyle.glass);
      expect(r(TargetPlatform.macOS, 27), MmVisualStyle.glass);
    });

    test('an explicit style is kept on any platform', () {
      expect(
        MmVisualStyle.glass.resolve(platform: TargetPlatform.android),
        MmVisualStyle.glass,
      );
      expect(
        MmVisualStyle.material.resolve(
          platform: TargetPlatform.iOS,
          appleMajorVersion: 26,
        ),
        MmVisualStyle.material,
      );
    });

    test('reads the major version from the OS version string', () {
      expect(parseAppleMajorVersion('Version 26.0 (Build 23A341)'), 26);
      expect(parseAppleMajorVersion('Version 18.6.2 (Build 22G100)'), 18);
      expect(parseAppleMajorVersion('unknown'), isNull);
    });
  });

  group('MmCalendarThemeData', () {
    final light = MmCalendarThemeData.fromSeed(Colors.indigo);
    final dark = MmCalendarThemeData.fromSeed(
      Colors.indigo,
      brightness: Brightness.dark,
    );

    test('takes accent and text colours from the ColorScheme', () {
      final scheme = ColorScheme.fromSeed(seedColor: Colors.teal);
      final theme = MmCalendarThemeData.fromColorScheme(scheme);
      expect(theme.accent, scheme.primary);
      expect(theme.onAccent, scheme.onPrimary);
      expect(theme.ink, scheme.onSurface);
      expect(theme.brightness, Brightness.light);
    });

    test('has a colour per holiday type, different in dark mode', () {
      expect(light.holidayColor(HolidayType.public), light.publicHoliday);
      expect(
        light.holidayColor(HolidayType.otherAnniversary),
        light.anniversary,
      );
      expect(light.publicHoliday, isNot(dark.publicHoliday));
    });

    test('lerps, copies and compares by value', () {
      expect(light.lerp(dark, 0), light);
      expect(light.lerp(dark, 1), dark);
      expect(light.copyWith(), light);
      expect(light.copyWith().hashCode, light.hashCode);
      expect(light.copyWith(cellRadius: 4), isNot(light));
    });

    test('adds Myanmar fonts and a taller line for Myanmar script', () {
      const base = TextStyle(fontSize: 14, height: 1.2);
      expect(light.textStyle(base, Language.english).height, 1.2);
      final my = light.textStyle(base, Language.myanmar);
      expect(my.height, light.myanmarLineHeight);
      expect(my.fontFamilyFallback, contains('Noto Sans Myanmar'));
    });
  });

  group('languages', () {
    test('maps app locales to calendar languages', () {
      expect(languageForLocale(const Locale('my')), Language.myanmar);
      expect(
        languageForLocale(
          const Locale.fromSubtags(languageCode: 'my', scriptCode: 'Qaag'),
        ),
        Language.zawgyi,
      );
      expect(languageForLocale(const Locale('shn')), Language.shan);
      expect(languageForLocale(const Locale('mnw')), Language.mon);
      expect(languageForLocale(const Locale('ksw')), Language.karen);
      expect(languageForLocale(const Locale('en', 'GB')), Language.english);
      expect(languageForLocale(const Locale('fr')), isNull);
    });

    test('writes numbers in the language digits', () {
      expect(Language.myanmar.digits(2026), '၂၀၂၆');
      expect(Language.english.digits(2026), '2026');
      expect(Language.myanmar.digits(-5), '-၅');
    });
  });
}
