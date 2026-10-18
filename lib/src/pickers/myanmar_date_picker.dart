import 'package:flutter/material.dart';
import 'package:myanmar_calendar_dart/myanmar_calendar_dart.dart';

import '../adaptive/mm_buttons.dart';
import '../adaptive/mm_overlays.dart';
import '../adaptive/mm_segmented.dart';
import '../calendars/myanmar_day_cell.dart';
import '../calendars/myanmar_month_calendar.dart';
import '../foundation/calendar_selection.dart';
import '../foundation/language_locale.dart';
import '../foundation/mm_strings.dart';
import '../foundation/mm_visual_style.dart';
import '../foundation/myanmar_calendar_controller.dart';
import '../foundation/myanmar_calendar_scope.dart';
import 'myanmar_date_wheel_picker.dart';
import 'myanmar_month_year_picker.dart';

/// How a date picker takes input.
enum MyanmarPickerInput {
  /// Tapping days in a month calendar.
  calendar,

  /// Myanmar year, month and fortnight-day wheels.
  wheels,
}

/// A chosen range of days, both ends included.
@immutable
class MyanmarDateRange {
  /// Creates a range.
  const MyanmarDateRange({required this.start, required this.end});

  /// The first day.
  final CompleteDate start;

  /// The last day.
  final CompleteDate end;

  /// How many days the range covers.
  int get dayCount =>
      DateTime.utc(end.western.year, end.western.month, end.western.day)
          .difference(
            DateTime.utc(
              start.western.year,
              start.western.month,
              start.western.day,
            ),
          )
          .inDays +
      1;

  @override
  bool operator ==(Object other) =>
      other is MyanmarDateRange &&
      other.start.western == start.western &&
      other.end.western == end.western;

  @override
  int get hashCode => Object.hash(start.western, end.western);
}

/// A date picker's content, for use inline or inside your own dialog: a
/// summary of the selection, then a month calendar, the Myanmar wheels, or
/// a month-year grid.
///
/// What it selects follows [controller]'s selection: single, range or
/// multi. The wheels are offered only for a single selection.
class MyanmarDatePicker extends StatefulWidget {
  /// Creates a picker on [controller].
  const MyanmarDatePicker({
    required this.controller,
    super.key,
    this.inputMode = MyanmarPickerInput.calendar,
    this.allowInputSwitch = true,
    this.cellStyle = MyanmarDayCellStyle.westernFirst,
    this.calendarHeight = 330,
    this.showSummary = true,
    this.style,
    this.clock,
  });

  /// The visible month, bounds and selection.
  final MyanmarCalendarController controller;

  /// How the picker starts taking input.
  final MyanmarPickerInput inputMode;

  /// Whether to offer the Western / Myanmar switch (single selection only).
  final bool allowInputSwitch;

  /// What the calendar's day cells show.
  final MyanmarDayCellStyle cellStyle;

  /// The calendar's height.
  final double calendarHeight;

  /// Whether to show the selected date or range above the calendar.
  final bool showSummary;

  /// Overrides the scope's visual style.
  final MmVisualStyle? style;

  /// The current time, for tests.
  final DateTime Function()? clock;

  @override
  State<MyanmarDatePicker> createState() => _MyanmarDatePickerState();
}

enum _Mode { calendar, wheels, monthYear }

class _MyanmarDatePickerState extends State<MyanmarDatePicker> {
  late _Mode _mode = widget.inputMode == MyanmarPickerInput.wheels && _single
      ? _Mode.wheels
      : _Mode.calendar;

  bool get _single => widget.controller.selection is SingleSelection;

  @override
  void initState() {
    super.initState();
    widget.controller.addListener(_rebuild);
  }

  @override
  void didUpdateWidget(MyanmarDatePicker oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.controller != oldWidget.controller) {
      oldWidget.controller.removeListener(_rebuild);
      widget.controller.addListener(_rebuild);
    }
  }

  @override
  void dispose() {
    widget.controller.removeListener(_rebuild);
    super.dispose();
  }

  void _rebuild() => setState(() {});

  @override
  Widget build(BuildContext context) {
    final scope = MyanmarCalendarScope.of(context);
    final theme = MyanmarCalendarScope.themeOf(context);
    final strings = MmStrings.of(scope.language);
    final controller = widget.controller;
    final reduceMotion = MediaQuery.disableAnimationsOf(context);

    final Widget body = switch (_mode) {
      _Mode.calendar => SizedBox(
        key: const ValueKey('calendar'),
        height: widget.calendarHeight,
        child: MyanmarMonthCalendar(
          controller: controller,
          cellStyle: widget.cellStyle,
          surface: false,
          padding: EdgeInsets.zero,
          clock: widget.clock,
          style: widget.style,
          onHeaderTitleTap: () => setState(() => _mode = _Mode.monthYear),
          headerTitleTapHint: strings.chooseMonth,
        ),
      ),
      _Mode.monthYear => SizedBox(
        key: const ValueKey('monthYear'),
        height: widget.calendarHeight,
        child: MyanmarMonthYearPicker(
          selectedMonth: controller.visibleMonth,
          firstDate: controller.firstDate,
          lastDate: controller.lastDate,
          style: widget.style,
          onChanged: (month) {
            controller.jumpTo(month);
            setState(() => _mode = _Mode.calendar);
          },
        ),
      ),
      _Mode.wheels => () {
        // The wheels always show a day, so that day is the selection.
        final shown = DateUtils.dateOnly(
          controller.selection.days.firstOrNull ??
              (widget.clock ?? DateTime.now)(),
        );
        if (controller.selection.isEmpty) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            if (mounted && controller.selection.isEmpty) {
              controller
                ..jumpTo(shown)
                ..select(shown);
            }
          });
        }
        return Padding(
          key: const ValueKey('wheels'),
          padding: const EdgeInsets.symmetric(vertical: 12),
          child: MyanmarDateWheelPicker(
            initialDate: shown,
            style: widget.style,
            onChanged: (day) {
              final d = DateTime(
                day.western.year,
                day.western.month,
                day.western.day,
              );
              controller.jumpTo(d);
              controller.select(d);
            },
          ),
        );
      }(),
    };

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        if (widget.allowInputSwitch && _single) ...[
          Center(
            child: MmSegmented<bool>(
              segments: {false: strings.western, true: strings.myanmar},
              selected: _mode == _Mode.wheels,
              style: widget.style,
              onChanged: (wheels) => setState(
                () => _mode = wheels ? _Mode.wheels : _Mode.calendar,
              ),
            ),
          ),
          const SizedBox(height: 12),
        ],
        if (widget.showSummary) ...[
          _Summary(selection: controller.selection),
          const SizedBox(height: 8),
          Divider(height: 1, color: theme.outline),
          const SizedBox(height: 8),
        ],
        AnimatedSwitcher(
          duration: reduceMotion
              ? Duration.zero
              : const Duration(milliseconds: 200),
          child: body,
        ),
      ],
    );
  }
}

class _Summary extends StatelessWidget {
  const _Summary({required this.selection});

  final CalendarSelection selection;

  @override
  Widget build(BuildContext context) {
    final scope = MyanmarCalendarScope.of(context);
    final theme = MyanmarCalendarScope.themeOf(context);
    final strings = MmStrings.of(scope.language);
    final language = scope.language;

    String full(DateTime d) {
      final m = scope.day(d).myanmar;
      return '${language.digits(m.year)} ${strings.myanmarDate(m)}';
    }

    final (String main, String sub) = switch (selection) {
      SingleSelection(:final date?) => (
        '${strings.weekdayName(date.weekday)}, ${strings.westernDate(date)}',
        full(date),
      ),
      RangeSelection(:final start?, :final end) => (
        end == null || end == start
            ? strings.westernDate(start)
            : '${strings.westernShort(start)} – ${strings.westernDate(end)}',
        strings.dayCount((selection as RangeSelection).length),
      ),
      MultiSelection(:final dates) when dates.isNotEmpty => (
        strings.dayCount(dates.length),
        selection.days.take(4).map(strings.westernShort).join(', ') +
            (dates.length > 4 ? '…' : ''),
      ),
      _ => (
        switch (selection) {
          RangeSelection() => strings.selectRange,
          MultiSelection() => strings.selectDates,
          _ => strings.selectDate,
        },
        '',
      ),
    };

    return Semantics(
      liveRegion: true,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 4),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              main,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: theme.textStyle(
                TextStyle(
                  color: theme.ink,
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                ),
                language,
              ),
            ),
            if (sub.isNotEmpty)
              Text(
                sub,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: theme.textStyle(
                  TextStyle(color: theme.muted, fontSize: 13.5),
                  language,
                ),
              ),
          ],
        ),
      ),
    );
  }
}

/// Shows a date picker and returns the chosen day, or `null` if the user
/// cancels.
///
/// Material shows a dialog; Cupertino and Glass show a sheet with Cancel and
/// Done. [inputMode] chooses between the calendar and the Myanmar wheels;
/// the user can switch unless [allowInputSwitch] is false.
Future<CompleteDate?> showMyanmarDatePicker({
  required BuildContext context,
  DateTime? initialDate,
  DateTime? firstDate,
  DateTime? lastDate,
  SelectableDayPredicate? selectableDayPredicate,
  MyanmarPickerInput inputMode = MyanmarPickerInput.calendar,
  bool allowInputSwitch = true,
  MyanmarDayCellStyle cellStyle = MyanmarDayCellStyle.westernFirst,
  String? title,
  MmVisualStyle? style,
  DateTime Function()? clock,
}) async {
  final controller = MyanmarCalendarController(
    initialMonth: initialDate,
    selection: SingleSelection(initialDate),
    firstDate: firstDate,
    lastDate: lastDate,
    selectableDayPredicate: selectableDayPredicate,
  );
  final scope = MyanmarCalendarScope.of(context);
  final ok = await _showPicker(
    context: context,
    controller: controller,
    title: title ?? MmStrings.of(scope.language).selectDate,
    inputMode: inputMode,
    allowInputSwitch: allowInputSwitch,
    cellStyle: cellStyle,
    style: style,
    clock: clock,
  );
  final day = controller.selection.days.firstOrNull;
  controller.dispose();
  return ok == true && day != null ? scope.day(day) : null;
}

/// Shows a range picker and returns the chosen range, or `null` if the user
/// cancels. Done is enabled once both ends are chosen.
///
/// It opens on [initialMonth], else the month of [initialStart], else this
/// month.
Future<MyanmarDateRange?> showMyanmarDateRangePicker({
  required BuildContext context,
  DateTime? initialMonth,
  DateTime? initialStart,
  DateTime? initialEnd,
  DateTime? firstDate,
  DateTime? lastDate,
  SelectableDayPredicate? selectableDayPredicate,
  MyanmarDayCellStyle cellStyle = MyanmarDayCellStyle.westernFirst,
  String? title,
  MmVisualStyle? style,
  DateTime Function()? clock,
}) async {
  final controller = MyanmarCalendarController(
    initialMonth: initialMonth ?? initialStart,
    selection: RangeSelection(start: initialStart, end: initialEnd),
    firstDate: firstDate,
    lastDate: lastDate,
    selectableDayPredicate: selectableDayPredicate,
  );
  final scope = MyanmarCalendarScope.of(context);
  final ok = await _showPicker(
    context: context,
    controller: controller,
    title: title ?? MmStrings.of(scope.language).selectRange,
    inputMode: MyanmarPickerInput.calendar,
    allowInputSwitch: false,
    cellStyle: cellStyle,
    style: style,
    clock: clock,
    canConfirm: (s) => s is RangeSelection && s.isComplete,
  );
  final range = controller.selection as RangeSelection;
  controller.dispose();
  if (ok != true || !range.isComplete) return null;
  return MyanmarDateRange(
    start: scope.day(range.start!),
    end: scope.day(range.end!),
  );
}

/// Shows a picker for any number of days and returns them earliest first,
/// or `null` if the user cancels.
Future<List<CompleteDate>?> showMyanmarMultiDatePicker({
  required BuildContext context,
  DateTime? initialMonth,
  Iterable<DateTime> initialDates = const [],
  DateTime? firstDate,
  DateTime? lastDate,
  SelectableDayPredicate? selectableDayPredicate,
  MyanmarDayCellStyle cellStyle = MyanmarDayCellStyle.westernFirst,
  String? title,
  MmVisualStyle? style,
  DateTime Function()? clock,
}) async {
  final controller = MyanmarCalendarController(
    initialMonth: initialMonth ?? initialDates.firstOrNull,
    selection: MultiSelection(initialDates),
    firstDate: firstDate,
    lastDate: lastDate,
    selectableDayPredicate: selectableDayPredicate,
  );
  final scope = MyanmarCalendarScope.of(context);
  final ok = await _showPicker(
    context: context,
    controller: controller,
    title: title ?? MmStrings.of(scope.language).selectDates,
    inputMode: MyanmarPickerInput.calendar,
    allowInputSwitch: false,
    cellStyle: cellStyle,
    style: style,
    clock: clock,
  );
  final days = controller.selection.days;
  controller.dispose();
  return ok == true ? [for (final d in days) scope.day(d)] : null;
}

Future<bool?> _showPicker({
  required BuildContext context,
  required MyanmarCalendarController controller,
  required String title,
  required MyanmarPickerInput inputMode,
  required bool allowInputSwitch,
  required MyanmarDayCellStyle cellStyle,
  required MmVisualStyle? style,
  required DateTime Function()? clock,
  bool Function(CalendarSelection selection)? canConfirm,
}) {
  final resolved = MyanmarCalendarScope.styleOf(context, style);
  final strings = MmStrings.of(MyanmarCalendarScope.of(context).language);
  bool confirmable(CalendarSelection s) =>
      canConfirm?.call(s) ?? !s.isEmpty || s is MultiSelection;

  Widget picker() => MyanmarDatePicker(
    controller: controller,
    inputMode: inputMode,
    allowInputSwitch: allowInputSwitch,
    cellStyle: cellStyle,
    style: style,
    clock: clock,
  );

  if (resolved == MmVisualStyle.material) {
    return showDialog<bool>(
      context: context,
      builder: (dialogContext) => MyanmarCalendarScope.wrap(
        context,
        Builder(
          builder: (ctx) {
            final theme = MyanmarCalendarScope.themeOf(ctx);
            return Dialog(
              backgroundColor: theme.surface,
              surfaceTintColor: Colors.transparent,
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 380),
                child: SingleChildScrollView(
                  padding: const EdgeInsets.fromLTRB(20, 20, 20, 8),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Text(
                        title,
                        style: TextStyle(color: theme.muted, fontSize: 13),
                      ),
                      const SizedBox(height: 6),
                      picker(),
                      ListenableBuilder(
                        listenable: controller,
                        builder: (_, _) => Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            MmButton(
                              label: strings.cancel,
                              variant: MmButtonVariant.text,
                              onPressed: () => Navigator.pop(ctx, false),
                            ),
                            MmButton(
                              label: strings.ok,
                              variant: MmButtonVariant.text,
                              onPressed: confirmable(controller.selection)
                                  ? () => Navigator.pop(ctx, true)
                                  : null,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  return showMmSheet<bool>(
    context: context,
    style: style,
    builder: (ctx) {
      final theme = MyanmarCalendarScope.themeOf(ctx);
      return SafeArea(
        top: false,
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              ListenableBuilder(
                listenable: controller,
                builder: (_, _) => Row(
                  children: [
                    MmButton(
                      label: strings.cancel,
                      variant: MmButtonVariant.text,
                      style: style,
                      onPressed: () => Navigator.pop(ctx, false),
                    ),
                    Expanded(
                      child: Text(
                        title,
                        textAlign: TextAlign.center,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          color: theme.ink,
                          fontWeight: FontWeight.w600,
                          fontSize: 16,
                        ),
                      ),
                    ),
                    MmButton(
                      label: strings.done,
                      variant: MmButtonVariant.filled,
                      style: style,
                      onPressed: confirmable(controller.selection)
                          ? () => Navigator.pop(ctx, true)
                          : null,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 10),
              picker(),
            ],
          ),
        ),
      );
    },
  );
}
