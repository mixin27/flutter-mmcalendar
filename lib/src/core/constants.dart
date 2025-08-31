import 'package:flutter_mmcalendar/src/models/era.dart';

class CalendarConstants {
  static const double solarYear = 365.2587564814815;
  static const double lunarMonth = 29.53058794607172;
  static const double mo = 1954168.050623;

  static const double se3 = 1312;
  static const int by = 640;
  static const int ey = 2140;
  static const int mby = 2;
  static const int mey = 1500;
  static const int lt = 1700;
  static const int ut = 2018;
  static const int mlt = 1062;
  static const int mut = 1379;
  static const double sg = 2361222;
}

class MyanmarDateFormat {
  static const String sasanaYear = 'S';
  static const String buddhistEra = 's';
  static const String burmeseYear = 'B';
  static const String myanmarYear = 'y';
  static const String ku = 'k';
  static const String monthInYear = 'M';
  static const String moonPhase = 'p';
  static const String fortnightDay = 'f';
  static const String dayNameInWeek = 'E';
  static const String nay = 'n';
  static const String yat = 'r';
  static const String simple = "S s k, B y k, M p f r, En.";
}

// Myanmar months
const List<String> mma = [
  "First Waso",
  "Tagu",
  "Kason",
  "Nayon",
  "Waso",
  "Wagaung",
  "Tawthalin",
  "Thadingyut",
  "Tazaungmon",
  "Nadaw",
  "Pyatho",
  "Tabodwe",
  "Tabaung",
];

const List<String> emaList = [
  "First Waso",
  "Tagu",
  "Kason",
  "Nayon",
  "Waso",
  "Wagaung",
  "Tawthalin",
  "Thadingyut",
  "Tazaungmon",
  "Nadaw",
  "Pyatho",
  "Tabodwe",
  "Tabaung",
  "Late Tagu",
  "Late Kason",
];

const List<String> wda = [
  "Saturday",
  "Sunday",
  "Monday",
  "Tuesday",
  "Wednesday",
  "Thursday",
  "Friday",
];

const List<String> msa = ["waxing", "full moon", "waning", "new moon"];

/// Eid 2
const List<int> ghEid2 = [2456936, 2457290, 2457644, 2457998, 2458353];

/// Chinese new year ref
const List<int> ghCNY = [
  2456689,
  2456690,
  2457073,
  2457074,
  2457427,
  2457428,
  2457782,
  2457783,
  2458166,
  2458167,
];

/// Diwali
const List<int> ghDiwali = [
  2456599,
  2456953,
  2457337,
  2457691,
  2458045,
  2458429,
];

/// Eid
const List<int> ghEid = [2456513, 2456867, 2457221, 2457576, 2457930, 2458285];

const List<Era> eraList = [
  Era(
    eid: 1.1,
    begin: -999,
    end: 797,
    wo: -1.1,
    nm: -1,
    fme: [
      [205, 1],
      [246, 1],
      [471, 1],
      [572, -1],
      [651, 1],
      [653, 2],
      [656, 1],
      [672, 1],
      [729, 1],
      [767, -1],
    ],
    wte: [],
  ),
  Era(
    eid: 1.2,
    begin: 798,
    end: 1099,
    wo: -1.1,
    nm: -1,
    fme: [
      [813, -1],
      [849, -1],
      [851, -1],
      [854, -1],
      [927, -1],
      [933, -1],
      [936, -1],
      [938, -1],
      [949, -1],
      [952, -1],
      [963, -1],
      [968, -1],
      [1039, -1],
    ],
    wte: [],
  ),
  Era(
    eid: 1.3,
    begin: 1100,
    end: 1216,
    wo: -0.85,
    nm: -1,
    fme: [
      [1120, 1],
      [1126, -1],
      [1150, 1],
      [1172, -1],
      [1207, 1],
    ],
    wte: [
      [1201, 1],
      [1202, 0],
    ],
  ),
  Era(
    eid: 2,
    begin: 1217,
    end: 1311,
    wo: -1,
    nm: 4,
    fme: [
      [1234, 1],
      [1261, -1],
    ],
    wte: [
      [1263, 1],
      [1264, 0],
    ],
  ),
  Era(
    eid: 3,
    begin: 1312,
    end: 9999,
    wo: -0.5,
    nm: 8,
    fme: [
      [1377, 1],
    ],
    wte: [
      [1344, 1],
      [1345, 0],
    ],
  ),
];
