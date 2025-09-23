import 'package:flutter/material.dart';
import 'package:flutter_mmcalendar/src/core/calendar_config.dart';
import 'package:flutter_mmcalendar/src/core/myanmar_calendar_theme.dart';
import 'package:flutter_mmcalendar/src/localization/language.dart';
import 'package:flutter_mmcalendar/src/localization/translation_service.dart';
import 'package:flutter_mmcalendar/src/models/complete_date.dart';
import 'package:flutter_mmcalendar/src/services/myanmar_calendar_service.dart';

import 'myanmar_calendar_widget.dart';

/// A comprehensive Myanmar Date Picker widget for Flutter applications
///
/// This widget provides an intuitive interface for selecting Myanmar calendar dates
/// with support for both Myanmar and Western date display, multiple languages,
/// and various customization options.
///
/// ## Features
/// - Modal dialog and inline date picker modes
/// - Myanmar and Western date display
/// - Multi-language support
/// - Date range constraints (min/max dates)
/// - Holiday and astrological information display
/// - Customizable themes and styling
/// - Quick date selection shortcuts
/// - Year and month navigation
/// - Today button
/// - Clear/Cancel actions
///
/// ## Usage Examples
///
/// ### Modal Date Picker
/// ```dart
/// final selectedDate = await showMyanmarDatePicker(
///   context: context,
///   initialDate: DateTime.now(),
///   firstDate: DateTime(2020),
///   lastDate: DateTime(2030),
///   language: Language.myanmar,
/// );
/// ```
///
/// ### Inline Date Picker
/// ```dart
/// MyanmarDatePickerWidget(
///   initialDate: DateTime.now(),
///   onDateChanged: (date) {
///     print('Selected: ${date.formatComplete()}');
///   },
///   language: Language.english,
///   showHolidays: true,
/// )
/// ```
class MyanmarDatePickerWidget extends StatefulWidget {
  /// Initial date to display
  final DateTime? initialDate;

  /// Minimum selectable date
  final DateTime? firstDate;

  /// Maximum selectable date
  final DateTime? lastDate;

  /// Language for display
  final Language language;

  /// Calendar configuration
  final CalendarConfig? config;

  /// Callback when date is selected
  final void Function(CompleteDate date)? onDateChanged;

  /// Callback when picker is confirmed (for modal mode)
  final void Function(CompleteDate date)? onConfirm;

  /// Callback when picker is cancelled
  final VoidCallback? onCancel;

  /// Whether to show holidays
  final bool showHolidays;

  /// Whether to show astrological information
  final bool showAstrology;

  /// Whether to show Western dates
  final bool showWesternDates;

  /// Whether to show Myanmar dates
  final bool showMyanmarDates;

  /// Whether to show today button
  final bool showTodayButton;

  /// Whether to show clear button
  final bool showClearButton;

  /// Whether to show confirm/cancel buttons (modal mode)
  final bool showActionButtons;

  /// Custom theme for the picker
  final MyanmarCalendarTheme? theme;

  /// Height of the picker
  final double? height;

  /// Width of the picker
  final double? width;

  /// Padding around the picker
  final EdgeInsetsGeometry? padding;

  /// Margin around the picker
  final EdgeInsetsGeometry? margin;

  /// Help text displayed at the top
  final String? helpText;

  /// Cancel button text
  final String? cancelText;

  /// Confirm button text
  final String? confirmText;

  /// Whether picker is in modal mode
  final bool isModal;

  /// Animation duration for transitions
  final Duration animationDuration;

  /// First day of week (0=Saturday, 1=Sunday, etc.)
  final int firstDayOfWeek;

  /// Whether to highlight today
  final bool highlightToday;

  /// Whether to highlight weekends
  final bool highlightWeekends;

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
    this.firstDayOfWeek = 1, // Sunday in Myanmar system
    this.highlightToday = true,
    this.highlightWeekends = true,
  });

  @override
  State<MyanmarDatePickerWidget> createState() =>
      _MyanmarDatePickerWidgetState();
}

class _MyanmarDatePickerWidgetState extends State<MyanmarDatePickerWidget>
    with TickerProviderStateMixin {
  late MyanmarCalendarService _service;
  late MyanmarCalendarTheme _theme;
  late DateTime _currentDate;
  DateTime? _selectedDate;
  late TabController _tabController;
  late AnimationController _animationController;
  late Animation<double> _slideAnimation;

  // View modes
  static const int _calendarView = 0;
  static const int _yearView = 1;
  static const int _monthView = 2;
  int _currentView = _calendarView;

  @override
  void initState() {
    super.initState();
    _initializeDatePicker();
  }

  void _initializeDatePicker() {
    // Initialize service
    _service = MyanmarCalendarService(
      config: widget.config,
      defaultLanguage: widget.language,
    );

    // Initialize theme
    _theme = widget.theme ?? MyanmarCalendarTheme.defaultTheme();

    // Initialize dates
    _currentDate = widget.initialDate ?? DateTime.now();
    _selectedDate = widget.initialDate;

    // Initialize controllers
    _tabController = TabController(length: 2, vsync: this);
    _animationController = AnimationController(
      duration: widget.animationDuration,
      vsync: this,
    );

    _slideAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );

    _animationController.forward();
  }

  @override
  void dispose() {
    _tabController.dispose();
    _animationController.dispose();
    super.dispose();
  }

  @override
  void didUpdateWidget(MyanmarDatePickerWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    // Update service if configuration changed
    if (widget.config != oldWidget.config ||
        widget.language != oldWidget.language) {
      _service = MyanmarCalendarService(
        config: widget.config,
        defaultLanguage: widget.language,
      );
    }

    // Update theme if changed
    if (widget.theme != oldWidget.theme) {
      _theme = widget.theme ?? MyanmarCalendarTheme.defaultTheme();
    }
  }

  // ============================================================================
  // HELPER METHODS
  // ============================================================================

  /// Check if date is selectable
  bool _isDateSelectable(DateTime date) {
    if (widget.firstDate != null && date.isBefore(widget.firstDate!)) {
      return false;
    }
    if (widget.lastDate != null && date.isAfter(widget.lastDate!)) {
      return false;
    }
    return true;
  }

  /// Handle date selection
  void _onDateSelected(CompleteDate completeDate) {
    if (!_isDateSelectable(completeDate.western.toDateTime())) return;

    setState(() {
      _selectedDate = completeDate.western.toDateTime();
    });

    widget.onDateChanged?.call(completeDate);

    if (widget.isModal) {
      // In modal mode, don't auto-confirm, wait for confirm button
    } else {
      // In inline mode, immediately call onConfirm if provided
      widget.onConfirm?.call(completeDate);
    }
  }

  /// Handle today button press
  void _onTodayPressed() {
    final today = DateTime.now();
    if (!_isDateSelectable(today)) return;

    final completeDate = _service.getCompleteDate(today);
    _onDateSelected(completeDate);
  }

  /// Handle clear button press
  void _onClearPressed() {
    setState(() {
      _selectedDate = null;
    });
  }

  /// Handle confirm button press
  void _onConfirmPressed() {
    if (_selectedDate != null) {
      final completeDate = _service.getCompleteDate(_selectedDate!);
      widget.onConfirm?.call(completeDate);
    }
  }

  /// Handle cancel button press
  void _onCancelPressed() {
    widget.onCancel?.call();
  }

  /// Switch to year view
  void _showYearView() {
    setState(() {
      _currentView = _yearView;
    });
    _animationController.reset();
    _animationController.forward();
  }

  /// Switch to month view
  // ignore: unused_element
  void _showMonthView() {
    setState(() {
      _currentView = _monthView;
    });
    _animationController.reset();
    _animationController.forward();
  }

  /// Switch to calendar view
  void _showCalendarView() {
    setState(() {
      _currentView = _calendarView;
    });
    _animationController.reset();
    _animationController.forward();
  }

  /// Handle month changed
  void _onMonthChanged(DateTime month) {
    setState(() {
      _currentDate = month;
    });
  }

  // ============================================================================
  // BUILD METHODS
  // ============================================================================

  @override
  Widget build(BuildContext context) {
    return Container(
      height: widget.height ?? 560,
      width: widget.width ?? 400,
      padding: widget.padding ?? const EdgeInsets.all(16.0),
      margin: widget.margin,
      decoration: BoxDecoration(
        color: _theme.backgroundColor,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.1),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          if (widget.helpText != null) _buildHelpText(),
          if (_currentView == _calendarView) _buildTabBar(),
          Expanded(child: _buildCurrentView()),
          if (widget.showTodayButton ||
              widget.showClearButton ||
              widget.showActionButtons)
            _buildActionButtons(),
        ],
      ),
    );
  }

  /// Build help text
  Widget _buildHelpText() {
    return Container(
      padding: const EdgeInsets.only(bottom: 16),
      child: Text(
        widget.helpText!,
        style: TextStyle(color: _theme.weekdayHeaderTextColor, fontSize: 14),
        textAlign: TextAlign.center,
      ),
    );
  }

  /// Build tab bar for calendar/year selection
  Widget _buildTabBar() {
    return Container(
      height: 48,
      margin: const EdgeInsets.only(bottom: 8),
      decoration: BoxDecoration(
        color: _theme.headerBackgroundColor.withValues(alpha: 0.2),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: _theme.headerBackgroundColor.withValues(alpha: 0.2),
        ),
      ),
      child: TabBar(
        controller: _tabController,
        labelStyle: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
        unselectedLabelStyle: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.normal,
        ),
        labelColor: _theme.headerTextColor,
        unselectedLabelColor: _theme.dateCellTextColor,
        indicator: BoxDecoration(
          color: _theme.headerBackgroundColor,
          borderRadius: BorderRadius.all(Radius.circular(6)),
        ),
        indicatorSize: TabBarIndicatorSize.tab,
        tabs: [
          Tab(text: TranslationService.translate('Calendar')),
          Tab(text: TranslationService.translate('Year View')),
        ],
      ),
    );
  }

  /// Build current view based on state
  Widget _buildCurrentView() {
    return SlideTransition(
      position: Tween<Offset>(
        begin: const Offset(0, 0.1),
        end: Offset.zero,
      ).animate(_slideAnimation),
      child: FadeTransition(
        opacity: _slideAnimation,
        child: _getCurrentViewWidget(),
      ),
    );
  }

  /// Get current view widget
  Widget _getCurrentViewWidget() {
    switch (_currentView) {
      case _yearView:
        return _buildYearView();
      case _monthView:
        return _buildMonthView();
      default:
        return _buildCalendarView();
    }
  }

  /// Build calendar view
  Widget _buildCalendarView() {
    return TabBarView(
      controller: _tabController,
      children: [
        // Calendar tab
        MyanmarCalendarWidget(
          initialDate: _currentDate,
          language: widget.language,
          config: widget.config,
          onDateSelected: _onDateSelected,
          onMonthChanged: _onMonthChanged,
          showHolidays: widget.showHolidays,
          showAstrology: widget.showAstrology,
          showWesternDates: widget.showWesternDates,
          showMyanmarDates: widget.showMyanmarDates,
          selectedDate: _selectedDate,
          minDate: widget.firstDate,
          maxDate: widget.lastDate,
          highlightToday: widget.highlightToday,
          highlightWeekends: widget.highlightWeekends,
          firstDayOfWeek: widget.firstDayOfWeek,
          theme: widget.theme ?? MyanmarCalendarTheme.defaultTheme(),
        ),

        // Year overview tab - with month access
        _buildYearOverview(),
      ],
    );
  }

  /// Build year overview with months
  Widget _buildYearOverview() {
    final currentYear = _currentDate.year;

    return Column(
      children: [
        // Year navigation
        Container(
          padding: const EdgeInsets.all(8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                icon: const Icon(Icons.chevron_left),
                onPressed: () {
                  setState(() {
                    _currentDate = DateTime(
                      currentYear - 1,
                      _currentDate.month,
                    );
                  });
                },
              ),
              // Year navigation with month view access
              GestureDetector(
                onTap: _showYearView,
                child: Text(
                  currentYear.toString(),
                  style: TextStyle(
                    color: _theme.dateCellTextColor,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    decoration: TextDecoration.underline,
                  ),
                ),
              ),
              IconButton(
                icon: const Icon(Icons.chevron_right),
                onPressed: () {
                  setState(() {
                    _currentDate = DateTime(
                      currentYear + 1,
                      _currentDate.month,
                    );
                  });
                },
              ),
            ],
          ),
        ),

        // Month grid
        Expanded(
          child: GridView.builder(
            padding: const EdgeInsets.all(8),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              childAspectRatio: 1.5,
              crossAxisSpacing: 8,
              mainAxisSpacing: 8,
            ),
            itemCount: 12,
            itemBuilder: (context, index) {
              final month = index + 1;
              // final monthDate = DateTime(currentYear, month, 1);
              final isSelected =
                  _selectedDate != null &&
                  _selectedDate!.year == currentYear &&
                  _selectedDate!.month == month;

              // Improved month name handling
              final monthName = _getImprovedMonthName(month);

              return GestureDetector(
                onTap: () {
                  setState(() {
                    _currentDate = DateTime(_currentDate.year, month);
                  });
                  _tabController.animateTo(0); // Switch to calendar tab
                },
                child: Container(
                  decoration: isSelected
                      ? BoxDecoration(
                          color: _theme.headerBackgroundColor,
                          borderRadius: BorderRadius.circular(8),
                        )
                      : BoxDecoration(
                          border: Border.all(color: Colors.grey[300]!),
                          borderRadius: BorderRadius.circular(8),
                        ),
                  child: Center(
                    child: Text(
                      monthName,
                      style: isSelected
                          ? TextStyle(
                              color: Colors.white,
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                            )
                          : TextStyle(
                              color: Colors.black87,
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                            ),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  /// Build year selection view
  Widget _buildYearView() {
    final currentYear = _currentDate.year;
    final startYear = (currentYear / 10).floor() * 10;

    return Column(
      children: [
        // Year range header
        Container(
          padding: const EdgeInsets.all(16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                icon: const Icon(Icons.chevron_left),
                onPressed: () {
                  setState(() {
                    _currentDate = DateTime(startYear - 10, _currentDate.month);
                  });
                },
              ),
              Text(
                '$startYear - ${startYear + 9}',
                style: TextStyle(
                  color: _theme.dateCellTextColor,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              IconButton(
                icon: const Icon(Icons.chevron_right),
                onPressed: () {
                  setState(() {
                    _currentDate = DateTime(startYear + 10, _currentDate.month);
                  });
                },
              ),
            ],
          ),
        ),

        // Year grid
        Expanded(
          child: GridView.builder(
            padding: const EdgeInsets.all(16),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 4,
              childAspectRatio: 1.5,
              crossAxisSpacing: 8,
              mainAxisSpacing: 8,
            ),
            itemCount: 12, // Show 12 years
            itemBuilder: (context, index) {
              final year =
                  startYear + index - 1; // Start one year before for better UX
              final isSelected = year == currentYear;
              final isSelectable = _isYearSelectable(year);

              return GestureDetector(
                onTap: isSelectable
                    ? () {
                        setState(() {
                          _currentDate = DateTime(year, _currentDate.month);
                        });
                        _showCalendarView();
                      }
                    : null,
                child: Container(
                  decoration: isSelected
                      ? BoxDecoration(
                          color: _theme.headerBackgroundColor,
                          borderRadius: BorderRadius.all(Radius.circular(8)),
                        )
                      : BoxDecoration(
                          border: Border.all(
                            color: _theme.headerBackgroundColor,
                          ),
                          borderRadius: BorderRadius.circular(8),
                          color: _theme.headerBackgroundColor.withValues(
                            alpha: 0.2,
                          ),
                        ),
                  child: Center(
                    child: Text(
                      year.toString(),
                      style: isSelected
                          ? TextStyle(
                              color: _theme.headerTextColor,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            )
                          : isSelectable
                          ? TextStyle(
                              color: _theme.dateCellTextColor,
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            )
                          : TextStyle(
                              color: _theme.dateCellTextColor,
                              fontSize: 16,
                            ),
                    ),
                  ),
                ),
              );
            },
          ),
        ),

        // Back button
        Container(
          padding: const EdgeInsets.all(16),
          child: ElevatedButton(
            onPressed: _showCalendarView,
            child: Text(TranslationService.translate('Back to Calendar')),
          ),
        ),
      ],
    );
  }

  /// Check if year is selectable
  bool _isYearSelectable(int year) {
    if (widget.firstDate != null && year < widget.firstDate!.year) {
      return false;
    }
    if (widget.lastDate != null && year > widget.lastDate!.year) {
      return false;
    }
    return true;
  }

  /// Build month selection view
  Widget _buildMonthView() {
    return Column(
      children: [
        // Year display with tap to show year view
        Container(
          padding: const EdgeInsets.all(16),
          child: GestureDetector(
            onTap: _showYearView,
            child: Text(
              _currentDate.year.toString(),
              style: TextStyle(
                color: _theme.dateCellTextColor,
                fontSize: 16,
                fontWeight: FontWeight.w600,
                decoration: TextDecoration.underline,
              ),
            ),
          ),
        ),

        // Month grid
        Expanded(
          child: GridView.builder(
            padding: const EdgeInsets.all(16),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              childAspectRatio: 2.0,
              crossAxisSpacing: 8,
              mainAxisSpacing: 8,
            ),
            itemCount: 12,
            itemBuilder: (context, index) {
              final month = index + 1;
              final isSelected =
                  _selectedDate != null &&
                  _selectedDate!.year == _currentDate.year &&
                  _selectedDate!.month == month;

              final monthName = _getImprovedMonthName(month);

              return GestureDetector(
                onTap: () {
                  setState(() {
                    _currentDate = DateTime(_currentDate.year, month);
                  });
                  _showCalendarView();
                },
                child: Container(
                  decoration: isSelected
                      ? BoxDecoration(
                          color: _theme.headerBackgroundColor,
                          borderRadius: BorderRadius.all(Radius.circular(8)),
                        )
                      : BoxDecoration(
                          border: Border.all(
                            color: _theme.headerBackgroundColor,
                          ),
                          borderRadius: BorderRadius.circular(8),
                          color: _theme.headerBackgroundColor.withValues(
                            alpha: 0.3,
                          ),
                        ),
                  child: Center(
                    child: Text(
                      monthName,
                      style: isSelected
                          ? TextStyle(
                              color: _theme.headerTextColor,
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                            )
                          : TextStyle(
                              color: _theme.dateCellTextColor,
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                            ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              );
            },
          ),
        ),

        // Back button
        Container(
          padding: const EdgeInsets.all(16),
          child: ElevatedButton(
            onPressed: _showCalendarView,
            child: Text(TranslationService.translate('Back to Calendar')),
          ),
        ),
      ],
    );
  }

  /// Build action buttons
  Widget _buildActionButtons() {
    return Container(
      padding: const EdgeInsets.only(top: 16),
      child: Column(
        children: [
          Row(
            children: [
              // Today button
              if (widget.showTodayButton) ...[
                OutlinedButton(
                  onPressed: _onTodayPressed,
                  style: OutlinedButton.styleFrom(
                    foregroundColor: _theme.headerBackgroundColor,
                    side: BorderSide(color: _theme.headerBackgroundColor),
                  ),
                  child: Text(
                    TranslationService.translate('Today'),
                    style: TextStyle(fontSize: 12),
                  ),
                ),
                const SizedBox(width: 8),
              ],

              // Clear button
              if (widget.showClearButton) ...[
                OutlinedButton(
                  onPressed: _selectedDate != null ? _onClearPressed : null,
                  // style: OutlinedButton.styleFrom(
                  //   foregroundColor: const Color(0xFF757575),
                  //   side: const BorderSide(color: Color(0xFF757575)),
                  // ),
                  child: Text(
                    TranslationService.translate('Clear'),
                    style: TextStyle(fontSize: 12),
                  ),
                ),
                const SizedBox(width: 8),
              ],

              const Spacer(),

              // Cancel/Confirm buttons (for modal mode)
              if (widget.showActionButtons) ...[
                TextButton(
                  onPressed: _onCancelPressed,
                  style: TextButton.styleFrom(
                    foregroundColor: const Color(0xFF757575),
                  ),
                  child: Text(
                    widget.cancelText ?? TranslationService.translate('Cancel'),
                    style: TextStyle(fontSize: 12),
                  ),
                ),
                const SizedBox(width: 8),
                TextButton(
                  onPressed: _selectedDate != null ? _onConfirmPressed : null,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: _theme.headerBackgroundColor,
                    foregroundColor: _theme.headerTextColor,
                  ),
                  child: Text(
                    widget.confirmText ?? TranslationService.translate('OK'),
                    style: TextStyle(fontSize: 12),
                  ),
                ),
              ],
            ],
          ),
        ],
      ),
    );
  }

  /// Improved month name handling
  String _getImprovedMonthName(int month) {
    final monthName = TranslationService.getWesternMonthName(
      month - 1, // Convert to 0-based index
      widget.language,
    );

    return _createSmartAbbreviation(monthName, widget.language);
  }

  /// Create smart abbreviation for month names
  String _createSmartAbbreviation(String monthName, Language language) {
    switch (language) {
      case Language.myanmar:
      case Language.zawgyi:
        // For Myanmar script, preserve more characters for readability
        if (monthName.length <= 5) return monthName;
        return monthName.substring(0, 5);

      case Language.english:
        // For English, use standard 3-letter abbreviations
        if (monthName.length <= 3) return monthName;
        return monthName.substring(0, 3);

      case Language.mon:
      case Language.shan:
      case Language.karen:
        // For other Myanmar languages, use 4 characters max
        if (monthName.length <= 4) return monthName;
        return monthName.substring(0, 4);
    }
  }
}

// ============================================================================
// SHOW MYANMAR DATE PICKER FUNCTION
// ============================================================================

// Get default help text based on language
String _getDefaultHelpText(Language language) {
  switch (language) {
    case Language.myanmar:
      return 'ရက်စွဲရွေးချယ်ပါ';
    case Language.zawgyi:
      return 'ရက္စြဲေရြးခ်ယ္ပါ';
    case Language.mon:
      return 'ရွေးချယ်ရန် ရက်စွဲ';
    case Language.shan:
      return 'တၢင်းလိူဝ်ႈ ဝၼ်းတီး';
    case Language.karen:
      return 'နံၣ်ခံါ်ယၤဖိ';
    case Language.english:
      return 'Select Date';
  }
}

/// Get default title based on language
String _getDefaultTitle(Language language) {
  switch (language) {
    case Language.myanmar:
      return 'ရက်စွဲရွေးချယ်ရန်';
    case Language.zawgyi:
      return 'ရက္စြဲေရြးခ်ယ္ရန္';
    case Language.mon:
      return 'ရက်စွဲရွေးချယ်ရန်';
    case Language.shan:
      return 'တၢင်းလိူဝ်ႈ ဝၼ်းတီး';
    case Language.karen:
      return 'နံၣ်ခံါ်ယၤဖိ';
    case Language.english:
      return 'Select Date';
  }
}

/// Get default text based on key and language
String _getDefaultText(String key, Language language) {
  final translations = <String, Map<Language, String>>{
    'Cancel': {
      Language.myanmar: 'ပယ်ဖျက်',
      Language.zawgyi: 'ပယ္ဖ်က္',
      Language.mon: 'ပယ်ဖျက်',
      Language.shan: 'ပိူင်ႈ',
      Language.karen: 'နံကျိၤ',
      Language.english: 'Cancel',
    },
    'OK': {
      Language.myanmar: 'အိုကေ',
      Language.zawgyi: 'အိုေက',
      Language.mon: 'အိုကေ',
      Language.shan: 'ဢွၵ်ႇ',
      Language.karen: 'အီၤကျီၤ',
      Language.english: 'OK',
    },
  };

  return translations[key]?[language] ?? key;
}

/// Shows a modal Myanmar date picker dialog
///
/// Returns the selected [CompleteDate] or null if cancelled.
///
/// Example:
/// ```dart
/// final selectedDate = await showMyanmarDatePicker(
///   context: context,
///   initialDate: DateTime.now(),
///   firstDate: DateTime(2020),
///   lastDate: DateTime(2030),
///   language: Language.myanmar,
/// );
///
/// if (selectedDate != null) {
///   print('Selected: ${selectedDate.formatComplete()}');
/// }
/// ```
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
  int firstDayOfWeek = 1, // Sunday in Myanmar system
  bool highlightToday = true,
  bool highlightWeekends = true,
  bool barrierDismissible = true,
  Color? barrierColor,
}) async {
  final result = await showDialog<CompleteDate>(
    context: context,
    barrierDismissible: barrierDismissible,
    barrierColor: barrierColor,
    builder: (BuildContext context) {
      return Dialog(
        insetPadding: const EdgeInsets.all(4),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: MyanmarDatePickerWidget(
          initialDate: initialDate,
          firstDate: firstDate,
          lastDate: lastDate,
          language: language,
          config: config,
          helpText: helpText ?? _getDefaultHelpText(language),
          cancelText: cancelText ?? _getDefaultText('Cancel', language),
          confirmText: confirmText ?? _getDefaultText('OK', language),
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
          height: 590,
          width: 400,
          onConfirm: (date) {
            Navigator.of(context).pop(date);
          },
          onCancel: () {
            Navigator.of(context).pop();
          },
        ),
      );
    },
  );

  return result;
}

/// Shows a fullscreen Myanmar date picker
///
/// Useful for mobile devices where a modal dialog might be too small.
///
/// Example:
/// ```dart
/// final selectedDate = await showMyanmarDatePickerFullscreen(
///   context: context,
///   initialDate: DateTime.now(),
///   language: Language.myanmar,
/// );
/// ```
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
  final result = await Navigator.of(context).push<CompleteDate>(
    MaterialPageRoute(
      fullscreenDialog: true,
      builder: (BuildContext context) {
        return Scaffold(
          appBar: AppBar(
            title: Text(title ?? _getDefaultTitle(language)),
            leading: IconButton(
              icon: const Icon(Icons.close),
              onPressed: () => Navigator.of(context).pop(),
            ),
          ),
          body: MyanmarDatePickerWidget(
            initialDate: initialDate,
            firstDate: firstDate,
            lastDate: lastDate,
            language: language,
            config: config,
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
            onConfirm: (date) {
              Navigator.of(context).pop(date);
            },
            onCancel: () {
              Navigator.of(context).pop();
            },
          ),
        );
      },
    ),
  );

  return result;
}
