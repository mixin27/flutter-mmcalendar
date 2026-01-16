import 'package:flutter_mmcalendar/flutter_mmcalendar.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('Debug holiday calculation for July 27, 2026', () {
    MyanmarCalendar.configure(
      customHolidays: [
        CustomHoliday(
          id: 'holiday_today',
          name: "Today's Custom Holiday",
          type: HolidayType.other,
          predicate: (m, w) => w.month == 1 && w.day == 16,
        ),
        CustomHoliday(
          id: 'my_birthday',
          name: 'My Birthday',
          type: HolidayType.other,
          predicate: (m, w) => w.month == 7 && w.day == 27,
        ),
      ],
    );

    // Initialize with default cache as in main.dart
    MyanmarCalendar.configureCache(const CacheConfig());

    final today = DateTime(2026, 1, 16);
    final completeToday = MyanmarCalendar.fromDateTime(today).completeDate;
    print('DEBUG - Today (Jan 16): ${completeToday.allHolidays}');
    expect(completeToday.allHolidays, contains("Today's Custom Holiday"));

    final birthday = DateTime(2026, 7, 27);
    final completeBirthday = MyanmarCalendar.fromDateTime(
      birthday,
    ).completeDate;
    print('DEBUG - Birthday (July 27): ${completeBirthday.allHolidays}');
    print(
      'DEBUG - Birthday Myanmar Date: ${completeBirthday.myanmar.year}/${completeBirthday.myanmar.month}/${completeBirthday.myanmar.day}',
    );
    print(
      'DEBUG - Birthday Western Date: ${completeBirthday.western.year}-${completeBirthday.western.month}-${completeBirthday.western.day}',
    );

    expect(completeBirthday.allHolidays, contains("My Birthday"));
  });
}
