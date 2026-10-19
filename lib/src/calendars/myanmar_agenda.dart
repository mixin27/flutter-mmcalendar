import 'package:flutter/material.dart';
import 'package:myanmar_calendar_dart/myanmar_calendar_dart.dart';

import '../adaptive/mm_chip.dart';
import '../foundation/language_locale.dart';
import '../foundation/mm_calendar_theme_data.dart';
import '../foundation/mm_strings.dart';
import '../foundation/mm_visual_style.dart';
import '../foundation/myanmar_calendar_scope.dart';
import '../foundation/myanmar_day_data.dart';
import '../foundation/today_builder.dart';
import '../moon/moon_glyph.dart';
import 'calendar_layout.dart';
import 'myanmar_month_calendar.dart';

/// What earns a day a place in a [MyanmarAgenda].
enum MyanmarAgendaItem {
  /// Public, religious, cultural and other holidays.
  holidays,

  /// Myanmar and other anniversary days.
  anniversaries,

  /// Sabbath days (not Sabbath Eve).
  sabbath,

  /// Full and new moons.
  moonDays,

  /// Days with events from the `eventLoader`.
  events,
}

/// Builds the row for one of the app's events.
typedef MyanmarEventBuilder =
    Widget Function(BuildContext context, Object? event);

/// The days from [from] to [to] that have something on them, as a sliver
/// with a pinned header per month. Put it in a `CustomScrollView`, or use
/// [MyanmarAgenda] for a ready-made list.
class MyanmarAgendaSliver extends StatelessWidget {
  /// Creates an agenda sliver.
  const MyanmarAgendaSliver({
    required this.from,
    required this.to,
    super.key,
    this.include = const {...MyanmarAgendaItem.values},
    this.eventLoader,
    this.eventBuilder,
    this.onDayTapped,
    this.style,
    this.clock,
  });

  /// The first day to list.
  final DateTime from;

  /// The last day to list.
  final DateTime to;

  /// What earns a day a place.
  final Set<MyanmarAgendaItem> include;

  /// The app's events per day.
  final MyanmarEventLoader? eventLoader;

  /// Builds an event's row; defaults to its `toString()` in an accent tile.
  final MyanmarEventBuilder? eventBuilder;

  /// Called with a tapped day.
  final ValueChanged<CompleteDate>? onDayTapped;

  /// Overrides the scope's visual style.
  final MmVisualStyle? style;

  /// The current time, for tests.
  final DateTime Function()? clock;

  /// Whether [data] has anything [include] asks for.
  static bool listed(MyanmarDayData data, Set<MyanmarAgendaItem> include) {
    for (final h in data.holidays) {
      final anniversary =
          h.type == HolidayType.myanmarAnniversary ||
          h.type == HolidayType.otherAnniversary;
      if (anniversary && include.contains(MyanmarAgendaItem.anniversaries)) {
        return true;
      }
      if (!anniversary && include.contains(MyanmarAgendaItem.holidays)) {
        return true;
      }
    }
    return (include.contains(MyanmarAgendaItem.sabbath) &&
            data.sabbath == SabbathType.sabbath) ||
        (include.contains(MyanmarAgendaItem.moonDays) && data.isMoonDay) ||
        (include.contains(MyanmarAgendaItem.events) && data.events.isNotEmpty);
  }

  @override
  Widget build(BuildContext context) {
    final scope = MyanmarCalendarScope.of(context);
    final theme = MyanmarCalendarScope.themeOf(context);
    final strings = MmStrings.of(scope.language);

    return TodayBuilder(
      clock: clock,
      builder: (context, today) {
        // Group the listed days by Western month.
        final months = <DateTime, List<MyanmarDayData>>{};
        for (
          var d = DateUtils.dateOnly(from);
          !d.isAfter(to);
          d = CalendarLayout.addDays(d, 1)
        ) {
          final data = MyanmarDayData.resolve(
            date: scope.day(d),
            today: today,
            events: eventLoader?.call(d) ?? const [],
          );
          if (listed(data, include)) {
            (months[DateTime(d.year, d.month)] ??= []).add(data);
          }
        }
        if (months.isEmpty) {
          return SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Text(
                strings.nothingOnTheseDays,
                textAlign: TextAlign.center,
                style: TextStyle(color: theme.muted),
              ),
            ),
          );
        }
        return SliverMainAxisGroup(
          slivers: [
            for (final entry in months.entries)
              SliverMainAxisGroup(
                slivers: [
                  PinnedHeaderSliver(
                    child: _MonthHeader(month: entry.key, scope: scope),
                  ),
                  SliverList.builder(
                    itemCount: entry.value.length,
                    itemBuilder: (context, i) => _AgendaDay(
                      data: entry.value[i],
                      include: include,
                      eventBuilder: eventBuilder,
                      onTap: onDayTapped,
                      theme: theme,
                      language: scope.language,
                    ),
                  ),
                ],
              ),
          ],
        );
      },
    );
  }
}

/// A scrolling list of the days that have holidays, Sabbath, moon days or
/// events, with a pinned header per month.
class MyanmarAgenda extends StatelessWidget {
  /// Lists [days] days from [from] (default: today).
  const MyanmarAgenda({
    super.key,
    this.from,
    this.days = 90,
    this.include = const {...MyanmarAgendaItem.values},
    this.eventLoader,
    this.eventBuilder,
    this.onDayTapped,
    this.controller,
    this.padding,
    this.style,
    this.clock,
  });

  /// The first day; today when `null`.
  final DateTime? from;

  /// How many days to cover.
  final int days;

  /// What earns a day a place.
  final Set<MyanmarAgendaItem> include;

  /// The app's events per day.
  final MyanmarEventLoader? eventLoader;

  /// Builds an event's row.
  final MyanmarEventBuilder? eventBuilder;

  /// Called with a tapped day.
  final ValueChanged<CompleteDate>? onDayTapped;

  /// The list's scroll controller.
  final ScrollController? controller;

  /// Space around the list.
  final EdgeInsetsGeometry? padding;

  /// Overrides the scope's visual style.
  final MmVisualStyle? style;

  /// The current time, for tests.
  final DateTime Function()? clock;

  @override
  Widget build(BuildContext context) {
    final start = DateUtils.dateOnly(from ?? (clock ?? DateTime.now)());
    final sliver = MyanmarAgendaSliver(
      from: start,
      to: CalendarLayout.addDays(start, days - 1),
      include: include,
      eventLoader: eventLoader,
      eventBuilder: eventBuilder,
      onDayTapped: onDayTapped,
      style: style,
      clock: clock,
    );
    return CustomScrollView(
      controller: controller,
      slivers: [
        if (padding == null)
          sliver
        else
          SliverPadding(padding: padding!, sliver: sliver),
      ],
    );
  }
}

class _MonthHeader extends StatelessWidget {
  const _MonthHeader({required this.month, required this.scope});

  final DateTime month;
  final MyanmarCalendarScopeData scope;

  @override
  Widget build(BuildContext context) {
    final theme = MyanmarCalendarScope.themeOf(context);
    final strings = MmStrings.of(scope.language);
    final style = MyanmarCalendarScope.styleOf(context);
    final background = switch (style) {
      MmVisualStyle.glass => theme.surface.withValues(alpha: 0.85),
      _ => theme.surface,
    };
    return Semantics(
      header: true,
      child: ColoredBox(
        color: background,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16, 10, 16, 6),
          child: Text.rich(
            TextSpan(
              children: [
                TextSpan(
                  text: strings.westernMonthYear(month),
                  style: const TextStyle(fontWeight: FontWeight.w700),
                ),
                TextSpan(
                  text: '  ${CalendarLayout.myanmarSpanOfMonth(scope, month)}',
                  style: TextStyle(color: theme.muted, fontSize: 12.5),
                ),
              ],
            ),
            style: theme.textStyle(
              TextStyle(color: theme.accent, fontSize: 14),
              scope.language,
            ),
          ),
        ),
      ),
    );
  }
}

class _AgendaDay extends StatelessWidget {
  const _AgendaDay({
    required this.data,
    required this.include,
    required this.theme,
    required this.language,
    this.eventBuilder,
    this.onTap,
  });

  final MyanmarDayData data;
  final Set<MyanmarAgendaItem> include;
  final MmCalendarThemeData theme;
  final Language language;
  final MyanmarEventBuilder? eventBuilder;
  final ValueChanged<CompleteDate>? onTap;

  @override
  Widget build(BuildContext context) {
    final strings = MmStrings.of(language);
    TextStyle ts(double size, Color c, [FontWeight? w]) => theme.textStyle(
      TextStyle(fontSize: size, color: c, fontWeight: w),
      language,
    );

    final chips = <Widget>[
      for (final h in data.holidays)
        if ((h.type == HolidayType.myanmarAnniversary ||
                h.type == HolidayType.otherAnniversary)
            ? include.contains(MyanmarAgendaItem.anniversaries)
            : include.contains(MyanmarAgendaItem.holidays))
          MmChip(
            label: h.name,
            color: theme.holidayColor(h.type),
            dot: !h.isCustom,
            outlined: h.isCustom,
          ),
      if (include.contains(MyanmarAgendaItem.sabbath) &&
          data.sabbath == SabbathType.sabbath)
        MmChip(
          label: TranslationService.translateTo(
            data.date.astro.sabbath,
            language,
          ),
          color: theme.sabbath,
          dot: true,
        ),
      if (include.contains(MyanmarAgendaItem.moonDays) && data.isMoonDay)
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            MoonGlyph(date: data.myanmar, size: 16),
            const SizedBox(width: 4),
            Text(strings.moonPhase(data.moonPhase), style: ts(12, theme.muted)),
          ],
        ),
    ];
    final events = include.contains(MyanmarAgendaItem.events)
        ? data.events
        : const <Object?>[];

    final row = Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 48,
            child: Column(
              children: [
                Text(
                  language.digits(data.day.day),
                  style: ts(
                    20,
                    data.isToday ? theme.accent : theme.ink,
                    FontWeight.w700,
                  ).copyWith(height: theme.lineHeight(language, 1.1)),
                ),
                Text(
                  strings.weekdayShort(data.day.weekday),
                  style: ts(
                    11,
                    theme.muted,
                  ).copyWith(height: theme.lineHeight(language, 1.2)),
                ),
              ],
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  strings.myanmarDate(data.myanmar),
                  style: ts(12.5, theme.muted),
                ),
                const SizedBox(height: 4),
                Wrap(
                  spacing: 6,
                  runSpacing: 6,
                  crossAxisAlignment: WrapCrossAlignment.center,
                  children: chips,
                ),
                for (final e in events) ...[
                  const SizedBox(height: 6),
                  eventBuilder?.call(context, e) ?? _DefaultEvent(event: e),
                ],
              ],
            ),
          ),
        ],
      ),
    );
    if (onTap == null) return row;
    return Material(
      type: MaterialType.transparency,
      child: InkWell(onTap: () => onTap!(data.date), child: row),
    );
  }
}

class _DefaultEvent extends StatelessWidget {
  const _DefaultEvent({required this.event});

  final Object? event;

  @override
  Widget build(BuildContext context) {
    final theme = MyanmarCalendarScope.themeOf(context);
    final language = MyanmarCalendarScope.of(context).language;
    return DecoratedBox(
      decoration: BoxDecoration(
        color: theme.accentContainer,
        borderRadius: BorderRadius.circular(8),
        border: BorderDirectional(
          start: BorderSide(color: theme.accent, width: 3),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
        child: Text(
          '$event',
          style: theme.textStyle(
            TextStyle(color: theme.ink, fontSize: 13),
            language,
          ),
        ),
      ),
    );
  }
}
