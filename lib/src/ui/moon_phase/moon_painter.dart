import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_mmcalendar/src/core/calculations.dart';

/// A custom painter that draws the moon phase for a given [DateTime].
///
/// This painter uses the [MoonPhaseCalculation] to determine the phase angle
/// of the moon and renders the illuminated and dark portions accordingly.
///
/// The moon is drawn with the light side (`lightColor`) and the dark side
/// (`darkColor`) using simple geometric approximations.
///
/// Example:
/// ```dart
/// CustomPaint(
///   size: const Size(50, 50),
///   painter: MoonPainter(
///     date: DateTime.now(),
///     resolution: 100,
///     lightColor: Colors.white,
///     darkColor: Colors.black,
///   ),
/// )
/// ```
class MoonPainter extends CustomPainter {
  /// Creates a painter that draws a moon phase for the given [date].
  ///
  /// The [resolution] controls the level of detail for drawing the dark side.
  MoonPainter({
    required this.date,
    required this.resolution,
    required this.lightColor,
    required this.darkColor,
  }) {
    paintLight.color = lightColor;
    paintDark.color = darkColor;
  }

  /// The date for which to calculate and draw the moon phase.
  final DateTime date;

  /// Determines the rendering resolution for moon shading.
  ///
  /// Higher values provide smoother rendering but increase paint cost.
  final double resolution;

  /// The color of the illuminated part of the moon.
  final Color lightColor;

  /// The color of the dark side of the moon.
  final Color darkColor;

  /// Paint for the dark side of the moon.
  final Paint paintDark = Paint();

  /// Paint for the light side of the moon.
  final Paint paintLight = Paint();

  @override
  void paint(Canvas canvas, Size size) {
    // Use half of the shortest side as radius
    final double radius = size.shortestSide / 2;
    final Offset center = Offset(size.width / 2, size.height / 2);

    final double phaseAngle = MoonPhaseCalculation.getMoonPhaseAngle(date);
    final double positionAngle = (pi - phaseAngle + (2 * pi)) % (2 * pi);
    final double cosTerm = cos(positionAngle);
    final double rsquared = radius * radius;
    final double whichQuarter = ((positionAngle * 2.0 / pi) + 4) % 4;

    // Draw illuminated circle
    canvas.drawCircle(center, radius, paintLight);

    // Dark side shading
    for (int j = 0; j < resolution; ++j) {
      final double y = (j / resolution) * radius; // scale by resolution
      final double rrf = sqrt(rsquared - y * y);
      final double xx = rrf * cosTerm;
      final double x1 = center.dx - (whichQuarter < 2 ? rrf : xx);
      final double w = rrf + xx;

      // draw symmetric top & bottom strips
      canvas.drawRect(
        Rect.fromLTRB(x1, center.dy - y, w + x1, center.dy - y + 2),
        paintDark,
      );
      canvas.drawRect(
        Rect.fromLTRB(x1, center.dy + y, w + x1, center.dy + y + 2),
        paintDark,
      );
    }
  }

  @override
  bool shouldRepaint(covariant MoonPainter oldDelegate) {
    return oldDelegate.date != date ||
        oldDelegate.resolution != resolution ||
        oldDelegate.lightColor != lightColor ||
        oldDelegate.darkColor != darkColor;
  }
}
