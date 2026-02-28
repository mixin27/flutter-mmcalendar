// ignore_for_file: public_member_api_docs

import 'package:flutter/material.dart';
import 'package:myanmar_calendar_dart/myanmar_calendar_dart.dart';

import 'moon_phase_painter.dart';
import 'moon_phase_view.dart';

/// High-level widget that renders moon phase from daily Myanmar moon data.
class DailyMoonPhaseWidget extends StatelessWidget {
  const DailyMoonPhaseWidget({
    super.key,
    required this.myanmarDate,
    this.language = Language.english,
    this.size = 42,
    this.showLabel = false,
    this.showIllumination = false,
    this.labelStyle,
    this.gap = 6,
    this.animate = false,
    this.animationDuration = const Duration(milliseconds: 240),
    this.illuminatedColor = const Color(0xFFFFF7CC),
    this.shadowColor = const Color(0xFF1E293B),
    this.borderColor = const Color(0xFF0F172A),
    this.borderWidth = 1,
  });

  factory DailyMoonPhaseWidget.fromCompleteDate(
    CompleteDate date, {
    Key? key,
    Language language = Language.english,
    double size = 42,
    bool showLabel = false,
    bool showIllumination = false,
    TextStyle? labelStyle,
    double gap = 6,
    bool animate = false,
    Duration animationDuration = const Duration(milliseconds: 240),
    Color illuminatedColor = const Color(0xFFFFF7CC),
    Color shadowColor = const Color(0xFF1E293B),
    Color borderColor = const Color(0xFF0F172A),
    double borderWidth = 1,
  }) {
    return DailyMoonPhaseWidget(
      key: key,
      myanmarDate: date.myanmar,
      language: language,
      size: size,
      showLabel: showLabel,
      showIllumination: showIllumination,
      labelStyle: labelStyle,
      gap: gap,
      animate: animate,
      animationDuration: animationDuration,
      illuminatedColor: illuminatedColor,
      shadowColor: shadowColor,
      borderColor: borderColor,
      borderWidth: borderWidth,
    );
  }

  final MyanmarDate myanmarDate;
  final Language language;
  final double size;
  final bool showLabel;
  final bool showIllumination;
  final TextStyle? labelStyle;
  final double gap;
  final bool animate;
  final Duration animationDuration;
  final Color illuminatedColor;
  final Color shadowColor;
  final Color borderColor;
  final double borderWidth;

  double get phase {
    return MoonPhaseMath.phaseFromDailyMyanmarData(
      moonPhase: myanmarDate.moonPhase,
      fortnightDay: myanmarDate.fortnightDay,
      monthLength: myanmarDate.monthLength,
    );
  }

  double get illumination => MoonPhaseMath.illumination(phase);

  String get phaseName {
    return TranslationService.getMoonPhaseName(myanmarDate.moonPhase, language);
  }

  @override
  Widget build(BuildContext context) {
    final semanticLabel =
        '$phaseName, day ${myanmarDate.fortnightDay}, '
        '${(illumination * 100).round()} percent illuminated';

    final moon = MoonPhaseView(
      phase: phase,
      size: size,
      animate: animate,
      animationDuration: animationDuration,
      illuminatedColor: illuminatedColor,
      shadowColor: shadowColor,
      borderColor: borderColor,
      borderWidth: borderWidth,
      semanticLabel: semanticLabel,
    );

    final lines = <String>[];
    if (showLabel) {
      lines.add(phaseName);
    }
    if (showIllumination) {
      lines.add('${(illumination * 100).round()}%');
    }

    if (lines.isEmpty) {
      return moon;
    }

    final effectiveStyle =
        labelStyle ??
        Theme.of(context).textTheme.labelSmall ??
        const TextStyle();

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        moon,
        SizedBox(height: gap),
        Text(
          lines.join(' • '),
          style: effectiveStyle,
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
