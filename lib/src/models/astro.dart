import 'package:equatable/equatable.dart';
import 'package:flutter_mmcalendar/src/models/enums.dart';

/// Astro model representing astrological information of a day.
class Astro extends Equatable {
  final int yatyaza;
  final int pyathada;
  final int sabbatheve;
  final int sabbath;
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

  final int nagahle; // 0=West,1=North,2=East,3=South
  final int mahabote; // 0-6
  final int nakhat; // 0-2
  final int yearName; // 0-11

  const Astro({
    required this.yatyaza,
    required this.pyathada,
    required this.sabbatheve,
    required this.sabbath,
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

  /// Get all active events as a Set for easy iteration.
  Set<AstroEvent> get activeEvents {
    final events = <AstroEvent>{};
    if (yatyaza > 0) events.add(AstroEvent.yatyaza);
    if (pyathada == 1) events.add(AstroEvent.pyathada);
    if (pyathada == 2) events.add(AstroEvent.afternoonPyathada);
    if (sabbatheve > 0) events.add(AstroEvent.sabbatheve);
    if (sabbath > 0) events.add(AstroEvent.sabbatheve); // optional if needed
    if (thamanyo > 0) events.add(AstroEvent.thamanyo);
    if (amyeittasote > 0) events.add(AstroEvent.amyeittasote);
    if (warameittugyi > 0) events.add(AstroEvent.warameittugyi);
    if (warameittunge > 0) events.add(AstroEvent.warameittunge);
    if (yatpote > 0) events.add(AstroEvent.yatpote);
    if (thamaphyu > 0) events.add(AstroEvent.thamaphyu);
    if (nagapor > 0) events.add(AstroEvent.nagapor);
    if (yatyotema > 0) events.add(AstroEvent.yatyotema);
    if (mahayatkyan > 0) events.add(AstroEvent.mahayatkyan);
    if (shanyat > 0) events.add(AstroEvent.shanyat);

    return events;
  }

  @override
  List<Object?> get props => [
    yatyaza,
    pyathada,
    sabbatheve,
    sabbath,
    thamanyo,
    amyeittasote,
    warameittugyi,
    warameittunge,
    yatpote,
    thamaphyu,
    nagapor,
    yatyotema,
    mahayatkyan,
    shanyat,
    nagahle,
    mahabote,
    nakhat,
    yearName,
  ];
}
