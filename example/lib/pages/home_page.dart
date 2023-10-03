import 'package:example/pages/holidays_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mmcalendar/flutter_mmcalendar.dart';

class HomePage extends StatelessWidget {
  const HomePage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final date = DateTime(1998, 7, 27);
    final dateStr = '${date.year}/${date.month}/${date.day}';

    return Scaffold(
      appBar: AppBar(
        title: const Text('Flutter MM Calendar'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => const HolidaysPage()),
              );
            },
            child: const Text('Holidays'),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Center(
          child: ListView(
            children: [
              Text(
                'Thingyan Holidays for 2023',
                style: Theme.of(context).textTheme.headlineSmall,
              ),
              const SizedBox(height: 10),
              Text(
                getThingyan(),
              ),
              Text(
                'Default - $dateStr',
                style: Theme.of(context).textTheme.headlineSmall,
              ),
              const SizedBox(height: 10),
              Text(
                FlutterMmcalendar.getDateByLanguage(date),
              ),
              const SizedBox(height: 20),
              Text(
                'Myanmar - $dateStr',
                style: Theme.of(context).textTheme.headlineSmall,
              ),
              const SizedBox(height: 10),
              Text(
                FlutterMmcalendar.getDateByLanguage(
                  date,
                  language: Language.myanmar,
                ),
              ),
              const SizedBox(height: 20),
              Text(
                'English - $dateStr',
                style: Theme.of(context).textTheme.headlineSmall,
              ),
              const SizedBox(height: 10),
              Text(
                FlutterMmcalendar.getDateByLanguage(
                  date,
                  language: Language.english,
                ),
              ),
              const SizedBox(height: 20),
              Text(
                'Mon - $dateStr',
                style: Theme.of(context).textTheme.headlineSmall,
              ),
              const SizedBox(height: 10),
              Text(
                FlutterMmcalendar.getDateByLanguage(
                  date,
                  language: Language.mon,
                ),
              ),
              const SizedBox(height: 20),
              Text(
                'Zawgyi - $dateStr',
                style: Theme.of(context).textTheme.headlineSmall,
              ),
              const SizedBox(height: 10),
              Text(
                FlutterMmcalendar.getDateByLanguage(
                  date,
                  language: Language.zawgyi,
                ),
              ),
              const SizedBox(height: 20),
              Text(
                'Tai - $dateStr',
                style: Theme.of(context).textTheme.headlineSmall,
              ),
              const SizedBox(height: 10),
              Text(
                FlutterMmcalendar.getDateByLanguage(
                  date,
                  language: Language.tai,
                ),
              ),
              const SizedBox(height: 20),
              Text(
                'Karen - $dateStr',
                style: Theme.of(context).textTheme.headlineSmall,
              ),
              const SizedBox(height: 10),
              Text(
                FlutterMmcalendar.getDateByLanguage(
                  date,
                  language: Language.karen,
                ),
              ),
              const SizedBox(height: 20),
              Text(
                'Astrological - 1998/07/27',
                style: Theme.of(context).textTheme.headlineSmall,
              ),
              const SizedBox(height: 10),
              Text(
                getAstroInfo(DateTime(1998, 7, 27)),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}

String getAstroInfo(DateTime date) {
  final myanmarDate = MyanmarDateConverter.fromDateTime(date);
  final astro = AstroConverter.convert(myanmarDate);

  var str = '';

  final amyeittasote = astro.getAmyeittasote();
  str += 'Amyeittasote: $amyeittasote\n';

  final astrologicalDay = astro.getAstrologicalDay();
  str += 'AstrologicalDay: $astrologicalDay\n';

  final mahabote = astro.getMahabote();
  str += 'Mahabote: $mahabote\n';

  final mahayatkyan = astro.getMahayatkyan();
  str += 'Mahayatkyan: $mahayatkyan\n';

  final nagahle = astro.getNagahle();
  str += 'Nagahle: $nagahle\n';

  final nagapor = astro.getNagapor();
  str += 'Nagapor: $nagapor\n';

  final nakhat = astro.getNakhat();
  str += 'Nakhat: $nakhat\n';

  final sabbath = astro.getSabbath();
  str += 'Sabbath: $sabbath\n';

  final shanyat = astro.getShanyat();
  str += 'Shanyat: $shanyat\n';

  final thamanyo = astro.getThamanyo();
  str += 'Thamanyo: $thamanyo\n';

  final thamaphyu = astro.getThamaphyu();
  str += 'Thamaphyu: $thamaphyu\n';

  final warameittugyi = astro.getWarameittugyi();
  str += 'Warameittugyi: $warameittugyi\n';

  final warameittunge = astro.getWarameittunge();
  str += 'Warameittunge: $warameittunge\n';

  final yatpote = astro.getYatpote();
  str += 'Yatpote: $yatpote\n';

  final yatyotema = astro.getYatyotema();
  str += 'Yatyotema: $yatyotema\n';

  final yearName = astro.getYearName();
  str += 'YearName: $yearName';

  return str;
}

String getThingyan() {
  int year = DateTime.now().year;
  final akyoDay = ThingyanCalculator.getAkyoDay(year);
  String str = 'Akyo: ${akyoDay.format(pattern: 'f r En')}\n';

  final akyaDay = ThingyanCalculator.getAkyaDay(year);
  str += 'Akya: ${akyaDay.format(pattern: 'f r En')}\n';

  final akyatDays = ThingyanCalculator.getAkyatDays(year);
  for (var i = 0; i < akyatDays.length; i++) {
    str += 'Akyat(${i + 1}): ${akyatDays[i].format(pattern: 'f r En')}\n';
  }

  final atatDay = ThingyanCalculator.getAtatDay(year);
  str += 'Atat: ${atatDay.format(pattern: 'f r En')}\n';

  return str;
}
