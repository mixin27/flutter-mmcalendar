import 'package:flutter/material.dart';
import 'package:flutter_mmcalendar/flutter_mmcalendar.dart';

void main() {
  MmCalendarConfig.initDefault(
    const MmCalendarOptions(
      language: Language.myanmar,
    ),
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter MMCalendar',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Flutter MM Calendar'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(20),
          child: Center(
            child: ListView(
              children: [
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
