import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:myanmar_calendar_dart/myanmar_calendar_dart.dart';

import '../foundation/myanmar_calendar_scope.dart';

/// Which way a [MoonGlyph]'s lit side faces.
enum MoonTilt {
  /// Lit side straight right when waxing and left when waning, as in most
  /// calendars.
  upright(0),

  /// Tilted the way the moon looks from Myanmar, near the tropics: the
  /// evening crescent lies on its back with its lit side low.
  myanmar(45);

  const MoonTilt(this.degrees);

  /// Degrees the lit side turns downward from horizontal.
  final double degrees;
}

/// A drawn moon for a Myanmar day: lit fraction from the day of the
/// fortnight, with the terminator drawn as an ellipse.
class MoonGlyph extends StatelessWidget {
  /// Draws the moon for [date].
  const MoonGlyph({
    required this.date,
    super.key,
    this.size = 24,
    this.tilt = MoonTilt.upright,
    this.earthshine = false,
    this.animate = true,
    this.semanticLabel,
  });

  /// The Myanmar day whose moon to draw.
  final MyanmarDate date;

  /// The glyph's width and height.
  final double size;

  /// Which way the lit side faces.
  final MoonTilt tilt;

  /// Whether the dark part glows faintly, as it does on a thin crescent.
  final bool earthshine;

  /// Whether to animate between phases when [date] changes.
  final bool animate;

  /// Read by screen readers; without it the glyph is decorative.
  final String? semanticLabel;

  /// How lit the moon is on [date], from 0 (new) to 1 (full).
  static double illumination(MyanmarDate date) {
    switch (date.phase) {
      case MoonPhase.fullMoon:
        return 1;
      case MoonPhase.newMoon:
        return 0;
      case MoonPhase.waxing:
        return (date.fortnightDay / 15).clamp(0, 1);
      case MoonPhase.waning:
        final days = math.max(date.monthLength - 15, 1);
        return (1 - date.fortnightDay / days).clamp(0, 1);
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = MyanmarCalendarScope.themeOf(context);
    final waxing =
        date.phase == MoonPhase.waxing || date.phase == MoonPhase.fullMoon;
    final target = illumination(date);
    final reduceMotion = MediaQuery.disableAnimationsOf(context);

    Widget paint(double lit) => CustomPaint(
      size: Size.square(size),
      painter: MoonPainter(
        illumination: lit,
        waxing: waxing,
        tiltDegrees: tilt.degrees,
        lit: theme.moon,
        dark: earthshine
            ? Color.alphaBlend(
                theme.moon.withValues(alpha: 0.14),
                theme.moonShadow,
              )
            : theme.moonShadow,
      ),
    );

    final glyph = animate && !reduceMotion
        ? TweenAnimationBuilder<double>(
            tween: Tween(end: target),
            duration: const Duration(milliseconds: 350),
            curve: Curves.easeOutCubic,
            builder: (_, lit, _) => paint(lit),
          )
        : paint(target);

    return Semantics(
      label: semanticLabel,
      image: semanticLabel != null,
      excludeSemantics: true,
      child: glyph,
    );
  }
}

/// Paints a moon [illumination] lit, on the right when [waxing], turned down
/// by [tiltDegrees].
class MoonPainter extends CustomPainter {
  /// Creates the painter.
  const MoonPainter({
    required this.illumination,
    required this.waxing,
    required this.lit,
    required this.dark,
    this.tiltDegrees = 0,
  });

  /// From 0 (new) to 1 (full).
  final double illumination;

  /// Lit on the right (waxing) or left (waning), before tilting.
  final bool waxing;

  /// The lit colour.
  final Color lit;

  /// The unlit colour.
  final Color dark;

  /// Degrees the lit side turns downward.
  final double tiltDegrees;

  @override
  void paint(Canvas canvas, Size size) {
    final r = size.shortestSide / 2 - 0.5;
    final center = size.center(Offset.zero);
    final f = illumination.clamp(0.0, 1.0);
    canvas
      ..save()
      ..translate(center.dx, center.dy);

    if (f <= 0.015) {
      canvas.drawCircle(
        Offset.zero,
        r - 0.6,
        Paint()
          ..style = PaintingStyle.stroke
          ..strokeWidth = math.max(1, r * 0.12)
          ..color = lit,
      );
      canvas.restore();
      return;
    }
    if (f >= 0.985) {
      canvas
        ..drawCircle(Offset.zero, r, Paint()..color = lit)
        ..restore();
      return;
    }

    // Draw with the lit side towards +x, then turn it into place: right and
    // down for waxing, left and down for waning.
    final tilt = tiltDegrees * math.pi / 180;
    canvas.rotate(waxing ? tilt : math.pi - tilt);
    canvas.drawCircle(Offset.zero, r, Paint()..color = dark);

    final rx = (1 - 2 * f).abs() * r;
    final top = Offset(0, -r);
    final bottom = Offset(0, r);
    final path = Path()
      ..moveTo(top.dx, top.dy)
      // The lit half-disc's edge.
      ..arcToPoint(bottom, radius: Radius.circular(r))
      // Back along the terminator: bulging right (a crescent) under half
      // lit, left (gibbous) over half.
      ..arcToPoint(
        top,
        radius: Radius.elliptical(math.max(rx, 0.01), r),
        clockwise: f > 0.5,
      )
      ..close();
    canvas
      ..drawPath(path, Paint()..color = lit)
      ..restore();
  }

  @override
  bool shouldRepaint(MoonPainter old) =>
      old.illumination != illumination ||
      old.waxing != waxing ||
      old.lit != lit ||
      old.dark != dark ||
      old.tiltDegrees != tiltDegrees;
}
