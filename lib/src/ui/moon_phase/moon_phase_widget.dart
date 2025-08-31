import 'package:flutter/material.dart';
import 'package:flutter_mmcalendar/src/ui/moon_phase/moon_painter.dart';

/// A widget that displays the moon phase for a given [DateTime].
///
/// Wraps a [CustomPaint] that uses [MoonPainter] to render the moon.
/// Useful for embedding moon icons in calendar apps, astronomy widgets,
/// or night-sky themed UIs.
///
/// Example:
/// ```dart
/// MoonPhaseWidget(
///   date: DateTime.now(),
///   size: 48,
///   resolution: 120,
///   lightColor: Colors.yellowAccent,
///   darkColor: Colors.black,
/// )
/// ```
class MoonPhaseWidget extends StatelessWidget {
  /// Creates a widget to display the moon phase for the given [date].
  const MoonPhaseWidget({
    super.key,
    required this.date,
    this.size = 36,
    this.resolution = 96,
    this.lightColor = const Color(0xFFF7EAC6),
    this.darkColor = Colors.black87,
  });

  /// The date for which the moon phase should be displayed.
  final DateTime date;

  /// The width and height of the widget.
  final double size;

  /// The rendering resolution for the moon shading.
  final double resolution;

  /// The color of the illuminated part of the moon.
  final Color lightColor;

  /// The color of the dark side of the moon.
  final Color darkColor;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size,
      height: size,
      child: CustomPaint(
        painter: MoonPainter(
          date: date,
          resolution: resolution,
          lightColor: lightColor,
          darkColor: darkColor,
        ),
        size: Size(size, size),
      ),
    );
  }
}
