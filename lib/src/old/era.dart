final class Era {
  const Era({
    required this.eid,
    required this.begin,
    required this.end,
    required this.wo,
    required this.nm,
    required this.fme,
    required this.wte,
  });

  final double eid;
  final int begin;
  final int end;
  final double wo;
  final int nm;
  final List<List<int>> fme;
  final List<List<int>> wte;

  static List<Era> gEras = [
    // The first era (the era of Myanmar kings: ME1216 and before)
    // Makaranta system 1 (ME 0 - 797)
    const Era(
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
        [767, -1]
      ],
      wte: [], // exceptions for watat years
    ),

    // Makaranta system 2 (ME 798 - 1099)
    const Era(
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
        [1039, -1]
      ],
      wte: [],
    ),

    // Thandeikta (ME 1100 - 1216)
    const Era(
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
        [1207, 1]
      ],
      wte: [
        [1201, 1],
        [1202, 0]
      ],
    ),

    // ---------------------------------------------------------
    // The second era (the era under British colony: 1217 ME - 1311 ME)
    const Era(
      eid: 2,
      begin: 1217,
      end: 1311,
      wo: -1,
      nm: 4,
      fme: [
        [1234, 1],
        [1261, -1]
      ],
      wte: [
        [1263, 1],
        [1264, 0]
      ],
    ),

    // ---------------------------------------------------------
    // The third era (the era after Independence 1312 ME and after)
    const Era(
      eid: 3,
      begin: 1312,
      end: 9999,
      wo: -0.5,
      nm: 8,
      fme: [
        [1377, 1]
      ],
      wte: [
        [1344, 1],
        [1345, 0]
      ],
    ),
  ];
}
