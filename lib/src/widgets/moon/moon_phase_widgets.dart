import 'package:flutter/material.dart';
import 'package:flutter_mmcalendar/src/core/myanmar_date_time.dart';

import 'moon_phase_painter.dart';

/// Reusable moon phase widget.
class MoonPhaseProgressWidget extends StatelessWidget {
  /// Date to show moon phase.
  final DateTime date;

  /// Width for widget.
  final double? width;

  /// Height for widget.
  final double? height;

  /// Background color for widget.
  final Color? backgroundColor;

  /// Foreground color for widget.
  final Color? foregroundColor;

  /// Create a new moon phase progress widget
  const MoonPhaseProgressWidget({
    super.key,
    required this.date,
    this.width,
    this.height,
    this.backgroundColor,
    this.foregroundColor,
  });

  @override
  Widget build(BuildContext context) {
    final completeDate = MyanmarDateTime.fromDateTime(date).completeDate;

    return Container(
      width: width ?? 80,
      height: width ?? 80,
      decoration: BoxDecoration(
        color: backgroundColor ?? Theme.of(context).colorScheme.surface,
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
            color:
                foregroundColor ??
                Theme.of(context).colorScheme.primary.withValues(alpha: 0.3),
            blurRadius: 10,
            spreadRadius: 2,
          ),
        ],
      ),
      child: CustomPaint(
        painter: DetailedMoonPhasePainter(
          moonPhase: completeDate.moonPhase,
          fortnightDay: completeDate.fortnightDay,
          color: foregroundColor ?? Theme.of(context).colorScheme.primary,
        ),
      ),
    );
  }
}

/// Moon phase widget like indicator.
class MoonPhaseIndicator extends StatelessWidget {
  /// Date to show moon phase.
  final DateTime date;

  /// Width for widget.
  final double? width;

  /// Height for widget.
  final double? height;

  /// Background color for widget.
  final Color? backgroundColor;

  /// Foreground color for widget.
  final Color? foregroundColor;

  /// Create a new moon phase indicator
  const MoonPhaseIndicator({
    super.key,
    required this.date,
    this.width,
    this.height,
    this.backgroundColor,
    this.foregroundColor,
  });

  @override
  Widget build(BuildContext context) {
    final completeDate = MyanmarDateTime.fromDateTime(date).completeDate;

    return Container(
      width: width ?? 60,
      height: width ?? 60,
      decoration: BoxDecoration(
        color:
            backgroundColor ??
            Theme.of(context).colorScheme.surface.withValues(alpha: 0.2),
        shape: BoxShape.circle,
      ),
      child: CustomPaint(
        painter: MoonPhasePainter(
          moonPhase: completeDate.moonPhase,
          fortnightDay: completeDate.fortnightDay,
          color:
              foregroundColor ??
              Theme.of(context).colorScheme.onPrimaryContainer,
        ),
      ),
    );
  }
}
