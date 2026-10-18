import 'package:flutter/material.dart';
import 'package:myanmar_calendar_dart/myanmar_calendar_dart.dart';

import '../foundation/calendar_selection.dart';
import '../foundation/language_locale.dart';
import '../foundation/mm_calendar_theme_data.dart';
import '../foundation/mm_strings.dart';
import '../foundation/mm_visual_style.dart';
import '../foundation/myanmar_calendar_scope.dart';
import '../foundation/myanmar_day_data.dart';
import '../moon/moon_glyph.dart';

/// What a day cell shows.
enum MyanmarDayCellStyle {
  /// Western day top left, Myanmar day bottom right, equally readable.
  dual,

  /// A large Western day with the Myanmar day under it.
  westernFirst,

  /// A large Myanmar day with the Western day under it.
  lunarFirst,

  /// The Western day and marks only.
  minimal,

  /// A moon for every day, with the Western day under it.
  moon,
}

/// One day in a calendar grid, drawn from [data] in [cellStyle].
///
/// Holidays colour the day and add a dot per holiday type; Sabbath adds a
/// Sabbath dot; full and new moons show a moon; events add accent dots.
class MyanmarDayCell extends StatelessWidget {
  /// Creates a cell.
  const MyanmarDayCell({
    required this.data,
    super.key,
    this.cellStyle = MyanmarDayCellStyle.dual,
    this.onTap,
    this.focused = false,
    this.style,
  });

  /// The day and its state.
  final MyanmarDayData data;

  /// What the cell shows.
  final MyanmarDayCellStyle cellStyle;

  /// Called when the day is tapped; `null` for disabled days.
  final VoidCallback? onTap;

  /// Whether keyboard focus is on this day.
  final bool focused;

  /// Overrides the scope's visual style.
  final MmVisualStyle? style;

  /// What a screen reader says for [data]: the dates, holidays, Sabbath,
  /// events and the cell's state, in [language].
  static String semanticLabel(MyanmarDayData data, Language language) {
    final s = MmStrings.of(language);
    final parts = <String>[
      '${s.weekdayName(data.day.weekday)}, ${s.westernDate(data.day)}',
      s.myanmarDate(data.myanmar),
      ...data.holidays.map((h) => h.name),
      if (data.sabbath != SabbathType.none)
        TranslationService.translateTo(data.date.astro.sabbath, language),
      if (data.events.isNotEmpty) s.eventCount(data.events.length),
      if (data.isToday) s.today,
      switch (data.rangePosition) {
        RangePosition.start => s.rangeStart,
        RangePosition.end => s.rangeEnd,
        RangePosition.middle => s.inRange,
        _ => data.isSelected ? s.selected : '',
      },
      if (data.isDisabled) s.unavailable,
    ];
    return parts.where((p) => p.isNotEmpty).join('. ');
  }

  @override
  Widget build(BuildContext context) {
    final scope = MyanmarCalendarScope.of(context);
    final theme = MyanmarCalendarScope.themeOf(context);
    final style = MyanmarCalendarScope.styleOf(context, this.style);
    final language = scope.language;

    final range = data.rangePosition;
    final filled =
        (data.isSelected && range == RangePosition.none) ||
        range == RangePosition.start ||
        range == RangePosition.end ||
        range == RangePosition.single;
    final band = range == RangePosition.middle;

    final ink = filled
        ? theme.onAccent
        : data.isPublicHoliday
        ? theme.publicHoliday
        : data.holidays.any((h) => h.type == HolidayType.religious)
        ? theme.religiousHoliday
        : data.isToday
        ? theme.accent
        : theme.ink;
    final muted = filled ? theme.onAccent.withValues(alpha: 0.85) : theme.muted;

    final content = _CellContent(
      data: data,
      cellStyle: cellStyle,
      ink: ink,
      muted: muted,
      theme: theme,
      language: language,
      strongToday: data.isToday && !filled,
    );

    final radius = BorderRadius.circular(theme.cellRadius);
    // Material circles the day, except in the dual style, whose corners
    // hold the two dates.
    final round =
        style == MmVisualStyle.material &&
        cellStyle != MyanmarDayCellStyle.dual;
    final Decoration? decoration;
    if (filled) {
      decoration = BoxDecoration(
        color: style == MmVisualStyle.glass
            ? theme.accent.withValues(alpha: 0.85)
            : theme.accent,
        borderRadius: switch (range) {
          RangePosition.start => BorderRadiusDirectional.horizontal(
            start: radius.topLeft,
          ).resolve(Directionality.of(context)),
          RangePosition.end => BorderRadiusDirectional.horizontal(
            end: radius.topLeft,
          ).resolve(Directionality.of(context)),
          _ => round ? BorderRadius.circular(999) : radius,
        },
        boxShadow: style == MmVisualStyle.glass
            ? [
                BoxShadow(
                  color: theme.accent.withValues(alpha: 0.35),
                  blurRadius: 10,
                  offset: const Offset(0, 3),
                ),
              ]
            : null,
      );
    } else if (band) {
      decoration = BoxDecoration(color: theme.accentContainer);
    } else if (data.isToday) {
      decoration = BoxDecoration(
        borderRadius: round ? BorderRadius.circular(999) : radius,
        border: Border.all(color: theme.accent, width: 1.5),
      );
    } else {
      decoration = null;
    }

    Widget cell = DecoratedBox(
      decoration: decoration ?? const BoxDecoration(),
      position: DecorationPosition.background,
      child: content,
    );
    if (focused) {
      cell = DecoratedBox(
        position: DecorationPosition.foreground,
        decoration: BoxDecoration(
          borderRadius: radius,
          border: Border.all(color: theme.accent, width: 2),
        ),
        child: cell,
      );
    }
    final dim = data.isDisabled ? 0.3 : (data.isOutside ? 0.4 : 1.0);
    if (dim < 1) cell = Opacity(opacity: dim, child: cell);
    // In rows much taller than wide, keep the day close to square and
    // centred, so its two dates and its highlight stay together.
    final shaped = cell;
    cell = LayoutBuilder(
      builder: (context, box) {
        final w = box.maxWidth;
        final h = box.maxHeight;
        if (w.isFinite && h.isFinite && h > w * 1.15) {
          return Center(
            child: SizedBox(width: w, height: w * 1.05, child: shaped),
          );
        }
        return shaped;
      },
    );

    return Semantics(
      button: true,
      selected: data.isSelected,
      enabled: !data.isDisabled,
      label: semanticLabel(data, language),
      excludeSemantics: true,
      onTap: onTap,
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: onTap,
        child: cell,
      ),
    );
  }
}

class _CellContent extends StatelessWidget {
  const _CellContent({
    required this.data,
    required this.cellStyle,
    required this.ink,
    required this.muted,
    required this.theme,
    required this.language,
    required this.strongToday,
  });

  final MyanmarDayData data;
  final MyanmarDayCellStyle cellStyle;
  final Color ink;
  final Color muted;
  final MmCalendarThemeData theme;
  final Language language;
  final bool strongToday;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, box) {
        // Type grows with the cell; FittedBox keeps large text from
        // overflowing short rows.
        final side = box.biggest.shortestSide.isFinite
            ? box.biggest.shortestSide
            : 44.0;
        final big = (side * 0.34).clamp(11.0, 26.0);
        final small = (side * 0.22).clamp(8.0, 15.0);
        final moonSize = (side * 0.26).clamp(8.0, 18.0);
        final weight = strongToday ? FontWeight.w700 : FontWeight.w500;
        final western = language.digits(data.day.day);
        final myanmar = data.myanmar;
        final lunar = data.isMoonDay
            ? null
            : language.digits(myanmar.fortnightDay);

        Text text(String s, double size, Color c, [FontWeight? w]) => Text(
          s,
          maxLines: 1,
          style: theme
              .textStyle(
                TextStyle(
                  fontSize: size,
                  color: c,
                  fontWeight: w,
                  height: 1.1,
                  fontFeatures: const [FontFeature.tabularFigures()],
                ),
                language,
              )
              .copyWith(height: 1.1),
        );
        Widget moonGlyph(double s) => MoonGlyph(date: myanmar, size: s);
        final marks = _Marks(
          data: data,
          theme: theme,
          size: (side * 0.1).clamp(3.0, 6.0),
        );

        Widget body;
        switch (cellStyle) {
          case MyanmarDayCellStyle.dual:
            body = Padding(
              padding: EdgeInsets.all(side * 0.08),
              child: Stack(
                children: [
                  Align(
                    alignment: AlignmentDirectional.topStart,
                    child: text(western, big * 0.9, ink, weight),
                  ),
                  Align(
                    alignment: AlignmentDirectional.bottomEnd,
                    child: lunar == null
                        ? moonGlyph(moonSize)
                        : text(lunar, small, muted),
                  ),
                  Align(
                    alignment: AlignmentDirectional.bottomStart,
                    child: marks,
                  ),
                ],
              ),
            );
            return body;
          case MyanmarDayCellStyle.westernFirst:
            body = Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                text(western, big, ink, weight),
                SizedBox(
                  height: small * 1.2,
                  child: Center(
                    child: lunar == null
                        ? moonGlyph(small)
                        : text(lunar, small, muted),
                  ),
                ),
                marks,
              ],
            );
          case MyanmarDayCellStyle.lunarFirst:
            body = Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(
                  height: big * 1.15,
                  child: Center(
                    child: lunar == null
                        ? moonGlyph(big)
                        : text(lunar, big, ink, FontWeight.w600),
                  ),
                ),
                text(western, small, muted, weight),
                marks,
              ],
            );
          case MyanmarDayCellStyle.minimal:
            body = Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                text(western, big, ink, weight),
                const SizedBox(height: 2),
                marks,
              ],
            );
          case MyanmarDayCellStyle.moon:
            body = Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                moonGlyph(big * 0.9),
                const SizedBox(height: 2),
                text(western, small * 1.05, ink, weight),
              ],
            );
        }
        return Center(
          child: FittedBox(fit: BoxFit.scaleDown, child: body),
        );
      },
    );
  }
}

/// Dots for the day's holiday types, Sabbath and events.
class _Marks extends StatelessWidget {
  const _Marks({required this.data, required this.theme, required this.size});

  final MyanmarDayData data;
  final MmCalendarThemeData theme;
  final double size;

  @override
  Widget build(BuildContext context) {
    final colors = <Color>{
      for (final h in data.holidays) theme.holidayColor(h.type),
      if (data.sabbath == SabbathType.sabbath) theme.sabbath,
      if (data.events.isNotEmpty) theme.accent,
    }.take(4);
    return SizedBox(
      height: size,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          for (final c in colors)
            Padding(
              padding: EdgeInsets.symmetric(horizontal: size * 0.2),
              child: DecoratedBox(
                decoration: BoxDecoration(
                  color:
                      data.isSelected &&
                          data.rangePosition != RangePosition.middle
                      ? theme.onAccent
                      : c,
                  shape: BoxShape.circle,
                ),
                child: SizedBox.square(dimension: size),
              ),
            ),
        ],
      ),
    );
  }
}
