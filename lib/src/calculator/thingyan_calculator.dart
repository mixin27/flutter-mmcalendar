import 'package:flutter_mmcalendar/flutter_mmcalendar.dart';

/// Thingyan Calculator
class ThingyanCalculator {
  /// Calculate the Thingyan (Myanmar new year)
  static Thingyan getThingyan(int myear) {
    double ja = CalendarConstants.solarYear * myear + CalendarConstants.mo;

    double jk;

    if (myear >= CalendarConstants.se3) {
      jk = ja - 2.169918982;
    } else {
      jk = ja - 2.1675;
    }

    double da = (ja).roundToDouble();
    double dk = (jk).roundToDouble();

    return Thingyan(ja: ja, jk: jk, da: da, dk: dk);
  }

  /// Get [Thingyan] `akyo` day.
  ///
  /// `year` - Year to be calculated
  ///
  /// Return - [MyanmarDate]
  static MyanmarDate getAkyoDay(int year) {
    final thingyan = getThingyan(year);
    final akyoDay = MyanmarDateLogic.julianToMyanmarDate(thingyan.akyoDay);
    return akyoDay;
  }

  /// Get [Thingyan] `akya` day.
  ///
  /// `year` - Year to be calculated
  ///
  /// Return - [MyanmarDate]
  static MyanmarDate getAkyaDay(int year) {
    final thingyan = getThingyan(year);
    final akyaDay = MyanmarDateLogic.julianToMyanmarDate(thingyan.akyaDay);
    return akyaDay;
  }

  /// Get [Thingyan] `akyat` days.
  ///
  /// `year` - Year to be calculated
  ///
  /// Return - List of [MyanmarDate]
  static List<MyanmarDate> getAkyatDays(int year) {
    final thingyan = getThingyan(year);
    List<MyanmarDate> dates = List.empty(growable: true);

    for (var i = 0; i < thingyan.akyatDay.length; i++) {
      final akyatDay =
          MyanmarDateLogic.julianToMyanmarDate(thingyan.akyatDay[i]);
      dates.add(akyatDay);
    }

    return dates;
  }

  /// Get [Thingyan] `atat` day.
  ///
  /// `year` - Year to be calculated
  ///
  /// Return - [MyanmarDate]
  static MyanmarDate getAtatDay(int year) {
    final thingyan = getThingyan(year);
    final atatDay = MyanmarDateLogic.julianToMyanmarDate(thingyan.atatDay);
    return atatDay;
  }

  /// Get [Thingyan] dates map.
  static Map<String, MyanmarDate> getThingyanDates(int year) {
    Map<String, MyanmarDate> dateMap = {};

    final akyoDay = ThingyanCalculator.getAkyoDay(year);
    dateMap.putIfAbsent('Akyo', () => akyoDay);

    final akyaDay = ThingyanCalculator.getAkyaDay(year);
    dateMap.putIfAbsent('Akya', () => akyaDay);

    final akyatDays = ThingyanCalculator.getAkyatDays(year);
    for (var i = 0; i < akyatDays.length; i++) {
      dateMap.putIfAbsent('Akyat_${i + 1}', () => akyatDays[i]);
    }

    final atatDay = ThingyanCalculator.getAtatDay(year);
    dateMap.putIfAbsent('Atat', () => atatDay);

    return dateMap;
  }
}
