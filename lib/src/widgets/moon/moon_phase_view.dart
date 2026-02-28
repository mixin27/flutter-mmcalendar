// ignore_for_file: public_member_api_docs

import 'package:flutter/material.dart';

import 'moon_phase_painter.dart';

/// Generic reusable moon phase widget for any use case.
class MoonPhaseView extends StatefulWidget {
  const MoonPhaseView({
    super.key,
    required this.phase,
    this.size = 40,
    this.padding,
    this.animate = false,
    this.animationDuration = const Duration(milliseconds: 240),
    this.illuminatedColor = const Color(0xFFFFF7CC),
    this.shadowColor = const Color(0xFF1E293B),
    this.borderColor = const Color(0xFF0F172A),
    this.borderWidth = 1,
    this.showEarthshine = true,
    this.earthshineColor = const Color(0xFF93C5FD),
    this.semanticLabel,
  });

  /// Normalized moon phase in the range `0..1`.
  final double phase;
  final double size;
  final EdgeInsetsGeometry? padding;
  final bool animate;
  final Duration animationDuration;
  final Color illuminatedColor;
  final Color shadowColor;
  final Color borderColor;
  final double borderWidth;
  final bool showEarthshine;
  final Color earthshineColor;
  final String? semanticLabel;

  @override
  State<MoonPhaseView> createState() => _MoonPhaseViewState();
}

class _MoonPhaseViewState extends State<MoonPhaseView> {
  late double _fromPhase;

  @override
  void initState() {
    super.initState();
    _fromPhase = widget.phase;
  }

  @override
  void didUpdateWidget(covariant MoonPhaseView oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.phase != oldWidget.phase) {
      _fromPhase = oldWidget.phase;
    }
  }

  @override
  Widget build(BuildContext context) {
    final content = widget.animate
        ? TweenAnimationBuilder<double>(
            tween: Tween<double>(begin: _fromPhase, end: widget.phase),
            duration: widget.animationDuration,
            onEnd: () {
              _fromPhase = widget.phase;
            },
            builder: (BuildContext context, double value, Widget? child) {
              return _paintedMoon(value);
            },
          )
        : _paintedMoon(widget.phase);

    final padded = widget.padding == null
        ? content
        : Padding(padding: widget.padding!, child: content);

    return Semantics(label: widget.semanticLabel, image: true, child: padded);
  }

  Widget _paintedMoon(double phase) {
    return SizedBox(
      width: widget.size,
      height: widget.size,
      child: CustomPaint(
        painter: MoonPhasePainter(
          phase: phase,
          illuminatedColor: widget.illuminatedColor,
          shadowColor: widget.shadowColor,
          borderColor: widget.borderColor,
          borderWidth: widget.borderWidth,
          showEarthshine: widget.showEarthshine,
          earthshineColor: widget.earthshineColor,
        ),
      ),
    );
  }
}
