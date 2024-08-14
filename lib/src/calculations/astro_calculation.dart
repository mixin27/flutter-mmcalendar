import '../language/language.dart';
import '../models/models.dart';

/// Calculation Algorithms for Myanmar Astro
class AstroCalculation {
  /// Get [Astro]
  ///
  /// <a href=
  /// "http://cool-emerald.blogspot.sg/2013/12/myanmar-astrological-calendar-days.html">
  /// More details</a>
  static Astro getAstro({
    required int mmonth,
    required int monthLength,
    required int monthDay,
    required int weekDay,
    required int myear,
    LanguageCatalog? languageCatalog,
  }) {
    double d, m1, wd1, wd2;
    int sabbath, sabbatheve, yatyaza, pyathada, thamanyo, amyeittasote;
    int warameittugyi, warameittunge, yatpote, thamaphyu, nagapor, yatyotema;
    int mahayatkyan, shanyat, nagahle, mahabote, nakhat;
    List<int> wda = List<int>.empty();
    List<int> sya = List<int>.empty();

    if (mmonth <= 0) {
      mmonth = 4; // first waso is considered waso
    }

    d = monthDay -
        15 * (monthDay / 16.0).floorToDouble(); // waxing or waning day [0-15]
    sabbath = 0;

    if ((monthDay == 8) ||
        (monthDay == 15) ||
        (monthDay == 23) ||
        (monthDay == monthLength)) {
      sabbath = 1;
    }

    sabbatheve = 0;

    if ((monthDay == 7) ||
        (monthDay == 14) ||
        (monthDay == 22) ||
        (monthDay == (monthLength - 1))) {
      sabbatheve = 1;
    }

    yatyaza = 0;
    m1 = mmonth % 4;
    wd1 = (m1 / 2.0).floorToDouble() + 4;
    wd2 = ((1 - (m1 / 2.0).floor()) + m1 % 2) * (1 + 2 * (m1 % 2));

    //if ((wd == wd1) || (wd == wd2))
    if (((weekDay - wd1).abs() < 0.0000001) ||
        ((weekDay - wd2).abs() < 0.0000001)) {
      yatyaza = 1;
    }

    pyathada = 0;
    wda = [1, 3, 3, 0, 2, 1, 2];

    if (m1 == wda[weekDay]) {
      pyathada = 1;
    }

    if ((m1 == 0) && (weekDay == 4)) {
      pyathada = 2; // afternoon pyathada
    }

    thamanyo = 0;
    m1 = mmonth - 1 - (mmonth / 9.0).floorToDouble();
    wd1 = (m1 * 2 - (m1 / 8.0).floor()) % 7;

    wd2 = (weekDay + 7 - wd1) % 7;

    if (wd2 <= 1) {
      thamanyo = 1;
    }

    amyeittasote = 0;
    wda = [5, 8, 3, 7, 2, 4, 1];

    if (d.toInt() == wda[weekDay]) {
      amyeittasote = 1;
    }

    warameittugyi = 0;
    wda = [7, 1, 4, 8, 9, 6, 3];

    if (d == wda[weekDay]) {
      warameittugyi = 1;
    }

    warameittunge = 0;
    double wn = (weekDay + 6) % 7;

    if ((12 - d) == wn) {
      warameittunge = 1;
    }

    yatpote = 0;
    wda = [8, 1, 4, 6, 9, 8, 7];

    if (d == wda[weekDay]) {
      yatpote = 1;
    }

    thamaphyu = 0;
    wda = [1, 2, 6, 6, 5, 6, 7];

    if (d == wda[weekDay]) {
      thamaphyu = 1;
    }

    wda = [0, 1, 0, 0, 0, 3, 3];

    if (d == wda[weekDay]) {
      thamaphyu = 1;
    }

    if ((d == 4) && (weekDay == 5)) {
      thamaphyu = 1;
    }

    nagapor = 0;
    wda = [26, 21, 2, 10, 18, 2, 21];

    if (monthDay == wda[weekDay]) {
      nagapor = 1;
    }

    wda = [17, 19, 1, 0, 9, 0, 0];

    if (monthDay == wda[weekDay]) {
      nagapor = 1;
    }

    if (((monthDay == 2) && (weekDay == 1)) ||
        (((monthDay == 12) || (monthDay == 4) || (monthDay == 18)) &&
            (weekDay == 2))) {
      nagapor = 1;
    }

    yatyotema = 0;

    // m1 = (mm % 2) ? mm : ((mm + 9) % 12);

    m1 = (mmonth % 2 > 0) ? mmonth.toDouble() : ((mmonth + 9) % 12);
    m1 = (m1 + 4) % 12 + 1;

    if (d == m1) {
      yatyotema = 1;
    }

    mahayatkyan = 0;
    m1 = (((mmonth % 12) / 2.0).floorToDouble() + 4) % 6 + 1;

    if (d == m1) {
      mahayatkyan = 1;
    }

    shanyat = 0;
    sya = [8, 8, 2, 2, 9, 3, 3, 5, 1, 4, 7, 4];

    if (d == sya[mmonth - 1]) {
      shanyat = 1;
    }

    nagahle = ((mmonth % 12) / 3.0).floor();
    mahabote = (myear - weekDay) % 7;
    nakhat = myear % 3;

    Astro astro = Astro(
      sabbath: sabbath,
      sabbatheve: sabbatheve,
      yatyaza: yatyaza,
      pyathada: pyathada,
      thamanyo: thamanyo,
      amyeittasote: amyeittasote,
      warameittugyi: warameittugyi,
      warameittunge: warameittunge,
      yatpote: yatpote,
      thamaphyu: thamaphyu,
      nagapor: nagapor,
      yatyotema: yatyotema,
      mahayatkyan: mahayatkyan,
      shanyat: shanyat,
      // 0=west, 1=north, 2=east, 3=south
      nagahle: nagahle,
      // 0=Binga, 1=Atun, 2=Yaza, 3=Adipati, 4=Marana, 5=Thike, 6=Puti
      mahabote: mahabote,
      nakhat: nakhat,
      yearName: myear % 12,
      languageCatalog: languageCatalog,
    );

    return astro;
  }
}
