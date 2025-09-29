import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_mmcalendar/flutter_mmcalendar.dart';

import 'package:example/pages/home_page.dart';

void main() {
  // Configure Myanmar Calendar on app startup
  MyanmarCalendar.configure(
    language: Language.english,
    timezoneOffset: 6.5, // Myanmar Standard Time
    sasanaYearType: 0,
  );

  final service = MyanmarCalendarService(
    config: CalendarConfig(defaultLanguage: Language.myanmar.name),
  );
  final dateTime = MyanmarCalendar.fromWestern(2026, 8, 13);
  final result = service.formatMyanmarDate(
    dateTime.myanmarDate,
    pattern: '&y &M',
    language: Language.myanmar,
  );
  log("Result -> $result");

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
