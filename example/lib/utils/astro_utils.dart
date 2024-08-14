import 'package:flutter_mmcalendar/flutter_mmcalendar.dart';

class AstroUtils {
  static Astro getAstro(DateTime date) {
    final mmCalendar = MmCalendar(
      config: MmCalendarConfig.myanmarLanguage(),
    );
    final myanmarDate = mmCalendar.fromDateTime(date);
    return myanmarDate.astro;
  }

  static String getAstroInfo(DateTime date) {
    final astro = getAstro(date);

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
}
