import 'package:flutter/material.dart';
import 'package:myanmar_calendar_dart/myanmar_calendar_dart.dart';

import '../adaptive/mm_chip.dart';
import '../foundation/mm_strings.dart';
import '../foundation/mm_visual_style.dart';
import '../foundation/myanmar_calendar_scope.dart';

/// A holiday as a small chip coloured by its type. Custom holidays get an
/// outline instead of a fill.
class HolidayBadge extends StatelessWidget {
  /// Creates a badge for [holiday].
  const HolidayBadge(this.holiday, {super.key, this.onPressed, this.style});

  /// The holiday.
  final Holiday holiday;

  /// Makes the badge tappable.
  final VoidCallback? onPressed;

  /// Overrides the scope's visual style.
  final MmVisualStyle? style;

  @override
  Widget build(BuildContext context) {
    final theme = MyanmarCalendarScope.themeOf(context);
    return MmChip(
      label: holiday.name,
      color: holiday.isCustom ? theme.accent : theme.holidayColor(holiday.type),
      dot: !holiday.isCustom,
      outlined: holiday.isCustom,
      onPressed: onPressed,
      style: style,
    );
  }
}

/// A day's astrological marks as chips: Sabbath or Sabbath Eve, Yatyaza,
/// Pyathada, and optionally the named astrological days.
class AstroBadges extends StatelessWidget {
  /// Creates badges for [date].
  const AstroBadges({
    required this.date,
    super.key,
    this.includeHolidays = false,
    this.includeAstrologicalDays = true,
    this.style,
  });

  /// The day.
  final CompleteDate date;

  /// Whether to lead with the day's holidays.
  final bool includeHolidays;

  /// Whether to add Thamanyo, Amyeittasote and the other named days.
  final bool includeAstrologicalDays;

  /// Overrides the scope's visual style.
  final MmVisualStyle? style;

  /// Whether [date] has anything these badges would show.
  static bool hasAny(
    CompleteDate date, {
    bool includeHolidays = false,
    bool includeAstrologicalDays = true,
  }) =>
      (includeHolidays && date.holidays.entries.isNotEmpty) ||
      date.astro.sabbath.isNotEmpty ||
      date.astro.yatyaza.isNotEmpty ||
      date.astro.pyathada.isNotEmpty ||
      (includeAstrologicalDays && date.astro.astrologicalDays.isNotEmpty);

  @override
  Widget build(BuildContext context) {
    final theme = MyanmarCalendarScope.themeOf(context);
    final strings = MmStrings.of(MyanmarCalendarScope.of(context).language);
    final astro = date.astro;
    return Wrap(
      spacing: 6,
      runSpacing: 6,
      children: [
        if (includeHolidays)
          for (final h in date.holidays.entries) HolidayBadge(h, style: style),
        if (astro.sabbath.isNotEmpty)
          MmChip(
            label: strings.term(astro.sabbath),
            color: theme.sabbath,
            dot: true,
            style: style,
          ),
        if (astro.yatyaza.isNotEmpty)
          MmChip(label: strings.term(astro.yatyaza), style: style),
        if (astro.pyathada.isNotEmpty)
          MmChip(label: strings.term(astro.pyathada), style: style),
        if (includeAstrologicalDays)
          for (final d in astro.astrologicalDays)
            MmChip(label: strings.term(d), style: style),
      ],
    );
  }
}
