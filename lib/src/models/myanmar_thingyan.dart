import 'package:flutter/foundation.dart';
import '../calculations/calculations.dart';
import 'models.dart';

/// Myanmar Thingyan
class MyanmarThingyan {
  /// Thingyan label
  final String label;

  /// `Julian` day number
  final double jdn;

  /// [MyanmarDate] value
  final MyanmarDate date;

  const MyanmarThingyan({
    required this.label,
    required this.jdn,
    required this.date,
  });

  @override
  String toString() => 'MyanmarThingyan(label: $label, jdn: $jdn, date: $date)';

  @override
  bool operator ==(covariant MyanmarThingyan other) {
    if (identical(this, other)) return true;

    return other.label == label && other.jdn == jdn && other.date == date;
  }

  @override
  int get hashCode => label.hashCode ^ jdn.hashCode ^ date.hashCode;

  MyanmarThingyan copyWith({
    String? label,
    double? jdn,
    MyanmarDate? date,
  }) {
    return MyanmarThingyan(
      label: label ?? this.label,
      jdn: jdn ?? this.jdn,
      date: date ?? this.date,
    );
  }
}

/// Myanmar Tingyan
class Thingyan {
  const Thingyan({
    required this.akyo,
    required this.akya,
    required this.akyat,
    required this.atat,
  });

  /// [Thingyan] akyo
  final int akyo;

  /// [Thingyan] akyo [MyanmarDate]
  MyanmarDate get akyoDate =>
      MyanmarDateCalculation.fromJulianDay(akyo.toDouble());

  /// [Thingyan] akya
  final int akya;

  /// [Thingyan] akya [MyanmarDate]
  MyanmarDate get akyaDate =>
      MyanmarDateCalculation.fromJulianDay(akya.toDouble());

  /// [Thingyan] akyats
  final List<int> akyat;

  /// [Thingyan] akyats [MyanmarDate]
  List<MyanmarDate> get akyatDates => akyat
      .map((e) => MyanmarDateCalculation.fromJulianDay(e.toDouble()))
      .toList();

  /// [Thingyan] atat
  final int atat;

  /// [Thingyan] atat [MyanmarDate]
  MyanmarDate get atatDate =>
      MyanmarDateCalculation.fromJulianDay(atat.toDouble());

  /// Myanmar new year day
  int get myanmarNewYearDay => atat + 1;

  /// Myanmar new year [MyanmarDate]
  MyanmarDate get myanmarNewYearDate =>
      MyanmarDateCalculation.fromJulianDay(myanmarNewYearDay.toDouble());

  Thingyan copyWith({
    int? akyo,
    int? akya,
    List<int>? akyat,
    int? atat,
  }) {
    return Thingyan(
      akyo: akyo ?? this.akyo,
      akya: akya ?? this.akya,
      akyat: akyat ?? this.akyat,
      atat: atat ?? this.atat,
    );
  }

  @override
  String toString() {
    return 'Thingyan(akyo: $akyo, akya: $akya, akyat: $akyat, atat: $atat)';
  }

  @override
  bool operator ==(covariant Thingyan other) {
    if (identical(this, other)) return true;

    return other.akyo == akyo &&
        other.akya == akya &&
        listEquals(other.akyat, akyat) &&
        other.atat == atat;
  }

  @override
  int get hashCode {
    return akyo.hashCode ^ akya.hashCode ^ akyat.hashCode ^ atat.hashCode;
  }
}
