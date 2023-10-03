import 'package:example/pages/holidays_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mmcalendar/flutter_mmcalendar.dart';

class HomePage extends StatelessWidget {
  const HomePage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
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
                'Thingyan',
                style: Theme.of(context).textTheme.headlineSmall,
              ),
              const SizedBox(height: 10),
              Text(
                getThingyan(),
              ),
              const SizedBox(height: 20),
              Text(
                'Default',
                style: Theme.of(context).textTheme.headlineSmall,
              ),
              const SizedBox(height: 10),
              Text(
                FlutterMmcalendar.getDateByLanguage(DateTime.now()),
              ),
              const SizedBox(height: 20),
              Text(
                'Myanmar',
                style: Theme.of(context).textTheme.headlineSmall,
              ),
              const SizedBox(height: 10),
              Text(
                FlutterMmcalendar.getDateByLanguage(
                  DateTime.now(),
                  language: Language.myanmar,
                ),
              ),
              const SizedBox(height: 20),
              Text(
                'English',
                style: Theme.of(context).textTheme.headlineSmall,
              ),
              const SizedBox(height: 10),
              Text(
                FlutterMmcalendar.getDateByLanguage(
                  DateTime.now(),
                  language: Language.english,
                ),
              ),
              const SizedBox(height: 20),
              Text(
                'Mon',
                style: Theme.of(context).textTheme.headlineSmall,
              ),
              const SizedBox(height: 10),
              Text(
                FlutterMmcalendar.getDateByLanguage(
                  DateTime.now(),
                  language: Language.mon,
                ),
              ),
              const SizedBox(height: 20),
              Text(
                'Zawgyi',
                style: Theme.of(context).textTheme.headlineSmall,
              ),
              const SizedBox(height: 10),
              Text(
                FlutterMmcalendar.getDateByLanguage(
                  DateTime.now(),
                  language: Language.zawgyi,
                ),
              ),
              const SizedBox(height: 20),
              Text(
                'Astro',
                style: Theme.of(context).textTheme.headlineSmall,
              ),
              const SizedBox(height: 10),
              Text(
                getAstroInfo(),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}

String getAstroInfo() {
  final myanmarDate = MyanmarDateConverter.fromDateTime(DateTime.now());
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
  String str = 'Akyo: ${akyoDay.format('f r En')}\n';

  final akyaDay = ThingyanCalculator.getAkyaDay(year);
  str += 'Akya: ${akyaDay.format('f r En')}\n';

  final akyatDays = ThingyanCalculator.getAkyatDays(year);
  for (var i = 0; i < akyatDays.length; i++) {
    str += 'Akyat(${i + 1}): ${akyatDays[i].format('f r En')}\n';
  }

  final atatDay = ThingyanCalculator.getAtatDay(year);
  str += 'Atat: ${atatDay.format('f r En')}\n';

  return str;
}
