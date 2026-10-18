import 'package:flutter/material.dart';
import 'package:myanmar_calendar_dart/myanmar_calendar_dart.dart';

import '../adaptive/mm_pressable.dart';
import '../adaptive/mm_surface.dart';
import '../foundation/language_locale.dart';
import '../foundation/mm_strings.dart';
import '../foundation/mm_visual_style.dart';
import '../foundation/myanmar_calendar_controller.dart';
import '../foundation/myanmar_calendar_scope.dart';
import '../foundation/myanmar_day_data.dart';
import '../foundation/today_builder.dart';
import '../moon/moon_glyph.dart';
import 'calendar_layout.dart';
import 'myanmar_day_cell.dart';

/// One week in a row that pages by swiping, for app headers and agenda
/// pages. Each day shows its weekday, Western day, and Myanmar day or moon.
///
/// It follows the controller's selection: selecting a day elsewhere brings
/// its week into view.
class MyanmarWeekStrip extends StatefulWidget {
  /// Creates a week strip.
  const MyanmarWeekStrip({
    super.key,
    this.controller,
    this.firstDayOfWeek,
    this.onDayTapped,
    this.surface = true,
    this.height = 78,
    this.style,
    this.clock,
  });

  /// The selection to show and change; a single-selection controller when
  /// `null`.
  final MyanmarCalendarController? controller;

  /// The first day of each week; `null` uses the scope's.
  final int? firstDayOfWeek;

  /// Called with the day the user taps, if it is selectable.
  final ValueChanged<CompleteDate>? onDayTapped;

  /// Whether to draw the strip on an [MmSurface].
  final bool surface;

  /// The strip's height.
  final double height;

  /// Overrides the scope's visual style.
  final MmVisualStyle? style;

  /// The current time, for tests.
  final DateTime Function()? clock;

  @override
  State<MyanmarWeekStrip> createState() => _MyanmarWeekStripState();
}

class _MyanmarWeekStripState extends State<MyanmarWeekStrip> {
  // Page 0 is the week of 1 Jan 1900; weeks run to 2200.
  static final DateTime _origin = DateTime(1900);
  static const int _pageCount = 300 * 53;

  MyanmarCalendarController? _own;
  PageController? _pages;
  int _firstDay = DateTime.sunday;

  MyanmarCalendarController get _controller =>
      widget.controller ?? (_own ??= MyanmarCalendarController());

  DateTime get _originWeek => CalendarLayout.weekStart(_origin, _firstDay);

  int _pageOf(DateTime day) {
    final start = CalendarLayout.weekStart(day, _firstDay);
    final utc = DateTime.utc(start.year, start.month, start.day);
    final o = _originWeek;
    return utc.difference(DateTime.utc(o.year, o.month, o.day)).inDays ~/ 7;
  }

  DateTime _weekAt(int page) => CalendarLayout.addDays(_originWeek, page * 7);

  DateTime get _anchor =>
      _controller.selection.days.firstOrNull ??
      (widget.clock ?? DateTime.now)();

  @override
  void initState() {
    super.initState();
    _controller.addListener(_onController);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final firstDay =
        widget.firstDayOfWeek ??
        MyanmarCalendarScope.of(context).firstDayOfWeek;
    if (_pages == null || firstDay != _firstDay) {
      _firstDay = firstDay;
      _pages?.dispose();
      _pages = PageController(initialPage: _pageOf(_anchor));
    }
  }

  @override
  void dispose() {
    _controller.removeListener(_onController);
    _own?.dispose();
    _pages?.dispose();
    super.dispose();
  }

  void _onController() {
    final target = _pageOf(_anchor);
    final pages = _pages!;
    if (pages.hasClients && pages.page?.round() != target) {
      if (MediaQuery.disableAnimationsOf(context)) {
        pages.jumpToPage(target);
      } else {
        pages.animateToPage(
          target,
          duration: const Duration(milliseconds: 280),
          curve: Curves.easeOutCubic,
        );
      }
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final scope = MyanmarCalendarScope.of(context);
    final strings = MmStrings.of(scope.language);
    final style = MyanmarCalendarScope.styleOf(context, widget.style);

    final strip = TodayBuilder(
      clock: widget.clock,
      builder: (context, today) => SizedBox(
        height: widget.height,
        child: PageView.builder(
          controller: _pages,
          itemCount: _pageCount,
          itemBuilder: (context, page) {
            final start = _weekAt(page);
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 6),
              child: Row(
                children: [
                  for (var i = 0; i < 7; i++)
                    Expanded(
                      child: _day(
                        CalendarLayout.addDays(start, i),
                        today,
                        scope,
                        strings,
                        style,
                      ),
                    ),
                ],
              ),
            );
          },
        ),
      ),
    );
    return widget.surface
        ? MmSurface(style: widget.style, child: strip)
        : strip;
  }

  Widget _day(
    DateTime day,
    DateTime today,
    MyanmarCalendarScopeData scope,
    MmStrings strings,
    MmVisualStyle style,
  ) {
    final data = MyanmarDayData.resolve(
      date: scope.day(day),
      today: today,
      selection: _controller.selection,
      isSelectable: _controller.isSelectable,
    );
    final t = MyanmarCalendarScope.themeOf(context);
    final selected = data.isSelected;
    final fg = selected
        ? t.onAccent
        : data.isPublicHoliday
        ? t.publicHoliday
        : data.isToday
        ? t.accent
        : t.ink;
    final sub = selected ? t.onAccent.withValues(alpha: 0.85) : t.muted;
    final language = scope.language;
    TextStyle ts(double size, Color c, [FontWeight? w]) => t
        .textStyle(TextStyle(fontSize: size, color: c, fontWeight: w), language)
        .copyWith(height: 1.15);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 2),
      child: MmPressable(
        onPressed: data.isDisabled
            ? null
            : () {
                if (_controller.select(day)) {
                  widget.onDayTapped?.call(data.date);
                }
              },
        semanticLabel: MyanmarDayCell.semanticLabel(data, language),
        selected: selected,
        borderRadius: BorderRadius.circular(14),
        focusColor: t.accent,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 180),
          decoration: BoxDecoration(
            color: selected
                ? t.accent.withValues(
                    alpha: style == MmVisualStyle.glass ? 0.85 : 1,
                  )
                : null,
            borderRadius: BorderRadius.circular(
              style == MmVisualStyle.material ? 999 : 14,
            ),
            border: data.isToday && !selected
                ? Border.all(color: t.accent, width: 1.5)
                : null,
          ),
          child: FittedBox(
            fit: BoxFit.scaleDown,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 2),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(strings.weekdayShort(day.weekday), style: ts(11, sub)),
                  Text(
                    language.digits(day.day),
                    style: ts(
                      17,
                      fg,
                      data.isToday ? FontWeight.w700 : FontWeight.w600,
                    ),
                  ),
                  SizedBox(
                    height: 14,
                    child: Center(
                      child: data.isMoonDay
                          ? MoonGlyph(date: data.myanmar, size: 11)
                          : Text(
                              language.digits(data.myanmar.fortnightDay),
                              style: ts(10, sub),
                            ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
