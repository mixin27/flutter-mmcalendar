import 'package:flutter/material.dart';
import 'package:flutter_mmcalendar/src/core/calendar_config.dart';
import 'package:flutter_mmcalendar/src/localization/language.dart';
import 'package:flutter_mmcalendar/src/localization/translation_service.dart';
import 'package:flutter_mmcalendar/src/models/complete_date.dart';
import 'package:flutter_mmcalendar/src/services/myanmar_calendar_service.dart';
import 'package:flutter_mmcalendar/src/utils/package_constants.dart';

/// A comprehensive Myanmar Calendar widget for Flutter applications
///
/// This widget displays a full calendar view with Myanmar dates, Western dates,
/// holidays, astrological information, and supports multiple languages.
///
/// ## Features
/// - Full calendar view with Myanmar and Western dates
/// - Holiday highlighting and information
/// - Astrological day marking
/// - Multi-language support
/// - Customizable themes and styling
/// - Touch interaction and date selection
/// - Month/year navigation
/// - Today highlighting
/// - Weekend highlighting
/// - Custom date cell rendering
///
/// ## Example Usage
///
/// ```dart
/// MyanmarCalendarWidget(
///   initialDate: DateTime.now(),
///   language: Language.myanmar,
///   onDateSelected: (date) {
///     print('Selected: ${date.formatComplete()}');
///   },
///   showHolidays: true,
///   showAstrology: true,
///   theme: MyanmarCalendarTheme.traditional(),
/// )
/// ```
class MyanmarCalendarWidget extends StatefulWidget {
  /// Initial date to display (defaults to today)
  final DateTime? initialDate;

  /// Language for display (defaults to English)
  final Language language;

  /// Calendar configuration
  final CalendarConfig? config;

  /// Callback when a date is selected
  final void Function(CompleteDate date)? onDateSelected;

  /// Callback when month changes
  final void Function(DateTime month)? onMonthChanged;

  /// Whether to show holidays
  final bool showHolidays;

  /// Whether to show astrological information
  final bool showAstrology;

  /// Whether to show Western dates
  final bool showWesternDates;

  /// Whether to show Myanmar dates
  final bool showMyanmarDates;

  /// Whether to show weekday headers
  final bool showWeekdayHeaders;

  /// Whether to show month/year header
  final bool showHeader;

  /// Whether to show navigation buttons
  final bool showNavigation;

  /// Whether to enable date selection
  final bool enableSelection;

  /// Custom theme for the calendar
  final MyanmarCalendarTheme? theme;

  /// Custom cell builder
  final Widget Function(BuildContext context, CompleteDate date)? cellBuilder;

  /// Custom header builder
  final Widget Function(BuildContext context, DateTime month)? headerBuilder;

  /// Height of the calendar
  final double? height;

  /// Width of the calendar
  final double? width;

  /// Padding around the calendar
  final EdgeInsetsGeometry? padding;

  /// Margin around the calendar
  final EdgeInsetsGeometry? margin;

  /// First day of week (0=Saturday, 1=Sunday, etc.) - Myanmar weekday system
  final int firstDayOfWeek;

  /// Selected date
  final DateTime? selectedDate;

  /// Minimum selectable date
  final DateTime? minDate;

  /// Maximum selectable date
  final DateTime? maxDate;

  /// Whether to highlight today
  final bool highlightToday;

  /// Whether to highlight weekends
  final bool highlightWeekends;

  /// Animation duration for transitions
  final Duration animationDuration;

  /// Whether to show animations
  final bool enableAnimations;

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
    this.firstDayOfWeek = 1, // Sunday in Myanmar weekday system
    this.selectedDate,
    this.minDate,
    this.maxDate,
    this.highlightToday = true,
    this.highlightWeekends = true,
    this.animationDuration = const Duration(milliseconds: 300),
    this.enableAnimations = true,
  });

  @override
  State<MyanmarCalendarWidget> createState() => _MyanmarCalendarWidgetState();
}

class _MyanmarCalendarWidgetState extends State<MyanmarCalendarWidget>
    with TickerProviderStateMixin {
  late MyanmarCalendarService _service;
  late MyanmarCalendarTheme _theme;
  late DateTime _currentMonth;
  DateTime? _selectedDate;
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  late PageController _pageController;

  // Cache for complete dates to avoid recalculation
  final Map<String, CompleteDate> _dateCache = {};

  @override
  void initState() {
    super.initState();
    _initializeWidget();
  }

  void _initializeWidget() {
    // Initialize service and configuration
    _service = MyanmarCalendarService(
      config: widget.config,
      defaultLanguage: widget.language,
    );

    // Ensure TranslationService is set to correct language
    TranslationService.setLanguage(widget.language);

    // Initialize theme
    _theme = widget.theme ?? MyanmarCalendarTheme.defaultTheme();

    // Initialize current month
    _currentMonth = DateTime(
      (widget.initialDate ?? DateTime.now()).year,
      (widget.initialDate ?? DateTime.now()).month,
      1,
    );

    // Initialize selected date
    _selectedDate = widget.selectedDate ?? widget.initialDate;

    // Initialize animations
    _animationController = AnimationController(
      duration: widget.animationDuration,
      vsync: this,
    );

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );

    // Initialize page controller
    _pageController = PageController();

    // Start animation
    if (widget.enableAnimations) {
      _animationController.forward();
    }
  }

  @override
  void dispose() {
    _animationController.dispose();
    _pageController.dispose();
    super.dispose();
  }

  @override
  void didUpdateWidget(MyanmarCalendarWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    // Update service if configuration changed
    if (widget.config != oldWidget.config ||
        widget.language != oldWidget.language) {
      _service = MyanmarCalendarService(
        config: widget.config,
        defaultLanguage: widget.language,
      );
      _dateCache.clear(); // Clear cache when configuration changes
    }

    // Update theme if changed
    if (widget.theme != oldWidget.theme) {
      _theme = widget.theme ?? MyanmarCalendarTheme.defaultTheme();
    }

    // Update selected date if changed
    if (widget.selectedDate != oldWidget.selectedDate) {
      _selectedDate = widget.selectedDate;
    }
  }

  // ============================================================================
  // HELPER METHODS
  // ============================================================================

  /// Get complete date information with caching
  CompleteDate _getCompleteDate(DateTime date) {
    final key = '${date.year}-${date.month}-${date.day}';
    if (!_dateCache.containsKey(key)) {
      _dateCache[key] = _service.getCompleteDate(date);
    }
    return _dateCache[key]!;
  }

  /// Get dates for current month view
  List<DateTime> _getCalendarDates() {
    final firstDayOfMonth = DateTime(
      _currentMonth.year,
      _currentMonth.month,
      1,
    );
    final lastDayOfMonth = DateTime(
      _currentMonth.year,
      _currentMonth.month + 1,
      0,
    );

    // Calculate the start date (may be from previous month)
    var startDate = firstDayOfMonth;

    // Convert DateTime weekday (1=Monday, 7=Sunday) to Myanmar weekday (0=Saturday, 1=Sunday, ..., 6=Friday)
    final firstDayMyanmarWeekday = (firstDayOfMonth.weekday + 1) % 7;

    // Calculate how many days back we need to go to reach the first day of week
    final daysBack = (firstDayMyanmarWeekday - widget.firstDayOfWeek + 7) % 7;
    if (daysBack > 0) {
      startDate = firstDayOfMonth.subtract(Duration(days: daysBack));
    }

    // Calculate the end date (may be from next month)
    var endDate = lastDayOfMonth;
    final lastDayMyanmarWeekday = (lastDayOfMonth.weekday + 1) % 7;
    final daysForward = (widget.firstDayOfWeek + 6 - lastDayMyanmarWeekday) % 7;
    if (daysForward > 0) {
      endDate = lastDayOfMonth.add(Duration(days: daysForward));
    }

    // Generate all dates for the calendar grid (should be exactly 42 dates = 6 weeks × 7 days)
    final dates = <DateTime>[];
    var currentDate = startDate;
    while (!currentDate.isAfter(endDate) && dates.length < 42) {
      dates.add(currentDate);
      currentDate = currentDate.add(const Duration(days: 1));
    }

    // Ensure we always have exactly 42 dates for a 6×7 grid
    while (dates.length < 42) {
      dates.add(currentDate);
      currentDate = currentDate.add(const Duration(days: 1));
    }

    return dates;
  }

  /// Check if date is selectable
  bool _isDateSelectable(DateTime date) {
    if (!widget.enableSelection) return false;
    if (widget.minDate != null && date.isBefore(widget.minDate!)) return false;
    if (widget.maxDate != null && date.isAfter(widget.maxDate!)) return false;
    return true;
  }

  /// Check if date is today
  bool _isToday(DateTime date) {
    final now = DateTime.now();
    return date.year == now.year &&
        date.month == now.month &&
        date.day == now.day;
  }

  /// Check if date is selected
  bool _isSelected(DateTime date) {
    if (_selectedDate == null) return false;
    return date.year == _selectedDate!.year &&
        date.month == _selectedDate!.month &&
        date.day == _selectedDate!.day;
  }

  /// Check if date is in current month
  bool _isInCurrentMonth(DateTime date) {
    return date.year == _currentMonth.year && date.month == _currentMonth.month;
  }

  /// Check if date is weekend
  bool _isWeekend(DateTime date) {
    // DateTime uses 1=Monday, 7=Sunday
    // But we need to check against Myanmar calendar system: 0=Saturday, 1=Sunday, ..., 6=Friday
    final myanmarWeekday =
        (date.weekday + 1) % 7; // Convert DateTime weekday to Myanmar weekday
    return myanmarWeekday == 0 || myanmarWeekday == 1; // Saturday or Sunday
  }

  /// Navigate to previous month
  void _goToPreviousMonth() {
    setState(() {
      _currentMonth = DateTime(_currentMonth.year, _currentMonth.month - 1, 1);
    });
    widget.onMonthChanged?.call(_currentMonth);
    _animateTransition();
  }

  /// Navigate to next month
  void _goToNextMonth() {
    setState(() {
      _currentMonth = DateTime(_currentMonth.year, _currentMonth.month + 1, 1);
    });
    widget.onMonthChanged?.call(_currentMonth);
    _animateTransition();
  }

  /// Animate transition
  void _animateTransition() {
    if (widget.enableAnimations) {
      _animationController.reset();
      _animationController.forward();
    }
  }

  /// Handle date selection
  void _onDateTap(DateTime date) {
    if (!_isDateSelectable(date)) return;

    setState(() {
      _selectedDate = date;
    });

    final completeDate = _getCompleteDate(date);
    widget.onDateSelected?.call(completeDate);
  }

  // ============================================================================
  // BUILD METHODS
  // ============================================================================

  @override
  Widget build(BuildContext context) {
    return Container(
      height: widget.height,
      width: widget.width,
      padding: widget.padding ?? const EdgeInsets.all(8.0),
      margin: widget.margin,
      decoration: _theme.calendarDecoration,
      child: Column(
        children: [
          if (widget.showHeader) _buildHeader(),
          if (widget.showWeekdayHeaders) _buildWeekdayHeaders(),
          Expanded(child: _buildCalendarGrid()),
        ],
      ),
    );
  }

  /// Build calendar header with month/year and navigation
  Widget _buildHeader() {
    return Container(
      height: PackageConstants.getDimension('headerHeight'),
      decoration: _theme.headerDecoration,
      child:
          widget.headerBuilder?.call(context, _currentMonth) ??
          Row(
            children: [
              if (widget.showNavigation) _buildNavigationButton(true),
              Expanded(child: _buildMonthYearTitle()),
              if (widget.showNavigation) _buildNavigationButton(false),
            ],
          ),
    );
  }

  /// Build month/year title
  Widget _buildMonthYearTitle() {
    final myanmarDate = _service.westernToMyanmar(_currentMonth);

    return InkWell(
      onTap: () => _showMonthYearPicker(),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (widget.showMyanmarDates) ...[
              Text(
                _service.formatMyanmarDate(
                  myanmarDate,
                  pattern: '&y &M',
                  language: widget.language,
                ),
                style: _theme.headerTextStyle,
                textAlign: TextAlign.center,
              ),
            ],
            if (widget.showWesternDates) ...[
              Text(
                _service.formatWesternDate(
                  _service.myanmarToWesternDate(
                    myanmarDate.year,
                    myanmarDate.month,
                    myanmarDate.day,
                  ),
                  pattern: '%M %yyyy',
                  language: widget.language,
                ),
                style: _theme.headerSubTextStyle,
                textAlign: TextAlign.center,
              ),
            ],
          ],
        ),
      ),
    );
  }

  /// Build navigation button
  Widget _buildNavigationButton(bool isPrevious) {
    return IconButton(
      icon: Icon(
        isPrevious ? Icons.chevron_left : Icons.chevron_right,
        color: _theme.navigationIconColor,
        size: PackageConstants.getDimension('iconSize'),
      ),
      onPressed: isPrevious ? _goToPreviousMonth : _goToNextMonth,
      tooltip: isPrevious
          ? TranslationService.translate('previousMonth')
          : TranslationService.translate('nextMonth'),
    );
  }

  /// Build weekday headers
  Widget _buildWeekdayHeaders() {
    return Container(
      height: 40,
      decoration: _theme.weekdayHeaderDecoration,
      child: Row(
        children: List.generate(7, (index) {
          final myanmarWeekdayIndex = (widget.firstDayOfWeek + index) % 7;

          String weekdayName = TranslationService.getWeekdayName(
            myanmarWeekdayIndex,
            widget.language,
          );

          // Improved abbreviation logic
          String abbreviation = _getWeekdayAbbreviation(weekdayName);

          return Expanded(
            child: Container(
              alignment: Alignment.center,
              child: Text(abbreviation, style: _theme.weekdayTextStyle),
            ),
          );
        }),
      ),
    );
  }

  /// Get weekday abbreviation with better logic
  String _getWeekdayAbbreviation(String weekdayName) {
    // Handle different languages appropriately
    switch (widget.language) {
      case Language.myanmar:
      case Language.zawgyi:
        // For Myanmar script, use first 3 characters or less if shorter
        return weekdayName.length > 3
            ? weekdayName.substring(0, 3)
            : weekdayName;
      case Language.english:
        // For English, use standard 3-letter abbreviations
        return weekdayName.length > 3
            ? weekdayName.substring(0, 3)
            : weekdayName;
      default:
        // For other languages, use first 3 characters or the whole name if shorter
        return weekdayName.length > 3
            ? weekdayName.substring(0, 3)
            : weekdayName;
    }
  }

  /// Build calendar grid
  Widget _buildCalendarGrid() {
    final dates = _getCalendarDates();

    return widget.enableAnimations
        ? FadeTransition(opacity: _fadeAnimation, child: _buildGrid(dates))
        : _buildGrid(dates);
  }

  /// Build the actual grid
  Widget _buildGrid(List<DateTime> dates) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 7,
        childAspectRatio: 1.0,
      ),
      itemCount: dates.length,
      itemBuilder: (context, index) {
        final date = dates[index];
        return _buildDateCell(date);
      },
    );
  }

  /// Build individual date cell
  Widget _buildDateCell(DateTime date) {
    if (widget.cellBuilder != null) {
      final completeDate = _getCompleteDate(date);
      return widget.cellBuilder!(context, completeDate);
    }

    final completeDate = _getCompleteDate(date);
    final isToday = _isToday(date);
    final isSelected = _isSelected(date);
    final isInCurrentMonth = _isInCurrentMonth(date);
    final isWeekend = _isWeekend(date);
    final isSelectable = _isDateSelectable(date);

    // Determine cell style
    BoxDecoration? decoration;
    TextStyle? textStyle = _theme.dateTextStyle;

    if (isSelected) {
      decoration = _theme.selectedDateDecoration;
      textStyle = _theme.selectedDateTextStyle;
    } else if (isToday && widget.highlightToday) {
      decoration = _theme.todayDecoration;
      textStyle = _theme.todayTextStyle;
    } else if (completeDate.hasHolidays && widget.showHolidays) {
      decoration = _theme.holidayDecoration;
      textStyle = _theme.holidayTextStyle;
    } else if (completeDate.hasAstrologicalDays && widget.showAstrology) {
      decoration = _theme.astrologicalDecoration;
      textStyle = _theme.astrologicalTextStyle;
    } else if (isWeekend && widget.highlightWeekends) {
      decoration = _theme.weekendDecoration;
      textStyle = _theme.weekendTextStyle;
    }

    if (!isInCurrentMonth) {
      textStyle = textStyle.copyWith(
        color: textStyle.color?.withValues(alpha: 0.4),
      );
    }

    if (!isSelectable) {
      textStyle = textStyle.copyWith(
        color: textStyle.color?.withValues(alpha: 0.3),
      );
    }

    return GestureDetector(
      onTap: () => _onDateTap(date),
      child: Container(
        margin: const EdgeInsets.all(1),
        decoration: decoration,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Western date
            if (widget.showWesternDates) ...[
              Text(date.day.toString(), style: textStyle),
            ],

            // Myanmar date
            if (widget.showMyanmarDates) ...[
              Text(
                _formatMyanmarDay(completeDate.myanmarDay),
                style: textStyle.copyWith(
                  fontSize: (textStyle.fontSize ?? 14) * 0.8,
                ),
              ),
            ],

            // Holiday indicator
            if (widget.showHolidays && completeDate.hasHolidays) ...[
              Container(
                width: 4,
                height: 4,
                decoration: BoxDecoration(
                  color: _theme.holidayIndicatorColor,
                  shape: BoxShape.circle,
                ),
              ),
            ],

            // Astrological indicator
            if (widget.showAstrology && completeDate.hasAstrologicalDays) ...[
              Container(
                width: 4,
                height: 4,
                decoration: BoxDecoration(
                  color: _theme.astrologicalIndicatorColor,
                  shape: BoxShape.circle,
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  /// Format Myanmar day with localization
  String _formatMyanmarDay(int day) {
    return TranslationService.translate(day.toString());
  }

  /// Show month/year picker
  void _showMonthYearPicker() {
    showDialog(
      context: context,
      builder: (context) => _MonthYearPickerDialog(
        initialDate: _currentMonth,
        language: widget.language,
        service: _service,
        theme: _theme,
        onDateSelected: (selectedDate) {
          setState(() {
            _currentMonth = DateTime(selectedDate.year, selectedDate.month, 1);
          });
          widget.onMonthChanged?.call(_currentMonth);
          _animateTransition();
        },
      ),
    );
  }
}

// ============================================================================
// MYANMAR CALENDAR THEME
// ============================================================================

/// Theme configuration for Myanmar Calendar Widget
class MyanmarCalendarTheme {
  final BoxDecoration? calendarDecoration;
  final BoxDecoration? headerDecoration;
  final BoxDecoration? weekdayHeaderDecoration;
  final BoxDecoration? selectedDateDecoration;
  final BoxDecoration? todayDecoration;
  final BoxDecoration? holidayDecoration;
  final BoxDecoration? astrologicalDecoration;
  final BoxDecoration? weekendDecoration;

  final TextStyle headerTextStyle;
  final TextStyle headerSubTextStyle;
  final TextStyle weekdayTextStyle;
  final TextStyle dateTextStyle;
  final TextStyle selectedDateTextStyle;
  final TextStyle todayTextStyle;
  final TextStyle holidayTextStyle;
  final TextStyle astrologicalTextStyle;
  final TextStyle weekendTextStyle;

  final Color navigationIconColor;
  final Color holidayIndicatorColor;
  final Color astrologicalIndicatorColor;

  const MyanmarCalendarTheme({
    this.calendarDecoration,
    this.headerDecoration,
    this.weekdayHeaderDecoration,
    this.selectedDateDecoration,
    this.todayDecoration,
    this.holidayDecoration,
    this.astrologicalDecoration,
    this.weekendDecoration,
    required this.headerTextStyle,
    required this.headerSubTextStyle,
    required this.weekdayTextStyle,
    required this.dateTextStyle,
    required this.selectedDateTextStyle,
    required this.todayTextStyle,
    required this.holidayTextStyle,
    required this.astrologicalTextStyle,
    required this.weekendTextStyle,
    required this.navigationIconColor,
    required this.holidayIndicatorColor,
    required this.astrologicalIndicatorColor,
  });

  /// Default theme
  static MyanmarCalendarTheme defaultTheme() {
    return MyanmarCalendarTheme(
      calendarDecoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.1),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      headerDecoration: BoxDecoration(
        color: Colors.blue[600],
        borderRadius: const BorderRadius.vertical(top: Radius.circular(8)),
      ),
      weekdayHeaderDecoration: BoxDecoration(
        color: Colors.grey[100],
        border: Border(bottom: BorderSide(color: Colors.grey[300]!)),
      ),
      selectedDateDecoration: BoxDecoration(
        color: Colors.blue[600],
        shape: BoxShape.circle,
      ),
      todayDecoration: BoxDecoration(
        border: Border.all(color: Colors.blue[600]!, width: 2),
        shape: BoxShape.circle,
      ),
      holidayDecoration: BoxDecoration(
        color: Colors.red[100],
        shape: BoxShape.circle,
      ),
      astrologicalDecoration: BoxDecoration(
        color: Colors.orange[100],
        shape: BoxShape.circle,
      ),
      weekendDecoration: BoxDecoration(
        color: Colors.grey[100],
        shape: BoxShape.circle,
      ),
      headerTextStyle: const TextStyle(
        color: Colors.white,
        fontSize: 16,
        fontWeight: FontWeight.bold,
      ),
      headerSubTextStyle: const TextStyle(color: Colors.white70, fontSize: 12),
      weekdayTextStyle: TextStyle(
        color: Colors.grey[600],
        fontSize: 12,
        fontWeight: FontWeight.w500,
      ),
      dateTextStyle: const TextStyle(color: Colors.black87, fontSize: 14),
      selectedDateTextStyle: const TextStyle(
        color: Colors.white,
        fontSize: 14,
        fontWeight: FontWeight.bold,
      ),
      todayTextStyle: TextStyle(
        color: Colors.blue[600],
        fontSize: 14,
        fontWeight: FontWeight.bold,
      ),
      holidayTextStyle: TextStyle(
        color: Colors.red[700],
        fontSize: 14,
        fontWeight: FontWeight.w500,
      ),
      astrologicalTextStyle: TextStyle(
        color: Colors.orange[700],
        fontSize: 14,
        fontWeight: FontWeight.w500,
      ),
      weekendTextStyle: TextStyle(color: Colors.grey[600], fontSize: 14),
      navigationIconColor: Colors.white,
      holidayIndicatorColor: Colors.red[600]!,
      astrologicalIndicatorColor: Colors.orange[600]!,
    );
  }

  /// Traditional Myanmar theme
  static MyanmarCalendarTheme traditional() {
    return MyanmarCalendarTheme(
      calendarDecoration: BoxDecoration(
        color: const Color(0xFFFFFDE7), // Cream
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFB71C1C), width: 2),
      ),
      headerDecoration: const BoxDecoration(
        color: Color(0xFFB71C1C), // Deep red
        borderRadius: BorderRadius.vertical(top: Radius.circular(10)),
      ),
      weekdayHeaderDecoration: BoxDecoration(
        color: const Color(0xFFFFC107).withValues(alpha: 0.3), // Gold tint
        border: const Border(
          bottom: BorderSide(color: Color(0xFFB71C1C), width: 1),
        ),
      ),
      selectedDateDecoration: const BoxDecoration(
        color: Color(0xFFB71C1C),
        shape: BoxShape.circle,
      ),
      todayDecoration: BoxDecoration(
        border: Border.all(color: const Color(0xFFFFC107), width: 2),
        shape: BoxShape.circle,
      ),
      holidayDecoration: BoxDecoration(
        color: const Color(0xFFB71C1C).withValues(alpha: 0.2),
        shape: BoxShape.circle,
      ),
      astrologicalDecoration: BoxDecoration(
        color: const Color(0xFF2E7D32).withValues(alpha: 0.2),
        shape: BoxShape.circle,
      ),
      weekendDecoration: BoxDecoration(
        color: const Color(0xFFFFC107).withValues(alpha: 0.1),
        shape: BoxShape.circle,
      ),
      headerTextStyle: const TextStyle(
        color: Color(0xFFFFFDE7),
        fontSize: 16,
        fontWeight: FontWeight.bold,
      ),
      headerSubTextStyle: const TextStyle(
        color: Color(0xFFFFC107),
        fontSize: 12,
      ),
      weekdayTextStyle: const TextStyle(
        color: Color(0xFFB71C1C),
        fontSize: 12,
        fontWeight: FontWeight.w600,
      ),
      dateTextStyle: const TextStyle(color: Color(0xFF212121), fontSize: 14),
      selectedDateTextStyle: const TextStyle(
        color: Color(0xFFFFFDE7),
        fontSize: 14,
        fontWeight: FontWeight.bold,
      ),
      todayTextStyle: const TextStyle(
        color: Color(0xFFFFC107),
        fontSize: 14,
        fontWeight: FontWeight.bold,
      ),
      holidayTextStyle: const TextStyle(
        color: Color(0xFFB71C1C),
        fontSize: 14,
        fontWeight: FontWeight.w600,
      ),
      astrologicalTextStyle: const TextStyle(
        color: Color(0xFF2E7D32),
        fontSize: 14,
        fontWeight: FontWeight.w500,
      ),
      weekendTextStyle: const TextStyle(color: Color(0xFF757575), fontSize: 14),
      navigationIconColor: const Color(0xFFFFFDE7),
      holidayIndicatorColor: const Color(0xFFB71C1C),
      astrologicalIndicatorColor: const Color(0xFF2E7D32),
    );
  }

  /// Dark theme
  static MyanmarCalendarTheme dark() {
    return MyanmarCalendarTheme(
      calendarDecoration: BoxDecoration(
        color: const Color(0xFF1E1E1E),
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.3),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      headerDecoration: const BoxDecoration(
        color: Color(0xFF90CAF9),
        borderRadius: BorderRadius.vertical(top: Radius.circular(8)),
      ),
      weekdayHeaderDecoration: BoxDecoration(
        color: const Color(0xFF2E2E2E),
        border: Border(bottom: BorderSide(color: Colors.grey[600]!)),
      ),
      selectedDateDecoration: const BoxDecoration(
        color: Color(0xFF90CAF9),
        shape: BoxShape.circle,
      ),
      todayDecoration: BoxDecoration(
        border: Border.all(color: const Color(0xFF81C784), width: 2),
        shape: BoxShape.circle,
      ),
      holidayDecoration: BoxDecoration(
        color: const Color(0xFFCF6679).withValues(alpha: 0.3),
        shape: BoxShape.circle,
      ),
      astrologicalDecoration: BoxDecoration(
        color: const Color(0xFFFFAB40).withValues(alpha: 0.3),
        shape: BoxShape.circle,
      ),
      weekendDecoration: BoxDecoration(
        color: const Color(0xFF424242).withValues(alpha: 0.5),
        shape: BoxShape.circle,
      ),
      headerTextStyle: const TextStyle(
        color: Color(0xFF000000),
        fontSize: 16,
        fontWeight: FontWeight.bold,
      ),
      headerSubTextStyle: const TextStyle(
        color: Color(0xFF424242),
        fontSize: 12,
      ),
      weekdayTextStyle: const TextStyle(
        color: Color(0xFFBDBDBD),
        fontSize: 12,
        fontWeight: FontWeight.w500,
      ),
      dateTextStyle: const TextStyle(color: Color(0xFFFFFFFF), fontSize: 14),
      selectedDateTextStyle: const TextStyle(
        color: Color(0xFF000000),
        fontSize: 14,
        fontWeight: FontWeight.bold,
      ),
      todayTextStyle: const TextStyle(
        color: Color(0xFF81C784),
        fontSize: 14,
        fontWeight: FontWeight.bold,
      ),
      holidayTextStyle: const TextStyle(
        color: Color(0xFFCF6679),
        fontSize: 14,
        fontWeight: FontWeight.w500,
      ),
      astrologicalTextStyle: const TextStyle(
        color: Color(0xFFFFAB40),
        fontSize: 14,
        fontWeight: FontWeight.w500,
      ),
      weekendTextStyle: const TextStyle(color: Color(0xFF9E9E9E), fontSize: 14),
      navigationIconColor: const Color(0xFF000000),
      holidayIndicatorColor: const Color(0xFFCF6679),
      astrologicalIndicatorColor: const Color(0xFFFFAB40),
    );
  }
}

// ============================================================================
// MONTH/YEAR PICKER DIALOG
// ============================================================================

class _MonthYearPickerDialog extends StatefulWidget {
  final DateTime initialDate;
  final Language language;
  final MyanmarCalendarService service;
  final MyanmarCalendarTheme theme;
  final void Function(DateTime) onDateSelected;

  const _MonthYearPickerDialog({
    required this.initialDate,
    required this.language,
    required this.service,
    required this.theme,
    required this.onDateSelected,
  });

  @override
  State<_MonthYearPickerDialog> createState() => _MonthYearPickerDialogState();
}

class _MonthYearPickerDialogState extends State<_MonthYearPickerDialog> {
  late DateTime _selectedDate;
  late PageController _pageController;

  @override
  void initState() {
    super.initState();
    _selectedDate = widget.initialDate;
    _pageController = PageController();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Container(
        width: 300,
        height: 400,
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Text(
              TranslationService.translate('Select Month and Year'),
              style: widget.theme.headerTextStyle.copyWith(color: Colors.black),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: Column(
                children: [
                  _buildYearSelector(),
                  const SizedBox(height: 16),
                  _buildMonthGrid(),
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: Text(TranslationService.translate('Cancel')),
                ),
                const SizedBox(width: 8),
                ElevatedButton(
                  onPressed: () {
                    widget.onDateSelected(_selectedDate);
                    Navigator.of(context).pop();
                  },
                  child: Text(TranslationService.translate('OK')),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildYearSelector() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        IconButton(
          icon: const Icon(Icons.chevron_left),
          onPressed: () {
            setState(() {
              _selectedDate = DateTime(
                _selectedDate.year - 1,
                _selectedDate.month,
              );
            });
          },
        ),
        Text(
          _selectedDate.year.toString(),
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        IconButton(
          icon: const Icon(Icons.chevron_right),
          onPressed: () {
            setState(() {
              _selectedDate = DateTime(
                _selectedDate.year + 1,
                _selectedDate.month,
              );
            });
          },
        ),
      ],
    );
  }

  Widget _buildMonthGrid() {
    return Expanded(
      child: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          childAspectRatio: 2.0,
        ),
        itemCount: 12,
        itemBuilder: (context, index) {
          final month = index + 1;
          final isSelected = month == _selectedDate.month;

          // Improved month name handling
          final monthName = _getMonthName(month);

          return GestureDetector(
            onTap: () {
              setState(() {
                _selectedDate = DateTime(_selectedDate.year, month);
              });
            },
            child: Container(
              margin: const EdgeInsets.all(4),
              decoration: BoxDecoration(
                color: isSelected ? Colors.blue : null,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Colors.grey[300]!),
              ),
              child: Center(
                child: Text(
                  monthName,
                  style: TextStyle(
                    color: isSelected ? Colors.white : Colors.black,
                    fontWeight: isSelected
                        ? FontWeight.bold
                        : FontWeight.normal,
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  /// Improved month name handling with better abbreviation logic
  String _getMonthName(int month) {
    final monthName = TranslationService.getWesternMonthName(
      month - 1, // Convert to 0-based index
      widget.language,
    );

    // Smart abbreviation based on language and name length
    return _createSmartAbbreviation(monthName);
  }

  /// Create smart abbreviation for month names
  String _createSmartAbbreviation(String monthName) {
    // Handle different languages appropriately
    switch (widget.language) {
      case Language.myanmar:
      case Language.zawgyi:
        // For Myanmar script, try to keep meaningful parts
        if (monthName.length <= 4) return monthName;
        return monthName.substring(0, 4);

      case Language.english:
        // For English, use standard 3-letter abbreviations
        if (monthName.length <= 3) return monthName;
        return monthName.substring(0, 3);

      default:
        // For other languages, use adaptive approach
        if (monthName.length <= 4) return monthName;
        return monthName.length > 6
            ? monthName.substring(0, 4)
            : monthName.substring(0, 3);
    }
  }
}
