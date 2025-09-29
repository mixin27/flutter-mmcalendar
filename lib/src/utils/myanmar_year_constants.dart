/// Myanmar Year Constants class
class MyanmarYearConstants {
  // Private constructor to prevent instantiation
  MyanmarYearConstants._();

  /// Get Myanmar year constants depending on era
  ///
  /// @param my myanmar year
  /// @return map
  /// EI = Myanmar calendar era id [1-3]
  /// WO = watat offset to compensate
  /// NM = number of months to find excess days
  /// EW = exception in watat year
  static Map<String, double> getMyConst(int my) {
    // Myanmar calendar era id [1-3] : calculations methods/constants depends on era
    double eraId;
    // watat offset to compensate
    double watatOffset;
    // number of months to find excess days
    double numberOfMonths;
    // exception in watat year
    double exceptionInWatatYear = 0;
    int i;

    List<List<int>> fme;
    List<int> wte;

    // The third era (the era after Independence 1312 ME and after)
    if (my >= 1312) {
      eraId = 3;
      watatOffset = -0.5;
      numberOfMonths = 8;
      fme = [
        [1377, 1],
      ];
      wte = [1344, 1345];
    }
    // The second era (the era under British colony: 1217 ME - 1311 ME)
    else if (my >= 1217) {
      eraId = 2;
      watatOffset = -1;
      numberOfMonths = 4;
      fme = [
        [1234, 1],
        [1261, -1],
      ];
      wte = [1263, 1264];
    }
    // The first era (the era of Myanmar kings: ME1216 and before)
    // Thandeikta (ME 1100 - 1216)
    else if (my >= 1100) {
      eraId = 1.3;
      watatOffset = -0.85;
      numberOfMonths = -1;
      fme = [
        [1120, 1],
        [1126, -1],
        [1150, 1],
        [1172, -1],
        [1207, 1],
      ];
      wte = [1201, 1202];
    }
    // Makaranta system 2 (ME 798 - 1099)
    else if (my >= 798) {
      eraId = 1.2;
      watatOffset = -1.1;
      numberOfMonths = -1;
      fme = [
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
      ];
      wte = <int>[];
    }
    // Makaranta system 1 (ME 0 - 797)
    else {
      eraId = 1.1;
      watatOffset = -1.1;
      numberOfMonths = -1;
      fme = [
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
      ];
      wte = <int>[];
    }

    i = _bSearch2(my, fme);
    if (i >= 0) {
      // full moon day offset exceptions
      watatOffset += fme[i][1];
    }
    i = _bSearch1(my, wte);
    if (i >= 0) {
      // correct watat exceptions
      exceptionInWatatYear = 1;
    }

    return {
      'EI': eraId,
      'WO': watatOffset,
      'NM': numberOfMonths,
      'EW': exceptionInWatatYear,
    };
  }

  // Binary search for array with two elements
  static int _bSearch2(int key, List<List<int>> arr) {
    int low = 0;
    int high = arr.length - 1;

    while (low <= high) {
      int mid = (low + high) ~/ 2;
      if (arr[mid][0] == key) {
        return mid;
      } else if (arr[mid][0] < key) {
        low = mid + 1;
      } else {
        high = mid - 1;
      }
    }
    // Key not found
    return -1;
  }

  // Binary search for array with one element
  static int _bSearch1(int key, List<int> arr) {
    int low = 0;
    int high = arr.length - 1;

    while (low <= high) {
      int mid = (low + high) ~/ 2;
      if (arr[mid] == key) {
        return mid;
      } else if (arr[mid] < key) {
        low = mid + 1;
      } else {
        high = mid - 1;
      }
    }
    // Key not found
    return -1;
  }
}
