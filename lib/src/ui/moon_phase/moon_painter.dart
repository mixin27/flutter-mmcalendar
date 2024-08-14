import 'dart:math';

import 'package:flutter/material.dart';

import '../../calculations/calculations.dart';

/// Moon custom painter class.
class MoonPainter extends CustomPainter {
  MoonPainter({
    Key? key,
    required this.date,
    required this.size,
    required this.resolution,
    required this.lightColor,
    required this.darkColor,
  });

  /// DateTime to show.
  /// Even hour, minutes, and seconds are calculated for MoonWidget
  final DateTime date;

  ///Decide the container size for the MoonWidget
  final double size;

  ///Resolution will be the moon radius.
  ///Large resolution needs more math operation makes widget heavy.
  ///Enter a small number if it is sufficient to mark it small,
  ///such as an icon or marker.
  final double resolution;

  ///Color of light side of moon
  final Color lightColor;

  ///Color of dark side of moon
  final Color darkColor;

  /// Dark paint object
  final paintDark = Paint();

  /// Light paint object
  final paintLight = Paint();

  @override
  void paint(Canvas canvas, Size size) {
    double radius = resolution;

    int width = radius.toInt() * 2;
    int height = radius.toInt() * 2;
    double phaseAngle = MoonPhaseCalculation.getMoonPhaseAngle(date);

    double xcenter = 0;
    double ycenter = 0;

    try {
      paintLight.color = lightColor;
      canvas.drawCircle(const Offset(0, 1), radius, paintLight);
    } catch (e) {
      radius = min(width, height) * 0.4;
      paintLight.color = lightColor;

      Rect oval = Rect.fromLTRB(
        xcenter - radius,
        ycenter - radius,
        xcenter + radius,
        ycenter + radius,
      );

      canvas.drawOval(oval, paintLight);
    }

    double positionAngle = pi - phaseAngle;
    if (positionAngle < 0.0) {
      positionAngle += 2.0 * pi;
    }

    paintDark.color = darkColor;

    double cosTerm = cos(positionAngle);

    double rsquared = radius * radius;
    double whichQuarter = ((positionAngle * 2.0 / pi) + 4) % 4;

    for (int j = 0; j < radius; ++j) {
      double rrf = sqrt(rsquared - j * j);
      double rr = rrf;
      double xx = rrf * cosTerm;
      double x1 = xcenter - (whichQuarter < 2 ? rr : xx);
      double w = rr + xx;

      canvas.drawRect(
        Rect.fromLTRB(x1, ycenter - j, w + x1, ycenter - j + 2),
        paintDark,
      );
      canvas.drawRect(
        Rect.fromLTRB(x1, ycenter + j, w + x1, ycenter + j + 2),
        paintDark,
      );
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
