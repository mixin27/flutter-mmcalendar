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
}
