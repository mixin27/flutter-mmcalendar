// ignore_for_file: public_member_api_docs

import 'dart:math' as math;

import 'package:flutter/material.dart';

/// Reusable moon phase painter.
///
/// [phase] is normalized in the range `0.0..1.0`:
/// - `0.0` => new moon
/// - `0.5` => full moon
/// - `1.0` => new moon (next cycle)
class MoonPhasePainter extends CustomPainter {
  MoonPhasePainter({
    required this.phase,
    this.illuminatedColor = const Color(0xFFFFF7CC),
    this.shadowColor = const Color(0xFF1E293B),
    this.borderColor = const Color(0xFF0F172A),
    this.borderWidth = 1.0,
    this.showEarthshine = true,
    this.earthshineColor = const Color(0xFF93C5FD),
  });

  final double phase;
  final Color illuminatedColor;
  final Color shadowColor;
  final Color borderColor;
  final double borderWidth;
  final bool showEarthshine;
  final Color earthshineColor;

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = math.min(size.width, size.height) / 2;
    if (radius <= 0) {
      return;
    }

    final normalized = _normalizePhase(phase);
    final moonRect = Rect.fromCircle(center: center, radius: radius);
    final illumination = MoonPhaseMath.illumination(normalized);
    final waxing = normalized <= 0.5;

    // Base shadow disc.
    canvas.drawOval(
      moonRect,
      Paint()
        ..color = shadowColor
        ..style = PaintingStyle.fill,
    );

    // Soft earthshine only for thinner crescents.
    if (showEarthshine && illumination < 0.4) {
      final alpha = ((0.4 - illumination) / 0.4 * 0.18).clamp(0.0, 0.18);
      canvas.drawOval(
        moonRect,
        Paint()
          ..color = earthshineColor.withValues(alpha: alpha)
          ..style = PaintingStyle.fill,
      );
    }

    canvas.save();
    canvas.clipPath(Path()..addOval(moonRect));

    // Draw the base lit hemisphere.
    final litHalfRect = waxing
        ? Rect.fromLTRB(
            center.dx,
            center.dy - radius,
            center.dx + radius,
            center.dy + radius,
          )
        : Rect.fromLTRB(
            center.dx - radius,
            center.dy - radius,
            center.dx,
            center.dy + radius,
          );
    canvas.drawRect(
      litHalfRect,
      Paint()
        ..color = illuminatedColor
        ..style = PaintingStyle.fill,
    );

    // Draw terminator ellipse to morph crescent <-> quarter <-> gibbous.
    final terminatorWidth =
        (2 * radius * math.cos(2 * math.pi * normalized).abs()).clamp(
          0.0,
          2 * radius,
        );
    if (terminatorWidth > 0) {
      final isCrescent = normalized < 0.25 || normalized > 0.75;
      final terminatorRect = Rect.fromCenter(
        center: center,
        width: terminatorWidth,
        height: 2 * radius,
      );
      canvas.drawOval(
        terminatorRect,
        Paint()
          ..color = isCrescent ? shadowColor : illuminatedColor
          ..style = PaintingStyle.fill,
      );
    }

    canvas.restore();

    if (borderWidth > 0) {
      canvas.drawOval(
        moonRect,
        Paint()
          ..color = borderColor
          ..style = PaintingStyle.stroke
          ..strokeWidth = borderWidth,
      );
    }
  }

  static double _normalizePhase(double input) {
    final phase = input % 1.0;
    return phase < 0 ? phase + 1.0 : phase;
  }

  @override
  bool shouldRepaint(covariant MoonPhasePainter oldDelegate) {
    return oldDelegate.phase != phase ||
        oldDelegate.illuminatedColor != illuminatedColor ||
        oldDelegate.shadowColor != shadowColor ||
        oldDelegate.borderColor != borderColor ||
        oldDelegate.borderWidth != borderWidth ||
        oldDelegate.showEarthshine != showEarthshine ||
        oldDelegate.earthshineColor != earthshineColor;
  }
}

class MoonPhaseMath {
  /// Convert normalized phase into illumination percentage (0..1).
  static double illumination(double phase) {
    final angle = (phase % 1.0) * 2 * math.pi;
    return (1 - math.cos(angle)) / 2;
  }

  /// Estimate a daily phase value from Myanmar daily moon-phase data.
  ///
  /// Inputs are expected from [MyanmarDate]:
  /// - [moonPhase] in `0..3`
  /// - [fortnightDay] in `1..15`
  /// - [monthLength] in `29..30`
  static double phaseFromDailyMyanmarData({
    required int moonPhase,
    required int fortnightDay,
    required int monthLength,
  }) {
    final safeMonthLength = monthLength <= 0 ? 30 : monthLength;
    final safeFortnightDay = fortnightDay.clamp(1, 15);

    switch (moonPhase) {
      case 0: // Waxing
        return (safeFortnightDay / 15.0) * 0.5;
      case 1: // Full moon
        return 0.5;
      case 2: // Waning
        final waningDays = (safeMonthLength - 15).clamp(14, 15);
        return 0.5 + (safeFortnightDay / (waningDays + 1)) * 0.5;
      case 3: // New moon
        return 1.0;
      default:
        return 0.0;
    }
  }
}
