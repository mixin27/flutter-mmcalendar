// ignore_for_file: public_member_api_docs, sort_constructors_first
/// Myanmar Tingyan
class Thingyan {
  const Thingyan({
    required this.ja,
    required this.jk,
    required this.da,
    required this.dk,
  });

  /// `Atat` time
  final double ja;

  /// `Akya` time
  final double jk;

  /// `Atat` day
  final double da;

  /// `Akya` day
  final double dk;

  /// `Atat` time
  double get atatTime => ja;

  /// `Akya` time
  double get akyaTime => jk;

  /// `Atat` day
  double get atatDay => da;

  /// `Akya` day
  double get akyaDay => dk;

  /// `Akyo` day
  double get akyoDay => dk - 1;

  /// Thingyan Akyat day
  ///
  /// `Akyat` day can be `two` days every `leap` year.
  List<double> get akyatDay {
    if ((da - dk) > 2) {
      return [dk + 1, dk + 2];
    }
    return [dk + 1];
  }

  /// Myanmar new year's day
  double get myanmarNewYearDay => da + 1;

  Thingyan copyWith({
    double? ja,
    double? jk,
    double? da,
    double? dk,
  }) {
    return Thingyan(
      ja: ja ?? this.ja,
      jk: jk ?? this.jk,
      da: da ?? this.da,
      dk: dk ?? this.dk,
    );
  }

  @override
  String toString() {
    return 'Thingyan(ja: $ja, jk: $jk, da: $da, dk: $dk)';
  }

  @override
  bool operator ==(covariant Thingyan other) {
    if (identical(this, other)) return true;

    return other.ja == ja && other.jk == jk && other.da == da && other.dk == dk;
  }

  @override
  int get hashCode {
    return ja.hashCode ^ jk.hashCode ^ da.hashCode ^ dk.hashCode;
  }
}
