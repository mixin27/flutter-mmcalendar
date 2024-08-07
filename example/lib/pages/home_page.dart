import 'package:example/pages/astro_info_page.dart';
import 'package:example/pages/calendar_view_page.dart';
import 'package:example/pages/holidays_page.dart';
import 'package:example/pages/language_sample_page.dart';
import 'package:example/pages/thingyan_holidays_page.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Flutter MM Calendar'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: ListView(
          children: [
            FilledButton(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => const LanguageSamplePage(),
                  ),
                );
              },
              child: const Text('Language Sample'),
            ),
            FilledButton(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => const AstroInfoPage(),
                  ),
                );
              },
              child: const Text('Astrological Information'),
            ),
            FilledButton(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => const HolidaysPage(),
                  ),
                );
              },
              child: const Text('Holidays'),
            ),
            FilledButton(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => const ThingyanHolidaysPage(),
                  ),
                );
              },
              child: const Text('Thingyan Holidays'),
            ),
            FilledButton(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => const CalendarViewPage(),
                  ),
                );
              },
              child: const Text('Calendar Views'),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
