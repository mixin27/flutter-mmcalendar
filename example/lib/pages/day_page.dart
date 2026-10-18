import 'package:flutter/material.dart';
import 'package:flutter_mmcalendar/flutter_mmcalendar.dart';

/// Today: the card, the moon, holidays, astrology and every detail.
class DayPage extends StatelessWidget {
  const DayPage({super.key});

  @override
  Widget build(BuildContext context) {
    final wide = MediaQuery.sizeOf(context).width >= 900;
    final left = [
      const MyanmarTodayCard(),
      const SizedBox(height: 12),
      Row(
        children: [
          const MyanmarTodayCard.compact(),
          const SizedBox(width: 12),
          Expanded(
            child: MmSurface(
              padding: const EdgeInsets.all(14),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  MyanmarDateText.today(pattern: '&y &M &P &ff'),
                  SizedBox(height: 4),
                  MyanmarDateText.today(westernPattern: '%Www %d %MMM %yyyy'),
                ],
              ),
            ),
          ),
        ],
      ),
      const SizedBox(height: 12),
      const NextMoonCountdown(),
      const SizedBox(height: 12),
      const HolidayList.upcoming(),
    ];
    final right = [
      const AstrologyCard(),
      const SizedBox(height: 12),
      const Center(child: NagahleCompass(surface: true)),
      const SizedBox(height: 12),
      MyanmarDayDetails(
        sections: const [DaySection.dates, DaySection.moon],
        onCopied: (text) => ScaffoldMessenger.maybeOf(
          context,
        )?.showSnackBar(SnackBar(content: Text('Copied $text'))),
      ),
    ];
    if (wide) {
      return Padding(
        padding: const EdgeInsets.fromLTRB(16, 12, 16, 0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(child: ListView(children: left)),
            const SizedBox(width: 16),
            Expanded(child: ListView(children: right)),
          ],
        ),
      );
    }
    return ListView(
      padding: const EdgeInsets.fromLTRB(12, 12, 12, 110),
      children: [...left, const SizedBox(height: 12), ...right],
    );
  }
}
