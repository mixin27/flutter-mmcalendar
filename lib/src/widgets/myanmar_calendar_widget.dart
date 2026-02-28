// ignore_for_file: public_member_api_docs

import 'package:flutter/material.dart';
import 'package:myanmar_calendar_dart/myanmar_calendar_dart.dart';

import '../core/calendar_repository.dart';
import '../core/myanmar_calendar_theme.dart';
import 'calendar_selection_mode.dart';
import 'internal/calendar_grid_utils.dart';
import 'internal/calendar_localization_utils.dart';
import 'myanmar_calendar_toolbar.dart';
import 'optimized_calendar_cell.dart';

/// Month-based calendar widget with Myanmar date integration.
///
/// Supports:
/// - Single/range/multi selection modes
/// - Holiday and astrology indicators
/// - Custom header/cell builders
/// - Min/max date constraints
class MyanmarCalendarWidget extends StatefulWidget {
  const MyanmarCalendarWidget({
    super.key,
    this.initialDate,
    this.language = Language.english,
    this.config,
    this.onDateSelected,
    this.onMonthChanged,
    this.showHolidays = true,
    this.showAstrology = false,
    this.showWesternDates = true,
    this.showMyanmarDates = true,
    this.showWeekdayHeaders = true,
    this.isCompactWeekday = false,
    this.showHeader = true,
    this.showNavigation = true,
    this.enableSelection = true,
    this.theme,
    this.cellBuilder,
    this.headerBuilder,
    this.height,
    this.width,
    this.padding,
    this.margin,
    this.firstDayOfWeek = 1,
    this.selectedDate,
    this.minDate,
    this.maxDate,
    this.highlightToday = true,
    this.highlightWeekends = true,
    this.animationDuration = const Duration(milliseconds: 300),
    this.enableAnimations = true,
    this.selectionMode = CalendarSelectionMode.single,
    this.onRangeSelected,
    this.onMultiSelected,
    this.initialSelectedRangeStart,
    this.initialSelectedRangeEnd,
    this.initialMultiSelectedDates,
  });

  final DateTime? initialDate;
  final Language language;
  final CalendarConfig? config;
  final void Function(CompleteDate date)? onDateSelected;
  final void Function(DateTime month)? onMonthChanged;
  final bool showHolidays;
  final bool showAstrology;
  final bool showWesternDates;
  final bool showMyanmarDates;
  final bool showWeekdayHeaders;
  final bool isCompactWeekday;
  final bool showHeader;
  final bool showNavigation;
  final bool enableSelection;
  final MyanmarCalendarTheme? theme;
  final Widget Function(BuildContext context, CompleteDate date)? cellBuilder;
  final Widget Function(BuildContext context, DateTime month)? headerBuilder;
  final double? height;
  final double? width;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final int firstDayOfWeek;
  final DateTime? selectedDate;
  final DateTime? minDate;
  final DateTime? maxDate;
  final bool highlightToday;
  final bool highlightWeekends;
  final Duration animationDuration;
  final bool enableAnimations;
  final CalendarSelectionMode selectionMode;
  final void Function(DateTime? start, DateTime? end)? onRangeSelected;
  final void Function(List<DateTime> selectedDates)? onMultiSelected;
  final DateTime? initialSelectedRangeStart;
  final DateTime? initialSelectedRangeEnd;
  final List<DateTime>? initialMultiSelectedDates;

  @override
  State<MyanmarCalendarWidget> createState() => _MyanmarCalendarWidgetState();
}

class _MyanmarCalendarWidgetState extends State<MyanmarCalendarWidget> {
  late CalendarRepository _repository;
  late MyanmarCalendarTheme _theme;
  late DateTime _visibleMonth;

  DateTime? _selectedDate;
  DateTime? _rangeStart;
  DateTime? _rangeEnd;
  final Set<DateTime> _multiSelected = <DateTime>{};

  @override
  void initState() {
    super.initState();
    _repository = CalendarRepository(
      language: widget.language,
      config: widget.config,
    );
    _theme = widget.theme ?? MyanmarCalendarTheme.defaultTheme();

    final now = widget.initialDate ?? DateTime.now();
    _visibleMonth = DateTime(now.year, now.month);
    _selectedDate = _normalizeOrNull(widget.selectedDate ?? widget.initialDate);
    _rangeStart = _normalizeOrNull(widget.initialSelectedRangeStart);
    _rangeEnd = _normalizeOrNull(widget.initialSelectedRangeEnd);

    if (widget.initialMultiSelectedDates != null) {
      _multiSelected.addAll(
        widget.initialMultiSelectedDates!
            .map(CalendarGridUtils.normalize)
            .toSet(),
      );
    }
  }

  @override
  void didUpdateWidget(covariant MyanmarCalendarWidget oldWidget) {
    super.didUpdateWidget(oldWidget);

    _repository.reconfigure(language: widget.language, config: widget.config);

    if (widget.theme != oldWidget.theme) {
      _theme = widget.theme ?? MyanmarCalendarTheme.defaultTheme();
    }

    if (widget.selectedDate != oldWidget.selectedDate) {
      _selectedDate = _normalizeOrNull(widget.selectedDate);
    }
  }

  @override
  void dispose() {
    _repository.clear();
    super.dispose();
  }

  DateTime _normalize(DateTime value) {
    return CalendarGridUtils.normalize(value);
  }

  DateTime? _normalizeOrNull(DateTime? value) {
    return value == null ? null : _normalize(value);
  }

  bool _same(DateTime a, DateTime b) {
    return CalendarGridUtils.isSameDate(a, b);
  }

  bool _isDateSelectable(DateTime date) {
    if (!widget.enableSelection) {
      return false;
    }
    if (widget.minDate != null && date.isBefore(_normalize(widget.minDate!))) {
      return false;
    }
    if (widget.maxDate != null && date.isAfter(_normalize(widget.maxDate!))) {
      return false;
    }
    return true;
  }

  bool _isToday(DateTime date) {
    return _same(date, DateTime.now());
  }

  bool _isInCurrentMonth(DateTime date) {
    return date.year == _visibleMonth.year && date.month == _visibleMonth.month;
  }

  bool _isSingleSelected(DateTime date) {
    return _selectedDate != null && _same(date, _selectedDate!);
  }

  bool _isRangeStart(DateTime date) {
    return _rangeStart != null && _same(date, _rangeStart!);
  }

  bool _isRangeEnd(DateTime date) {
    return _rangeEnd != null && _same(date, _rangeEnd!);
  }

  bool _isInRange(DateTime date) {
    if (_rangeStart == null || _rangeEnd == null) {
      return false;
    }
    return date.isAfter(_rangeStart!) && date.isBefore(_rangeEnd!);
  }

  void _goToPreviousMonth() {
    _goToMonth(DateTime(_visibleMonth.year, _visibleMonth.month - 1));
  }

  void _goToNextMonth() {
    _goToMonth(DateTime(_visibleMonth.year, _visibleMonth.month + 1));
  }

  void _goToMonth(DateTime month) {
    setState(() {
      _visibleMonth = DateTime(month.year, month.month);
    });
    widget.onMonthChanged?.call(_visibleMonth);
  }

  void _onDateTap(DateTime date) {
    final normalized = _normalize(date);
    if (!_isDateSelectable(normalized)) {
      return;
    }

    setState(() {
      switch (widget.selectionMode) {
        case CalendarSelectionMode.single:
          _selectedDate = normalized;
          widget.onDateSelected?.call(_repository.getCompleteDate(normalized));
          break;
        case CalendarSelectionMode.range:
          if (_rangeStart == null || _rangeEnd != null) {
            _rangeStart = normalized;
            _rangeEnd = null;
          } else if (normalized.isBefore(_rangeStart!)) {
            _rangeEnd = _rangeStart;
            _rangeStart = normalized;
          } else {
            _rangeEnd = normalized;
          }
          widget.onRangeSelected?.call(_rangeStart, _rangeEnd);
          break;
        case CalendarSelectionMode.multi:
          if (_multiSelected.contains(normalized)) {
            _multiSelected.remove(normalized);
          } else {
            _multiSelected.add(normalized);
          }
          final sorted = _multiSelected.toList()
            ..sort((a, b) => a.compareTo(b));
          widget.onMultiSelected?.call(sorted);
          break;
      }
    });
  }

  String _buildWesternMonthTitle() {
    return '${CalendarLocalizationUtils.westernMonth(_visibleMonth.month, widget.language)} ${_visibleMonth.year}';
  }

  String _buildMyanmarMonthTitle() {
    final date = _repository.getMyanmarDate(_visibleMonth);
    return _repository.formatMyanmar(
      date,
      pattern: '&M &y',
      language: widget.language,
    );
  }

  String _buildHeaderTitle() {
    if (widget.showWesternDates) {
      return _buildWesternMonthTitle();
    }
    return _buildMyanmarMonthTitle();
  }

  String? _buildHeaderSubtitle() {
    if (widget.showWesternDates && widget.showMyanmarDates) {
      return _buildMyanmarMonthTitle();
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: widget.width,
      height: widget.height,
      margin: widget.margin,
      padding: widget.padding ?? _theme.calendarPadding,
      decoration: BoxDecoration(
        color: _theme.backgroundColor,
        borderRadius: BorderRadius.circular(_theme.borderRadius),
        border: Border.all(
          color: _theme.borderColor,
          width: _theme.borderWidth,
        ),
        boxShadow: _theme.elevation <= 0
            ? null
            : <BoxShadow>[
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.08),
                  blurRadius: _theme.elevation,
                  offset: const Offset(0, 2),
                ),
              ],
      ),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            if (widget.showHeader) _buildHeader(context),
            if (widget.showWeekdayHeaders) _buildWeekdayHeader(context),
            _buildGrid(context),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    if (widget.headerBuilder != null) {
      return widget.headerBuilder!(context, _visibleMonth);
    }

    return MyanmarCalendarToolbar(
      month: _visibleMonth,
      language: widget.language,
      theme: _theme,
      title: _buildHeaderTitle(),
      subtitle: _buildHeaderSubtitle(),
      showNavigation: widget.showNavigation,
      onPrevious: _goToPreviousMonth,
      onNext: _goToNextMonth,
    );
  }

  Widget _buildWeekdayHeader(BuildContext context) {
    return Container(
      color: _theme.weekdayHeaderBackgroundColor,
      padding: _theme.weekdayHeaderPadding,
      child: Row(
        children: List<Widget>.generate(7, (index) {
          final weekday = (widget.firstDayOfWeek + index) % 7;
          final label = CalendarLocalizationUtils.weekday(
            weekday,
            widget.language,
            compact: widget.isCompactWeekday,
          );
          final isWeekend =
              widget.highlightWeekends && (weekday == 0 || weekday == 1);
          return Expanded(
            child: Text(
              label,
              textAlign: TextAlign.center,
              style: _theme.weekdayHeaderTextStyle.copyWith(
                color: isWeekend
                    ? _theme.headerBackgroundColor
                    : _theme.weekdayHeaderTextColor,
              ),
            ),
          );
        }),
      ),
    );
  }

  Widget _buildGrid(BuildContext context) {
    final dates = CalendarGridUtils.buildMonthGrid(
      _visibleMonth,
      firstDayOfWeek: widget.firstDayOfWeek,
    );

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 7,
        mainAxisSpacing: 0,
        crossAxisSpacing: 0,
      ),
      itemCount: dates.length,
      itemBuilder: (BuildContext context, int index) {
        final date = dates[index];
        final completeDate = _repository.getCompleteDate(date);

        if (widget.cellBuilder != null) {
          return GestureDetector(
            onTap: _isDateSelectable(date) ? () => _onDateTap(date) : null,
            child: widget.cellBuilder!(context, completeDate),
          );
        }

        return OptimizedCalendarCell(
          date: completeDate,
          isSelected: widget.selectionMode == CalendarSelectionMode.single
              ? _isSingleSelected(date)
              : false,
          isRangeStart:
              widget.selectionMode == CalendarSelectionMode.range &&
              _isRangeStart(date),
          isRangeEnd:
              widget.selectionMode == CalendarSelectionMode.range &&
              _isRangeEnd(date),
          isInRange:
              widget.selectionMode == CalendarSelectionMode.range &&
              _isInRange(date),
          isMultiSelected:
              widget.selectionMode == CalendarSelectionMode.multi &&
              _multiSelected.contains(date),
          isToday: widget.highlightToday && _isToday(date),
          isDisabled: !_isDateSelectable(date),
          isInCurrentMonth: _isInCurrentMonth(date),
          onTap: _isDateSelectable(date) ? () => _onDateTap(date) : null,
          language: widget.language,
          showHolidays: widget.showHolidays,
          showAstrology: widget.showAstrology,
          theme: _theme,
        );
      },
    );
  }
}
