// ignore_for_file: public_member_api_docs

import 'package:flutter/material.dart';
import 'package:myanmar_calendar_dart/myanmar_calendar_dart.dart';

import '../core/calendar_repository.dart';
import '../core/myanmar_calendar_theme.dart';
import 'internal/calendar_grid_utils.dart';
import 'internal/calendar_localization_utils.dart';
import 'myanmar_calendar_widget.dart';
import 'myanmar_date_summary_card.dart';

/// Inline Myanmar date picker with calendar/year modes.
///
/// This widget is the shared implementation used by both modal and fullscreen
/// picker helpers.
class MyanmarDatePickerWidget extends StatefulWidget {
  const MyanmarDatePickerWidget({
    super.key,
    this.initialDate,
    this.firstDate,
    this.lastDate,
    this.language = Language.english,
    this.config,
    this.onDateChanged,
    this.onConfirm,
    this.onCancel,
    this.showHolidays = true,
    this.showAstrology = false,
    this.showWesternDates = true,
    this.showMyanmarDates = true,
    this.showTodayButton = true,
    this.showClearButton = true,
    this.showActionButtons = false,
    this.theme,
    this.height,
    this.width,
    this.padding,
    this.margin,
    this.helpText,
    this.cancelText,
    this.confirmText,
    this.isModal = false,
    this.animationDuration = const Duration(milliseconds: 300),
    this.firstDayOfWeek = 1,
    this.highlightToday = true,
    this.highlightWeekends = true,
  });

  final DateTime? initialDate;
  final DateTime? firstDate;
  final DateTime? lastDate;
  final Language language;
  final CalendarConfig? config;
  final void Function(CompleteDate date)? onDateChanged;
  final void Function(CompleteDate date)? onConfirm;
  final VoidCallback? onCancel;
  final bool showHolidays;
  final bool showAstrology;
  final bool showWesternDates;
  final bool showMyanmarDates;
  final bool showTodayButton;
  final bool showClearButton;
  final bool showActionButtons;
  final MyanmarCalendarTheme? theme;
  final double? height;
  final double? width;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final String? helpText;
  final String? cancelText;
  final String? confirmText;
  final bool isModal;
  final Duration animationDuration;
  final int firstDayOfWeek;
  final bool highlightToday;
  final bool highlightWeekends;

  @override
  State<MyanmarDatePickerWidget> createState() =>
      _MyanmarDatePickerWidgetState();
}

class _MyanmarDatePickerWidgetState extends State<MyanmarDatePickerWidget>
    with SingleTickerProviderStateMixin {
  late CalendarRepository _repository;
  late MyanmarCalendarTheme _theme;
  late DateTime _currentMonth;
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;

  DateTime? _selectedDate;
  CompleteDate? _selectedCompleteDate;
  bool _showYearGrid = false;

  @override
  void initState() {
    super.initState();
    _repository = CalendarRepository(
      language: widget.language,
      config: widget.config,
    );
    _theme = widget.theme ?? MyanmarCalendarTheme.defaultTheme();

    final initial = widget.initialDate ?? DateTime.now();
    _currentMonth = DateTime(initial.year, initial.month);
    _selectedDate = CalendarGridUtils.normalize(initial);
    _selectedCompleteDate = _repository.getCompleteDate(_selectedDate!);

    _animationController = AnimationController(
      vsync: this,
      duration: widget.animationDuration,
    );
    _fadeAnimation = CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeOut,
    );
    _animationController.forward();
  }

  @override
  void didUpdateWidget(covariant MyanmarDatePickerWidget oldWidget) {
    super.didUpdateWidget(oldWidget);

    _repository.reconfigure(language: widget.language, config: widget.config);

    if (widget.theme != oldWidget.theme) {
      _theme = widget.theme ?? MyanmarCalendarTheme.defaultTheme();
    }
  }

  @override
  void dispose() {
    _animationController.dispose();
    _repository.clear();
    super.dispose();
  }

  bool _isDateSelectable(DateTime value) {
    final date = CalendarGridUtils.normalize(value);
    if (widget.firstDate != null &&
        date.isBefore(CalendarGridUtils.normalize(widget.firstDate!))) {
      return false;
    }
    if (widget.lastDate != null &&
        date.isAfter(CalendarGridUtils.normalize(widget.lastDate!))) {
      return false;
    }
    return true;
  }

  void _onCalendarDateSelected(CompleteDate date) {
    final selected = CalendarGridUtils.normalize(date.western.toDateTime());
    if (!_isDateSelectable(selected)) {
      return;
    }

    setState(() {
      _selectedDate = selected;
      _selectedCompleteDate = date;
      _currentMonth = DateTime(selected.year, selected.month);
    });

    widget.onDateChanged?.call(date);
    if (!widget.isModal) {
      widget.onConfirm?.call(date);
    }
  }

  void _onTodayPressed() {
    final now = CalendarGridUtils.normalize(DateTime.now());
    if (!_isDateSelectable(now)) {
      return;
    }

    final complete = _repository.getCompleteDate(now);
    _onCalendarDateSelected(complete);
  }

  void _onClearPressed() {
    setState(() {
      _selectedDate = null;
      _selectedCompleteDate = null;
    });
  }

  void _onConfirmPressed() {
    if (_selectedCompleteDate != null) {
      widget.onConfirm?.call(_selectedCompleteDate!);
    }
  }

  void _onCancelPressed() {
    widget.onCancel?.call();
  }

  void _jumpYear(int offset) {
    final minYear = _minSelectableYear;
    final maxYear = _maxSelectableYear;
    final nextYear = (_currentMonth.year + offset).clamp(minYear, maxYear);

    if (nextYear == _currentMonth.year) {
      return;
    }

    setState(() {
      _currentMonth = DateTime(nextYear, _currentMonth.month);
    });
  }

  void _selectMonth(int month) {
    if (!_isMonthSelectable(_currentMonth.year, month)) {
      return;
    }

    setState(() {
      _currentMonth = DateTime(_currentMonth.year, month);
      _showYearGrid = false;
    });
  }

  int get _minSelectableYear {
    final referenceYear = DateTime.now().year;
    return widget.firstDate?.year ?? (referenceYear - 300);
  }

  int get _maxSelectableYear {
    final referenceYear = DateTime.now().year;
    return widget.lastDate?.year ?? (referenceYear + 300);
  }

  bool _isMonthSelectable(int year, int month) {
    final monthStart = DateTime(year, month, 1);
    final monthEnd = DateTime(year, month + 1, 0);

    if (widget.firstDate != null) {
      final minDate = CalendarGridUtils.normalize(widget.firstDate!);
      if (monthEnd.isBefore(minDate)) {
        return false;
      }
    }

    if (widget.lastDate != null) {
      final maxDate = CalendarGridUtils.normalize(widget.lastDate!);
      if (monthStart.isAfter(maxDate)) {
        return false;
      }
    }

    return true;
  }

  Future<void> _showScrollableYearSelector() async {
    final minYear = _minSelectableYear;
    final maxYear = _maxSelectableYear;
    final initialYear = _currentMonth.year.clamp(minYear, maxYear);
    final yearsCount = maxYear - minYear + 1;
    final initialIndex = initialYear - minYear;

    if (yearsCount <= 0) {
      return;
    }

    final selectedYear = await showModalBottomSheet<int>(
      context: context,
      showDragHandle: true,
      builder: (BuildContext context) {
        var activeYear = initialYear;
        final controller = FixedExtentScrollController(
          initialItem: initialIndex,
        );

        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setModalState) {
            return SafeArea(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Text(
                      'Select Year',
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(height: 8),
                    SizedBox(
                      height: 220,
                      child: ListWheelScrollView.useDelegate(
                        controller: controller,
                        itemExtent: 42,
                        perspective: 0.004,
                        diameterRatio: 1.6,
                        physics: const FixedExtentScrollPhysics(),
                        onSelectedItemChanged: (int index) {
                          setModalState(() {
                            activeYear = minYear + index;
                          });
                        },
                        childDelegate: ListWheelChildBuilderDelegate(
                          childCount: yearsCount,
                          builder: (BuildContext context, int index) {
                            final year = minYear + index;
                            final selected = year == activeYear;
                            return Center(
                              child: Text(
                                '$year',
                                style: TextStyle(
                                  fontSize: selected ? 22 : 18,
                                  fontWeight: selected
                                      ? FontWeight.w700
                                      : FontWeight.w500,
                                  color: selected
                                      ? _theme.headerBackgroundColor
                                      : _theme.dateCellTextColor.withValues(
                                          alpha: 0.8,
                                        ),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: <Widget>[
                        TextButton(
                          onPressed: () => Navigator.of(context).pop(),
                          child: Text(
                            CalendarLocalizationUtils.cancel(widget.language),
                          ),
                        ),
                        const Spacer(),
                        FilledButton(
                          onPressed: () =>
                              Navigator.of(context).pop(activeYear),
                          child: Text(
                            CalendarLocalizationUtils.ok(widget.language),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );

    if (!mounted ||
        selectedYear == null ||
        selectedYear == _currentMonth.year) {
      return;
    }

    setState(() {
      _currentMonth = DateTime(selectedYear, _currentMonth.month);
    });
  }

  @override
  Widget build(BuildContext context) {
    final content = FadeTransition(
      opacity: _fadeAnimation,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          if (widget.helpText != null) _buildHelpText(context),
          _buildModeSwitch(context),
          const SizedBox(height: 8),
          if (_showYearGrid)
            _buildYearGrid(context)
          else
            _buildCalendar(context),
          if (_selectedCompleteDate != null) ...<Widget>[
            const SizedBox(height: 10),
            MyanmarDateSummaryCard(
              date: _selectedCompleteDate!,
              language: widget.language,
              theme: _theme,
              showHolidays: widget.showHolidays,
              showAstrology: widget.showAstrology,
            ),
          ],
          if (widget.showTodayButton ||
              widget.showClearButton ||
              widget.showActionButtons)
            _buildActionRow(context),
        ],
      ),
    );

    final decorated = AnimatedContainer(
      duration: widget.animationDuration,
      margin: widget.margin,
      padding: widget.padding ?? const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: _theme.backgroundColor,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: _theme.borderColor.withValues(alpha: 0.4)),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.07),
            blurRadius: 16,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: SingleChildScrollView(child: content),
    );

    if (widget.width == null && widget.height == null) {
      return decorated;
    }

    return SizedBox(
      width: widget.width,
      height: widget.height,
      child: decorated,
    );
  }

  Widget _buildHelpText(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Text(
        widget.helpText!,
        style: Theme.of(context).textTheme.titleSmall?.copyWith(
          color: _theme.weekdayHeaderTextColor,
          fontWeight: FontWeight.w600,
        ),
        textAlign: TextAlign.center,
      ),
    );
  }

  Widget _buildModeSwitch(BuildContext context) {
    final foreground = _theme.headerBackgroundColor;

    return Container(
      decoration: BoxDecoration(
        color: foreground.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(10),
      ),
      padding: const EdgeInsets.all(3),
      child: Row(
        children: <Widget>[
          Expanded(
            child: _ModeButton(
              label: CalendarLocalizationUtils.calendar(widget.language),
              active: !_showYearGrid,
              activeColor: foreground,
              onTap: () => setState(() => _showYearGrid = false),
            ),
          ),
          Expanded(
            child: _ModeButton(
              label: CalendarLocalizationUtils.yearView(widget.language),
              active: _showYearGrid,
              activeColor: foreground,
              onTap: () => setState(() => _showYearGrid = true),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCalendar(BuildContext context) {
    return MyanmarCalendarWidget(
      initialDate: _currentMonth,
      selectedDate: _selectedDate,
      language: widget.language,
      config: widget.config,
      firstDayOfWeek: widget.firstDayOfWeek,
      highlightToday: widget.highlightToday,
      highlightWeekends: widget.highlightWeekends,
      minDate: widget.firstDate,
      maxDate: widget.lastDate,
      showHolidays: widget.showHolidays,
      showAstrology: widget.showAstrology,
      showWesternDates: widget.showWesternDates,
      showMyanmarDates: widget.showMyanmarDates,
      theme: _theme,
      onMonthChanged: (month) {
        _currentMonth = DateTime(month.year, month.month);
      },
      onDateSelected: _onCalendarDateSelected,
    );
  }

  Widget _buildYearGrid(BuildContext context) {
    final year = _currentMonth.year;
    final canGoPrev = year > _minSelectableYear;
    final canGoNext = year < _maxSelectableYear;

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            IconButton(
              onPressed: canGoPrev ? () => _jumpYear(-1) : null,
              icon: const Icon(Icons.chevron_left),
            ),
            InkWell(
              onTap: _showScrollableYearSelector,
              borderRadius: BorderRadius.circular(999),
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  color: _theme.headerBackgroundColor.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(999),
                  border: Border.all(
                    color: _theme.headerBackgroundColor.withValues(alpha: 0.25),
                  ),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Text(
                      '$year',
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(width: 4),
                    const Icon(Icons.unfold_more, size: 18),
                  ],
                ),
              ),
            ),
            IconButton(
              onPressed: canGoNext ? () => _jumpYear(1) : null,
              icon: const Icon(Icons.chevron_right),
            ),
          ],
        ),
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            crossAxisSpacing: 8,
            mainAxisSpacing: 8,
            childAspectRatio: 2.1,
          ),
          itemCount: 12,
          itemBuilder: (BuildContext context, int index) {
            final month = index + 1;
            final isCurrent = month == _currentMonth.month;
            final isSelectable = _isMonthSelectable(_currentMonth.year, month);
            final label = CalendarLocalizationUtils.shortWesternMonth(
              month,
              widget.language,
            );

            return InkWell(
              borderRadius: BorderRadius.circular(10),
              onTap: isSelectable ? () => _selectMonth(month) : null,
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 180),
                decoration: BoxDecoration(
                  color: !isSelectable
                      ? _theme.disabledDateBackgroundColor
                      : isCurrent
                      ? _theme.headerBackgroundColor
                      : _theme.headerBackgroundColor.withValues(alpha: 0.08),
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                    color: !isSelectable
                        ? _theme.disabledDateTextColor.withValues(alpha: 0.3)
                        : isCurrent
                        ? _theme.headerBackgroundColor
                        : _theme.headerBackgroundColor.withValues(alpha: 0.25),
                  ),
                ),
                child: Center(
                  child: Text(
                    label,
                    style: TextStyle(
                      color: !isSelectable
                          ? _theme.disabledDateTextColor
                          : isCurrent
                          ? _theme.headerTextColor
                          : _theme.dateCellTextColor,
                      fontWeight: isCurrent ? FontWeight.w700 : FontWeight.w500,
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ],
    );
  }

  Widget _buildActionRow(BuildContext context) {
    final language = widget.language;
    final utilityButtons = <Widget>[
      if (widget.showTodayButton)
        OutlinedButton.icon(
          onPressed: _onTodayPressed,
          icon: const Icon(Icons.today, size: 16),
          label: Text(CalendarLocalizationUtils.today(language)),
        ),
      if (widget.showClearButton)
        OutlinedButton.icon(
          onPressed: _selectedDate == null ? null : _onClearPressed,
          icon: const Icon(Icons.clear, size: 16),
          label: Text(CalendarLocalizationUtils.clear(language)),
        ),
    ];

    final modalButtons = <Widget>[
      if (widget.showActionButtons)
        TextButton(
          onPressed: _onCancelPressed,
          child: Text(
            widget.cancelText ?? CalendarLocalizationUtils.cancel(language),
          ),
        ),
      if (widget.showActionButtons)
        FilledButton(
          onPressed: _selectedDate == null ? null : _onConfirmPressed,
          child: Text(
            widget.confirmText ?? CalendarLocalizationUtils.ok(language),
          ),
        ),
    ];

    return Padding(
      padding: const EdgeInsets.only(top: 10),
      child: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          final isCompact = constraints.maxWidth < 430;

          if (isCompact) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                if (utilityButtons.isNotEmpty)
                  Wrap(spacing: 8, runSpacing: 8, children: utilityButtons),
                if (utilityButtons.isNotEmpty && modalButtons.isNotEmpty)
                  const SizedBox(height: 8),
                if (modalButtons.isNotEmpty)
                  Wrap(
                    alignment: WrapAlignment.end,
                    spacing: 8,
                    runSpacing: 8,
                    children: modalButtons,
                  ),
              ],
            );
          }

          return Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              if (utilityButtons.isNotEmpty)
                Expanded(
                  child: Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: utilityButtons,
                  ),
                ),
              if (utilityButtons.isNotEmpty && modalButtons.isNotEmpty)
                const SizedBox(width: 8),
              if (modalButtons.isNotEmpty)
                Wrap(spacing: 8, runSpacing: 8, children: modalButtons),
            ],
          );
        },
      ),
    );
  }
}

class _ModeButton extends StatelessWidget {
  const _ModeButton({
    required this.label,
    required this.active,
    required this.activeColor,
    required this.onTap,
  });

  final String label;
  final bool active;
  final Color activeColor;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 180),
        padding: const EdgeInsets.symmetric(vertical: 8),
        decoration: BoxDecoration(
          color: active ? activeColor : Colors.transparent,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Text(
          label,
          textAlign: TextAlign.center,
          style: TextStyle(
            color: active ? Colors.white : activeColor,
            fontWeight: active ? FontWeight.w700 : FontWeight.w500,
          ),
        ),
      ),
    );
  }
}

/// Shows a dialog-based Myanmar date picker and returns selected date.
Future<CompleteDate?> showMyanmarDatePicker({
  required BuildContext context,
  DateTime? initialDate,
  DateTime? firstDate,
  DateTime? lastDate,
  Language language = Language.myanmar,
  CalendarConfig? config,
  String? helpText,
  String? cancelText,
  String? confirmText,
  MyanmarCalendarTheme? theme,
  bool showHolidays = true,
  bool showAstrology = false,
  bool showWesternDates = true,
  bool showMyanmarDates = true,
  int firstDayOfWeek = 1,
  bool highlightToday = true,
  bool highlightWeekends = true,
  bool barrierDismissible = true,
  Color? barrierColor,
}) async {
  return showDialog<CompleteDate>(
    context: context,
    barrierDismissible: barrierDismissible,
    barrierColor: barrierColor,
    builder: (BuildContext dialogContext) {
      return Dialog(
        insetPadding: const EdgeInsets.all(10),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        child: MyanmarDatePickerWidget(
          initialDate: initialDate,
          firstDate: firstDate,
          lastDate: lastDate,
          language: language,
          config: config,
          helpText: helpText ?? CalendarLocalizationUtils.selectDate(language),
          cancelText: cancelText,
          confirmText: confirmText,
          theme: theme,
          showHolidays: showHolidays,
          showAstrology: showAstrology,
          showWesternDates: showWesternDates,
          showMyanmarDates: showMyanmarDates,
          firstDayOfWeek: firstDayOfWeek,
          highlightToday: highlightToday,
          highlightWeekends: highlightWeekends,
          isModal: true,
          showActionButtons: true,
          onConfirm: (date) => Navigator.of(dialogContext).pop(date),
          onCancel: () => Navigator.of(dialogContext).pop(),
        ),
      );
    },
  );
}

/// Shows a fullscreen Myanmar date picker page and returns selected date.
Future<CompleteDate?> showMyanmarDatePickerFullscreen({
  required BuildContext context,
  DateTime? initialDate,
  DateTime? firstDate,
  DateTime? lastDate,
  Language language = Language.myanmar,
  CalendarConfig? config,
  String? title,
  String? cancelText,
  String? confirmText,
  MyanmarCalendarTheme? theme,
  bool showHolidays = true,
  bool showAstrology = false,
  bool showWesternDates = true,
  bool showMyanmarDates = true,
  int firstDayOfWeek = 1,
  bool highlightToday = true,
  bool highlightWeekends = true,
}) async {
  return Navigator.of(context).push<CompleteDate>(
    MaterialPageRoute<CompleteDate>(
      fullscreenDialog: true,
      builder: (BuildContext pageContext) {
        return Scaffold(
          appBar: AppBar(
            title: Text(
              title ?? CalendarLocalizationUtils.selectDate(language),
            ),
            leading: IconButton(
              onPressed: () => Navigator.of(pageContext).pop(),
              icon: const Icon(Icons.close),
            ),
          ),
          body: SafeArea(
            child: MyanmarDatePickerWidget(
              initialDate: initialDate,
              firstDate: firstDate,
              lastDate: lastDate,
              language: language,
              config: config,
              cancelText: cancelText,
              confirmText: confirmText,
              theme: theme,
              showHolidays: showHolidays,
              showAstrology: showAstrology,
              showWesternDates: showWesternDates,
              showMyanmarDates: showMyanmarDates,
              firstDayOfWeek: firstDayOfWeek,
              highlightToday: highlightToday,
              highlightWeekends: highlightWeekends,
              isModal: true,
              showActionButtons: true,
              padding: const EdgeInsets.all(16),
              onConfirm: (date) => Navigator.of(pageContext).pop(date),
              onCancel: () => Navigator.of(pageContext).pop(),
            ),
          ),
        );
      },
    ),
  );
}
