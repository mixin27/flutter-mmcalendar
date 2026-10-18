import 'package:flutter/material.dart';

/// A busy, colourful backdrop, so glass goldens have something to show.
class GoldenWallpaper extends StatelessWidget {
  const GoldenWallpaper({required this.dark, super.key});

  /// Whether to use the dark colours.
  final bool dark;

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        DecoratedBox(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: dark
                  ? const [
                      Color(0xFF2B3480),
                      Color(0xFF0B0C22),
                      Color(0xFF9A4E1C),
                    ]
                  : const [
                      Color(0xFF6F7FE0),
                      Color(0xFFB59BE8),
                      Color(0xFFF0A257),
                    ],
            ),
          ),
        ),
        const Positioned(
          right: 30,
          top: 60,
          child: DecoratedBox(
            decoration: BoxDecoration(
              color: Color(0xFFFFD45C),
              shape: BoxShape.circle,
            ),
            child: SizedBox.square(dimension: 110),
          ),
        ),
        for (var i = 0; i < 14; i++)
          Positioned(
            left: 0,
            right: 0,
            top: 40.0 + i * 62,
            child: Text(
              'Thadingyut 1388  ' * 3,
              maxLines: 1,
              overflow: TextOverflow.clip,
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.w700,
                color: Colors.white.withValues(alpha: 0.35),
              ),
            ),
          ),
      ],
    );
  }
}
