import 'package:flutter_mmcalendar/flutter_mmcalendar.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('MyanmarCalendarClient', () {
    late MyanmarCalendarClient service;

    setUp(() {
      service = MyanmarCalendarClient();
    });

    test('calculates holidays correctly', () {
      // Independence Day. Since myanmar_calendar_dart 3, 1 January is a
      // public holiday only from 2018 to 2021, as in the reference.
      final myanmarDate = MyanmarCalendar.fromWestern(2024, 1, 4);
      final holidayInfo = service.getHolidayInfo(myanmarDate.myanmarDate);
      expect(holidayInfo.has(HolidayId.independenceDay), isTrue);
    });

    test('validates Myanmar dates correctly', () {
      expect(service.validateMyanmar(1387, 9, 22).isValid, isTrue);
      expect(service.validateMyanmar(1385, 15, 1).isValid, isFalse);
      expect(service.validateMyanmar(1385, 1, 32).isValid, isFalse);
    });
  });
}
