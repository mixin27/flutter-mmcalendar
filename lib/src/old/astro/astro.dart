import 'package:flutter_mmcalendar/flutter_mmcalendar.dart';

class Astro {
  const Astro({
    required this.sabbath,
    required this.sabbatheve,
    required this.yatyaza,
    required this.pyathada,
    required this.thamanyo,
    required this.amyeittasote,
    required this.warameittugyi,
    required this.warameittunge,
    required this.yatpote,
    required this.thamaphyu,
    required this.nagapor,
    required this.yatyotema,
    required this.mahayatkyan,
    required this.shanyat,
    required this.nagahle,
    required this.mahabote,
    required this.nakhat,
    required this.yearName,
  });

  final int sabbath;
  final int sabbatheve;
  final int yatyaza;
  final int pyathada;
  final int thamanyo;
  final int amyeittasote;
  final int warameittugyi;
  final int warameittunge;
  final int yatpote;
  final int thamaphyu;
  final int nagapor;
  final int yatyotema;
  final int mahayatkyan;
  final int shanyat;
  // 0 = west, 1 = north, 2 = east, 3 = south
  final int nagahle;
  // 0 = Binga, 1 = Atun, 2 = Yaza, 3 = Adipati, 4 = Marana, 5 = Thike, 6 = Puti
  final int mahabote;
  /* 0 = orc, 1 = elf, 2 = human */
  final int nakhat;
  // {"ပုဿနှစ်","မာခနှစ်","ဖ္လကိုန်သံဝစ္ဆိုဝ်ရနှစ်","စယ်နှစ်",
  // "ပိသျက်နှစ်","စိဿနှစ်","အာသတ်နှစ်","သရဝန်နှစ်",
  // "ဘဒ္ဒြသံဝစ္ဆုံရ်နှစ်","အာသိန်နှစ်","ကြတိုက်နှစ်","မြိက္ကသိုဝ်နှစ်"}
  final int yearName;

  String getAstrologicalDay() {
    return getAstrologicalDayByLanguage(LanguageCatalog.instance);
  }

  String getAstrologicalDayByLanguage(LanguageCatalog languageCatalog) {
    String str = "";
    if (yatyaza > 0) {
      str += languageCatalog.translate("Yatyaza");
    }
    if (pyathada == 1) {
      str += languageCatalog.translate("Pyathada");
    } else if (pyathada == 2) {
      str += languageCatalog.translate("Afternoon Pyathada");
    }
    return str;
  }

  bool get isSabbath => (sabbath > 0) || (sabbatheve > 0);

  String getSabbath() => getAstrologicalDayByLanguage(LanguageCatalog.instance);

  String getSabbathByLanguage(LanguageCatalog languageCatalog) {
    String str = '';
    if (sabbath > 0) {
      str += languageCatalog.translate("Sabbath");
    } else if (sabbatheve > 0) {
      str += languageCatalog.translate("Sabbath Eve");
    }
    return str;
  }

  bool get isThamanyo => thamanyo > 0;

  String getThamanyo() => getThamanyoByLanguage(LanguageCatalog.instance);

  String getThamanyoByLanguage(LanguageCatalog languageCatalog) {
    return isThamanyo ? languageCatalog.translate('Thamanyo') : '';
  }

  bool get isAmyeittasote => amyeittasote > 0;

  String getAmyeittasote() =>
      getAmyeittasoteByLanguage(LanguageCatalog.instance);

  String getAmyeittasoteByLanguage(LanguageCatalog languageCatalog) {
    return isAmyeittasote ? languageCatalog.translate('Amyeittasote') : '';
  }

  bool get isWarameittugyi => warameittugyi > 0;

  String getWarameittugyi() =>
      getWarameittugyiByLanguage(LanguageCatalog.instance);

  String getWarameittugyiByLanguage(LanguageCatalog languageCatalog) {
    return isWarameittugyi ? languageCatalog.translate("Warameittugyi") : "";
  }

  bool get isWarameittunge => warameittunge > 0;

  String getWarameittunge() {
    return getWarameittungeByLanguage(LanguageCatalog.instance);
  }

  String getWarameittungeByLanguage(LanguageCatalog languageCatalog) {
    return isWarameittunge ? languageCatalog.translate("Warameittunge") : "";
  }

  bool get isYatpote {
    return (yatpote > 0);
  }

  String getYatpote() {
    return getYatpoteByLanguage(LanguageCatalog.instance);
  }

  String getYatpoteByLanguage(LanguageCatalog languageCatalog) {
    return isYatpote ? languageCatalog.translate("Yatpote") : "";
  }

  bool get isThamaphyu {
    return (thamaphyu > 0);
  }

  String getThamaphyu() {
    return getThamaphyuByLanguage(LanguageCatalog.instance);
  }

  String getThamaphyuByLanguage(LanguageCatalog languageCatalog) {
    return isThamaphyu ? languageCatalog.translate("Thamaphyu") : "";
  }

  bool get isNagapor {
    return (nagapor > 0);
  }

  String getNagapor() {
    return getNagaporByLanguage(LanguageCatalog.instance);
  }

  String getNagaporByLanguage(LanguageCatalog languageCatalog) {
    return isNagapor ? languageCatalog.translate("Nagapor") : "";
  }

  bool get isYatyotema {
    return (yatyotema > 0);
  }

  String getYatyotema() {
    return getYatyotemaByLanguage(LanguageCatalog.instance);
  }

  String getYatyotemaByLanguage(LanguageCatalog languageCatalog) {
    return isYatyotema ? languageCatalog.translate("Yatyotema") : "";
  }

  bool get isMahayatkyan {
    return (mahayatkyan > 0);
  }

  String getMahayatkyan() {
    return getMahayatkyanByLanguage(LanguageCatalog.instance);
  }

  String getMahayatkyanByLanguage(LanguageCatalog languageCatalog) {
    return isMahayatkyan ? languageCatalog.translate("Mahayatkyan") : "";
  }

  bool get isShanyat {
    return (shanyat > 0);
  }

  String getShanyat() {
    return getShanyatByLanguage(LanguageCatalog.instance);
  }

  String getShanyatByLanguage(LanguageCatalog languageCatalog) {
    return isShanyat ? languageCatalog.translate("Shanyat") : "";
  }

  String getNagahle() {
    return getNagahleByLanguage(LanguageCatalog.instance);
  }

  String getNagahleByLanguage(LanguageCatalog languageCatalog) {
    final na = ["West", "North", "East", "South"];
    return languageCatalog.translate(na[nagahle]);
  }

  String getMahabote() {
    return getMahaboteByLanguage(LanguageCatalog.instance);
  }

  String getMahaboteByLanguage(LanguageCatalog languageCatalog) {
    final pa = ["Binga", "Atun", "Yaza", "Adipati", "Marana", "Thike", "Puti"];
    return languageCatalog.translate(pa[mahabote]);
  }

  String getNakhat() {
    return getNakhatByLanguage(LanguageCatalog.instance);
  }

  String getNakhatByLanguage(LanguageCatalog languageCatalog) {
    final nk = ["Orc", "Elf", "Human"];
    return languageCatalog.translate(nk[nakhat]);
  }

  String getYearName() {
    final yearNames = [
      "\u1015\u102F\u103F\u1014\u103E\u1005\u103A",
      "\u1019\u102C\u1001\u1014\u103E\u1005\u103A",
      "\u1016\u1039\u101C\u1000\u102D\u102F\u1014\u103A\u101E\u1036\u101D\u1005\u1039\u1006\u102D\u102F\u101D\u103A\u101B\u1014\u103E\u1005\u103A",
      "\u1005\u101A\u103A\u1014\u103E\u1005\u103A",
      "\u1015\u102D\u101E\u103B\u1000\u103A\u1014\u103E\u1005\u103A",
      "\u1005\u102D\u103F\u1014\u103E\u1005\u103A",
      "\u1021\u102C\u101E\u1010\u103A\u1014\u103E\u1005\u103A",
      "\u101E\u101B\u101D\u1014\u103A\u1014\u103E\u1005\u103A",
      "\u1018\u1012\u1039\u1012\u103C\u101E\u1036\u101D\u1005\u1039\u1006\u102F\u1036\u101B\u103A\u1014\u103E\u1005\u103A",
      "\u1021\u102C\u101E\u102D\u1014\u103A\u1014\u103E\u1005\u103A",
      "\u1000\u103C\u1010\u102D\u102F\u1000\u103A\u1014\u103E\u1005\u103A",
      "\u1019\u103C\u102D\u1000\u1039\u1000\u101E\u102D\u102F\u101D\u103A\u1014\u103E\u1005\u103A"
    ];
    return yearNames[yearName];
  }

  Astro copyWith({
    int? sabbath,
    int? sabbatheve,
    int? yatyaza,
    int? pyathada,
    int? thamanyo,
    int? amyeittasote,
    int? warameittugyi,
    int? warameittunge,
    int? yatpote,
    int? thamaphyu,
    int? nagapor,
    int? yatyotema,
    int? mahayatkyan,
    int? shanyat,
    int? nagahle,
    int? mahabote,
    int? nakhat,
    int? yearName,
  }) {
    return Astro(
      sabbath: sabbath ?? this.sabbath,
      sabbatheve: sabbatheve ?? this.sabbatheve,
      yatyaza: yatyaza ?? this.yatyaza,
      pyathada: pyathada ?? this.pyathada,
      thamanyo: thamanyo ?? this.thamanyo,
      amyeittasote: amyeittasote ?? this.amyeittasote,
      warameittugyi: warameittugyi ?? this.warameittugyi,
      warameittunge: warameittunge ?? this.warameittunge,
      yatpote: yatpote ?? this.yatpote,
      thamaphyu: thamaphyu ?? this.thamaphyu,
      nagapor: nagapor ?? this.nagapor,
      yatyotema: yatyotema ?? this.yatyotema,
      mahayatkyan: mahayatkyan ?? this.mahayatkyan,
      shanyat: shanyat ?? this.shanyat,
      nagahle: nagahle ?? this.nagahle,
      mahabote: mahabote ?? this.mahabote,
      nakhat: nakhat ?? this.nakhat,
      yearName: yearName ?? this.yearName,
    );
  }

  @override
  String toString() {
    return 'Astro(sabbath: $sabbath, sabbatheve: $sabbatheve, yatyaza: $yatyaza, pyathada: $pyathada, thamanyo: $thamanyo, amyeittasote: $amyeittasote, warameittugyi: $warameittugyi, warameittunge: $warameittunge, yatpote: $yatpote, thamaphyu: $thamaphyu, nagapor: $nagapor, yatyotema: $yatyotema, mahayatkyan: $mahayatkyan, shanyat: $shanyat, nagahle: $nagahle, mahabote: $mahabote, nakhat: $nakhat, yearName: $yearName)';
  }

  String toStringByLanguage(LanguageCatalog languageCatalog) {
    String str = '';

    str += getAstrologicalDay();

    if (isSabbath) {
      str += '${languageCatalog.language.comma} ';
      str += getSabbathByLanguage(languageCatalog);
    }

    if (isThamanyo) {
      str += " ${languageCatalog.language.comma} ";
      str += getThamanyoByLanguage(languageCatalog);
    }

    if (isThamaphyu) {
      str += " ${languageCatalog.language.comma} ";
      str += getThamaphyuByLanguage(languageCatalog);
    }

    if (isAmyeittasote) {
      str += " ${languageCatalog.language.comma} ";
      str += getAmyeittasoteByLanguage(languageCatalog);
    }

    if (isWarameittugyi) {
      str += " ${languageCatalog.language.comma} ";
      str += getWarameittugyiByLanguage(languageCatalog);
    }

    if (isWarameittunge) {
      str += " ${languageCatalog.language.comma} ";
      str += getWarameittungeByLanguage(languageCatalog);
    }

    if (isYatpote) {
      str += " ${languageCatalog.language.comma} ";
      str += getYatpoteByLanguage(languageCatalog);
    }

    if (isNagapor) {
      str += " ${languageCatalog.language.comma} ";
      str += getNagapor();
    }

    if (isYatyotema) {
      str += " ${languageCatalog.language.comma} ";
      str += getYatyotemaByLanguage(languageCatalog);
    }

    if (isMahayatkyan) {
      str += " ${languageCatalog.language.comma} ";
      str += getMahayatkyanByLanguage(languageCatalog);
    }

    if (isShanyat) {
      str += " ${languageCatalog.language.comma} ";
      str += getShanyatByLanguage(languageCatalog);
    }

    str +=
        "\u1014\u1002\u102B\u1038\u1001\u1031\u102B\u1004\u103A\u1038${getNagahleByLanguage(languageCatalog)}\u101E\u102D\u102F\u1037\u101C\u103E\u100A\u103A\u1037\u101E\u100A\u103A\u104B";
    str += " ${languageCatalog.language.comma} ";
    str += "${getMahaboteByLanguage(languageCatalog)}\u1016\u103D\u102C\u1038";
    str += " ${languageCatalog.language.comma} ";
    str +=
        "${getNakhatByLanguage(languageCatalog)}\u1014\u1000\u1039\u1001\u1010\u103A";

    str += " ${languageCatalog.language.comma} ";
    str += getYearName();

    return str;
  }

  @override
  bool operator ==(covariant Astro other) {
    if (identical(this, other)) return true;

    return other.sabbath == sabbath &&
        other.sabbatheve == sabbatheve &&
        other.yatyaza == yatyaza &&
        other.pyathada == pyathada &&
        other.thamanyo == thamanyo &&
        other.amyeittasote == amyeittasote &&
        other.warameittugyi == warameittugyi &&
        other.warameittunge == warameittunge &&
        other.yatpote == yatpote &&
        other.thamaphyu == thamaphyu &&
        other.nagapor == nagapor &&
        other.yatyotema == yatyotema &&
        other.mahayatkyan == mahayatkyan &&
        other.shanyat == shanyat &&
        other.nagahle == nagahle &&
        other.mahabote == mahabote &&
        other.nakhat == nakhat &&
        other.yearName == yearName;
  }

  @override
  int get hashCode {
    return sabbath.hashCode ^
        sabbatheve.hashCode ^
        yatyaza.hashCode ^
        pyathada.hashCode ^
        thamanyo.hashCode ^
        amyeittasote.hashCode ^
        warameittugyi.hashCode ^
        warameittunge.hashCode ^
        yatpote.hashCode ^
        thamaphyu.hashCode ^
        nagapor.hashCode ^
        yatyotema.hashCode ^
        mahayatkyan.hashCode ^
        shanyat.hashCode ^
        nagahle.hashCode ^
        mahabote.hashCode ^
        nakhat.hashCode ^
        yearName.hashCode;
  }
}
