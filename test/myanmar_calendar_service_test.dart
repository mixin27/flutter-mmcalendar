import 'package:flutter_mmcalendar/flutter_mmcalendar.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('MyanmarCalendarService Tests', () {
    late MyanmarCalendarService service;

    setUp(() {
      service = MyanmarCalendarService();
    });

    test('calculates holidays correctly', () {
      final myanmarDate = MyanmarCalendar.fromWestern(2024, 1, 1);
      final holidayInfo = service.getHolidayInfo(myanmarDate.myanmarDate);
      expect(holidayInfo.allHolidays, isNotEmpty);
    });

    test('validates Myanmar dates correctly', () {
      expect(service.validateMyanmarDate(1387, 9, 22).isValid, isTrue);
      expect(service.validateMyanmarDate(1385, 15, 1).isValid, isFalse);
      expect(service.validateMyanmarDate(1385, 1, 32).isValid, isFalse);
    });
  });
}
