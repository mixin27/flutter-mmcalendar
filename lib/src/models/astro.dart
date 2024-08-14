import '../language/language.dart';

/// Astrological
class Astro {
  Astro({
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
    LanguageCatalog? languageCatalog,
  }) : _languageCatalog = languageCatalog ?? LanguageCatalog.myanmar();

  /// Language config
  final LanguageCatalog _languageCatalog;

  /// Public [LanguageCatalog] instance.
  LanguageCatalog get languageCatalog => _languageCatalog;

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
