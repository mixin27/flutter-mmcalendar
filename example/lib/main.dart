import 'package:flutter/material.dart';
import 'package:flutter_mmcalendar/flutter_mmcalendar.dart';

import 'package:example/pages/home_page.dart';

void main() {
  // Configure Myanmar Calendar on app startup
  // DateTime.now().timeZoneOffset.inHours.toDouble()
  MyanmarCalendar.configure(
    language: Language.english,
    // use 6.5 for Myanmar Standard Time
    timezoneOffset: DateTime.now().timeZoneOffset.inMinutes / 60,
    sasanaYearType: 0,
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

  final today = DateTime.now();
  final mToday = MyanmarCalendar.fromDateTime(today);
  final completeDateToday = mToday.completeDate;
  debugPrint('--- CUSTOM HOLIDAY VERIFICATION ---');
  debugPrint('Today (Jan 16, 2026):');
  debugPrint(
    '  Western: ${completeDateToday.western.year}-${completeDateToday.western.month}-${completeDateToday.western.day}',
  );
  debugPrint('  Holidays: ${completeDateToday.allHolidays}');

  final birthdayDate = DateTime(2026, 7, 27);
  final mBirthday = MyanmarCalendar.fromDateTime(birthdayDate);
  final completeDateBirthday = mBirthday.completeDate;
  debugPrint('Birthday (July 27, 2026):');
  debugPrint(
    '  Western: ${completeDateBirthday.western.year}-${completeDateBirthday.western.month}-${completeDateBirthday.western.day}',
  );
  debugPrint('  Holidays: ${completeDateBirthday.allHolidays}');
  debugPrint('-----------------------------------');

  // Initialize with default cache
  MyanmarCalendar.configureCache(const CacheConfig());

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Myanmar Calendar Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.indigo),
        fontFamily: 'Roboto',
      ),
      home: HomePage(),
    );
  }
}
