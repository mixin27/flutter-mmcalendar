// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter_mmcalendar/flutter_mmcalendar.dart';

/// Astrological
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

extension AstroX on Astro {
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

  String getSabbath() => getSabbathByLanguage(LanguageCatalog.instance);

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

  /// Get `Shanyat`
  String getShanyat() {
    return getShanyatByLanguage(LanguageCatalog.instance);
  }

  /// Get `Shanyat`
  String getShanyatByLanguage(LanguageCatalog languageCatalog) {
    return isShanyat ? languageCatalog.translate("Shanyat") : "";
  }

  /// Get `Nagahle`
  ///
  /// Return - One of `"West", "North", "East", "South"`
  String getNagahle() {
    return getNagahleByLanguage(LanguageCatalog.instance);
  }

  /// Get `Nagahle`
  ///
  /// Return - One of `"West", "North", "East", "South"`
  String getNagahleByLanguage(LanguageCatalog languageCatalog) {
    final na = ["West", "North", "East", "South"];
    return languageCatalog.translate(na[nagahle]);
  }

  /// Get `Mahabote`
  String getMahabote() {
    return getMahaboteByLanguage(LanguageCatalog.instance);
  }

  /// Get `Mahabote`
  String getMahaboteByLanguage(LanguageCatalog languageCatalog) {
    final pa = ["Binga", "Atun", "Yaza", "Adipati", "Marana", "Thike", "Puti"];
    return languageCatalog.translate(pa[mahabote]);
  }

  /// Get `Nakhat`
  String getNakhat() {
    return getNakhatByLanguage(LanguageCatalog.instance);
  }

  /// Get `Nakhat`
  String getNakhatByLanguage(LanguageCatalog languageCatalog) {
    final nk = ["Ogre", "Elf", "Human"];
    return languageCatalog.translate(nk[nakhat]);
  }

  /// Get year name
  String getYearName() {
    return getYearNameByLanguage(LanguageCatalog.instance);
  }

  /// Get year name by [LanguageCatalog]
  ///
  /// Return - One of `["ပုဿနှစ်", "မာခနှစ်", "ဖ္လကိုန်သံဝစ္ဆိုဝ်ရနှစ်", "စယ်နှစ်", "ပိသျက်နှစ်",`
  /// `"စိဿနှစ်", "အာသတ်နှစ်", "သရဝန်နှစ်", "ဘဒ္ဒြသံဝစ္ဆုံရ်နှစ်", "အာသိန်နှစ်", "ကြတိုက်နှစ်",`
  /// `"မြိက္ကသိုဝ်နှစ်" ]` or `empty`
  String getYearNameByLanguage(LanguageCatalog languageCatalog) {
    final yearNames = [
      "Hpusha",
      "Magha",
      "Phalguni",
      "Chitra",
      "Visakha",
      "Jyeshtha",
      "Ashadha",
      "Sravana",
      "Bhadrapaha",
      "Asvini",
      "Krittika",
      "Mrigasiras",
    ];

    return languageCatalog.translate(yearNames[yearName]);
  }
}
