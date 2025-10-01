// ignore_for_file: avoid_redundant_argument_values

import 'package:flutter_mmcalendar/src/core/calendar_config.dart';
import 'package:flutter_mmcalendar/src/core/myanmar_date_time.dart';
import 'package:flutter_mmcalendar/src/services/date_converter.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Conversion parity and stability', () {
    test('Western <-> JDN round-trip at noon (date-only)', () {
      final converter = DateConverter(const CalendarConfig());

      final samples = <List<int>>[
        [1752, 9, 14], // Gregorian start (British)
        [1886, 11, 30], // Historical
        [1948, 1, 4], // Independence Day
        [2018, 1, 1], // New Year guard
        [2024, 3, 31], // Easter 2024
      ];

      for (final s in samples) {
        final y = s[0], m = s[1], d = s[2];
        final jdn = converter.westernToJulian(y, m, d, 12, 0, 0);
        final back = converter.julianToWestern(jdn);
        expect([back.year, back.month, back.day], [y, m, d], reason: 'Date mismatch for $y-$m-$d');
        expect([back.hour, back.minute], [12, 0], reason: 'Noon-based time expected for $y-$m-$d');
      }
    });

    test('Myanmar <-> JDN round-trip at noon (JDN parity)', () {
      final converter = DateConverter(const CalendarConfig());

      final samples = <List<int>>[
        [1386, 8, 25], // National Day example (Tazaungmon 25 -> waning 10)
        [1385, 4, 15],
        [1380, 1, 8],
      ];

      for (final s in samples) {
        final my = s[0], mm = s[1], md = s[2];
        final jdn = converter.myanmarToJulian(my, mm, md, 12, 0, 0);
        final back = converter.julianToMyanmar(jdn);
        // Accept equivalent representations across year-boundary months (e.g., Late Tagu/Tagu)
        final jdnBack = converter.myanmarToJulian(back.year, back.month, back.day, 12, 0, 0);
        expect((jdnBack - jdn).abs() < 0.5, isTrue,
            reason: 'JDN round-trip mismatch for $my/$mm/$md -> ${back.year}/${back.month}/${back.day}');
      }
    });

    test('Myanmar date stability across intraday times', () {
      final cfg = CalendarConfig();
      final converter = DateConverter(cfg);

      final western = [2024, 3, 31]; // Easter 2024 Sunday
      final jdnMorning = converter.westernToJulian(western[0], western[1], western[2], 0, 0, 0);
      final jdnNight = converter.westernToJulian(western[0], western[1], western[2], 23, 59, 59);

      final mmMorning = converter.julianToMyanmar(jdnMorning);
      final mmNight = converter.julianToMyanmar(jdnNight);

      expect([mmMorning.year, mmMorning.month, mmMorning.day],
          [mmNight.year, mmNight.month, mmNight.day],
          reason: 'Myanmar date should remain the same within the same civil day');
    });
  });

  group('Easter and Good Friday detection', () {
    test('Easter 2024 and Good Friday 2024 are detected', () {
      // Easter Sunday 2024-03-31, Good Friday 2024-03-29
      final easter = MyanmarDateTime.fromWestern(2024, 3, 31);
      final gf = MyanmarDateTime.fromWestern(2024, 3, 29);

      expect(easter.holidayInfo.religiousHolidays.contains('Easter'), isTrue);
      expect(gf.holidayInfo.religiousHolidays.contains('Good Friday'), isTrue);
    });
  });
}


