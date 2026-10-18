import 'package:flutter/material.dart';
import 'package:myanmar_calendar_dart/myanmar_calendar_dart.dart';

import '../adaptive/mm_surface.dart';
import '../foundation/language_locale.dart';
import '../foundation/mm_strings.dart';
import '../foundation/mm_visual_style.dart';
import '../foundation/myanmar_calendar_controller.dart';
import '../foundation/myanmar_calendar_scope.dart';
import '../foundation/myanmar_day_data.dart';
import '../foundation/today_builder.dart';
import '../moon/moon_glyph.dart';
import 'myanmar_calendar_header.dart';
import 'myanmar_day_cell.dart';

/// A Myanmar month laid out the way it is counted: the waxing fortnight,
/// 1 to 15 ending on the full moon, then the waning fortnight to the new
/// moon. Watat years show First and Second Waso; late Tagu and late Kason
/// appear where the year has them.
///
/// Each day shows its fortnight day (or the moon) over its Western day.
class MyanmarLunarMonthCalendar extends StatefulWidget {
  /// Creates a lunar month view of Myanmar [year] and [month] (0 is First
  /// Waso, 13 and 14 are late Tagu and late Kason).
  const MyanmarLunarMonthCalendar({
    required this.year,
    required this.month,
    super.key,
    this.controller,
    this.onDayTapped,
    this.onMonthChanged,
    this.showHeader = true,
    this.surface = true,
    this.style,
    this.clock,
  });

  /// Shows the Myanmar month that [day] falls in.
  factory MyanmarLunarMonthCalendar.forDay(
    BuildContext context,
    DateTime day, {
    Key? key,
    MyanmarCalendarController? controller,
    ValueChanged<CompleteDate>? onDayTapped,
  }) {
    final m = MyanmarCalendarScope.of(context).day(day).myanmar;
    return MyanmarLunarMonthCalendar(
      key: key,
      year: m.year,
      month: m.month,
      controller: controller,
      onDayTapped: onDayTapped,
    );
  }

  /// The Myanmar year to show first.
  final int year;

  /// The Myanmar month to show first.
  final int month;

  /// Shows and changes the selection; days are selected through it.
  final MyanmarCalendarController? controller;

  /// Called with the day the user taps.
  final ValueChanged<CompleteDate>? onDayTapped;

  /// Called with the Myanmar year and month that come into view.
  final void Function(int year, int month)? onMonthChanged;

  /// Whether to show the title with previous and next buttons.
  final bool showHeader;

  /// Whether to draw on an [MmSurface].
  final bool surface;

  /// Overrides the scope's visual style.
  final MmVisualStyle? style;

  /// The current time, for tests.
  final DateTime Function()? clock;

  /// The months of Myanmar [year] in calendar order, skipping those the
  /// year doesn't have.
  static List<int> monthsOf(MyanmarCalendarClient client, int year) => [
    for (final m in const [1, 2, 3, 0, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14])
      if (client.getMyanmarMonth(year, m).isNotEmpty) m,
  ];

  /// The Western date of a Myanmar day, from its Julian day number.
  static DateTime westernOf(MyanmarDate date) {
    // Fliegel and Van Flandern's conversion for the Gregorian calendar.
    final j = date.julianDayNumber.round();
    var l = j + 68569;
    final n = (4 * l) ~/ 146097;
    l = l - (146097 * n + 3) ~/ 4;
    final i = (4000 * (l + 1)) ~/ 1461001;
    l = l - (1461 * i) ~/ 4 + 31;
    final k = (80 * l) ~/ 2447;
    final day = l - (2447 * k) ~/ 80;
    l = k ~/ 11;
    final month = k + 2 - 12 * l;
    final year = 100 * (n - 49) + i + l;
    return DateTime(year, month, day);
  }

  @override
  State<MyanmarLunarMonthCalendar> createState() =>
      _MyanmarLunarMonthCalendarState();
}

class _MyanmarLunarMonthCalendarState extends State<MyanmarLunarMonthCalendar> {
  late int _year = widget.year;
  late int _month = widget.month;

  @override
  void initState() {
    super.initState();
    widget.controller?.addListener(_rebuild);
  }

  @override
  void didUpdateWidget(MyanmarLunarMonthCalendar oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.year != oldWidget.year || widget.month != oldWidget.month) {
      _year = widget.year;
      _month = widget.month;
    }
    if (widget.controller != oldWidget.controller) {
      oldWidget.controller?.removeListener(_rebuild);
      widget.controller?.addListener(_rebuild);
    }
  }

  @override
  void dispose() {
    widget.controller?.removeListener(_rebuild);
    super.dispose();
  }

  void _rebuild() => setState(() {});

  void _step(MyanmarCalendarClient client, int delta) {
    var year = _year;
    var months = MyanmarLunarMonthCalendar.monthsOf(client, year);
    var index = months.indexOf(_month) + delta;
    if (index < 0) {
      year--;
      months = MyanmarLunarMonthCalendar.monthsOf(client, year);
      index = months.length - 1;
    } else if (index >= months.length) {
      year++;
      months = MyanmarLunarMonthCalendar.monthsOf(client, year);
      index = 0;
    }
    setState(() {
      _year = year;
      _month = months[index];
    });
    widget.onMonthChanged?.call(_year, _month);
  }

  @override
  Widget build(BuildContext context) {
    final scope = MyanmarCalendarScope.of(context);
    final theme = MyanmarCalendarScope.themeOf(context);
    final strings = MmStrings.of(scope.language);
    final language = scope.language;
    final days = scope.client.getMyanmarMonth(_year, _month);

    final body = TodayBuilder(
      clock: widget.clock,
      builder: (context, today) {
        if (days.isEmpty) return const SizedBox.shrink();
        final first = MyanmarLunarMonthCalendar.westernOf(days.first);
        final last = MyanmarLunarMonthCalendar.westernOf(days.last);
        String short(DateTime d) =>
            '${language.digits(d.day)} '
            '${TranslationService.getShortWesternMonthName(d.month, language)}';
        final span =
            '${short(first)} – ${short(last)} ${language.digits(last.year)}';
        final yearType = TranslationService.getYearTypeName(
          days.first.yearType,
          language,
        );
        final waxing = [
          for (final d in days)
            if (d.phase == MoonPhase.waxing || d.phase == MoonPhase.fullMoon) d,
        ];
        final waning = [
          for (final d in days)
            if (d.phase == MoonPhase.waning || d.phase == MoonPhase.newMoon) d,
        ];

        Widget fortnight(String label, List<MyanmarDate> list) => LayoutBuilder(
          builder: (context, box) {
            final wide = box.maxWidth >= 520;
            final columns = wide ? 15 : 8;
            final labelWidth = wide ? 72.0 : 0.0;
            final cellWidth = (box.maxWidth - labelWidth) / columns;
            final grid = Wrap(
              children: [
                for (final d in list)
                  SizedBox(
                    width: cellWidth,
                    height: cellWidth * 1.15,
                    child: Padding(
                      padding: const EdgeInsets.all(1.5),
                      child: _LunarDay(
                        date: d,
                        western: MyanmarLunarMonthCalendar.westernOf(d),
                        today: today,
                        controller: widget.controller,
                        onTap: widget.onDayTapped,
                      ),
                    ),
                  ),
              ],
            );
            final title = Semantics(
              header: true,
              child: Text(
                label,
                style: theme.textStyle(
                  TextStyle(
                    fontSize: 12.5,
                    fontWeight: FontWeight.w600,
                    color: theme.muted,
                  ),
                  language,
                ),
              ),
            );
            if (!wide) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [title, const SizedBox(height: 4), grid],
              );
            }
            return Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(width: labelWidth, child: title),
                Expanded(child: grid),
              ],
            );
          },
        );

        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisSize: MainAxisSize.min,
          children: [
            if (widget.showHeader)
              MyanmarCalendarHeader(
                title:
                    '${strings.myanmarMonth(_month, days.first.yearType)} '
                    '${language.digits(_year)}',
                subtitle: '$span · $yearType',
                onPrevious: () => _step(scope.client, -1),
                onNext: () => _step(scope.client, 1),
                previousTooltip: strings.previousMonth,
                nextTooltip: strings.nextMonth,
                style: widget.style,
              ),
            const SizedBox(height: 8),
            fortnight(strings.moonPhase(MoonPhase.waxing), waxing),
            const SizedBox(height: 10),
            fortnight(strings.moonPhase(MoonPhase.waning), waning),
          ],
        );
      },
    );
    final padded = Padding(padding: const EdgeInsets.all(14), child: body);
    return widget.surface
        ? MmSurface(style: widget.style, child: padded)
        : padded;
  }
}

class _LunarDay extends StatelessWidget {
  const _LunarDay({
    required this.date,
    required this.western,
    required this.today,
    this.controller,
    this.onTap,
  });

  final MyanmarDate date;
  final DateTime western;
  final DateTime today;
  final MyanmarCalendarController? controller;
  final ValueChanged<CompleteDate>? onTap;

  @override
  Widget build(BuildContext context) {
    final scope = MyanmarCalendarScope.of(context);
    final theme = MyanmarCalendarScope.themeOf(context);
    final language = scope.language;
    final data = MyanmarDayData.resolve(
      date: scope.day(western),
      today: today,
      selection: controller?.selection,
      isSelectable: controller?.isSelectable,
    );
    final selected = data.isSelected;
    final holiday = data.holidays.any(
      (h) => h.type == HolidayType.public || h.type == HolidayType.religious,
    );
    final fg = selected
        ? theme.onAccent
        : holiday
        ? theme.publicHoliday
        : theme.ink;
    final sub = selected ? theme.onAccent.withValues(alpha: 0.85) : theme.muted;
    final tappable = !data.isDisabled && (controller != null || onTap != null);

    void tap() {
      if (controller != null && !controller!.select(western)) return;
      onTap?.call(data.date);
    }

    return Semantics(
      button: tappable,
      selected: selected,
      label: MyanmarDayCell.semanticLabel(data, language),
      excludeSemantics: true,
      onTap: tappable ? tap : null,
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: tappable ? tap : null,
        child: DecoratedBox(
          decoration: BoxDecoration(
            color: selected ? theme.accent : theme.surfaceVariant,
            borderRadius: BorderRadius.circular(8),
            border: data.isToday && !selected
                ? Border.all(color: theme.accent, width: 1.5)
                : null,
          ),
          child: Stack(
            children: [
              Center(
                child: FittedBox(
                  fit: BoxFit.scaleDown,
                  child: Padding(
                    padding: const EdgeInsets.all(2),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        SizedBox(
                          height: 18,
                          child: Center(
                            child: data.isMoonDay
                                ? MoonGlyph(date: date, size: 15)
                                : Text(
                                    language.digits(date.fortnightDay),
                                    style: theme
                                        .textStyle(
                                          TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w600,
                                            color: fg,
                                          ),
                                          language,
                                        )
                                        .copyWith(height: 1.1),
                                  ),
                          ),
                        ),
                        Text(
                          language.digits(western.day),
                          style: theme
                              .textStyle(
                                TextStyle(fontSize: 10, color: sub),
                                language,
                              )
                              .copyWith(height: 1.1),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              if (data.sabbath == SabbathType.sabbath)
                Positioned(
                  left: 6,
                  right: 6,
                  bottom: 2,
                  height: 2,
                  child: ColoredBox(
                    color: selected ? theme.onAccent : theme.sabbath,
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
