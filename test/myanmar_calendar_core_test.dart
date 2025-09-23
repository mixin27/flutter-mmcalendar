import 'package:flutter_mmcalendar/flutter_mmcalendar.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Myanmar Calendar Core Tests', () {
    test('today returns correct Myanmar date', () {
      final today = MyanmarCalendar.today();
      expect(today, isNotNull);
      expect(today.myanmarYear, isPositive);
      expect(today.myanmarMonth, inInclusiveRange(1, 12));
      expect(today.myanmarDay, inInclusiveRange(1, 31));
    });

    test('converts Western to Myanmar date correctly', () {
      final myanmarDate = MyanmarCalendar.fromWestern(2025, 9, 22);
      expect(myanmarDate.myanmarYear, 1387);
      expect(myanmarDate.myanmarMonth, 7);
      expect(myanmarDate.myanmarDay, 1);
    });
  });
}
