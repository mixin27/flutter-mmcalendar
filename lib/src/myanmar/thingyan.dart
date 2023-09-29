class Thingyan {
  final double ja;
  final double jk;
  final double da;
  final double dk;

  const Thingyan({
    required this.ja,
    required this.jk,
    required this.da,
    required this.dk,
  });

  double get atatTime => ja;
  double get akyaTime => jk;
  double get atatDay => da;
  double get akyaDay => dk;

  double get akyoDay => dk - 1;

  /// Thingyan Akyat day
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
