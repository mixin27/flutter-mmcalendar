import 'package:flutter/foundation.dart';
import 'package:flutter_mmcalendar/src/core/calculations.dart';
import 'date.dart';

/// Represents a Myanmar Thingyan day.
class MyanmarThingyan {
  /// Label for the Thingyan day.
  final String label;

  /// Julian Day Number of the Thingyan.
  final double jdn;

  /// Corresponding Myanmar date.
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

  MyanmarThingyan copyWith({String? label, double? jdn, MyanmarDate? date}) {
    return MyanmarThingyan(
      label: label ?? this.label,
      jdn: jdn ?? this.jdn,
      date: date ?? this.date,
    );
  }
}

/// Represents the full Thingyan period in Myanmar calendar.
class Thingyan {
  /// Akyo (first day of Thingyan)
  final int akyo;

  /// Akya (last day of Thingyan)
  final int akya;

  /// Akyat (intermediate Thingyan days)
  final List<int> akyat;

  /// Atat (New Year day)
  final int atat;

  const Thingyan({
    required this.akyo,
    required this.akya,
    required this.akyat,
    required this.atat,
  });

  /// Converts `akyo` to [MyanmarDate]
  MyanmarDate get akyoDate =>
      MyanmarDateCalculation.fromJulianDay(akyo.toDouble());

  /// Converts `akya` to [MyanmarDate]
  MyanmarDate get akyaDate =>
      MyanmarDateCalculation.fromJulianDay(akya.toDouble());

  /// Converts `akyat` to a list of [MyanmarDate]
  List<MyanmarDate> get akyatDates => akyat
      .map((jd) => MyanmarDateCalculation.fromJulianDay(jd.toDouble()))
      .toList();

  /// Converts `atat` to [MyanmarDate]
  MyanmarDate get atatDate =>
      MyanmarDateCalculation.fromJulianDay(atat.toDouble());

  /// Returns the Julian day of the Myanmar New Year
  int get myanmarNewYearDay => atat + 1;

  /// Returns the Myanmar date of the Myanmar New Year
  MyanmarDate get myanmarNewYearDate =>
      MyanmarDateCalculation.fromJulianDay(myanmarNewYearDay.toDouble());

  /// Creates a copy of this object with optional new values.
  Thingyan copyWith({int? akyo, int? akya, List<int>? akyat, int? atat}) {
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
  int get hashCode =>
      akyo.hashCode ^ akya.hashCode ^ akyat.hashCode ^ atat.hashCode;
}
