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
  final dateTime = DateTime.now();
  MyanmarDate myanmarDate = FlutterMmcalendar.getMyanmarDate(
    year: dateTime.year,
    month: dateTime.month,
    day: dateTime.day,
  );

  final astro = AstroConverter.convert(myanmarDate);

  return '''
isSabbath:            ${astro.isSabbath}
isThamanyo:           ${astro.isThamanyo}
isThamaphyu:         ${astro.isSabbath}
isAmyeittasote:      ${astro.isSabbath}
isWarameittugyi:     ${astro.isSabbath}
isWarameittunge:     ${astro.isSabbath}
isYatpote:           ${astro.isSabbath}
isNagapor:           ${astro.isSabbath}
isYatyotema:         ${astro.isSabbath}
isMahayatkyan:       ${astro.isSabbath}
isShanyat:           ${astro.isSabbath}
Nagahle:              ${astro.getNagahle()}
Mahabote:             ${astro.getMahabote()}
Nakhat:               ${astro.getNakhat()}
YearName:             ${astro.getYearName()}
AstroligicalDay:      ${astro.getAstrologicalDay()}
''';
}
