import 'package:flutter/material.dart';

import 'moon_painter.dart';

/// Moon phase widget for showing angles between `new moon` and `full moon`.
class MoonPhaseWidget extends StatelessWidget {
  const MoonPhaseWidget({
    super.key,
    required this.date,
    this.size = 36,
    this.resolution = 96,
    this.lightColor = const Color(0xFFF7EAC6),
    this.darkColor = Colors.black87,
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

  @override
  Widget build(BuildContext context) {
    final scale = size / (resolution * 2);

    return SizedBox(
      width: size,
      height: size,
      child: Center(
        child: Transform.scale(
          scale: scale,
          child: CustomPaint(
            painter: MoonPainter(
              date: date,
              size: size,
              resolution: resolution,
              lightColor: lightColor,
              darkColor: darkColor,
            ),
          ),
        ),
      ),
    );
  }
}
