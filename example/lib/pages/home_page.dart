import 'package:example/pages/astro_info_page.dart';
import 'package:example/pages/holidays_page.dart';
import 'package:example/pages/moon_phase_page.dart';
import 'package:example/pages/thingyan_holidays_page.dart';
import 'package:example/widgets/calendar_language_switch_tile.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Flutter MM Calendar')),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: ListView(
          children: [
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
                  MaterialPageRoute(builder: (context) => const HolidaysPage()),
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
                    builder: (context) => const MoonPhasePage(),
                  ),
                );
              },
              child: const Text('Moon Phase'),
            ),
            const SizedBox(height: 20),
            const CalendarLanguageListTile(),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
