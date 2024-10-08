import 'dart:math';

/// Calculation moon phase angel.
class MoonPhaseCalculation {
  static double deg2rad = pi / 180;

  /// convert degrees to a valid angle:
  static double angle(double degree) {
    while (degree >= 360.0) {
      degree -= 360.0;
    }

    while (degree < 0.0) {
      degree += 360.0;
    }

    return degree * deg2rad;
  }

  /// Return the phase angle for the given date, in RADIANS.
  /// Equation from Meeus eqn. 46.4.
  static double getMoonPhaseAngle(DateTime date) {
    // Time measured in Julian centuries from epoch J2000.0:
    DateTime tEpoch = DateTime(2000, 1, 1, 12);
    double t = (decimalYears(date) - decimalYears(tEpoch)) / 100.0;
    double t2 = t * t;
    double t3 = t2 * t;
    double t4 = t3 * t;

    // Mean elongation of the moon:
    double D = angle(297.8502042 +
        445267.1115168 * t -
        0.0016300 * t2 +
        t3 / 545868 +
        t4 / 113065000);
    // Sun's mean anomaly:
    double M =
        angle(357.5291092 + 35999.0502909 * t - 0.0001536 * t2 + t3 / 24490000);
    // Moon's mean anomaly:
    double mPrime = angle(134.9634114 +
        477198.8676313 * t +
        0.0089970 * t2 -
        t3 / 3536000 +
        t4 / 14712000);

    return (angle(180 -
        (D / deg2rad) -
        6.289 * sin(mPrime) +
        2.100 * sin(M) -
        1.274 * sin(2 * D - mPrime) -
        0.658 * sin(2 * D) -
        0.214 * sin(2 * mPrime) -
        0.110 * sin(D)));
  }

  /// Get decimal years
  static double decimalYears(DateTime date) {
    return date.millisecondsSinceEpoch.toDouble() /
        365.242191 /
        (24 * 60 * 60 * 1000);
  }

  /// Get time as decimal day
  static double getTimeAsDecimalDay(DateTime date) {
    return date.millisecondsSinceEpoch.toDouble() / (24 * 60 * 60 * 1000);
  }
}
