import '../language/language.dart';
import '../models/models.dart';

/// Utility extension of [Astro].
extension AstroExtension on Astro {
  String getAstrologicalDay() {
    return getAstrologicalDayByLanguage(languageCatalog);
  }

  String getAstrologicalDayByLanguage(LanguageCatalog langCatalog) {
    String str = "";
    if (yatyaza > 0) {
      str += langCatalog.translate("Yatyaza");
    }
    if (pyathada == 1) {
      str += langCatalog.translate("Pyathada");
    } else if (pyathada == 2) {
      str += langCatalog.translate("Afternoon Pyathada");
    }
    return str;
  }

  bool get isSabbath => (sabbath > 0) || (sabbatheve > 0);

  String getSabbath() => getSabbathByLanguage(languageCatalog);

  String getSabbathByLanguage(LanguageCatalog langCatalog) {
    String str = '';
    if (sabbath > 0) {
      str += langCatalog.translate("Sabbath");
    } else if (sabbatheve > 0) {
      str += langCatalog.translate("Sabbath Eve");
    }
    return str;
  }

  bool get isThamanyo => thamanyo > 0;

  String getThamanyo() => getThamanyoByLanguage(languageCatalog);

  String getThamanyoByLanguage(LanguageCatalog langCatalog) {
    return isThamanyo ? langCatalog.translate('Thamanyo') : '';
  }

  bool get isAmyeittasote => amyeittasote > 0;

  String getAmyeittasote() => getAmyeittasoteByLanguage(languageCatalog);

  String getAmyeittasoteByLanguage(LanguageCatalog langCatalog) {
    return isAmyeittasote ? langCatalog.translate('Amyeittasote') : '';
  }

  bool get isWarameittugyi => warameittugyi > 0;

  String getWarameittugyi() => getWarameittugyiByLanguage(languageCatalog);

  String getWarameittugyiByLanguage(LanguageCatalog langCatalog) {
    return isWarameittugyi ? langCatalog.translate("Warameittugyi") : "";
  }

  bool get isWarameittunge => warameittunge > 0;

  String getWarameittunge() {
    return getWarameittungeByLanguage(languageCatalog);
  }

  String getWarameittungeByLanguage(LanguageCatalog langCatalog) {
    return isWarameittunge ? langCatalog.translate("Warameittunge") : "";
  }

  bool get isYatpote {
    return (yatpote > 0);
  }

  String getYatpote() {
    return getYatpoteByLanguage(languageCatalog);
  }

  String getYatpoteByLanguage(LanguageCatalog langCatalog) {
    return isYatpote ? langCatalog.translate("Yatpote") : "";
  }

  bool get isThamaphyu {
    return (thamaphyu > 0);
  }

  String getThamaphyu() {
    return getThamaphyuByLanguage(languageCatalog);
  }

  String getThamaphyuByLanguage(LanguageCatalog langCatalog) {
    return isThamaphyu ? langCatalog.translate("Thamaphyu") : "";
  }

  bool get isNagapor {
    return (nagapor > 0);
  }

  String getNagapor() {
    return getNagaporByLanguage(languageCatalog);
  }

  String getNagaporByLanguage(LanguageCatalog langCatalog) {
    return isNagapor ? langCatalog.translate("Nagapor") : "";
  }

  bool get isYatyotema {
    return (yatyotema > 0);
  }

  String getYatyotema() {
    return getYatyotemaByLanguage(languageCatalog);
  }

  String getYatyotemaByLanguage(LanguageCatalog langCatalog) {
    return isYatyotema ? langCatalog.translate("Yatyotema") : "";
  }

  bool get isMahayatkyan {
    return (mahayatkyan > 0);
  }

  String getMahayatkyan() {
    return getMahayatkyanByLanguage(languageCatalog);
  }

  String getMahayatkyanByLanguage(LanguageCatalog langCatalog) {
    return isMahayatkyan ? langCatalog.translate("Mahayatkyan") : "";
  }

  bool get isShanyat {
    return (shanyat > 0);
  }

  /// Get `Shanyat`
  String getShanyat() {
    return getShanyatByLanguage(languageCatalog);
  }

  /// Get `Shanyat`
  String getShanyatByLanguage(LanguageCatalog langCatalog) {
    return isShanyat ? langCatalog.translate("Shanyat") : "";
  }

  /// Get `Nagahle`
  ///
  /// Return - One of `"West", "North", "East", "South"`
  String getNagahle() {
    return getNagahleByLanguage(languageCatalog);
  }

  /// Get `Nagahle`
  ///
  /// Return - One of `"West", "North", "East", "South"`
  String getNagahleByLanguage(LanguageCatalog langCatalog) {
    final na = ["West", "North", "East", "South"];
    return langCatalog.translate(na[nagahle]);
  }

  /// Get `Mahabote`
  String getMahabote() {
    return getMahaboteByLanguage(languageCatalog);
  }

  /// Get `Mahabote`
  String getMahaboteByLanguage(LanguageCatalog langCatalog) {
    final pa = ["Binga", "Atun", "Yaza", "Adipati", "Marana", "Thike", "Puti"];
    return langCatalog.translate(pa[mahabote]);
  }

  /// Get `Nakhat`
  String getNakhat() {
    return getNakhatByLanguage(languageCatalog);
  }

  /// Get `Nakhat`
  String getNakhatByLanguage(LanguageCatalog langCatalog) {
    final nk = ["Ogre", "Elf", "Human"];
    return langCatalog.translate(nk[nakhat]);
  }

  /// Get year name
  String getYearName() {
    return getYearNameByLanguage(languageCatalog);
  }

  /// Get year name by [LanguageCatalog]
  ///
  /// Return - One of `["ပုဿနှစ်", "မာခနှစ်", "ဖ္လကိုန်သံဝစ္ဆိုဝ်ရနှစ်", "စယ်နှစ်", "ပိသျက်နှစ်",`
  /// `"စိဿနှစ်", "အာသတ်နှစ်", "သရဝန်နှစ်", "ဘဒ္ဒြသံဝစ္ဆုံရ်နှစ်", "အာသိန်နှစ်", "ကြတိုက်နှစ်",`
  /// `"မြိက္ကသိုဝ်နှစ်" ]` or `empty`
  String getYearNameByLanguage(LanguageCatalog langCatalog) {
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

    return langCatalog.translate(yearNames[yearName]);
  }
}
