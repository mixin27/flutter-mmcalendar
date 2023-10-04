import 'package:flutter_mmcalendar/flutter_mmcalendar.dart';

/// Thingyan Calculator
class ThingyanCalculator {
  /// Get [MyanmarThingyan] list by [DateTime]
  static List<MyanmarThingyan> getMyanmarThingyanDaysFromDateTime(
      DateTime dateTime) {
    final myanmarDate = MyanmarDateConverter.fromDateTime(dateTime);
    return getMyanmarThingyanDays(myanmarDate);
  }

  /// Get [MyanmarThingyan] list by [MyanmarDate].
  static List<MyanmarThingyan> getMyanmarThingyanDays(MyanmarDate myanmarDate) {
    List<MyanmarThingyan> thingyanDays = List.empty(growable: true);
    final thingyan = getThingyan(myanmarDate);

    final akyoDay = MyanmarThingyan(
      label: LanguageCatalog.instance.translate('Thingyan Akyo'),
      jdn: thingyan.akyo.toDouble(),
      date: thingyan.akyoDate,
    );
    thingyanDays.add(akyoDay);

    final akyaDay = MyanmarThingyan(
      label: LanguageCatalog.instance.translate('Thingyan Akya'),
      jdn: thingyan.akya.toDouble(),
      date: thingyan.akyaDate,
    );
    thingyanDays.add(akyaDay);

    for (var i = 0; i < thingyan.akyat.length; i++) {
      final akyatDay = MyanmarThingyan(
        label: LanguageCatalog.instance.translate('Thingyan Akyat'),
        jdn: thingyan.akyat[i].toDouble(),
        date: thingyan.akyatDates[i],
      );
      thingyanDays.add(akyatDay);
    }

    final atatDay = MyanmarThingyan(
      label: LanguageCatalog.instance.translate('Thingyan Atat'),
      jdn: thingyan.atat.toDouble(),
      date: thingyan.atatDate,
    );
    thingyanDays.add(atatDay);

    final newYearDay = MyanmarThingyan(
      label: LanguageCatalog.instance.translate('Myanmar New Year Day'),
      jdn: thingyan.myanmarNewYearDay.toDouble(),
      date: thingyan.myanmarNewYearDate,
    );
    thingyanDays.add(newYearDay);

    return thingyanDays;
  }

  /// Get [Thingyan] holiday from [DateTime]
  static Thingyan getThingyanFromDateTime(DateTime dateTime) {
    final myanmarDate = MyanmarDateConverter.fromDateTime(dateTime);
    return getThingyan(myanmarDate);
  }

  /// Get [Thingyan] holiday from [MyanmarDate]
  static Thingyan getThingyan(MyanmarDate myanmarDate) {
    final my = myanmarDate.myear;
    final mm = myanmarDate.mmonth;
    final mmt = (mm / 13).floor();

    // solar year (365.2587565)
    double sy = 1577917828.0 / 4320000.0;

    // beginning of 0 ME
    double mo = 1954168.050623;

    // // start of Thingyan and third era
    int se3 = 1312;
    double atatTime = sy * (my + mmt) + mo; // atat time
    double akyaTime;

    if (my >= se3) {
      akyaTime = atatTime - 2.169918982; // akya time
    } else {
      akyaTime = atatTime - 2.1675;
    }

    // Akya
    int akn = akyaTime.round();
    // Atat
    int atn = atatTime.round();
    // Akyo
    int akyo = akn - 1;

    // Akyat start day
    int akyat = akn + 1;

    /// Akyat days
    List<int> akyats = List.empty(growable: true);
    while (akyat < atn) {
      akyats.add(akyat);
      akyat++;
    }

    return Thingyan(
      akyo: akyo,
      akya: akn,
      akyat: akyats,
      atat: atn,
    );
  }
}
