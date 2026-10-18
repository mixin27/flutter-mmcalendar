import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:myanmar_calendar_dart/myanmar_calendar_dart.dart';

import '../adaptive/mm_surface.dart';
import '../foundation/calendar_selection.dart';
import '../foundation/mm_strings.dart';
import '../foundation/mm_visual_style.dart';
import '../foundation/myanmar_calendar_controller.dart';
import '../foundation/myanmar_calendar_scope.dart';
import '../foundation/myanmar_day_data.dart';
import '../foundation/today_builder.dart';
import 'calendar_layout.dart';
import 'myanmar_calendar_header.dart';
import 'myanmar_day_cell.dart';

/// Loads the app's events for a day, for event dots and the agenda.
typedef MyanmarEventLoader = List<Object?> Function(DateTime day);

/// Wraps or replaces a day cell. [cell] is the default cell for [day].
typedef MyanmarDayBuilder =
    Widget Function(BuildContext context, MyanmarDayData day, Widget cell);

/// A month grid that shows Western and Myanmar dates together, pages by
/// swiping, and selects one day, a range or several days.
///
/// ```dart
/// MyanmarMonthCalendar(
///   controller: controller,
///   cellStyle: MyanmarDayCellStyle.dual,
///   eventLoader: (day) => events[day] ?? const [],
///   onSelectionChanged: (selection) { ... },
/// )
/// ```
///
/// With a bounded height the rows share it; otherwise each row is about as
/// tall as a cell is wide.
class MyanmarMonthCalendar extends StatefulWidget {
  /// Creates a month calendar.
  const MyanmarMonthCalendar({
    super.key,
    this.controller,
    this.cellStyle = MyanmarDayCellStyle.dual,
    this.firstDayOfWeek,
    this.weekendDays = const {DateTime.saturday, DateTime.sunday},
    this.showHeader = true,
    this.showWeekdays = true,
    this.showOutsideDays = true,
    this.eventLoader,
    this.dayBuilder,
    this.onDayTapped,
    this.onSelectionChanged,
    this.onMonthChanged,
    this.headerTrailing,
    this.onHeaderTitleTap,
    this.headerTitleTapHint,
    this.surface = true,
    this.padding = const EdgeInsets.fromLTRB(12, 12, 12, 10),
    this.style,
    this.clock,
  });

  /// The visible month and selection; a single-selection controller on this
  /// month when `null`.
  final MyanmarCalendarController? controller;

  /// What each day cell shows.
  final MyanmarDayCellStyle cellStyle;

  /// The first column's weekday (`DateTime.monday` to `DateTime.sunday`);
  /// `null` uses the scope's.
  final int? firstDayOfWeek;

  /// Weekdays whose header labels are coloured.
  final Set<int> weekendDays;

  /// Whether to show the title row with previous and next buttons.
  final bool showHeader;

  /// Whether to show the weekday names.
  final bool showWeekdays;

  /// Whether to show the neighbouring months' days in the first and last
  /// rows.
  final bool showOutsideDays;

  /// The app's events per day, shown as dots.
  final MyanmarEventLoader? eventLoader;

  /// Wraps or replaces each day cell.
  final MyanmarDayBuilder? dayBuilder;

  /// Called with the day the user taps, if it is selectable.
  final ValueChanged<CompleteDate>? onDayTapped;

  /// Called when a tap or key changes the selection.
  final ValueChanged<CalendarSelection>? onSelectionChanged;

  /// Called with the first day of the month that comes into view.
  final ValueChanged<DateTime>? onMonthChanged;

  /// A widget at the end of the header, such as a "Today" button.
  final Widget? headerTrailing;

  /// Makes the header title a button, e.g. to pick a month.
  final VoidCallback? onHeaderTitleTap;

  /// What tapping the title does, for screen readers.
  final String? headerTitleTapHint;

  /// Whether to draw the calendar on an [MmSurface].
  final bool surface;

  /// Space inside the surface.
  final EdgeInsetsGeometry padding;

  /// Overrides the scope's visual style.
  final MmVisualStyle? style;

  /// The current time, for tests; defaults to `DateTime.now`.
  final DateTime Function()? clock;

  @override
  State<MyanmarMonthCalendar> createState() => _MyanmarMonthCalendarState();
}

class _MyanmarMonthCalendarState extends State<MyanmarMonthCalendar> {
  static final DateTime _openStart = DateTime(1800);
  static final DateTime _openEnd = DateTime(2200, 12);

  MyanmarCalendarController? _ownController;
  late PageController _pages;
  final FocusNode _focusNode = FocusNode(debugLabel: 'MyanmarMonthCalendar');
  DateTime? _focusedDay;
  bool _showFocus = false;
  late DateTime _shownMonth;

  MyanmarCalendarController get _controller =>
      widget.controller ?? (_ownController ??= MyanmarCalendarController());

  DateTime get _start => _monthOf(_controller.firstDate ?? _openStart);
  DateTime get _end => _monthOf(_controller.lastDate ?? _openEnd);
  int get _pageCount => DateUtils.monthDelta(_start, _end) + 1;
  int _indexOf(DateTime month) => DateUtils.monthDelta(_start, month);
  DateTime _monthAt(int index) => DateTime(_start.year, _start.month + index);
  static DateTime _monthOf(DateTime d) => DateTime(d.year, d.month);

  @override
  void initState() {
    super.initState();
    _controller.addListener(_onController);
    _shownMonth = _controller.visibleMonth;
    _pages = PageController(initialPage: _indexOf(_shownMonth));
    _focusNode.addListener(_onFocus);
  }

  @override
  void didUpdateWidget(MyanmarMonthCalendar oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.controller != oldWidget.controller) {
      (oldWidget.controller ?? _ownController)?.removeListener(_onController);
      if (widget.controller != null) {
        _ownController?.dispose();
        _ownController = null;
      }
      _controller.addListener(_onController);
      _onController();
    }
  }

  @override
  void dispose() {
    _controller.removeListener(_onController);
    _ownController?.dispose();
    _pages.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  void _onFocus() => setState(
    () => _showFocus =
        _focusNode.hasFocus &&
        FocusManager.instance.highlightMode == FocusHighlightMode.traditional,
  );

  void _onController() {
    final month = _controller.visibleMonth;
    if (month != _shownMonth) {
      _shownMonth = month;
      widget.onMonthChanged?.call(month);
      final target = _indexOf(month);
      if (_pages.hasClients && _pages.page?.round() != target) {
        final current = _pages.page?.round() ?? target;
        final reduceMotion = MediaQuery.disableAnimationsOf(context);
        if ((current - target).abs() == 1 && !reduceMotion) {
          _pages.animateToPage(
            target,
            duration: const Duration(milliseconds: 320),
            curve: Curves.easeOutCubic,
          );
        } else {
          _pages.jumpToPage(target);
        }
      }
    }
    setState(() {});
  }

  void _onPageChanged(int index) => _controller.jumpTo(_monthAt(index));

  void _tap(DateTime day) {
    _focusedDay = day;
    if (!DateUtils.isSameMonth(day, _controller.visibleMonth)) {
      _controller.jumpTo(day);
    }
    final before = _controller.selection;
    if (!_controller.select(day)) return;
    final scope = MyanmarCalendarScope.of(context);
    widget.onDayTapped?.call(scope.day(day));
    if (_controller.selection != before) {
      widget.onSelectionChanged?.call(_controller.selection);
    }
  }

  KeyEventResult _onKey(FocusNode node, KeyEvent event) {
    if (event is! KeyDownEvent && event is! KeyRepeatEvent) {
      return KeyEventResult.ignored;
    }
    final firstDay =
        widget.firstDayOfWeek ??
        MyanmarCalendarScope.of(context).firstDayOfWeek;
    final rtl = Directionality.of(context) == TextDirection.rtl;
    final current =
        _focusedDay ??
        _controller.selection.days.firstOrNull ??
        _controller.visibleMonth;
    final key = event.logicalKey;
    DateTime? next;
    if (key == LogicalKeyboardKey.arrowLeft) {
      next = CalendarLayout.addDays(current, rtl ? 1 : -1);
    } else if (key == LogicalKeyboardKey.arrowRight) {
      next = CalendarLayout.addDays(current, rtl ? -1 : 1);
    } else if (key == LogicalKeyboardKey.arrowUp) {
      next = CalendarLayout.addDays(current, -7);
    } else if (key == LogicalKeyboardKey.arrowDown) {
      next = CalendarLayout.addDays(current, 7);
    } else if (key == LogicalKeyboardKey.pageUp ||
        key == LogicalKeyboardKey.pageDown) {
      final delta = key == LogicalKeyboardKey.pageUp ? -1 : 1;
      final target = DateTime(current.year, current.month + delta);
      final days = DateUtils.getDaysInMonth(target.year, target.month);
      next = DateTime(
        target.year,
        target.month,
        current.day > days ? days : current.day,
      );
    } else if (key == LogicalKeyboardKey.home) {
      next = CalendarLayout.weekStart(current, firstDay);
    } else if (key == LogicalKeyboardKey.end) {
      next = CalendarLayout.addDays(
        CalendarLayout.weekStart(current, firstDay),
        6,
      );
    } else if (key == LogicalKeyboardKey.enter ||
        key == LogicalKeyboardKey.space) {
      _tap(current);
      return KeyEventResult.handled;
    }
    if (next == null) return KeyEventResult.ignored;
    final first = _controller.firstDate;
    final last = _controller.lastDate;
    if ((first != null && next.isBefore(first)) ||
        (last != null && next.isAfter(last))) {
      return KeyEventResult.handled;
    }
    setState(() {
      _focusedDay = next;
      _showFocus = true;
    });
    if (!DateUtils.isSameMonth(next, _controller.visibleMonth)) {
      _controller.jumpTo(next);
    }
    return KeyEventResult.handled;
  }

  @override
  Widget build(BuildContext context) {
    final scope = MyanmarCalendarScope.of(context);
    final strings = MmStrings.of(scope.language);
    final theme = MyanmarCalendarScope.themeOf(context);
    final firstDay = widget.firstDayOfWeek ?? scope.firstDayOfWeek;
    final month = _controller.visibleMonth;

    return TodayBuilder(
      clock: widget.clock,
      builder: (context, today) {
        Widget weekdays() => LayoutBuilder(
          builder: (context, box) {
            final narrow = box.maxWidth / 7 < 34;
            return Row(
              children: [
                for (final w in CalendarLayout.weekdayOrder(firstDay))
                  Expanded(
                    child: ExcludeSemantics(
                      child: Text(
                        narrow
                            ? strings.weekdayNarrow(w)
                            : strings.weekdayShort(w),
                        textAlign: TextAlign.center,
                        maxLines: 1,
                        overflow: TextOverflow.clip,
                        style: theme.textStyle(
                          TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: widget.weekendDays.contains(w)
                                ? theme.publicHoliday.withValues(alpha: 0.85)
                                : theme.muted,
                          ),
                          scope.language,
                        ),
                      ),
                    ),
                  ),
              ],
            );
          },
        );

        Widget page(DateTime pageMonth, double? rowHeight) {
          final weeks = CalendarLayout.weeksOf(pageMonth, firstDay);
          Widget row(List<DateTime> week) => Row(
            children: [
              for (final d in week)
                Expanded(child: _cell(d, pageMonth, today, scope)),
            ],
          );
          return Column(
            children: [
              for (final week in weeks)
                rowHeight == null
                    ? Expanded(child: row(week))
                    : SizedBox(height: rowHeight, child: row(week)),
            ],
          );
        }

        final grid = LayoutBuilder(
          builder: (context, box) {
            final bounded = box.hasBoundedHeight;
            final cellWidth = box.maxWidth / 7;
            final rowHeight = bounded
                ? null
                : cellWidth *
                      (widget.cellStyle == MyanmarDayCellStyle.minimal
                          ? 0.82
                          : 0.98);
            final pager = PageView.builder(
              controller: _pages,
              itemCount: _pageCount,
              onPageChanged: _onPageChanged,
              itemBuilder: (context, index) => page(_monthAt(index), rowHeight),
            );
            if (bounded) return pager;
            final rows = CalendarLayout.weeksOf(month, firstDay).length;
            return AnimatedContainer(
              duration: MediaQuery.disableAnimationsOf(context)
                  ? Duration.zero
                  : const Duration(milliseconds: 220),
              curve: Curves.easeOutCubic,
              height: rows * rowHeight!,
              child: pager,
            );
          },
        );

        final focusable = Focus(
          focusNode: _focusNode,
          onKeyEvent: _onKey,
          child: grid,
        );

        final body = LayoutBuilder(
          builder: (context, box) {
            final bounded = box.hasBoundedHeight;
            return Column(
              mainAxisSize: bounded ? MainAxisSize.max : MainAxisSize.min,
              children: [
                if (widget.showHeader)
                  MyanmarCalendarHeader(
                    title: strings.westernMonthYear(month),
                    subtitle: CalendarLayout.myanmarSpanOfMonth(scope, month),
                    onPrevious: _controller.canGoPrevious
                        ? _controller.previousMonth
                        : null,
                    onNext: _controller.canGoNext
                        ? _controller.nextMonth
                        : null,
                    previousTooltip: strings.previousMonth,
                    nextTooltip: strings.nextMonth,
                    trailing: widget.headerTrailing,
                    onTitleTap: widget.onHeaderTitleTap,
                    titleTapTooltip: widget.headerTitleTapHint,
                    style: widget.style,
                  ),
                if (widget.showWeekdays) ...[
                  const SizedBox(height: 4),
                  weekdays(),
                  const SizedBox(height: 4),
                ],
                if (bounded) Expanded(child: focusable) else focusable,
              ],
            );
          },
        );

        final padded = Padding(padding: widget.padding, child: body);
        return widget.surface
            ? MmSurface(style: widget.style, child: padded)
            : padded;
      },
    );
  }

  Widget _cell(
    DateTime day,
    DateTime pageMonth,
    DateTime today,
    MyanmarCalendarScopeData scope,
  ) {
    final outside = !DateUtils.isSameMonth(day, pageMonth);
    if (outside && !widget.showOutsideDays) return const SizedBox.shrink();
    final data = MyanmarDayData.resolve(
      date: scope.day(day),
      today: today,
      selection: _controller.selection,
      visibleMonth: pageMonth,
      isSelectable: _controller.isSelectable,
      events: widget.eventLoader?.call(day) ?? const [],
    );
    final cell = MyanmarDayCell(
      data: data,
      cellStyle: widget.cellStyle,
      focused: _showFocus && DateUtils.isSameDay(_focusedDay, day),
      onTap: data.isDisabled ? null : () => _tap(day),
      style: widget.style,
    );
    final built = widget.dayBuilder?.call(context, data, cell) ?? cell;
    return Padding(padding: const EdgeInsets.all(1.5), child: built);
  }
}
