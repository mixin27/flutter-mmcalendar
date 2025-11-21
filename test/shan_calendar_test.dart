import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_mmcalendar/flutter_mmcalendar.dart';

void main() {
  group('Shan Calendar Tests', () {
    test('Shan year calculation from Myanmar year', () {
      // Test case from reviewer: Myanmar 1387 = Shan 2120
      expect(MyanmarCalendar.getShanYear(1387), 2120);

      // Additional test cases
      expect(MyanmarCalendar.getShanYear(1386), 2119);
      expect(MyanmarCalendar.getShanYear(1388), 2121);
      expect(MyanmarCalendar.getShanYear(1000), 1733);
    });

    test('Myanmar year calculation from Shan year', () {
      expect(MyanmarCalendar.getMyanmarYearFromShan(2120), 1387);
      expect(MyanmarCalendar.getShanYear(1386), 2119);
      expect(MyanmarCalendar.getMyanmarYearFromShan(1733), 1000);
    });

    test('Shan date creation and formatting', () {
      final date = MyanmarCalendar.fromMyanmar(1387, 10, 15);

      expect(date.shanYear, 2120);
      expect(date.shanDate.year, 2120);
      expect(date.shanDate.myanmarYear, 1387);

      final formatted = date.formatShan();
      expect(formatted, contains('2120'));
    });

    test('Complete date formatting with Shan', () {
      final date = MyanmarCalendar.fromMyanmar(1387, 10, 1);

      final complete = date.formatCompleteWithShan(
        language: Language.shan,
        includeShan: true,
      );

      expect(complete, contains('2120'));
      expect(complete, contains('1387'));
    });

    test('Shan date verification', () {
      expect(MyanmarCalendar.verifyShanYear(1387, 2120), true);
      expect(MyanmarCalendar.verifyShanYear(1387, 2119), false);
    });

    test('Today in Shan calendar', () {
      final shanToday = MyanmarCalendar.todayInShan();
      final myanmarToday = MyanmarCalendar.today().myanmarYear;

      expect(shanToday.year, myanmarToday + 733);
    });
  });
}
