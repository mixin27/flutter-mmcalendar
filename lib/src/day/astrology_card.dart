import 'dart:math' as math;

import 'package:flutter/material.dart';

import '../adaptive/mm_list.dart';
import '../adaptive/mm_surface.dart';
import '../foundation/mm_calendar_theme_data.dart';
import '../foundation/mm_strings.dart';
import '../foundation/mm_visual_style.dart';
import '../foundation/myanmar_calendar_scope.dart';
import 'day_badges.dart';
import 'day_builder.dart';

/// A day's astrology: the Sabbath, Yatyaza and Pyathada badges and the named
/// days, then mahabote, nakhat, the year name and nagahle, with the core
/// library's descriptions.
///
/// The descriptions are English in myanmar_calendar_dart 3.0; the names are
/// translated.
class AstrologyCard extends StatelessWidget {
  /// Creates a card for [date], or today.
  const AstrologyCard({
    super.key,
    this.date,
    this.showDescriptions = true,
    this.style,
    this.clock,
  });

  /// The day; today when null.
  final DateTime? date;

  /// Whether to show the mahabote and nakhat descriptions.
  final bool showDescriptions;

  /// Overrides the scope's visual style.
  final MmVisualStyle? style;

  /// The current time, for tests.
  final DateTime Function()? clock;

  @override
  Widget build(BuildContext context) {
    final scope = MyanmarCalendarScope.of(context);
    final theme = MyanmarCalendarScope.themeOf(context);
    final strings = MmStrings.of(scope.language);

    return DayBuilder(
      date: date,
      clock: clock,
      builder: (context, day, _) {
        final astro = day.astro;
        final client = scope.client;
        Widget? description(String text) => showDescriptions && text.isNotEmpty
            ? Text(
                text,
                locale: const Locale('en'),
                style: TextStyle(color: theme.muted, fontSize: 12.5),
              )
            : null;

        MmListRow row(String label, String value, [String? about]) => MmListRow(
          title: Text(value),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [Text(label), ?description(about ?? '')],
          ),
          style: style,
        );

        return DefaultTextStyle.merge(
          style: theme.textStyle(const TextStyle(), scope.language),
          child: MmListGroup(
            header: strings.astrology,
            style: style,
            children: [
              if (AstroBadges.hasAny(day))
                MmListRow(
                  title: AstroBadges(date: day, style: style),
                  style: style,
                ),
              row(
                strings.term('Mahabote'),
                strings.term(astro.mahabote),
                client.getMahaboteCharacteristics(astro.mahabote),
              ),
              row(
                strings.term('Nakhat'),
                strings.term(astro.nakhat),
                client.getNakhatDescription(astro.nakhat),
              ),
              row(strings.term('Year Name'), strings.term(astro.yearName)),
              MmListRow(
                leading: NagahleCompass.forDirection(
                  astro.nagahle,
                  size: 40,
                  showLabels: false,
                ),
                title: Text(strings.term(astro.nagahle)),
                subtitle: Text(strings.term('Naga Head')),
                style: style,
              ),
            ],
          ),
        );
      },
    );
  }
}

/// Which way the dragon's head (nagahle) turns in a day's month, drawn as a
/// compass with the dragon pointing that way.
class NagahleCompass extends StatelessWidget {
  /// Draws the compass for [date]'s month, or today's.
  const NagahleCompass({
    super.key,
    this.date,
    this.size = 150,
    this.showLabels = true,
    this.surface = false,
    this.clock,
  }) : direction = null;

  /// Draws the compass pointing at [direction]: "East", "South", "West" or
  /// "North", as the core library names it.
  const NagahleCompass.forDirection(
    String this.direction, {
    super.key,
    this.size = 150,
    this.showLabels = true,
    this.surface = false,
  }) : date = null,
       clock = null;

  /// The day; today when null.
  final DateTime? date;

  /// A fixed direction instead of a day's.
  final String? direction;

  /// The compass's width and height.
  final double size;

  /// Whether to letter the four directions.
  final bool showLabels;

  /// Whether to draw the compass on an [MmSurface] with its caption.
  final bool surface;

  /// The current time, for tests.
  final DateTime Function()? clock;

  /// Radians clockwise from north for a direction name.
  static double angleOf(String direction) => switch (direction) {
    'East' => math.pi / 2,
    'South' => math.pi,
    'West' => 3 * math.pi / 2,
    _ => 0,
  };

  @override
  Widget build(BuildContext context) {
    final theme = MyanmarCalendarScope.themeOf(context);
    final language = MyanmarCalendarScope.of(context).language;
    final strings = MmStrings.of(language);

    Widget compass(String dir) {
      // English uses N, E, S, W; other scripts need the whole word (East and
      // West both start with the same letter in Myanmar).
      final letters = [
        for (final d in const ['North', 'East', 'South', 'West'])
          language.code == 'en' ? d.substring(0, 1) : strings.term(d),
      ];
      final drawing = Semantics(
        image: true,
        label: '${strings.term('Naga Head')}: ${strings.term(dir)}',
        child: CustomPaint(
          size: Size.square(size),
          painter: _CompassPainter(
            angle: angleOf(dir),
            theme: theme,
            letters: showLabels ? letters : null,
            textStyle: theme.textStyle(
              DefaultTextStyle.of(context).style,
              language,
            ),
          ),
        ),
      );
      if (!surface) return drawing;
      return MmSurface(
        padding: const EdgeInsets.all(16),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            drawing,
            const SizedBox(width: 16),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  strings.term('Naga Head'),
                  style: TextStyle(color: theme.muted, fontSize: 12.5),
                ),
                Text(
                  strings.term(dir),
                  style: TextStyle(
                    color: theme.ink,
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
          ],
        ),
      );
    }

    if (direction != null) return compass(direction!);
    return DayBuilder(
      date: date,
      clock: clock,
      builder: (context, day, _) => compass(day.astro.nagahle),
    );
  }
}

class _CompassPainter extends CustomPainter {
  _CompassPainter({
    required this.angle,
    required this.theme,
    required this.textStyle,
    this.letters,
  });

  final double angle;
  final TextStyle textStyle;
  final MmCalendarThemeData theme;
  final List<String>? letters;

  @override
  void paint(Canvas canvas, Size size) {
    final c = size.center(Offset.zero);
    final r = size.shortestSide / 2;
    final ring = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = math.max(1, r * 0.03)
      ..color = theme.outline;
    canvas.drawCircle(c, r * 0.94, ring);

    // Ticks at the four directions.
    for (var i = 0; i < 4; i++) {
      final a = i * math.pi / 2;
      final dir = Offset(math.sin(a), -math.cos(a));
      canvas.drawLine(
        c + dir * r * 0.84,
        c + dir * r * 0.94,
        ring..color = theme.muted.withValues(alpha: 0.6),
      );
    }

    final labels = letters;
    if (labels != null) {
      for (var i = 0; i < 4; i++) {
        final a = i * math.pi / 2;
        final pos = c + Offset(math.sin(a), -math.cos(a)) * r * 0.72;
        final tp = TextPainter(
          text: TextSpan(
            text: labels[i],
            style: textStyle.copyWith(
              height: 1,
              color: theme.muted,
              fontSize: r * (labels[i].length > 1 ? 0.12 : 0.16),
              fontWeight: FontWeight.w600,
            ),
          ),
          textDirection: TextDirection.ltr,
        )..layout();
        tp.paint(canvas, pos - Offset(tp.width / 2, tp.height / 2));
      }
    }

    // The dragon: a curved body ending in a head that points at [angle].
    canvas
      ..save()
      ..translate(c.dx, c.dy)
      ..rotate(angle);
    final body = Path()
      ..moveTo(0, r * 0.42)
      ..cubicTo(-r * 0.26, r * 0.18, r * 0.26, -r * 0.06, 0, -r * 0.26);
    canvas.drawPath(
      body,
      Paint()
        ..style = PaintingStyle.stroke
        ..strokeWidth = r * 0.11
        ..strokeCap = StrokeCap.round
        ..color = theme.accent,
    );
    // The head stops short of the letters, so the one it points at shows.
    final head = Path()
      ..moveTo(0, -r * 0.56)
      ..lineTo(r * 0.14, -r * 0.26)
      ..lineTo(-r * 0.14, -r * 0.26)
      ..close();
    canvas
      ..drawPath(head, Paint()..color = theme.accent)
      ..drawCircle(
        Offset(0, -r * 0.36),
        math.max(1.2, r * 0.035),
        Paint()..color = theme.onAccent,
      )
      ..restore();
  }

  @override
  bool shouldRepaint(_CompassPainter old) =>
      old.angle != angle ||
      old.theme != theme ||
      old.textStyle != textStyle ||
      old.letters != letters;
}
