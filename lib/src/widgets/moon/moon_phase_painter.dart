import 'dart:math' as math;

import 'package:flutter/material.dart';

/// Simple moon phase painter for the app bar
class MoonPhasePainter extends CustomPainter {
  final int moonPhase;
  final int fortnightDay;
  final Color color;

  MoonPhasePainter({
    required this.moonPhase,
    required this.fortnightDay,
    required this.color,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = math.min(size.width, size.height) / 3;

    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;

    final shadowPaint = Paint()
      ..color = color.withValues(alpha: 0.3)
      ..style = PaintingStyle.fill;

    // Draw moon circle
    canvas.drawCircle(center, radius, shadowPaint);

    // Draw moon phase based on type
    switch (moonPhase) {
      case 0: // Waxing - right side illuminated
        final rect = Rect.fromCircle(center: center, radius: radius);
        final path = Path()..addArc(rect, -math.pi / 2, math.pi);
        canvas.drawPath(path, paint);
        break;

      case 1: // Full Moon - completely illuminated
        canvas.drawCircle(center, radius, paint);
        break;

      case 2: // Waning - left side illuminated
        final rect = Rect.fromCircle(center: center, radius: radius);
        final path = Path()..addArc(rect, math.pi / 2, math.pi);
        canvas.drawPath(path, paint);
        break;

      case 3: // New Moon - not illuminated (just shadow)
        break;
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}

/// Detailed moon phase painter for the main section
class DetailedMoonPhasePainter extends CustomPainter {
  final int moonPhase;
  final int fortnightDay;
  final Color color;

  DetailedMoonPhasePainter({
    required this.moonPhase,
    required this.fortnightDay,
    required this.color,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = math.min(size.width, size.height) / 2.5;

    final moonPaint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;

    final shadowPaint = Paint()
      ..color = color.withValues(alpha: 0.2)
      ..style = PaintingStyle.fill;

    final borderPaint = Paint()
      ..color = color.withValues(alpha: 0.5)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2;

    // Draw moon shadow/base
    canvas.drawCircle(center, radius, shadowPaint);
    canvas.drawCircle(center, radius, borderPaint);

    // Calculate illumination based on fortnight day
    final illuminationPercent = _calculateIllumination();

    // Draw illuminated part
    if (illuminationPercent > 0) {
      switch (moonPhase) {
        case 0: // Waxing
          _drawWaxingMoon(
            canvas,
            center,
            radius,
            illuminationPercent,
            moonPaint,
          );
          break;
        case 1: // Full Moon
          canvas.drawCircle(center, radius, moonPaint);
          break;
        case 2: // Waning
          _drawWaningMoon(
            canvas,
            center,
            radius,
            illuminationPercent,
            moonPaint,
          );
          break;
        case 3: // New Moon
          // No illumination
          break;
      }
    }

    // Add subtle glow effect
    if (moonPhase == 1) {
      final glowPaint = Paint()
        ..color = color.withValues(alpha: 0.1)
        ..style = PaintingStyle.fill;
      canvas.drawCircle(center, radius * 1.3, glowPaint);
    }
  }

  double _calculateIllumination() {
    switch (moonPhase) {
      case 0: // Waxing
        return fortnightDay / 15.0;
      case 1: // Full Moon
        return 1.0;
      case 2: // Waning
        return (15 - fortnightDay) / 15.0;
      case 3: // New Moon
        return 0.0;
      default:
        return 0.5;
    }
  }

  void _drawWaxingMoon(
    Canvas canvas,
    Offset center,
    double radius,
    double percent,
    Paint paint,
  ) {
    final rect = Rect.fromCircle(center: center, radius: radius);
    final sweepAngle = math.pi * 2 * percent;
    final path = Path()
      ..addArc(rect, -math.pi / 2, sweepAngle)
      ..lineTo(center.dx, center.dy);
    canvas.drawPath(path, paint);
  }

  void _drawWaningMoon(
    Canvas canvas,
    Offset center,
    double radius,
    double percent,
    Paint paint,
  ) {
    final rect = Rect.fromCircle(center: center, radius: radius);
    final sweepAngle = math.pi * 2 * percent;
    final path = Path()
      ..addArc(rect, math.pi / 2, sweepAngle)
      ..lineTo(center.dx, center.dy);
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}

/// Moon phase information data class
class MoonPhaseInfo {
  final String name;
  final String emoji;
  final Color color;
  final String description;

  const MoonPhaseInfo({
    required this.name,
    required this.emoji,
    required this.color,
    required this.description,
  });
}
